Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C11D689
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Feb 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709102253; cv=none; b=MU6tuXmyDuijIu+Lr8PBZPksAA0w0jY7WA4028MObDreZLdLcJ6B+3piAypPHLzdC+GoiI1yRJO5rhoOKSAF3pYgGuc0+rMdIBF5ums5qsoVgFyFyxtd6a5+s+2N2mPPBZL3zoWBCGOjOeYmSiUmAyVD1O1aneUzwboZjmUzcZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709102253; c=relaxed/simple;
	bh=Dq/9EYGpTQVaxDhJFiMnpFF7+26h119JJHSyGwcavBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDAc9GpL6xGvdxcwMBR1VZX0k7PqQ6JXSSJZXRfTOQ78fVF5vfiM+JBRLb5/AyK1SF+CPIgwZ1g10mt8gEZuHXS6RYRv8VhWWS7KoDS7c9GlEoKQC3vbhewcztuAFVu3lmqAK+e2xeRlFKnBa6SIAwnNuTabqH8iI/LFZXs1WM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=dKSl2fuv; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="dKSl2fuv"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id A43E5603C6;
	Wed, 28 Feb 2024 06:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1709102250;
	bh=Dq/9EYGpTQVaxDhJFiMnpFF7+26h119JJHSyGwcavBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dKSl2fuvEno5WCAAW9Z7OtUkalqREZVqfQhXjwh7Y3F0HhSQllL1DbCKca9FX/6vx
	 PEmt0n6D8y09sY+QorHH4lpes3Lb8+3JCfP3zWVv3M+n4GcoH+jsdQQBusy7ot6Nak
	 O2A0Yos5gtUEbIZYo1dZuOpUe7hwKhMBrPCIkPoTB7kCPYR9Wx3L7sQf55etqtTDQA
	 4uko9njCszGEXIf2LMqaVBWL5VtVhsyIbeUXmauU1gbINTYZDXGEglm80FEW79PQ5U
	 QHVbzMDUtqTY7tIW/cvMbL5VkkTBq9HxhcwDqNKLdHH1NDvXUZfb5z8TKIzcfuE3ve
	 6ls6wCWlaBF9A==
From: Tony Lindgren <tony@atomide.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v3 2/2] drm/omapdrm: Fix console with deferred ops
Date: Wed, 28 Feb 2024 08:35:32 +0200
Message-ID: <20240228063540.4444-3-tony@atomide.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240228063540.4444-1-tony@atomide.com>
References: <20240228063540.4444-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 95da53d63dcf ("drm/omapdrm: Use regular fbdev I/O helpers")
stopped console from updating for command mode displays because there is
no damage handling in fb_sys_write() unlike we had earlier in
drm_fb_helper_sys_write().

Let's fix the issue by adding FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS and
FB_DMAMEM_HELPERS_DEFERRED as suggested by Thomas. We cannot use the
FB_DEFAULT_DEFERRED_OPS as fb_deferred_io_mmap() won't work properly
for write-combine.

Fixes: 95da53d63dcf ("drm/omapdrm: Use regular fbdev I/O helpers")
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpu/drm/omapdrm/Kconfig      |  2 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c | 28 ++++++++++++++++++++++------
 drivers/video/fbdev/core/Kconfig     |  6 ++++++
 include/linux/fb.h                   |  4 ++++
 4 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/Kconfig b/drivers/gpu/drm/omapdrm/Kconfig
--- a/drivers/gpu/drm/omapdrm/Kconfig
+++ b/drivers/gpu/drm/omapdrm/Kconfig
@@ -4,7 +4,7 @@ config DRM_OMAP
 	depends on DRM && OF
 	depends on ARCH_OMAP2PLUS
 	select DRM_KMS_HELPER
-	select FB_DMAMEM_HELPERS if DRM_FBDEV_EMULATION
+	select FB_DMAMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
 	select VIDEOMODE_HELPERS
 	select HDMI
 	default n
diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -51,6 +51,10 @@ static void pan_worker(struct work_struct *work)
 	omap_gem_roll(bo, fbi->var.yoffset * npages);
 }
 
+FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS(omap_fbdev,
+				   drm_fb_helper_damage_range,
+				   drm_fb_helper_damage_area)
+
 static int omap_fbdev_pan_display(struct fb_var_screeninfo *var,
 		struct fb_info *fbi)
 {
@@ -78,11 +82,9 @@ static int omap_fbdev_pan_display(struct fb_var_screeninfo *var,
 
 static int omap_fbdev_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
-	struct drm_fb_helper *helper = info->par;
-	struct drm_framebuffer *fb = helper->fb;
-	struct drm_gem_object *bo = drm_gem_fb_get_obj(fb, 0);
+	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
 
-	return drm_gem_mmap_obj(bo, omap_gem_mmap_size(bo), vma);
+	return fb_deferred_io_mmap(info, vma);
 }
 
 static void omap_fbdev_fb_destroy(struct fb_info *info)
@@ -94,6 +96,7 @@ static void omap_fbdev_fb_destroy(struct fb_info *info)
 
 	DBG();
 
+	fb_deferred_io_cleanup(info);
 	drm_fb_helper_fini(helper);
 
 	omap_gem_unpin(bo);
@@ -104,15 +107,19 @@ static void omap_fbdev_fb_destroy(struct fb_info *info)
 	kfree(fbdev);
 }
 
+/*
+ * For now, we cannot use FB_DEFAULT_DEFERRED_OPS and fb_deferred_io_mmap()
+ * because we use write-combine.
+ */
 static const struct fb_ops omap_fb_ops = {
 	.owner = THIS_MODULE,
-	__FB_DEFAULT_DMAMEM_OPS_RDWR,
+	__FB_DEFAULT_DEFERRED_OPS_RDWR(omap_fbdev),
 	.fb_check_var	= drm_fb_helper_check_var,
 	.fb_set_par	= drm_fb_helper_set_par,
 	.fb_setcmap	= drm_fb_helper_setcmap,
 	.fb_blank	= drm_fb_helper_blank,
 	.fb_pan_display = omap_fbdev_pan_display,
-	__FB_DEFAULT_DMAMEM_OPS_DRAW,
+	__FB_DEFAULT_DEFERRED_OPS_DRAW(omap_fbdev),
 	.fb_ioctl	= drm_fb_helper_ioctl,
 	.fb_mmap	= omap_fbdev_fb_mmap,
 	.fb_destroy	= omap_fbdev_fb_destroy,
@@ -213,6 +220,15 @@ static int omap_fbdev_create(struct drm_fb_helper *helper,
 	fbi->fix.smem_start = dma_addr;
 	fbi->fix.smem_len = bo->size;
 
+	/* deferred I/O */
+	helper->fbdefio.delay = HZ / 20;
+	helper->fbdefio.deferred_io = drm_fb_helper_deferred_io;
+
+	fbi->fbdefio = &helper->fbdefio;
+	ret = fb_deferred_io_init(fbi);
+	if (ret)
+		goto fail;
+
 	/* if we have DMM, then we can use it for scrolling by just
 	 * shuffling pages around in DMM rather than doing sw blit.
 	 */
diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/core/Kconfig
--- a/drivers/video/fbdev/core/Kconfig
+++ b/drivers/video/fbdev/core/Kconfig
@@ -144,6 +144,12 @@ config FB_DMAMEM_HELPERS
 	select FB_SYS_IMAGEBLIT
 	select FB_SYSMEM_FOPS
 
+config FB_DMAMEM_HELPERS_DEFERRED
+	bool
+	depends on FB_CORE
+	select FB_DEFERRED_IO
+	select FB_DMAMEM_HELPERS
+
 config FB_IOMEM_FOPS
 	tristate
 	depends on FB_CORE
diff --git a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -686,6 +686,10 @@ extern int fb_deferred_io_fsync(struct file *file, loff_t start,
 	__FB_GEN_DEFAULT_DEFERRED_OPS_RDWR(__prefix, __damage_range, sys) \
 	__FB_GEN_DEFAULT_DEFERRED_OPS_DRAW(__prefix, __damage_area, sys)
 
+#define FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS(__prefix, __damage_range, __damage_area) \
+	__FB_GEN_DEFAULT_DEFERRED_OPS_RDWR(__prefix, __damage_range, sys) \
+	__FB_GEN_DEFAULT_DEFERRED_OPS_DRAW(__prefix, __damage_area, sys)
+
 /*
  * Initializes struct fb_ops for deferred I/O.
  */
-- 
2.43.1
