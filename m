From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Thu, 09 Jun 2016 09:44:27 +0000
Subject: [RFC v4 10/14] usb: hub: Handle deferred probe
Message-Id: <1465465471-28740-11-git-send-email-k.kozlowski@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add support for deferred probing to the usb hub.  Currently EPROBE_DEFER
does not exist in usb hub path but future patches will add it on the
port level.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 drivers/usb/core/hub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index bee13517676f..c421745b84aa 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1733,6 +1733,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	int ret;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
@@ -1852,11 +1853,12 @@ descriptor_error:
 	if (id->driver_info & HUB_QUIRK_CHECK_PORT_AUTOSUSPEND)
 		hub->quirk_check_port_auto_suspend = 1;
 
-	if (hub_configure(hub, endpoint) >= 0)
+	ret = hub_configure(hub, endpoint);
+	if (ret >= 0)
 		return 0;
 
 	hub_disconnect(intf);
-	return -ENODEV;
+	return ret;
 }
 
 static int
-- 
1.9.1

