From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH v2 3/3] drm/kms: allocate framebuffer cmap
Date: Tue, 03 Nov 2009 13:20:13 +0100
Message-ID: <4AF01FFD.50409@ladisch.de>
References: <4AEE8CDD.10600@ladisch.de> <4AEE8D6F.60209@ladisch.de> <alpine.LFD.2.00.0911021431360.30135@casper.infradead.org> <4AF01F72.2030605@ladisch.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754006AbZKCMUO@vger.kernel.org>
In-Reply-To: <4AF01F72.2030605@ladisch.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Without an allocated colormap, FBIOGETCMAP fails.  This would make
programs restore an all-black colormap ("links -g") or fail to work
altogether ("mplayer -vo fbdev2").

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
v2: implemented suggestions by James Simmons

 drivers/gpu/drm/drm_fb_helper.c |   4 ++++
 1 file changed, 4 insertions(+)

--- linux-2.6/drivers/gpu/drm/drm_fb_helper.c
+++ linux-2.6/drivers/gpu/drm/drm_fb_helper.c
@@ -905,6 +905,9 @@ int drm_fb_helper_single_fb_probe(struct
 
 	if (new_fb) {
 		info->var.pixclock = 0;
+		ret = fb_alloc_cmap(&info->cmap, crtc->gamma_size, 0);
+		if (ret)
+			return ret;
 		if (register_framebuffer(info) < 0)
 			return -EINVAL;
 	} else {
@@ -936,6 +939,7 @@ void drm_fb_helper_free(struct drm_fb_he
 		unregister_sysrq_key('v', &sysrq_drm_fb_helper_restore_op);
 	}
 	drm_fb_helper_crtc_free(helper);
+	fb_dealloc_cmap(&helper->fb->fbdev->cmap);
 }
 EXPORT_SYMBOL(drm_fb_helper_free);
 
