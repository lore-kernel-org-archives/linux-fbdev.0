From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 3/7 2.6.17-rc6-mm2] add preliminary i2c
	support to intelfb
Date: Wed, 14 Jun 2006 13:53:05 -0400
Message-ID: <B6AC359A-5990-4EB4-B69D-17F93F163AFB@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqZVY-0001CD-1M for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 10:50:24 -0700
Received: from mail6.sea5.speakeasy.net ([69.17.117.8])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FqZVX-0000bK-Ec
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 10:50:23 -0700
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

[03/07] intelfb: add intelfb_i2c_chan struct.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

drivers/video/intelfb/intelfb.h |   13 +++++++++++++
1 file changed, 13 insertions(+)

diff -Naurp -X linux-2.6.17-rc6-patched//Documentation/dontdiff  
linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb.h linux/ 
drivers/video/intelfb/intelfb.h
--- linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb.h	 
2006-06-14 10:27:39.000000000 -0500
+++ linux/drivers/video/intelfb/intelfb.h	2006-06-14  
10:29:39.000000000 -0500
@@ -6,6 +6,10 @@
#include <linux/agp_backend.h>
#include <linux/fb.h>
+#ifdef CONFIG_FB_INTEL_I2C
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#endif
/*** Version/name ***/
#define INTELFB_VERSION			"0.9.4"
@@ -208,6 +212,15 @@ struct intelfb_heap_data {
	u32 size;    // in bytes
};
+#ifdef CONFIG_FB_INTEL_I2C
+struct intelfb_i2c_chan {
+    struct intelfb_info *dinfo;
+    u32 reg;
+    struct i2c_adapter adapter;
+    struct i2c_algo_bit_data algo;
+};
+#endif
+
struct intelfb_vsync {
	wait_queue_head_t wait;
	unsigned int count;
