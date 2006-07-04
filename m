From: Aristeu Sergio Rozanski Filho <aris@valeta.org>
Subject: [PATCH] nvidiafb: don't use bl_mutex in
	nvidiafb_blank()
Date: Mon, 3 Jul 2006 22:39:58 -0300
Message-ID: <20060704013958.GI27596@cathedrallabs.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FxZtf-0007Iw-Ro for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 03 Jul 2006 18:40:16 -0700
Received: from tinc.cathedrallabs.org ([72.9.252.66])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FxZtf-00032f-Hk
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 03 Jul 2006 18:40:15 -0700
Received: from tate.cathedrallabs.org
	(201-25-166-92.ctame704.dsl.brasiltelecom.net.br [201.25.166.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tinc.cathedrallabs.org (Postfix) with ESMTP id DCCE51000A
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon,  3 Jul 2006 21:40:13 -0400 (EDT)
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

nvidiafb: remove usage of bl_mutex from nvidiafb_blank()

struct fb_info bl_mutex is used to protect bl_curve[] only, not needed in
nvidiafb_blank() and will cause a recursive mutex locking in
nvidia_bl_get_level_brightness()

Signed-off-by: Aristeu S. Rozanski F. <aris@valeta.org>

Index: ppc-2.6/drivers/video/nvidia/nvidia.c
===================================================================
--- ppc-2.6.orig/drivers/video/nvidia/nvidia.c	2006-07-03 20:08:07.000000000 -0300
+++ ppc-2.6/drivers/video/nvidia/nvidia.c	2006-07-03 20:08:16.000000000 -0300
@@ -934,14 +934,12 @@
 	NVWriteCrtc(par, 0x1a, vesa);
 
 #ifdef CONFIG_FB_NVIDIA_BACKLIGHT
-	mutex_lock(&info->bl_mutex);
 	if (info->bl_dev) {
 		down(&info->bl_dev->sem);
 		info->bl_dev->props->power = blank;
 		info->bl_dev->props->update_status(info->bl_dev);
 		up(&info->bl_dev->sem);
 	}
-	mutex_unlock(&info->bl_mutex);
 #endif
 
 	NVTRACE_LEAVE();


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
