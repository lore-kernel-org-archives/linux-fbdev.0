From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 2/3] drm/radeon/kms: allocate framebuffer cmap
Date: Mon, 02 Nov 2009 08:42:05 +0100
Message-ID: <4AEE8D4D.7070703@ladisch.de>
References: <4AEE8CDD.10600@ladisch.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754109AbZKBHop@vger.kernel.org>
In-Reply-To: <4AEE8CDD.10600@ladisch.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Without an allocated colormap, FBIOGETCMAP fails.  This would make
programs restore an all-black colormap ("links -g") or fail to work
altogether ("mplayer -vo fbdev2").

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- linux-2.6/drivers/gpu/drm/radeon/radeon_fb.c
+++ linux-2.6/drivers/gpu/drm/radeon/radeon_fb.c
@@ -242,6 +242,10 @@ int radeonfb_create(struct drm_device *d
 		goto out_unref;
 	}
 
+	ret = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (ret)
+		goto out_unref;
+
 	memset_io(fbptr, 0, aligned_size);
 
 	strcpy(info->fix.id, "radeondrmfb");
@@ -341,6 +345,7 @@ int radeonfb_remove(struct drm_device *d
 		radeon_object_kunmap(robj);
 		radeon_object_unpin(robj);
 		drm_fb_helper_free(&rfbdev->helper);
+		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
 	}
 
