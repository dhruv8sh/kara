import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
         name: i18n("Appearance")
         icon: "preferences-desktop-plasma"
         source: "Config/configAppearance.qml"
    }
    ConfigCategory {
         name: i18n("Behavior")
         icon: "settings-configure-symbolic"
         source: "Config/configBehavior.qml"
    }
}
