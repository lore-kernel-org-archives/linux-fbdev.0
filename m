From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 3/3] drm/i915: allocate framebuffer cmap
Date: Mon, 02 Nov 2009 08:42:39 +0100
Message-ID: <4AEE8D6F.60209@ladisch.de>
References: <4AEE8CDD.10600@ladisch.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754067AbZKBHmi@vger.kernel.org>
In-Reply-To: <4AEE8CDD.10600@ladisch.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Dave Airlie <airlied@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Without an allocated colormap, FBIOGETCMAP fails.  This would make
programs restore an all-black colormap ("links -g") or fail to work
altogether ("mplayer -vo fbdev2").

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
Untested.

--- linux-2.6/drivers/gpu/drm/i915/intel_fb.c
+++ linux-2.6/drivers/gpu/drm/i915/intel_fb.c
@@ -227,6 +227,10 @@ static int intelfb_create(struct drm_dev
 
 	fb->fbdev = info;
 
+	ret = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (ret)
+		goto out_unpin;
+
 	par->intel_fb = intel_fb;
 
 	/* To allow resizeing without swapping buffers */
@@ -270,6 +274,7 @@ int intelfb_remove(struct drm_device *de
 		iounmap(info->screen_base);
 		if (info->par)
 			drm_fb_helper_free(&par->helper);
+		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
 	}
 
