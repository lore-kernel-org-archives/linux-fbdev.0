From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: logos work/apply when?
Date: Fri, 13 Jul 2007 07:50:51 +0800
Message-ID: <1184284251.4566.3.camel@daplas>
References: <20070712130822.a8269fe0.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-0wks+aMEjJXHVTvbft+X"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I98R4-0004Jl-A8 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 16:51:02 -0700
Received: from nz-out-0506.google.com ([64.233.162.226])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I98R3-00058G-OM
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 16:51:02 -0700
Received: by nz-out-0506.google.com with SMTP id f1so835538nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jul 2007 16:51:00 -0700 (PDT)
In-Reply-To: <20070712130822.a8269fe0.rdunlap@xenotime.net>
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
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>


--=-0wks+aMEjJXHVTvbft+X
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2007-07-12 at 13:08 -0700, Randy Dunlap wrote: 
> Hi,
> 
> Is there some kernel config or video config (possibly set at boot time
> via vga=xyz or video=wxy) where one or more of the logos is not
> applicable?  or the other way:  are there certain kernel or video
> configs where only certain logos are applicable?
> 
> 
> I've tested vesafb with LOGO_LINUX_VGA16 but I can't see the logo.
> I do see an empty space for it at the top of the screen area, however.
> (booting with vga=0x317 in /etc/lilo.conf file)
> 
> When I use LOGO_LINUX_CLUT224 instead, I do see the logo.
> 
> or when I use FB_VGA16 instead of vesafb and also use LOGO_LINUX_VGA16,
> I can see the logo.
> 
> I'm just trying to understand when/why I should expect (or not expect)
> to see a logo (if it is enabled).

It's a bug. And I've been wanting to fix that for some time. Logo's with
depths <= the fb depth should still be shown. The problem is that VGA16
and monochrome logos do not contain color information, so we have to use
the console palette (and not create a new one). Try the attached patch.

Tony  


--=-0wks+aMEjJXHVTvbft+X
Content-Disposition: attachment; filename=fb_logo.diff
Content-Type: text/x-patch; name=fb_logo.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 7f3a0cc..b6a0a1c 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -244,8 +244,17 @@ static void fb_set_logo(struct fb_info *
 	u8 xor = (info->fix.visual == FB_VISUAL_MONO01) ? 0xff : 0;
 	u8 fg = 1, d;
 
-	if (fb_get_color_depth(&info->var, &info->fix) == 3)
-		fg = 7;
+	switch (fb_get_color_depth(&info->var, &info->fix)) {
+	case 1:
+		fg = 1;
+		break;
+	case 2:
+		fg = 3;
+		break;
+	default:
+		fg = 7; 
+		break;
+	}
 
 	if (info->fix.visual == FB_VISUAL_MONO01 ||
 	    info->fix.visual == FB_VISUAL_MONO10)
@@ -428,21 +437,6 @@ int fb_prepare_logo(struct fb_info *info
 		depth = 4;
 	}
 
-	if (depth >= 8) {
-		switch (info->fix.visual) {
-		case FB_VISUAL_TRUECOLOR:
-			fb_logo.needs_truepalette = 1;
-			break;
-		case FB_VISUAL_DIRECTCOLOR:
-			fb_logo.needs_directpalette = 1;
-			fb_logo.needs_cmapreset = 1;
-			break;
-		case FB_VISUAL_PSEUDOCOLOR:
-			fb_logo.needs_cmapreset = 1;
-			break;
-		}
-	}
-
 	/* Return if no suitable logo was found */
 	fb_logo.logo = fb_find_logo(depth);
 
@@ -467,6 +461,22 @@ int fb_prepare_logo(struct fb_info *info
 		fb_logo.depth = 4;
 	else
 		fb_logo.depth = 1;		
+
+	if (fb_logo.depth > 4 && depth >= 8) {
+		switch (info->fix.visual) {
+		case FB_VISUAL_TRUECOLOR:
+			fb_logo.needs_truepalette = 1;
+			break;
+		case FB_VISUAL_DIRECTCOLOR:
+			fb_logo.needs_directpalette = 1;
+			fb_logo.needs_cmapreset = 1;
+			break;
+		case FB_VISUAL_PSEUDOCOLOR:
+			fb_logo.needs_cmapreset = 1;
+			break;
+		}
+	}
+
 	return fb_logo.logo->height;
 }
 

--=-0wks+aMEjJXHVTvbft+X
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--=-0wks+aMEjJXHVTvbft+X
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--=-0wks+aMEjJXHVTvbft+X--
