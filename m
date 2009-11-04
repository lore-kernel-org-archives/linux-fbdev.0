From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH v3 3/3] drm/kms: allocate framebuffer cmap
Date: Wed, 04 Nov 2009 09:43:00 +0100
Message-ID: <4AF13E94.7030909@ladisch.de>
References: <4AEE8CDD.10600@ladisch.de> <4AEE8D6F.60209@ladisch.de> <alpine.LFD.2.00.0911021431360.30135@casper.infradead.org> <4AF01F72.2030605@ladisch.de> <4AF01FFD.50409@ladisch.de> <alpine.LFD.2.00.0911031718160.14442@casper.infradead.org> <4AF13E04.8000005@ladisch.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754784AbZKDInA@vger.kernel.org>
In-Reply-To: <4AF13E04.8000005@ladisch.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Dave Airlie <airlied@redhat.com>, dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Without an allocated colormap, FBIOGETCMAP fails.  This would make
programs restore an all-black colormap ("links -g") or fail to work
altogether ("mplayer -vo fbdev2").

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
v3: bugfix by James Simmons

 drivers/gpu/drm/drm_fb_helper.c |   7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6/drivers/gpu/drm/drm_fb_helper.c
+++ linux-2.6/drivers/gpu/drm/drm_fb_helper.c
@@ -905,8 +905,13 @@ int drm_fb_helper_single_fb_probe(struct
 
 	if (new_fb) {
 		info->var.pixclock = 0;
-		if (register_framebuffer(info) < 0)
+		ret = fb_alloc_cmap(&info->cmap, crtc->gamma_size, 0);
+		if (ret)
+			return ret;
+		if (register_framebuffer(info) < 0) {
+			fb_dealloc_cmap(&info->cmap);
 			return -EINVAL;
+		}
 	} else {
 		drm_fb_helper_set_par(info);
 	}
@@ -936,6 +941,7 @@ void drm_fb_helper_free(struct drm_fb_he
 		unregister_sysrq_key('v', &sysrq_drm_fb_helper_restore_op);
 	}
 	drm_fb_helper_crtc_free(helper);
+	fb_dealloc_cmap(&helper->fb->fbdev->cmap);
 }
 EXPORT_SYMBOL(drm_fb_helper_free);
 
