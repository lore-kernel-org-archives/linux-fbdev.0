From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 1/3] drm/fb: fix FBIOGET/PUT_VSCREENINFO pixel clock handling
Date: Mon, 02 Nov 2009 08:41:13 +0100
Message-ID: <4AEE8D19.10305@ladisch.de>
References: <4AEE8CDD.10600@ladisch.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754059AbZKBHlL@vger.kernel.org>
In-Reply-To: <4AEE8CDD.10600@ladisch.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Dave Airlie <airlied@redhat.com>, dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

When the framebuffer driver does not publish detailed timing information
for the current video mode, the correct value for the pixclock field is
zero, not -1.

Since pixclock is actually unsigned, the value -1 would be interpreted
as 4294967295 picoseconds (i.e., about 4 milliseconds) by
register_framebuffer() and userspace programs.

This patch allows X.org's fbdev driver to work.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- linux-2.6/drivers/gpu/drm/drm_fb_helper.c
+++ linux-2.6/drivers/gpu/drm/drm_fb_helper.c
@@ -583,7 +583,7 @@ int drm_fb_helper_check_var(struct fb_va
 	struct drm_framebuffer *fb = fb_helper->fb;
 	int depth;
 
-	if (var->pixclock == -1 || !var->pixclock)
+	if (var->pixclock != 0)
 		return -EINVAL;
 
 	/* Need to resize the fb object !!! */
@@ -675,7 +675,7 @@ int drm_fb_helper_set_par(struct fb_info
 	int ret;
 	int i;
 
-	if (var->pixclock != -1) {
+	if (var->pixclock != 0) {
 		DRM_ERROR("PIXEL CLCOK SET\n");
 		return -EINVAL;
 	}
@@ -888,7 +888,7 @@ int drm_fb_helper_single_fb_probe(struct
 	fb_helper->fb = fb;
 
 	if (new_fb) {
-		info->var.pixclock = -1;
+		info->var.pixclock = 0;
 		if (register_framebuffer(info) < 0)
 			return -EINVAL;
 	} else {
