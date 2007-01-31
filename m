From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 7/7] Cell: Draw SPE helper penguin logos
Date: Wed, 31 Jan 2007 13:44:19 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701311341480.15066@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701311325480.14996@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HCEp5-0007ly-2R for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 04:44:23 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HCEp2-0008Ul-Hy
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 04:44:23 -0800
In-Reply-To: <Pine.LNX.4.62.0701311325480.14996@pademelon.sonytel.be>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Let spu_management_ops.enumerate_spus() return the number of found SPEs
and use that information to draw some little helper penguin logos.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/cell/spu_base.c       |    7 +++++--
 arch/powerpc/platforms/cell/spu_priv1_mmio.c |    4 +++-
 arch/powerpc/platforms/ps3/spu.c             |    6 ++++--
 3 files changed, 12 insertions(+), 5 deletions(-)

--- ps3-linux-2.6.20-rc7.orig/arch/powerpc/platforms/cell/spu_base.c
+++ ps3-linux-2.6.20-rc7/arch/powerpc/platforms/cell/spu_base.c
@@ -31,6 +31,7 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 #include <linux/mutex.h>
+#include <linux/linux_logo.h>
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
 #include <asm/xmon.h>
@@ -676,16 +677,18 @@ static int __init init_spu_base(void)
 
 	ret = spu_enumerate_spus(create_spu);
 
-	if (ret) {
+	if (ret < 0) {
 		printk(KERN_WARNING "%s: Error initializing spus\n",
 			__FUNCTION__);
 		cleanup_spu_base();
 		return ret;
 	}
+	if (ret > 0)
+		fb_append_extra_logo(&logo_spe_clut224, ret);
 
 	xmon_register_spus(&spu_full_list);
 
-	return ret;
+	return 0;
 }
 module_init(init_spu_base);
 
--- ps3-linux-2.6.20-rc7.orig/arch/powerpc/platforms/cell/spu_priv1_mmio.c
+++ ps3-linux-2.6.20-rc7/arch/powerpc/platforms/cell/spu_priv1_mmio.c
@@ -331,6 +331,7 @@ static int __init of_enumerate_spus(int 
 {
 	int ret;
 	struct device_node *node;
+	unsigned int n = 0;
 
 	ret = -ENODEV;
 	for (node = of_find_node_by_type(NULL, "spe");
@@ -341,8 +342,9 @@ static int __init of_enumerate_spus(int 
 				__FUNCTION__, node->name);
 			break;
 		}
+		n++;
 	}
-	return ret;
+	return ret ? ret : n;
 }
 
 static int __init of_create_spu(struct spu *spu, void *data)
--- ps3-linux-2.6.20-rc7.orig/arch/powerpc/platforms/ps3/spu.c
+++ ps3-linux-2.6.20-rc7/arch/powerpc/platforms/ps3/spu.c
@@ -438,11 +438,13 @@ static int __init ps3_enumerate_spus(int
 		}
 	}
 
-	if (result)
+	if (result) {
 		printk(KERN_WARNING "%s:%d: Error initializing spus\n",
 			__func__, __LINE__);
+		return result;
+	}
 
-	return result;
+	return num_resource_id;
 }
 
 const struct spu_management_ops spu_management_ps3_ops = {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
