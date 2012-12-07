From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 07 Dec 2012 11:55:06 +0000
Subject: [PATCH 2/5] OMAPFB: simplify locking
Message-Id: <1354881309-17625-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>

Kernel lock verification code has lately detected possible circular
locking in omapfb. The exact problem is unclear, but omapfb's current
locking seems to be overly complex.

This patch simplifies the locking in the following ways:

- Remove explicit omapfb mem region locking. I couldn't figure out the
  need for this, as long as we take care to take omapfb lock.

- Get omapfb lock always, even if the operation is possibly only related
  to one fb_info. Better safe than sorry, and normally there's only one
  user for the fb so this shouldn't matter.

- Make sure fb_info lock is taken first, then omapfb lock.

With this patch the warnings about possible circular locking does not
happen anymore.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   65 +++-------------------
 drivers/video/omap2/omapfb/omapfb-main.c  |   40 ++++----------
 drivers/video/omap2/omapfb/omapfb-sysfs.c |   84 +++++++++++++++++++----------
 drivers/video/omap2/omapfb/omapfb.h       |   19 -------
 4 files changed, 73 insertions(+), 135 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 94de47e..ae7aac7 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -85,16 +85,6 @@ static int omapfb_setup_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 		goto out;
 	}
 
-	/* Take the locks in a specific order to keep lockdep happy */
-	if (old_rg->id < new_rg->id) {
-		omapfb_get_mem_region(old_rg);
-		omapfb_get_mem_region(new_rg);
-	} else if (new_rg->id < old_rg->id) {
-		omapfb_get_mem_region(new_rg);
-		omapfb_get_mem_region(old_rg);
-	} else
-		omapfb_get_mem_region(old_rg);
-
 	if (pi->enabled && !new_rg->size) {
 		/*
 		 * This plane's memory was freed, can't enable it
@@ -146,16 +136,6 @@ static int omapfb_setup_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 			goto undo;
 	}
 
-	/* Release the locks in a specific order to keep lockdep happy */
-	if (old_rg->id > new_rg->id) {
-		omapfb_put_mem_region(old_rg);
-		omapfb_put_mem_region(new_rg);
-	} else if (new_rg->id > old_rg->id) {
-		omapfb_put_mem_region(new_rg);
-		omapfb_put_mem_region(old_rg);
-	} else
-		omapfb_put_mem_region(old_rg);
-
 	return 0;
 
  undo:
@@ -166,15 +146,6 @@ static int omapfb_setup_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 
 	ovl->set_overlay_info(ovl, &old_info);
  put_mem:
-	/* Release the locks in a specific order to keep lockdep happy */
-	if (old_rg->id > new_rg->id) {
-		omapfb_put_mem_region(old_rg);
-		omapfb_put_mem_region(new_rg);
-	} else if (new_rg->id > old_rg->id) {
-		omapfb_put_mem_region(new_rg);
-		omapfb_put_mem_region(old_rg);
-	} else
-		omapfb_put_mem_region(old_rg);
  out:
 	dev_err(fbdev->dev, "setup_plane failed\n");
 
@@ -222,9 +193,6 @@ static int omapfb_setup_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
 
 	rg = ofbi->region;
 
-	down_write_nested(&rg->lock, rg->id);
-	atomic_inc(&rg->lock_count);
-
 	if (rg->size = size && rg->type = mi->type)
 		goto out;
 
@@ -257,9 +225,6 @@ static int omapfb_setup_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
 	}
 
  out:
-	atomic_dec(&rg->lock_count);
-	up_write(&rg->lock);
-
 	return r;
 }
 
@@ -268,14 +233,12 @@ static int omapfb_query_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
 	struct omapfb_info *ofbi = FB2OFB(fbi);
 	struct omapfb2_mem_region *rg;
 
-	rg = omapfb_get_mem_region(ofbi->region);
+	rg = ofbi->region;
 	memset(mi, 0, sizeof(*mi));
 
 	mi->size = rg->size;
 	mi->type = rg->type;
 
