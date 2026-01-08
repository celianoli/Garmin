import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.ActivityMonitor;
import Toybox.Lang;

class MoniteurCardiaqueView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        // 1. Récupérer les données
        var info = ActivityMonitor.getInfo();   
        var hr = null;      
        var stats = System.getSystemStats();
        var battery = stats.battery;

        // Vérification sécurisée du rythme cardiaque
        if (info has :currentHeartRate) {
            hr = info.currentHeartRate;
        } else if (info has :heartRate) {
            hr = info.heartRate;
        }

        // 2. Déterminer la couleur de fond selon le cœur
        var backgroundColor = Graphics.COLOR_BLACK;
        if (hr != null) {
            if (hr > 100) {
                backgroundColor = Graphics.COLOR_RED;
            } else if (hr > 60) {
                backgroundColor = Graphics.COLOR_DK_GREEN;
            }
        }

        // 3. Dessiner le fond
        dc.setColor(backgroundColor, backgroundColor);
        dc.clear();

        // 4. Préparer et afficher l'heure
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() / 2,
            Graphics.FONT_NUMBER_MEDIUM,
            timeString,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );

        // 5. Afficher la batterie en haut
        dc.drawText(
            dc.getWidth() / 2,
            40,
            Graphics.FONT_TINY,
            "Batt: " + battery.format("%d") + "%",
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // 6. Afficher le rythme cardiaque en bas
        var hrDisplay = (hr == null) ? "--" : hr.toString();
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() - 60,
            Graphics.FONT_SMALL,
            "HR: " + hrDisplay,
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }
}