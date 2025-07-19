            ComboBox {
                id: highlightTypeCombo
                model: [
                    i18n("Full Highlight"),
                    i18n("Full Highlight with Line"),
                    i18n("Line Highlight"),
                    i18n("Square Highlight"),
                    i18n("Pill Style"),
                    i18n("Text Style"),
                    i18n("Icon Style"),
                    i18n("Loader Style"),
                    i18n("Squiggly Circle Highlight")
                ]
                currentIndex: cfg.highlightType
                onCurrentIndexChanged: cfg.highlightType = currentIndex
            } 