From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 1/10] ps3: Add shutdown to virtual uart port driver framework
Date: Tue, 30 Jan 2007 17:59:57 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701301757280.29487@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>, Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

PS3: Add a shutdown method to the PS3's virtual uart port driver framework

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/vuart.c       |   17 +++++++++++++++++
 drivers/ps3/vuart.h       |    1 +
 2 files changed, 18 insertions(+)

--- ps3-linux-2.6.20-rc6.orig/drivers/ps3/vuart.c
+++ ps3-linux-2.6.20-rc6/drivers/ps3/vuart.c
@@ -865,6 +865,22 @@ static int ps3_vuart_remove(struct devic
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
@@ -876,6 +892,7 @@ struct bus_type ps3_vuart = {
 	.match = ps3_vuart_match,
 	.probe = ps3_vuart_probe,
 	.remove = ps3_vuart_remove,
+	.shutdown = ps3_vuart_shutdown,
 };
 
 int __init ps3_vuart_init(void)
--- ps3-linux-2.6.20-rc6.orig/drivers/ps3/vuart.h
+++ ps3-linux-2.6.20-rc6/drivers/ps3/vuart.h
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
