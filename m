From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 4/4] Cell: Draw SPE helper penguin logos
Date: Tue, 10 Jul 2007 14:27:06 +0200
Message-ID: <20070710123540.877411000@pademelon.sonytel.be>
References: <20070710122702.765654000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1635810034=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8ExT-0000n8-Tn for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jul 2007 05:36:48 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I8ExT-00037A-21
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jul 2007 05:36:47 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geoff Levand <geoffrey.levand@am.sony.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, James Simmons <jsimmons@infradead.org>, cbe-oss-dev@ozlabs.org

--===============1635810034==
Content-Disposition: inline; filename=spe-logo/logo-extra-spe-glue-2.6.21.diff

Let spu_management_ops.enumerate_spus() return the number of found SPEs
and use that information to draw some little helper penguin logos.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Acked-By: James Simmons <jsimmons@infradead.org>
---
 arch/powerpc/platforms/cell/spu_base.c   |   15 ++++++++++++++-
 arch/powerpc/platforms/cell/spu_manage.c |    4 +++-
 arch/powerpc/platforms/ps3/spu.c         |    6 ++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -31,6 +31,7 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 #include <linux/mutex.h>
+#include <linux/linux_logo.h>
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
 #include <asm/xmon.h>
@@ -603,12 +604,24 @@ static int __init init_spu_base(void)
 
 	ret = spu_enumerate_spus(create_spu);
 
-	if (ret) {
+	if (ret < 0) {
 		printk(KERN_WARNING "%s: Error initializing spus\n",
 			__FUNCTION__);
 		goto out_unregister_sysdev_class;
 	}
 
+	if (ret > 0) {
+		/*
+		 * We cannot put the forward declaration in
+		 * <linux/linux_logo.h> because of conflicting session type
+		 * conflicts for const and __initdata with different compiler
+		 * versions
+		 */
+		extern const struct linux_logo logo_spe_clut224;
+
+		fb_append_extra_logo(&logo_spe_clut224, ret);
+	}
+
 	xmon_register_spus(&spu_full_list);
 
 	return 0;
--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -279,6 +279,7 @@ static int __init of_enumerate_spus(int 
 {
 	int ret;
 	struct device_node *node;
+	unsigned int n = 0;
 
 	ret = -ENODEV;
 	for (node = of_find_node_by_type(NULL, "spe");
@@ -289,8 +290,9 @@ static int __init of_enumerate_spus(int 
 				__FUNCTION__, node->name);
 			break;
 		}
+		n++;
 	}
-	return ret;
+	return ret ? ret : n;
 }
 
 static int __init of_create_spu(struct spu *spu, void *data)
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -400,11 +400,13 @@ static int __init ps3_enumerate_spus(int
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

-- 
With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village ������ Da Vincilaan 7-D1 ������ B-1935 Zaventem ������ Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 ������ B-1840 Londerzeel ������ Belgium	
VAT BE 0413.825.160 ������ RPR Brussels	
Fortis Bank Zaventem ������ Swift GEBABEBB08A ������ IBAN BE39001382358619



--===============1635810034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1635810034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1635810034==--
