From: dmunsie@cecropia.com (Dennis Munsie)
Subject: [PATCH 2.6.17-rc6-mm2 5/8] intelfb: RESEND -
	add preliminary i2c support
Date: Tue, 20 Jun 2006 14:55:55 -0400 (EDT)
Message-ID: <20060620185555.2F11890CFB5@xenon>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FslKx-0003B5-51 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 11:52:31 -0700
Received: from mail6.sea5.speakeasy.net ([69.17.117.8])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FslKw-0001tE-UP
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

[05/07] intelfb: add output fields to dinfo.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

 drivers/video/intelfb/intelfb.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff -Naurp -X linux-2.6.17-rc6-patched/Documentation/dontdiff linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb.h linux/drivers/video/intelfb/intelfb.h
--- linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb.h	2006-06-14 12:34:07.000000000 -0500
+++ linux/drivers/video/intelfb/intelfb.h	2006-06-14 12:34:55.000000000 -0500
@@ -119,6 +119,11 @@
 /* Intel agpgart driver */
 #define AGP_PHYSICAL_MEMORY     2
 
+/* store information about an Ixxx DVO */
+/* The i830->i865 use multiple DVOs with multiple i2cs */
+/* the i915, i945 have a single sDVO i2c bus - which is different */
+#define MAX_OUTPUTS 6
+
 /* these are outputs from the chip - integrated only 
    external chips are via DVO or SDVO output */
 #define INTELFB_OUTPUT_UNUSED 0
@@ -344,6 +349,10 @@ struct intelfb_info {
 	
 	/* index into plls */
 	int pll_index;
+
+	/* outputs */
+	int num_outputs;
+	struct intelfb_output_rec output[MAX_OUTPUTS];
 };
 
 #define IS_I9XX(dinfo) (((dinfo)->chipset == INTEL_915G)||(dinfo->chipset == INTEL_915GM)||((dinfo)->chipset == INTEL_945G)||(dinfo->chipset==INTEL_945GM))
