import 'package:flutter/material.dart';
import '../BannerView.dart';
import 'IndicatorUtil.dart';

//indicator view of banner
class IndicatorWidget extends StatelessWidget {
    final IndicatorContainerBuilder? indicatorBuilder;
    final Widget? indicatorNormal;
    final Widget? indicatorSelected;
    final double? indicatorMargin;
    final int? size;
    final int? currentIndex;
    
    const IndicatorWidget({
        super.key,
        this.size,
        this.currentIndex,
        this.indicatorBuilder,
        this.indicatorNormal,
        this.indicatorSelected,
        this.indicatorMargin = 5.0,
    }): 
        assert(indicatorMargin != null),
        assert(size != null && size > 0),
        assert(currentIndex != null && currentIndex >= 0);
    
    @override
    Widget build(BuildContext context) {
        return _renderIndicator(context);
    }

    //indicator container
    Widget _renderIndicator(BuildContext context) {
        
        Widget smallContainer = Container(
            // color: Colors.purple[100],
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: _renderIndicatorTag(),
            ),
        );

        if(null != indicatorBuilder) {
            return indicatorBuilder!(context, smallContainer);
        }

        //default implement
        return Align(
            alignment: Alignment.bottomCenter,
            child:  Opacity(
                opacity: 0.5,
                child:  Container(
                    height: 40.0,
                    padding:  const EdgeInsets.symmetric(horizontal: 16.0),
                    color: Colors.black45,
                    alignment: Alignment.centerRight,
                    child: smallContainer,
                ),
            ),
        );
    }

    //generate every indicator item
    List<Widget> _renderIndicatorTag() {
        List<Widget> indicators = [];
        final int? len = size;
        Widget selected = indicatorSelected ?? IndicatorUtil.generateIndicatorItem(normal: false);
        Widget normal = indicatorNormal ?? IndicatorUtil.generateIndicatorItem(normal: true);

        for(var index = 0; index < len!; index++) {
            indicators.add(index == currentIndex ? selected : normal);
            if(index != len - 1) {
                indicators.add(SizedBox(width: indicatorMargin,));
            }
        }

        return indicators;
    }
}