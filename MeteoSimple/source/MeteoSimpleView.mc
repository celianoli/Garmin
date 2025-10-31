using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.Weather;
using MeteoUtils;

class MeteoWidget extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onUpdate(dc) {
        var width  = dc.getWidth();
        var height = dc.getHeight();
        dc.clear();

        var current = Weather.getCurrentConditions();

        if (current != null) {
            // Température
            var temp = current.temperature.toString() + "°C";
            dc.drawText(width/2, height/2 - 40, Gfx.FONT_LARGE, temp, Gfx.TEXT_JUSTIFY_CENTER);

            // Icône météo
            var iconId = MeteoUtils.getIconForCondition(current.condition);
            if (iconId != null) {
                var bmp = WatchUi.loadResource(iconId);
                dc.drawBitmap((width - bmp.getWidth())/2, height/2, bmp);
            }

            // Localisation via GPS
            var locationTxt = MeteoUtils.getLocationName();
            dc.drawText(width/2, height/2 + 80, Gfx.FONT_MEDIUM, locationTxt, Gfx.TEXT_JUSTIFY_CENTER);

        } else {
            dc.drawText(width/2, height/2, Gfx.FONT_MEDIUM, "Pas de données", Gfx.TEXT_JUSTIFY_CENTER);
        }
    }
}
