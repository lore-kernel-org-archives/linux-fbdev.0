From: Guido Guenther <agx@sigxcpu.org>
Subject: [patch] rivafb: use constants instead of magic
	values
Date: Sat, 22 Jul 2006 18:40:50 +0200
Message-ID: <20060722164050.GA5630@bogon.ms20.nix>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G4KXk-0007gR-0o for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Jul 2006 09:41:32 -0700
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G4KXj-00035g-EN
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Jul 2006 09:41:32 -0700
Received: from localhost (localhost.localnet [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 09C643A993
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 22 Jul 2006 18:41:22 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
	by localhost (honk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18067-12 for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 22 Jul 2006 18:41:21 +0200 (CEST)
Received: from bogon.sigxcpu.org (p54A8DF3C.dip.t-dialin.net [84.168.223.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 934FE3A992
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 22 Jul 2006 18:41:19 +0200 (CEST)
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

Hi,
this minor patch against current git uses (MIN/MAX)_LEVEL and
FB_(UN)BLANK instead of the valuees they are defined to. Please apply.
Cheers,
 -- Guido

diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 33dddba..2ae214b 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -389,8 +389,8 @@ #endif
 	mutex_lock(&info->bl_mutex);
 	info->bl_dev = bd;
 	fb_bl_default_curve(info, 0,
-		0x158 * FB_BACKLIGHT_MAX / MAX_LEVEL,
-		0x534 * FB_BACKLIGHT_MAX / MAX_LEVEL);
+		MIN_LEVEL * FB_BACKLIGHT_MAX / MAX_LEVEL,
+		FB_BACKLIGHT_MAX);
 	mutex_unlock(&info->bl_mutex);
 
 	up(&bd->sem);
@@ -780,7 +780,7 @@ static void riva_load_video_mode(struct 
 	
 	NVTRACE_ENTER();
 	/* time to calculate */
-	rivafb_blank(1, info);
+	rivafb_blank(FB_BLANK_NORMAL, info);
 
 	bpp = info->var.bits_per_pixel;
 	if (bpp == 16 && info->var.green.length == 5)
@@ -913,7 +913,7 @@ static void riva_load_video_mode(struct 
 	par->current_state = newmode;
 	riva_load_state(par, &par->current_state);
 	par->riva.LockUnlock(&par->riva, 0); /* important for HW cursor */
-	rivafb_blank(0, info);
+	rivafb_blank(FB_BLANK_UNBLANK, info);
 	NVTRACE_LEAVE();
 }
 

Signed-Off-By: Guido Guenther <agx@sigxcpu.org>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
