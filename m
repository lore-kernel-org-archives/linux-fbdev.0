From: dmunsie@cecropia.com (Dennis Munsie)
Subject: [PATCH 2.6.17-rc6-mm2 8/8] intelfb: RESEND -
	add preliminary i2c support
Date: Tue, 20 Jun 2006 14:55:55 -0400 (EDT)
Message-ID: <20060620185555.392BB90CFB8@xenon>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FslL2-0003BZ-IV for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 11:52:36 -0700
Received: from mail6.sea5.speakeasy.net ([69.17.117.8])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FslKx-0001tv-W9
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 11:52:36 -0700
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

Adds code to unregister the I2C buses in the cleanup function.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

 drivers/video/intelfb/intelfb.h     |    1 +
 drivers/video/intelfb/intelfb_i2c.c |   16 ++++++++++++++++
 drivers/video/intelfb/intelfbdrv.c  |    5 +++++
 3 files changed, 22 insertions(+)

diff -Naurp -X linux-2.6.17-rc6-patched/Documentation/dontdiff linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb.h linux/drivers/video/intelfb/intelfb.h
--- linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb.h	2006-06-14 15:27:30.000000000 -0500
+++ linux/drivers/video/intelfb/intelfb.h	2006-06-16 08:38:25.000000000 -0500
@@ -367,6 +367,7 @@ extern int intelfb_var_to_depth(const st
 
 #ifdef CONFIG_FB_INTEL_I2C
 extern void intelfb_create_i2c_busses(struct intelfb_info *dinfo);
+extern void intelfb_delete_i2c_busses(struct intelfb_info *dinfo);
 #endif
 
 #endif /* _INTELFB_H */
diff -Naurp -X linux-2.6.17-rc6-patched/Documentation/dontdiff linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb_i2c.c linux/drivers/video/intelfb/intelfb_i2c.c
--- linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb_i2c.c	2006-06-14 15:27:30.000000000 -0500
+++ linux/drivers/video/intelfb/intelfb_i2c.c	2006-06-16 08:36:58.000000000 -0500
@@ -182,3 +182,19 @@ void intelfb_create_i2c_busses(struct in
 	}
 	dinfo->num_outputs = i;
 }
+
+void intelfb_delete_i2c_busses(struct intelfb_info *dinfo)
+{
+	int i;
+
+	for (i = 0; i < MAX_OUTPUTS; i++) {
+		if (dinfo->output[i].i2c_bus.dinfo) {
+			i2c_bit_del_bus(&dinfo->output[i].i2c_bus.adapter);
+			dinfo->output[i].i2c_bus.dinfo = NULL;
+		}
+		if (dinfo->output[i].ddc_bus.dinfo) {
+			i2c_bit_del_bus(&dinfo->output[i].ddc_bus.adapter);
+			dinfo->output[i].ddc_bus.dinfo = NULL;
+		}
+	}
+}
diff -Naurp -X linux-2.6.17-rc6-patched/Documentation/dontdiff linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfbdrv.c linux/drivers/video/intelfb/intelfbdrv.c
--- linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfbdrv.c	2006-06-14 15:27:30.000000000 -0500
+++ linux/drivers/video/intelfb/intelfbdrv.c	2006-06-16 08:47:31.000000000 -0500
@@ -474,6 +474,11 @@ cleanup(struct intelfb_info *dinfo)
 		agp_free_memory(dinfo->gtt_ring_mem);
 	}
 
+#ifdef CONFIG_FB_INTEL_I2C
+	/* un-register I2C bus */
+	intelfb_delete_i2c_busses(dinfo);
+#endif
+
 	if (dinfo->mmio_base)
 		iounmap((void __iomem *)dinfo->mmio_base);
 	if (dinfo->aperture.virtual)
