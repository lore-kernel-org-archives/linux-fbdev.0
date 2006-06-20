From: dmunsie@cecropia.com (Dennis Munsie)
Subject: [PATCH 2.6.17-rc6-mm2 3/8] intelfb: RESEND -
	add preliminary i2c support
Date: Tue, 20 Jun 2006 14:55:55 -0400 (EDT)
Message-ID: <20060620185555.2A76390CFB3@xenon>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FslKx-0003B6-63 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 11:52:31 -0700
Received: from mail8.sea5.speakeasy.net ([69.17.117.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FslKw-0001tC-Ur
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 11:52:31 -0700
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
Cc: ehustvedt@cecropia.com, airlied@skynet.ie

From: Dennis Munsie <dmunsie@cecropia.com>

[03/07] intelfb: add intelfb_i2c_chan struct.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

 drivers/video/intelfb/intelfb.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff -Naurp -X linux-2.6.17-rc6-patched//Documentation/dontdiff linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb.h linux/drivers/video/intelfb/intelfb.h
--- linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb.h	2006-06-14 10:27:39.000000000 -0500
+++ linux/drivers/video/intelfb/intelfb.h	2006-06-14 10:29:39.000000000 -0500
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
