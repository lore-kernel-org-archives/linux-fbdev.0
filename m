From: Takashi Yoshii <yoshii.takashi@renesas.com>
Subject: [PATCH] Do set var even if no fb_check_var()
	provided.
Date: Wed, 27 Aug 2008 14:09:00 +0900
Message-ID: <48B4E16C.4000107@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYDHJ-0000GA-2o for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 22:09:09 -0700
Received: from mail.renesas.com ([202.234.163.13] helo=mail06.idc.renesas.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYDHH-0002Zb-J1
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 22:09:09 -0700
Received: from guardian03.idc.renesas.com ([172.20.8.202])
	by mail06.idc.renesas.com (sendmail) with ESMTP id m7R590bX024258
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 27 Aug 2008 14:09:01 +0900 (JST)
Received: (from root@localhost)
	by guardian03.idc.renesas.com with  id m7R591x0028166
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 14:09:01 +0900 (JST)
Received: from mta01.idc.renesas.com (localhost [127.0.0.1])
	by mta01.idc.renesas.com with ESMTP id m7R5908x016321
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 27 Aug 2008 14:09:01 +0900 (JST)
Received: from [172.30.8.103] by ims05.idc.renesas.com (Sendmail)
	with ESMTPA id <0K6800MLYUB0CW@ims05.idc.renesas.com> for
	linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 14:09:00 +0900 (JST)
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

The behavior of FBIOSET_VSCREENINFO seems to be weired on FB which does not
 provides fbops->fb_check_var.
It doesn't set anything, but gets info->var instead, and returns no error.
It is just same as FBIOGET_VSCREENINFO does.

IMHO, this should be one of the following candidates,
 1. set var without check.
 2. do nothing but return error (setting var is not supported).
or
 3. it's a bug (fb_check_var should always be provided).

The patch at the bottom implements "1".

Because I don't know API specification, nor the history of the code, 
I would like people who knows well to discuss this.

Regards,
/yoshii
---
drivers/video/fbmem.c:fb_set_var()
 Do set_var even if fbops->fb_check_var == NULL.
 Possible API change of ioctl(FBIOSET_VSCREENINFO).

Signed-off-by: Takashi YOSHII <yoshii.takashi@renesas.com>

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 776f7fc..6fc2ba6 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -939,16 +939,12 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 	    memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
 		u32 activate = var->activate;
 
-		if (!info->fbops->fb_check_var) {
-			*var = info->var;
-			goto done;
+		if (info->fbops->fb_check_var) {
+			ret = info->fbops->fb_check_var(var, info);
+			if (ret)
+				goto done;
 		}
 
-		ret = info->fbops->fb_check_var(var, info);
-
-		if (ret)
-			goto done;
-
 		if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
 			struct fb_videomode mode;
 
-- 
1.5.4.5


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
