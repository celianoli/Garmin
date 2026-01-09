import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.ActivityMonitor;
import Toybox.Lang;
import Toybox.Time;
import Toybox.Time.Gregorian;

class MoniteurCardiaqueView extends WatchUi.WatchFace {

    var imagePaysage;

    function initialize() {
        WatchFace.initialize();
        imagePaysage = WatchUi.loadResource(Rez.Drawables.Paysage);
    }

    function onUpdate(dc as Dc) as Void {
        var info = ActivityMonitor.getInfo();
        var stats = System.getSystemStats();
        
        // 1. RÉCUPÉRATION DU POULS (HR)
        var hr = null;
        if (info has :currentHeartRate) { hr = info.currentHeartRate; }
        var battery = stats.battery;
        var pas = (info.steps != null) ? info.steps : 0;

        // 2. LOGIQUE DES COULEURS DE ZONE
        var zoneColor = Graphics.COLOR_BLACK; 
        if (hr != null) {
            if (hr >= 185) { zoneColor = Graphics.COLOR_PURPLE; }
            else if (hr >= 165) { zoneColor = Graphics.COLOR_RED; }
            else if (hr >= 145) { zoneColor = Graphics.COLOR_ORANGE; }
            else if (hr >= 125) { zoneColor = Graphics.COLOR_GREEN; }
            else if (hr >= 100) { zoneColor = Graphics.COLOR_BLUE; }
            else { zoneColor = Graphics.COLOR_DK_GRAY; }
        }

        // 3. DESSIN DU FOND (L'image prend tout l'espace)
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        if (imagePaysage != null) {
            // On dessine l'image sur tout l'écran
            dc.drawBitmap(0, 0, imagePaysage);
        }

        // 4. BANDEAU DE ZONE EN BAS (Semi-transparent ou plein)
        dc.setColor(zoneColor, zoneColor);
        dc.fillRectangle(0, dc.getHeight() - 85, dc.getWidth(), 85);

        // 5. DATE ET JOUR (VEN 9 JAN)
        var now = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var jours = ["Dim", "Lun", "Mar", "Mer", "Jeu", "Ven", "Sam"];
        var mois = ["Jan", "Fév", "Mar", "Avr", "Mai", "Juin", "Juil", "Août", "Sep", "Oct", "Nov", "Déc"];
        var dateString = jours[now.day_of_week - 1] + " " + now.day + " " + mois[now.month - 1];

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT); 
        dc.drawText(dc.getWidth() / 2, 55, Graphics.FONT_TINY, dateString, Graphics.TEXT_JUSTIFY_CENTER);

        // 6. L'HEURE (Noire pour ressortir sur le paysage)
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$:$3$", [clockTime.hour, clockTime.min.format("%02d"), clockTime.sec.format("%02d")]);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_NUMBER_MEDIUM, timeString, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);

        // 7. BATTERIE (Icône + %)
        var battX = dc.getWidth() / 2 - 35;
        var battY = 25;
        dc.drawRectangle(battX, battY, 30, 14);
        dc.fillRectangle(battX + 30, battY + 4, 3, 6);
        var charge = (battery / 100.0) * 26;
        dc.fillRectangle(battX + 2, battY + 2, charge.toNumber(), 10);
        dc.drawText(battX + 40, battY - 4, Graphics.FONT_XTINY, battery.toNumber() + "%", Graphics.TEXT_JUSTIFY_LEFT);

        // 8. BPM ET BARRE DE PAS (En blanc sur le bandeau de couleur)
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        var hrDisplay = (hr == null) ? "--" : hr.toString();
        dc.drawText(dc.getWidth() / 2, dc.getHeight() - 70, Graphics.FONT_SMALL, "BPM: " + hrDisplay, Graphics.TEXT_JUSTIFY_CENTER);

        var xBar = dc.getWidth() / 4;
        var yBar = dc.getHeight() - 30;
        dc.drawRectangle(xBar, yBar, dc.getWidth() / 2, 3);
        var ratioPas = pas.toFloat() / 5000.0;
        if (ratioPas > 1.0) { ratioPas = 1.0; }
        dc.fillRectangle(xBar, yBar, (ratioPas * (dc.getWidth() / 2)).toNumber(), 3);
    }
}