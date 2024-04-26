library banner_view;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'indicator/IndicatorWidget.dart';
//indicator container builder
///[indicatorWidget] indicator widget, position the indicator widget into container
typedef IndicatorContainerBuilder = Widget Function(BuildContext context, Widget indicatorWidget);
typedef BannerViewClick =void Function(int index);

const String TAG = 'BannerView';

/// BannerView
class BannerView extends StatefulWidget{
     List<Widget> banners= [];
    //init index
     int initIndex;
    //switch interval
     Duration intervalDuration;
    //animation duration
     Duration animationDuration;
     IndicatorContainerBuilder? indicatorBuilder;
     Widget? indicatorNormal;
     Widget? indicatorSelected;
    //the margin of between indicator items
     double indicatorMargin;
     PageController? controller;
    //whether cycle rolling
     bool cycleRolling;
    //whether auto rolling
     bool autoRolling;
     Curve curve;
     ValueChanged? onPageChanged;
     bool log;
     BannerViewClick bannerViewClick;

    BannerView(this.banners, {
        super.key,
        this.initIndex = 0,
        this.intervalDuration = const Duration(seconds: 1),
        this.animationDuration = const Duration(milliseconds: 500),
        this.indicatorBuilder,
        this.indicatorNormal,
        this.indicatorSelected,
        this.indicatorMargin = 5.0,
        this.controller,
        this.cycleRolling = true,
        this.autoRolling = true,
        this.curve = Curves.easeInOut,
        this.onPageChanged,
        this.log = true,
        required this.bannerViewClick,
    }):
        assert(banners?.isNotEmpty ?? true),
        assert(null != indicatorMargin),
        assert(null != intervalDuration),
        assert(null != animationDuration),
        assert(null != cycleRolling);


    @override
    _BannerViewState createState() => _BannerViewState();
}

/// Created by yangxiaowei
class _BannerViewState extends State<BannerView> {

    List<Widget> _originBanners = [];
    List<Widget> _banners = [];
    Duration? _duration;
    PageController? _pageController;
    int _currentIndex = 0;

    @override
    void initState() {
        super.initState();
        _Logger.debug = widget.log ?? true;

        _isActive = true;

        _originBanners = widget.banners;
        _banners = _banners..addAll(_originBanners);
        
        if(widget.cycleRolling) {
            Widget first = _originBanners[0];
            Widget last = _originBanners[_originBanners.length - 1];
            
            _banners.insert(0, last);
            _banners.add(first);
            _currentIndex = widget.initIndex + 1;
        }else {
            _currentIndex = widget.initIndex;
        }

        _duration = widget.intervalDuration;
        _pageController = widget.controller ?? PageController(initialPage: _currentIndex);
        
        _nextBannerTask();
    }

    Timer? _timer;
    void _nextBannerTaskBy({int milliseconds = 0}) {
        if(!mounted) {
            return;
        }

        if(!widget.autoRolling) {
            return;
        }

        _cancel();

        _timer =  Timer(Duration(milliseconds: _duration!.inMilliseconds + milliseconds), () {
            _doChangeIndex();
        });
    }

    void _nextBannerTask() {
        _nextBannerTaskBy(milliseconds: 0);
    }

    void _cancel() {
        _timer?.cancel();
    }

    void _doChangeIndex({bool increment = true}) {
        if(!mounted) {
            return;
        }
        if(increment) {
            _currentIndex++;
        }else{
            _currentIndex--;
        }
        _currentIndex = _currentIndex % _banners.length;
        _Logger.d(TAG, "_doChangeIndex  $_currentIndex .");
        if(0 == _currentIndex) {
            _pageController?.jumpToPage(_currentIndex + 1);
            _nextBannerTaskBy(milliseconds: -_duration!.inMilliseconds);
            setState(() {});
        }else{
            _pageController?.animateToPage(
                _currentIndex, 
                duration: widget.animationDuration,
                curve: widget.curve,
            );
        }
    }

    @override
    Widget build(BuildContext context) {
        
        return _generateBody();
    }

    /// compose the body, banner view and indicator view
    Widget _generateBody() {
        return  Stack(
            children: <Widget>[
                _renderBannerBody(),
                _renderIndicator(),
            ],
        );
    }

