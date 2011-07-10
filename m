From: bernie@plugable.com
Date: Sun, 10 Jul 2011 07:30:00 +0000
Subject: [PATCH] drivers/video/udlfb match class, subclass, and protocol
Message-Id: <1310283000-2482-1-git-send-email-bernie@plugable.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Bernie Thompson <bernie@plugable.com>

Match udlfb only against vendor-specific class (e.g. only DisplayLink
graphics, not composite standard audio class interfaces). This enables
compatibility with composite graphics+audio devices (e.g. HDMI).

Match udlfb only against compatible subclass 0 and protocol 0 chips.
DisplayLink's USB 3.0 generation chips increment these values
to signal that they have a incompatible protocol, preventing udlfb
from erroneously matching to hardware it does not support.

Tested to confirm proper behavior on both USB 2.0 and USB 3.0
generation devices.

Reported-by: Andrew Kephart <akephart@akephart.org>
Signed-off-by: Bernie Thompson <bernie@plugable.com>
---
 drivers/video/udlfb.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index c6584c9..4e13375 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -49,13 +49,22 @@ static const u32 udlfb_info_flags = FBINFO_DEFAULT | FBINFO_READS_FAST |
 		FBINFO_HWACCEL_COPYAREA | FBINFO_MISC_ALWAYS_SETPAR;
 
 /*
- * There are many DisplayLink-based products, all with unique PIDs. We are able
- * to support all volume ones (circa 2009) with a single driver, so we match
- * globally on VID. TODO: Probe() needs to detect when we might be running
- * "future" chips, and bail on those, so a compatible driver can match.
+ * There are many DisplayLink-based graphics products, all with unique PIDs.
+ * So we match on DisplayLink's VID + Vendor-Defined Interface Class (0xff)
+ * We also require a match on SubClass (0x00) and Protocol (0x00),
+ * which is compatible with all known USB 2.0 era graphics chips and firmware,
+ * but allows DisplayLink to increment those for any future incompatible chips
  */
 static struct usb_device_id id_table[] = {
-	{.idVendor = 0x17e9, .match_flags = USB_DEVICE_ID_MATCH_VENDOR,},
+	{.idVendor = 0x17e9,
+	 .bInterfaceClass = 0xff,
+	 .bInterfaceSubClass = 0x00,
+	 .bInterfaceProtocol = 0x00,
+	 .match_flags = USB_DEVICE_ID_MATCH_VENDOR |
+		USB_DEVICE_ID_MATCH_INT_CLASS |
+		USB_DEVICE_ID_MATCH_INT_SUBCLASS |
+		USB_DEVICE_ID_MATCH_INT_PROTOCOL,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(usb, id_table);
-- 
1.7.4.1

