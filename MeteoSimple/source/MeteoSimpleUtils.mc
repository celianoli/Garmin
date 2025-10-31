module MeteoUtils {
    using Toybox.Graphics as Gfx;
    using Toybox.Weather;
    using Toybox.Position as Position;
    using Rez;

    // Retourne l'identifiant de l'image en fonction de la météo
    function getIconForCondition(condition) {
        if (condition == Weather.CONDITION_CLEAR) {
            return Rez.Drawables.Soleil;
        } else if (condition == Weather.CONDITION_PARTLY_CLOUDY or
                   condition == Weather.CONDITION_CLOUDY) {
            return Rez.Drawables.Nuage;
        } else if (condition == Weather.CONDITION_RAIN or
                   condition == Weather.CONDITION_SHOWERS) {
            return Rez.Drawables.Pluie;
        }
        return null;
    }

    // Retourne la localisation GPS (lat/lon)
    function getLocationName() {
        var info = Position.getInfo();
        if (info != null && info[:latitude] != null && info[:longitude] != null) {
            var lat = info[:latitude].format("%0.1f");
            var lon = info[:longitude].format("%0.1f");
            return "lat:" + lat + " lon:" + lon;
        }
        return "Ville inconnue";
    }
}
