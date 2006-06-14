From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 4/7 2.6.17-rc6-mm2] add preliminary i2c
	support to intelfb
Date: Wed, 14 Jun 2006 13:53:10 -0400
Message-ID: <596D4304-93AF-4BE7-8A20-C1756763F434@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqZVd-0001CU-4g for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 10:50:29 -0700
Received: from mail6.sea5.speakeasy.net ([69.17.117.8])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FqZVc-0000cy-Tk
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 10:50:29 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, Dave Airlie <airlied@skynet.ie>

From: Dennis Munsie <dmunsie@cecropia.com>

[04/07] intelfb: add intelfb_output_rec struct and the constants for  
it's
fields.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

drivers/video/intelfb/intelfb.h |   29 +++++++++++++++++++++++++++++
1 file changed, 29 insertions(+)

diff -Naurp -X linux-2.6.17-rc6-patched/Documentation/dontdiff  
linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb.h linux/ 
drivers/video/intelfb/intelfb.h
--- linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb.h	 
2006-06-14 11:13:02.000000000 -0500
+++ linux/drivers/video/intelfb/intelfb.h	2006-06-14  
11:14:03.000000000 -0500
@@ -119,6 +119,24 @@
/* Intel agpgart driver */
#define AGP_PHYSICAL_MEMORY     2
+/* these are outputs from the chip - integrated only
+   external chips are via DVO or SDVO output */
+#define INTELFB_OUTPUT_UNUSED 0
+#define INTELFB_OUTPUT_ANALOG 1
+#define INTELFB_OUTPUT_DVO 2
+#define INTELFB_OUTPUT_SDVO 3
+#define INTELFB_OUTPUT_LVDS 4
+#define INTELFB_OUTPUT_TVOUT 5
+
+#define INTELFB_DVO_CHIP_NONE 0
+#define INTELFB_DVO_CHIP_LVDS 1
+#define INTELFB_DVO_CHIP_TMDS 2
+#define INTELFB_DVO_CHIP_TVOUT 4
+
+#define INTELFB_OUTPUT_PIPE_NC  0
+#define INTELFB_OUTPUT_PIPE_A   1
+#define INTELFB_OUTPUT_PIPE_B   2
+
/*** Data Types ***/
/* supported chipsets */
@@ -221,6 +239,17 @@ struct intelfb_i2c_chan {
};
#endif
+struct intelfb_output_rec {
+    int type;
+    int pipe;
+    int flags;
+
+#ifdef CONFIG_FB_INTEL_I2C
+    struct intelfb_i2c_chan i2c_bus;
+    struct intelfb_i2c_chan ddc_bus;
+#endif
+};
+
struct intelfb_vsync {
	wait_queue_head_t wait;
	unsigned int count;
