From: Aristeu Sergio Rozanski Filho <aris@valeta.org>
Subject: [PATCH] nvidiafb: fix
	nvidia_bl_get_level_brightness() calc
Date: Mon, 3 Jul 2006 22:39:37 -0300
Message-ID: <20060704013937.GH27596@cathedrallabs.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FxZtb-0007Il-C5 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 03 Jul 2006 18:40:11 -0700
Received: from tinc.cathedrallabs.org ([72.9.252.66])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FxZta-0002wF-42
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 03 Jul 2006 18:40:11 -0700
Received: from tate.cathedrallabs.org
	(201-25-166-92.ctame704.dsl.brasiltelecom.net.br [201.25.166.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tinc.cathedrallabs.org (Postfix) with ESMTP id 14E6610009
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon,  3 Jul 2006 21:39:58 -0400 (EDT)
Content-Disposition: inline
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

nvidiafb: fix nvidia_bl_get_level_brightness() level calc

Signed-off-by: Aristeu S. Rozanski F. <aris@valeta.org>

Index: ppc-2.6/drivers/video/nvidia/nv_backlight.c
===================================================================
--- ppc-2.6.orig/drivers/video/nvidia/nv_backlight.c	2006-07-03 17:38:06.000000000 -0300
+++ ppc-2.6/drivers/video/nvidia/nv_backlight.c	2006-07-03 20:11:08.000000000 -0300
@@ -26,6 +26,7 @@
  */
 #define MIN_LEVEL 0x158
 #define MAX_LEVEL 0x534
+#define LEVEL_STEP ((MAX_LEVEL - MIN_LEVEL) / FB_BACKLIGHT_MAX)
 
 static struct backlight_properties nvidia_bl_data;
 
@@ -37,7 +38,7 @@
 
 	/* Get and convert the value */
 	mutex_lock(&info->bl_mutex);
-	nlevel = info->bl_curve[level] * FB_BACKLIGHT_MAX / MAX_LEVEL;
+	nlevel = MIN_LEVEL + info->bl_curve[level] * LEVEL_STEP;
 	mutex_unlock(&info->bl_mutex);
 
 	if (nlevel < 0)


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