-	omapfb_put_mem_region(rg);
-
 	return 0;
 }
 
@@ -314,14 +277,10 @@ int omapfb_set_update_mode(struct fb_info *fbi,
 	if (mode != OMAPFB_AUTO_UPDATE && mode != OMAPFB_MANUAL_UPDATE)
 		return -EINVAL;
 
-	omapfb_lock(fbdev);
-
 	d = get_display_data(fbdev, display);
 
-	if (d->update_mode = mode) {
-		omapfb_unlock(fbdev);
+	if (d->update_mode = mode)
 		return 0;
-	}
 
 	r = 0;
 
@@ -337,8 +296,6 @@ int omapfb_set_update_mode(struct fb_info *fbi,
 			r = -EINVAL;
 	}
 
-	omapfb_unlock(fbdev);
-
 	return r;
 }
 
@@ -353,14 +310,10 @@ int omapfb_get_update_mode(struct fb_info *fbi,
 	if (!display)
 		return -EINVAL;
 
-	omapfb_lock(fbdev);
-
 	d = get_display_data(fbdev, display);
 
 	*mode = d->update_mode;
 
-	omapfb_unlock(fbdev);
-
 	return 0;
 }
 
@@ -420,13 +373,10 @@ static int omapfb_set_color_key(struct fb_info *fbi,
 		struct omapfb_color_key *ck)
 {
 	struct omapfb_info *ofbi = FB2OFB(fbi);
-	struct omapfb2_device *fbdev = ofbi->fbdev;
 	int r;
 	int i;
 	struct omap_overlay_manager *mgr = NULL;
 
-	omapfb_lock(fbdev);
-
 	for (i = 0; i < ofbi->num_overlays; i++) {
 		if (ofbi->overlays[i]->manager) {
 			mgr = ofbi->overlays[i]->manager;
@@ -441,8 +391,6 @@ static int omapfb_set_color_key(struct fb_info *fbi,
 
 	r = _omapfb_set_color_key(mgr, ck);
 err:
-	omapfb_unlock(fbdev);
-
 	return r;
 }
 
@@ -450,13 +398,10 @@ static int omapfb_get_color_key(struct fb_info *fbi,
 		struct omapfb_color_key *ck)
 {
 	struct omapfb_info *ofbi = FB2OFB(fbi);
-	struct omapfb2_device *fbdev = ofbi->fbdev;
 	struct omap_overlay_manager *mgr = NULL;
 	int r = 0;
 	int i;
 
-	omapfb_lock(fbdev);
-
 	for (i = 0; i < ofbi->num_overlays; i++) {
 		if (ofbi->overlays[i]->manager) {
 			mgr = ofbi->overlays[i]->manager;
@@ -471,8 +416,6 @@ static int omapfb_get_color_key(struct fb_info *fbi,
 
 	*ck = omapfb_color_keys[mgr->id];
 err:
-	omapfb_unlock(fbdev);
-
 	return r;
 }
 
@@ -599,6 +542,8 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 
 	int r = 0;
 
+	omapfb_lock(fbdev);
+
 	switch (cmd) {
 	case OMAPFB_SYNC_GFX:
 		DBG("ioctl SYNC_GFX\n");
@@ -904,6 +849,8 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 		r = -EINVAL;
 	}
 
+	omapfb_unlock(fbdev);
+
 	if (r < 0)
 		DBG("ioctl failed: %d\n", r);
 
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 1a69d7c..28b2a21 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -672,8 +672,6 @@ int check_fb_var(struct fb_info *fbi, struct fb_var_screeninfo *var)
 
 	DBG("check_fb_var %d\n", ofbi->id);
 
-	WARN_ON(!atomic_read(&ofbi->region->lock_count));
-
 	r = fb_mode_to_dss_mode(var, &mode);
 	if (r) {
 		DBG("cannot convert var to omap dss mode\n");
@@ -855,8 +853,6 @@ int omapfb_setup_overlay(struct fb_info *fbi, struct omap_overlay *ovl,
 	int rotation = var->rotate;
 	int i;
 
-	WARN_ON(!atomic_read(&ofbi->region->lock_count));
-
 	for (i = 0; i < ofbi->num_overlays; i++) {
 		if (ovl != ofbi->overlays[i])
 			continue;
@@ -948,8 +944,6 @@ int omapfb_apply_changes(struct fb_info *fbi, int init)
 		fill_fb(fbi);
 #endif
 
-	WARN_ON(!atomic_read(&ofbi->region->lock_count));
-
 	for (i = 0; i < ofbi->num_overlays; i++) {
 		ovl = ofbi->overlays[i];
 
@@ -1008,15 +1002,16 @@ err:
 static int omapfb_check_var(struct fb_var_screeninfo *var, struct fb_info *fbi)
 {
 	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
 	int r;
 
 	DBG("check_var(%d)\n", FB2OFB(fbi)->id);
 
-	omapfb_get_mem_region(ofbi->region);
+	omapfb_lock(fbdev);
 
 	r = check_fb_var(fbi, var);
 
-	omapfb_put_mem_region(ofbi->region);
+	omapfb_unlock(fbdev);
 
 	return r;
 }
@@ -1025,11 +1020,12 @@ static int omapfb_check_var(struct fb_var_screeninfo *var, struct fb_info *fbi)
 static int omapfb_set_par(struct fb_info *fbi)
 {
 	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
 	int r;
 
 	DBG("set_par(%d)\n", FB2OFB(fbi)->id);
 
-	omapfb_get_mem_region(ofbi->region);
+	omapfb_lock(fbdev);
 
 	set_fb_fix(fbi);
 
@@ -1040,7 +1036,7 @@ static int omapfb_set_par(struct fb_info *fbi)
 	r = omapfb_apply_changes(fbi, 0);
 
  out:
-	omapfb_put_mem_region(ofbi->region);
+	omapfb_unlock(fbdev);
 
 	return r;
 }
@@ -1049,6 +1045,7 @@ static int omapfb_pan_display(struct fb_var_screeninfo *var,
 		struct fb_info *fbi)
 {
 	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
 	struct fb_var_screeninfo new_var;
 	int r;
 
@@ -1064,11 +1061,11 @@ static int omapfb_pan_display(struct fb_var_screeninfo *var,
 
 	fbi->var = new_var;
 
-	omapfb_get_mem_region(ofbi->region);
+	omapfb_lock(fbdev);
 
 	r = omapfb_apply_changes(fbi, 0);
 
-	omapfb_put_mem_region(ofbi->region);
+	omapfb_unlock(fbdev);
 
 	return r;
 }
@@ -1077,18 +1074,14 @@ static void mmap_user_open(struct vm_area_struct *vma)
 {
 	struct omapfb2_mem_region *rg = vma->vm_private_data;
 
-	omapfb_get_mem_region(rg);
 	atomic_inc(&rg->map_count);
-	omapfb_put_mem_region(rg);
 }
 
 static void mmap_user_close(struct vm_area_struct *vma)
 {
 	struct omapfb2_mem_region *rg = vma->vm_private_data;
 
-	omapfb_get_mem_region(rg);
 	atomic_dec(&rg->map_count);
-	omapfb_put_mem_region(rg);
 }
 
 static struct vm_operations_struct mmap_user_ops = {
@@ -1112,7 +1105,7 @@ static int omapfb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 		return -EINVAL;
 	off = vma->vm_pgoff << PAGE_SHIFT;
 
-	rg = omapfb_get_mem_region(ofbi->region);
+	rg = ofbi->region;
 
 	start = omapfb_get_region_paddr(ofbi);
 	len = fix->smem_len;
@@ -1140,13 +1133,9 @@ static int omapfb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 	/* vm_ops.open won't be called for mmap itself. */
 	atomic_inc(&rg->map_count);
 
-	omapfb_put_mem_region(rg);
-
 	return 0;
 
  error:
-	omapfb_put_mem_region(ofbi->region);
-
 	return r;
 }
 
@@ -1918,7 +1907,6 @@ static int omapfb_create_framebuffers(struct omapfb2_device *fbdev)
 
 		ofbi->region = &fbdev->regions[i];
 		ofbi->region->id = i;
-		init_rwsem(&ofbi->region->lock);
 
 		/* assign these early, so that fb alloc can use them */
 		ofbi->rotation_type = def_vrfb ? OMAP_DSS_ROT_VRFB :
@@ -1950,12 +1938,8 @@ static int omapfb_create_framebuffers(struct omapfb2_device *fbdev)
 	/* setup fb_infos */
 	for (i = 0; i < fbdev->num_fbs; i++) {
 		struct fb_info *fbi = fbdev->fbs[i];
-		struct omapfb_info *ofbi = FB2OFB(fbi);
 
-		omapfb_get_mem_region(ofbi->region);
 		r = omapfb_fb_init(fbdev, fbi);
-		omapfb_put_mem_region(ofbi->region);
-
 		if (r) {
 			dev_err(fbdev->dev, "failed to setup fb_info\n");
 			return r;
@@ -1987,12 +1971,8 @@ static int omapfb_create_framebuffers(struct omapfb2_device *fbdev)
 
 	for (i = 0; i < fbdev->num_fbs; i++) {
 		struct fb_info *fbi = fbdev->fbs[i];
-		struct omapfb_info *ofbi = FB2OFB(fbi);
 
-		omapfb_get_mem_region(ofbi->region);
 		r = omapfb_apply_changes(fbi, 1);
-		omapfb_put_mem_region(ofbi->region);
-
 		if (r) {
 			dev_err(fbdev->dev, "failed to change mode\n");
 			return r;
diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/omap2/omapfb/omapfb-sysfs.c
index 17aa174..6614462 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -49,6 +49,7 @@ static ssize_t store_rotate_type(struct device *dev,
 {
 	struct fb_info *fbi = dev_get_drvdata(dev);
 	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
 	struct omapfb2_mem_region *rg;
 	int rot_type;
 	int r;
@@ -62,12 +63,13 @@ static ssize_t store_rotate_type(struct device *dev,
 
 	if (!lock_fb_info(fbi))
 		return -ENODEV;
+	omapfb_lock(fbdev);
 
 	r = 0;
 	if (rot_type = ofbi->rotation_type)
 		goto out;
 
-	rg = omapfb_get_mem_region(ofbi->region);
+	rg = ofbi->region;
 
 	if (rg->size) {
 		r = -EBUSY;
@@ -81,8 +83,8 @@ static ssize_t store_rotate_type(struct device *dev,
 	 * need to do any further parameter checking at this point.
 	 */
 put_region:
-	omapfb_put_mem_region(rg);
 out:
+	omapfb_unlock(fbdev);
 	unlock_fb_info(fbi);
 
 	return r ? r : count;
@@ -104,6 +106,7 @@ static ssize_t store_mirror(struct device *dev,
 {
 	struct fb_info *fbi = dev_get_drvdata(dev);
 	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
 	bool mirror;
 	int r;
 	struct fb_var_screeninfo new_var;
@@ -114,11 +117,10 @@ static ssize_t store_mirror(struct device *dev,
 
 	if (!lock_fb_info(fbi))
 		return -ENODEV;
+	omapfb_lock(fbdev);
 
 	ofbi->mirror = mirror;
 
-	omapfb_get_mem_region(ofbi->region);
-
 	memcpy(&new_var, &fbi->var, sizeof(new_var));
 	r = check_fb_var(fbi, &new_var);
 	if (r)
@@ -133,8 +135,7 @@ static ssize_t store_mirror(struct device *dev,
 
 	r = count;
 out:
-	omapfb_put_mem_region(ofbi->region);
-
+	omapfb_unlock(fbdev);
 	unlock_fb_info(fbi);
 
 	return r;
@@ -273,15 +274,11 @@ static ssize_t store_overlays(struct device *dev, struct device_attribute *attr,
 
 		DBG("detaching %d\n", ofbi->overlays[i]->id);
 
-		omapfb_get_mem_region(ofbi->region);
-
 		omapfb_overlay_enable(ovl, 0);
 
 		if (ovl->manager)
 			ovl->manager->apply(ovl->manager);
 
-		omapfb_put_mem_region(ofbi->region);
-
 		for (t = i + 1; t < ofbi->num_overlays; t++) {
 			ofbi->rotation[t-1] = ofbi->rotation[t];
 			ofbi->overlays[t-1] = ofbi->overlays[t];
@@ -314,12 +311,8 @@ static ssize_t store_overlays(struct device *dev, struct device_attribute *attr,
 	}
 
 	if (added) {
-		omapfb_get_mem_region(ofbi->region);
-
 		r = omapfb_apply_changes(fbi, 0);
 
-		omapfb_put_mem_region(ofbi->region);
-
 		if (r)
 			goto out;
 	}
@@ -337,11 +330,13 @@ static ssize_t show_overlays_rotate(struct device *dev,
 {
 	struct fb_info *fbi = dev_get_drvdata(dev);
 	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
 	ssize_t l = 0;
 	int t;
 
 	if (!lock_fb_info(fbi))
 		return -ENODEV;
+	omapfb_lock(fbdev);
 
 	for (t = 0; t < ofbi->num_overlays; t++) {
 		l += snprintf(buf + l, PAGE_SIZE - l, "%s%d",
@@ -350,6 +345,7 @@ static ssize_t show_overlays_rotate(struct device *dev,
 
 	l += snprintf(buf + l, PAGE_SIZE - l, "\n");
 
+	omapfb_unlock(fbdev);
 	unlock_fb_info(fbi);
 
 	return l;
@@ -360,6 +356,7 @@ static ssize_t store_overlays_rotate(struct device *dev,
 {
 	struct fb_info *fbi = dev_get_drvdata(dev);
 	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
 	int num_ovls = 0, r, i;
 	int len;
 	bool changed = false;
@@ -371,6 +368,7 @@ static ssize_t store_overlays_rotate(struct device *dev,
 
 	if (!lock_fb_info(fbi))
 		return -ENODEV;
+	omapfb_lock(fbdev);
 
 	if (len > 0) {
 		char *p = (char *)buf;
@@ -407,12 +405,7 @@ static ssize_t store_overlays_rotate(struct device *dev,
 		for (i = 0; i < num_ovls; ++i)
 			ofbi->rotation[i] = rotation[i];
 
-		omapfb_get_mem_region(ofbi->region);
-
 		r = omapfb_apply_changes(fbi, 0);
-
-		omapfb_put_mem_region(ofbi->region);
-
 		if (r)
 			goto out;
 
@@ -421,6 +414,7 @@ static ssize_t store_overlays_rotate(struct device *dev,
 
 	r = count;
 out:
+	omapfb_unlock(fbdev);
 	unlock_fb_info(fbi);
 
 	return r;
@@ -431,8 +425,19 @@ static ssize_t show_size(struct device *dev,
 {
 	struct fb_info *fbi = dev_get_drvdata(dev);
 	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
+	int r;
+
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
+	omapfb_lock(fbdev);
+
+	r = snprintf(buf, PAGE_SIZE, "%lu\n", ofbi->region->size);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", ofbi->region->size);
+	omapfb_unlock(fbdev);
+	unlock_fb_info(fbi);
+
+	return r;
 }
 
 static ssize_t store_size(struct device *dev, struct device_attribute *attr,
@@ -454,12 +459,10 @@ static ssize_t store_size(struct device *dev, struct device_attribute *attr,
 
 	if (!lock_fb_info(fbi))
 		return -ENODEV;
+	omapfb_lock(fbdev);
 
 	rg = ofbi->region;
 
-	down_write_nested(&rg->lock, rg->id);
-	atomic_inc(&rg->lock_count);
-
 	if (atomic_read(&rg->map_count)) {
 		r = -EBUSY;
 		goto out;
@@ -492,9 +495,7 @@ static ssize_t store_size(struct device *dev, struct device_attribute *attr,
 
 	r = count;
 out:
-	atomic_dec(&rg->lock_count);
-	up_write(&rg->lock);
-
+	omapfb_unlock(fbdev);
 	unlock_fb_info(fbi);
 
 	return r;
@@ -505,8 +506,19 @@ static ssize_t show_phys(struct device *dev,
 {
 	struct fb_info *fbi = dev_get_drvdata(dev);
 	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
+	int r;
 
-	return snprintf(buf, PAGE_SIZE, "%0x\n", ofbi->region->paddr);
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
+	omapfb_lock(fbdev);
+
+	r = snprintf(buf, PAGE_SIZE, "%0x\n", ofbi->region->paddr);
+
+	omapfb_unlock(fbdev);
+	unlock_fb_info(fbi);
+
+	return r;
 }
 
 static ssize_t show_virt(struct device *dev,
@@ -522,11 +534,20 @@ static ssize_t show_upd_mode(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct fb_info *fbi = dev_get_drvdata(dev);
+	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
 	enum omapfb_update_mode mode;
 	int r;
 
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
+	omapfb_lock(fbdev);
+
 	r = omapfb_get_update_mode(fbi, &mode);
 
+	omapfb_unlock(fbdev);
+	unlock_fb_info(fbi);
+
 	if (r)
 		return r;
 
@@ -537,6 +558,8 @@ static ssize_t store_upd_mode(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct fb_info *fbi = dev_get_drvdata(dev);
+	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
 	unsigned mode;
 	int r;
 
@@ -544,10 +567,17 @@ static ssize_t store_upd_mode(struct device *dev, struct device_attribute *attr,
 	if (r)
 		return r;
 
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
+	omapfb_lock(fbdev);
+
 	r = omapfb_set_update_mode(fbi, mode);
 	if (r)
 		return r;
 
+	omapfb_unlock(fbdev);
+	unlock_fb_info(fbi);
+
 	return count;
 }
 
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/omapfb/omapfb.h
index 5f72bf9..71cd8ba 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -62,8 +62,6 @@ struct omapfb2_mem_region {
 	bool		alloc;		/* allocated by the driver */
 	bool		map;		/* kernel mapped by the driver */
 	atomic_t	map_count;
-	struct rw_semaphore lock;
-	atomic_t	lock_count;
 };
 
 /* appended to fb_info */
@@ -129,9 +127,6 @@ void omapfb_remove_sysfs(struct omapfb2_device *fbdev);
 
 int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg);
 
-int omapfb_update_window(struct fb_info *fbi,
-		u32 x, u32 y, u32 w, u32 h);
-
 int dss_mode_to_fb_mode(enum omap_color_mode dssmode,
 			struct fb_var_screeninfo *var);
 
@@ -194,18 +189,4 @@ static inline int omapfb_overlay_enable(struct omap_overlay *ovl,
 		return ovl->disable(ovl);
 }
 
-static inline struct omapfb2_mem_region *
-omapfb_get_mem_region(struct omapfb2_mem_region *rg)
-{
-	down_read_nested(&rg->lock, rg->id);
-	atomic_inc(&rg->lock_count);
-	return rg;
-}
-
-static inline void omapfb_put_mem_region(struct omapfb2_mem_region *rg)
-{
-	atomic_dec(&rg->lock_count);
-	up_read(&rg->lock);
-}
-
 #endif
-- 
1.7.10.4