    /// Banner container
    Widget _renderBannerBody() {

        Widget pageView =  PageView.builder(
            itemBuilder: (context, index) {

                Widget banner = _banners[index];
                return  GestureDetector(
                    child: banner,
                    onTap: (){
                        int position = widget.cycleRolling ? _currentIndex - 1 : _currentIndex;
                        position = position <= 0 ? 0 : position;
                        position = position % _originBanners.length;
                        print("PageView position=$position");
                        widget.bannerViewClick(position);
                    },
                );
            },  
            controller: _pageController,
            itemCount: _banners.length,  
            onPageChanged: (index) {
                _Logger.d(TAG, '**********   changed  index: $index  cu: $_currentIndex');
                _currentIndex = index;
                _nextBannerTask();
                setState(() {});
                if(null != widget.onPageChanged) {
                    widget.onPageChanged!(index);
                }
            },
            physics:  const ClampingScrollPhysics(),
        );

        // return pageView;
        return  NotificationListener(
            child: pageView,
            onNotification: (Notification notification) {
                _handleScrollNotification(notification);
                return true;
            },
        );
    }

    void _handleScrollNotification(Notification notification) {
        void _resetWhenAtEdge(PageMetrics pm) {
            if(null == pm || !pm.atEdge) {
                return;
            }
            if(!widget.cycleRolling) {
                return;
            }
            try{
                if(_currentIndex == 0) {
                    _pageController?.jumpToPage(_banners.length - 2);
                }else if(_currentIndex == _banners.length - 1) {
                    _pageController?.jumpToPage(1);
                }
                setState(() {});
            }catch (e){
                _Logger.d(TAG, 'Exception: ${e?.toString()}');
            }
        }

        void _handleUserScroll(UserScrollNotification notification) {
            UserScrollNotification? sn = notification;
                    
            PageMetrics? pm = sn.metrics as PageMetrics?;
            var page = pm?.page;
            var depth = sn.depth;
            
            var left = page == .0 ? .0 : page! % (page.round());
            
            if(depth == 0) {
                _Logger.d(TAG, '**  page: $page  , left: $left ,  atEdge: ${pm?.atEdge} ,  index: $_currentIndex');

                if(left == 0) {
                    setState(() {
                        _resetWhenAtEdge(pm!);
                    });
                }
            }
        }

        if(notification is UserScrollNotification) {
            if(_isStartByUser) {
                return;
            }
            if(_isEndByUser) {
                _isEndByUser = false;
                
            }else {
                _Logger.d(TAG, '#########   手动开始');
                _isStartByUser = true;
                _cancel();
            }

            _handleUserScroll(notification);
        }else if(notification is ScrollEndNotification) {
            _Logger.d(TAG, '#########   ${notification.runtimeType}    $_isStartByUser');

            if(_isEndByUser) {
                return;
            }
            if(_isStartByUser) {
                _Logger.d(TAG, '#########   手动结束');
                _isEndByUser = true;
                _isStartByUser = false;
            } else {
                _isEndByUser = false;
            }

            _nextBannerTask();
        }
    }

    bool _isEndByUser = false;
    bool _isStartByUser = false;

    /// indicator widget
    Widget _renderIndicator() {
        
        int index = widget.cycleRolling ? _currentIndex - 1 : _currentIndex;
        index = index <= 0 ? 0 : index;
        index = index % _originBanners.length;
        print("Indicator index=$index");
        return IndicatorWidget(
            size: _originBanners.length,
            currentIndex: index,
            indicatorBuilder: widget.indicatorBuilder,
            indicatorNormal: widget.indicatorNormal,
            indicatorSelected: widget.indicatorSelected,
            indicatorMargin: widget.indicatorMargin,
        );
    }

    bool _isActive = true;
    @override
    void deactivate() {
        super.deactivate();
        _isActive = !_isActive;
        if(_isActive) {
            _nextBannerTask();
        } else {
            _cancel();
        }
    }

    @override
    void dispose() {
        _isActive = false;
        _pageController?.dispose();
        _cancel();
        super.dispose();
    }
}

class _Logger {
    static bool debug = true;
    static void d(String tag, String msg) {
        if(debug) {
            print('$tag - $msg');
        }
    }
}