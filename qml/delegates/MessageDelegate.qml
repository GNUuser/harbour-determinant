import QtQuick 2.0
import Sailfish.Silica 1.0
import Quotient 0.5
import Determinant 0.1

Item {
    property int textAlign: ownMessage ? Text.AlignRight : Text.AlignLeft

    width: contentColumn.width
    height: contentColumn.height

    Rectangle {
        anchors.fill: contentColumn
        color: Theme.primaryColor
        opacity: ownMessage ? 0.05 : 0.1
        radius: Theme.paddingSmall
    }

    function formatEventStatus(eventStatus) {
        if (eventStatus & EventStatus.Redacted) {
            return "✝"
        }
        if (eventStatus & EventStatus.Hidden) {
            return "❏"
        }
        if (eventStatus === EventStatus.ReachedServer) {
            return "✓"
        }
        if (eventStatus === EventStatus.SendingFailed) {
            return "✗"
        }
        return "◌"
    }

    Column {
        id: contentColumn
        width: page.width * 0.8 - 2 * Theme.paddingMedium
        x: ownMessage
            ? page.width * 0.2 + Theme.paddingMedium
            : Theme.paddingMedium

        Label {
            id: authorLabel
            width: parent.width - 2 * Theme.paddingSmall
            x: Theme.paddingSmall

            text: authorDisplayName
            textFormat: Text.PlainText
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.secondaryColor
            horizontalAlignment: Text.AlignLeft
            elide: Text.ElideMiddle
            visible: !ownMessage
        }

        Label {
            id: messageLabel
            width: parent.width - 2 * Theme.paddingSmall
            x: Theme.paddingSmall

            text: customMessageCss + display
            textFormat: Text.RichText
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.primaryColor
            wrapMode: Text.Wrap
            horizontalAlignment: textAlign

            onLinkActivated: page.openLink(link)
        }

        Label {
            id: timeLabel
            width: parent.width - 2 * Theme.paddingSmall
            x: Theme.paddingSmall

            text: ownMessage
                  ? (humanize.formatTime(time) + " • "
                     + formatEventStatus(eventStatus))
                  : humanize.formatTime(time)
            color: Theme.secondaryColor
            font.pixelSize: Theme.fontSizeExtraSmall
            horizontalAlignment: Text.AlignRight
        }
    }
}
