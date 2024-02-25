Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125E49443
	for <linux-fbdev@vger.kernel.org>; Sun, 25 Feb 2024 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708843703; cv=none; b=mkCZfV0bS1gmJIikePcGtli7YsWy/sstopBPAyqNoJZJxRQmDzdj+vSjw0XqgSXf9MtZH6AP7D75etlwKs28AnNplb3OJMJ+GELnFMYsnEmigTmbdRB7k2XA3T+egP0xRDoDOYjmWhdkDUUd4O+QaSA3Z2NJCJL7A9nBQD/Bsvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708843703; c=relaxed/simple;
	bh=//3XwbGD2GXWwLU1X/o/2yik97bqwVWkSwt/JNFXnMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XX/dHeGc/f6jDNUusIQi8LI93zCENLQUrp2D4Wins0ERCv/HDbn/oHBimisYQi/0D3ZdbXST3Pw7wzjzkj/6MY7ciOkQLzDXgsLtSgHepQeVitilZHZFVpiViyUXQqXgu8RhByHLlmCuurKCrTEIoBlASKNT9xq164pnDYmjlCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=PS7sC/9B; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="PS7sC/9B"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 570006049D;
	Sun, 25 Feb 2024 06:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1708843701;
	bh=//3XwbGD2GXWwLU1X/o/2yik97bqwVWkSwt/JNFXnMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PS7sC/9BwFjlewIegGb+gKGhXLB3rVDiQ6NMigmYeaA3CASWTBuIl0DVvkmbiaDwo
	 aPTbwYTLrwgCDVFqejGP2ztlt4yciJYYWc9ZrJwQjZ+12radimpCMfNAE/++GA0mqN
	 IGchUQDKGAmOiAG52N6ROleFbS692BaBJ40NVIpBXI3S17XHXPvh5whwpQVGx5rhxA
	 ZmNXjJPgDaZFB19V7Mi8UJDGcd7l+a6ht6HFBQLH6KthyS4MZFbaulXgjKEqybdOLl
	 F+1v4tH7YLZ0x0u09V15iEAKwV99PqCZRCWVgzs3y0rM8v32/BAjQSmYP7yzdxdbbR
	 1qXmueBAFx3Yg==
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
Subject: [PATCH v2 2/2] drm/omapdrm: Fix console with deferred ops
Date: Sun, 25 Feb 2024 08:46:55 +0200
Message-ID: <20240225064700.48035-3-tony@atomide.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240225064700.48035-1-tony@atomide.com>
References: <20240225064700.48035-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 95da53d63dcf ("drm/omapdrm: Use regular fbdev I/O helpers")
broke console because there is no damage handling in fb_sys_write()
unlike we have in drm_fb_helper_sys_write().

Let's fix the issue by adding FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS to
use with FB_DEFAULT_DEFERRED_OPS as suggested by Thomas. We no longer
need omap_fbdev_fb_mmap() as FB_DEFAULT_DEFERRED_OPS sets it to
fb_deferred_io_mmap().

Fixes: 95da53d63dcf ("drm/omapdrm: Use regular fbdev I/O helpers")
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpu/drm/omapdrm/omap_fbdev.c | 27 +++++++++++++++------------
 include/linux/fb.h                   |  4 ++++
 2 files changed, 19 insertions(+), 12 deletions(-)

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
@@ -76,15 +80,6 @@ static int omap_fbdev_pan_display(struct fb_var_screeninfo *var,
 	return drm_fb_helper_pan_display(var, fbi);
 }
 
-static int omap_fbdev_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
-{
-	struct drm_fb_helper *helper = info->par;
-	struct drm_framebuffer *fb = helper->fb;
-	struct drm_gem_object *bo = drm_gem_fb_get_obj(fb, 0);
-
-	return drm_gem_mmap_obj(bo, omap_gem_mmap_size(bo), vma);
-}
-
 static void omap_fbdev_fb_destroy(struct fb_info *info)
 {
 	struct drm_fb_helper *helper = info->par;
@@ -94,6 +89,7 @@ static void omap_fbdev_fb_destroy(struct fb_info *info)
 
 	DBG();
 
+	fb_deferred_io_cleanup(info);
 	drm_fb_helper_fini(helper);
 
 	omap_gem_unpin(bo);
@@ -106,15 +102,13 @@ static void omap_fbdev_fb_destroy(struct fb_info *info)
 
 static const struct fb_ops omap_fb_ops = {
 	.owner = THIS_MODULE,
-	__FB_DEFAULT_DMAMEM_OPS_RDWR,
+	FB_DEFAULT_DEFERRED_OPS(omap_fbdev),
 	.fb_check_var	= drm_fb_helper_check_var,
 	.fb_set_par	= drm_fb_helper_set_par,
 	.fb_setcmap	= drm_fb_helper_setcmap,
 	.fb_blank	= drm_fb_helper_blank,
 	.fb_pan_display = omap_fbdev_pan_display,
-	__FB_DEFAULT_DMAMEM_OPS_DRAW,
 	.fb_ioctl	= drm_fb_helper_ioctl,
-	.fb_mmap	= omap_fbdev_fb_mmap,
 	.fb_destroy	= omap_fbdev_fb_destroy,
 };
 
@@ -213,6 +207,15 @@ static int omap_fbdev_create(struct drm_fb_helper *helper,
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
