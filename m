From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Fw: [PATCH][2.6.11-mm3] CONFIG_FB_ATY linkage error on PPC32
Date: Sun, 13 Mar 2005 17:08:03 -0500
Message-ID: <9e4733910503131408cd57b01@mail.gmail.com>
References: <20050313132844.7270c817.akpm@osdl.org>
	 <9e47339105031313553994f15a@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAcv7-0004D4-D5
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 15:54:53 -0800
Received: from rproxy.gmail.com ([64.233.170.205])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAcv6-00023n-TY
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 15:54:53 -0800
Received: by rproxy.gmail.com with SMTP id z35so2795672rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Mar 2005 15:54:43 -0800 (PST)
In-Reply-To: <9e47339105031313553994f15a@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Mikael Pettersson <mikpe@csd.uu.se>

This should be a more general fix. Mikael can you give it a try on ppc
since I don't have one?

If you have time it would also be helpful if you could try building
all of the ppc drivers both as modules and built-in just to make sure
they build.

There are 77 framebuffer drivers on eight platforms that need to be
checked. I tried to get them all right but I don't own all of the
needed hardware.

-- 
Jon Smirl
jonsmirl@gmail.com


===== drivers/video/Makefile 1.120 vs edited =====
--- 1.120/drivers/video/Makefile	2005-03-10 03:39:10 -05:00
+++ edited/drivers/video/Makefile	2005-03-13 16:56:53 -05:00
@@ -10,6 +10,9 @@
 
 obj-$(CONFIG_FB)                  += fb.o
 fb-y                              := fbmem.o fbmon.o fbcmap.o
fbsysfs.o modedb.o
+ifdef $(CONFIG-PPC)
+fb-y				  += macmodes.o
+endif
 fb-objs                           := $(fb-y)
 
 obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
@@ -41,9 +44,9 @@
 obj-$(CONFIG_FB_NEOMAGIC)         += neofb.o vgastate.o
 obj-$(CONFIG_FB_VIRGE)            += virgefb.o
 obj-$(CONFIG_FB_3DFX)             += tdfxfb.o
-obj-$(CONFIG_FB_CONTROL)          += controlfb.o macmodes.o
-obj-$(CONFIG_FB_PLATINUM)         += platinumfb.o macmodes.o
-obj-$(CONFIG_FB_VALKYRIE)         += valkyriefb.o macmodes.o
+obj-$(CONFIG_FB_CONTROL)          += controlfb.o
+obj-$(CONFIG_FB_PLATINUM)         += platinumfb.o
+obj-$(CONFIG_FB_VALKYRIE)         += valkyriefb.o
 obj-$(CONFIG_FB_CT65550)          += chipsfb.o
 obj-$(CONFIG_FB_IMSTT)            += imsttfb.o
 obj-$(CONFIG_FB_S3TRIO)           += S3triofb.o
@@ -61,7 +64,7 @@
 obj-$(CONFIG_FB_SGIVW)            += sgivwfb.o
 obj-$(CONFIG_FB_ACORN)            += acornfb.o
 obj-$(CONFIG_FB_ATARI)            += atafb.o
-obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o
+obj-$(CONFIG_FB_MAC)              += macfb.o
 obj-$(CONFIG_FB_HGA)              += hgafb.o
 obj-$(CONFIG_FB_IGA)              += igafb.o
 obj-$(CONFIG_FB_APOLLO)           += dnfb.o
===== drivers/video/macmodes.c 1.6 vs edited =====
--- 1.6/drivers/video/macmodes.c	2002-10-29 15:05:45 -05:00
+++ edited/drivers/video/macmodes.c	2005-03-13 17:01:03 -05:00
@@ -281,6 +281,7 @@
     var->vmode = mode->vmode;
     return 0;
 }
+EXPORT_SYMBOL(mac_vmode_to_var)
 
 
 /**
@@ -326,6 +327,7 @@
     }
     return -EINVAL;
 }
+EXPORT_SYMBOL(mac_var_to_vmode)
 
 
 /**
@@ -348,6 +350,7 @@
 	    break;
     return map->vmode;
 }
+EXPORT_SYMBOL(mac_map_monitor_sense)
 
 
 /**
@@ -370,7 +373,7 @@
  *
  */
 
-int __init mac_find_mode(struct fb_var_screeninfo *var, struct fb_info *info,
+int mac_find_mode(struct fb_var_screeninfo *var, struct fb_info *info,
 			 const char *mode_option, unsigned int default_bpp)
 {
     const struct fb_videomode *db = NULL;
@@ -384,3 +387,4 @@
     return fb_find_mode(var, info, mode_option, db, dbsize,
 			&mac_modedb[DEFAULT_MODEDB_INDEX], default_bpp);
 }
+EXPORT_SYMBOL(mac_find_mode)
===== drivers/video/macmodes.h 1.3 vs edited =====
--- 1.3/drivers/video/macmodes.h	2002-10-29 14:41:43 -05:00
+++ edited/drivers/video/macmodes.h	2005-03-13 17:01:32 -05:00
@@ -55,7 +55,7 @@
 extern int mac_var_to_vmode(const struct fb_var_screeninfo *var, int *vmode,
 			    int *cmode);
 extern int mac_map_monitor_sense(int sense);
-extern int __init mac_find_mode(struct fb_var_screeninfo *var,
+extern int mac_find_mode(struct fb_var_screeninfo *var,
 				struct fb_info *info, const char *mode_option,
 				unsigned int default_bpp);


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
