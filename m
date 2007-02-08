From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 1/10] ps3: Add shutdown to virtual uart
	port driver framework
Date: Thu, 8 Feb 2007 14:58:17 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0702081456450.19437@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HF9n7-0001lZ-W9 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 05:58:26 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HF9n5-0003TN-J2
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 05:58:26 -0800
In-Reply-To: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC Development <linuxppc-dev@ozlabs.org>

PS3: Add a shutdown method to the PS3's virtual uart port driver framework

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 drivers/ps3/vuart.c |   17 +++++++++++++++++
 drivers/ps3/vuart.h |    1 +
 2 files changed, 18 insertions(+)

--- ps3-linux-2.6.20.orig/drivers/ps3/vuart.c
+++ ps3-linux-2.6.20/drivers/ps3/vuart.c
@@ -867,6 +867,22 @@ static int ps3_vuart_remove(struct devic
 	return 0;
 }
 
+static void ps3_vuart_shutdown(struct device *_dev)
+{
+	struct ps3_vuart_port_device *dev = to_ps3_vuart_port_device(_dev);
+	struct ps3_vuart_port_driver *drv =
+		to_ps3_vuart_port_driver(_dev->driver);
+
+	dev_dbg(&dev->core, "%s:%d: %s\n", __func__, __LINE__,
+		dev->core.bus_id);
+
+	if (drv->shutdown)
+		drv->shutdown(dev);
+	else
+		dev_dbg(&dev->core, "%s:%d: %s no shutdown method\n", __func__,
+			__LINE__, dev->core.bus_id);
+}
+
 /**
  * ps3_vuart - The vuart instance.
  *
@@ -878,6 +894,7 @@ struct bus_type ps3_vuart = {
 	.match = ps3_vuart_match,
 	.probe = ps3_vuart_probe,
 	.remove = ps3_vuart_remove,
+	.shutdown = ps3_vuart_shutdown,
 };
 
 int __init ps3_vuart_init(void)
--- ps3-linux-2.6.20.orig/drivers/ps3/vuart.h
+++ ps3-linux-2.6.20/drivers/ps3/vuart.h
@@ -61,6 +61,7 @@ struct ps3_vuart_port_driver {
 	struct device_driver core;
 	int (*probe)(struct ps3_vuart_port_device *);
 	int (*remove)(struct ps3_vuart_port_device *);
+	void (*shutdown)(struct ps3_vuart_port_device *);
 	int (*tx_event)(struct ps3_vuart_port_device *dev);
 	int (*rx_event)(struct ps3_vuart_port_device *dev);
 	int (*disconnect_event)(struct ps3_vuart_port_device *dev);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
