From: Nikanth Karthikesan <knikanth@suse.de>
Subject: [PATCH 1/11 ] Change drm_ioctl as an
	unlocked_ioctl function
Date: Thu, 10 Jan 2008 21:19:06 +0530
Message-ID: <1199980146.9154.14.camel__37190.378670539$1199980418$gmane$org@nikanth-laptop.blr.novell.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
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
To: airlied@linux.ie, dri-devel@lists.sourceforge.net, benh@kernel.crashing.org, paulus@samba.org, thomas@winischhofer.net, adaplas@gmail.com, sylvain.meyer@worldonline.fr
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

The ioctl handlers are called with the BKL held, where as unlocked_ioctl
handlers are not. The drm_ioctl function is registered as an ioctl
handler. But it does not need the BKL to be held. Changing drm_ioctl to
register as an unlocked_ioctl function.

Signed-off-by: Nikanth Karthikesan <knikanth@suse.de>

---
diff --git a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
index dde02a1..e5570b8 100644
--- a/drivers/char/drm/drmP.h
+++ b/drivers/char/drm/drmP.h
@@ -833,8 +833,8 @@ static inline int drm_mtrr_del(int handle, unsigned long offset,
 				/* Driver support (drm_drv.h) */
 extern int drm_init(struct drm_driver *driver);
 extern void drm_exit(struct drm_driver *driver);
-extern int drm_ioctl(struct inode *inode, struct file *filp,
-		     unsigned int cmd, unsigned long arg);
+extern long drm_ioctl(struct file *filp, unsigned int cmd,
+						 unsigned long arg);
 extern long drm_compat_ioctl(struct file *filp,
 			     unsigned int cmd, unsigned long arg);
 extern int drm_lastclose(struct drm_device *dev);
diff --git a/drivers/char/drm/drm_drv.c b/drivers/char/drm/drm_drv.c
index 44a4626..7938153 100644
--- a/drivers/char/drm/drm_drv.c
+++ b/drivers/char/drm/drm_drv.c
@@ -438,7 +438,6 @@ static int drm_version(struct drm_device *dev, void *data,
 /**
  * Called whenever a process performs an ioctl on /dev/drm.
  *
- * \param inode device inode.
  * \param file_priv DRM file private.
  * \param cmd command.
  * \param arg user argument.
@@ -447,8 +446,7 @@ static int drm_version(struct drm_device *dev, void *data,
  * Looks up the ioctl function in the ::ioctls table, checking for root
  * previleges if so required, and dispatches to the respective function.
  */
-int drm_ioctl(struct inode *inode, struct file *filp,
-	      unsigned int cmd, unsigned long arg)
+long drm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct drm_file *file_priv = filp->private_data;
 	struct drm_device *dev = file_priv->head->dev;
diff --git a/drivers/char/drm/drm_ioc32.c b/drivers/char/drm/drm_ioc32.c
index 2286f33..3b35263 100644
--- a/drivers/char/drm/drm_ioc32.c
+++ b/drivers/char/drm/drm_ioc32.c
@@ -102,8 +102,8 @@ static int compat_drm_version(struct file *file, unsigned int cmd,
 			  &version->desc))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_VERSION, (unsigned long)version);
+	err = drm_ioctl(file, DRM_IOCTL_VERSION,
+			 (unsigned long)version);
 	if (err)
 		return err;
 
@@ -143,8 +143,7 @@ static int compat_drm_getunique(struct file *file, unsigned int cmd,
 			  &u->unique))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_GET_UNIQUE, (unsigned long)u);
+	err = drm_ioctl(file, DRM_IOCTL_GET_UNIQUE, (unsigned long)u);
 	if (err)
 		return err;
 
@@ -172,8 +171,7 @@ static int compat_drm_setunique(struct file *file, unsigned int cmd,
 			  &u->unique))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_SET_UNIQUE, (unsigned long)u);
+	return drm_ioctl(file, DRM_IOCTL_SET_UNIQUE, (unsigned long)u);
 }
 
 typedef struct drm_map32 {
@@ -203,8 +201,7 @@ static int compat_drm_getmap(struct file *file, unsigned int cmd,
 	if (__put_user(idx, &map->offset))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_GET_MAP, (unsigned long)map);
+	err = drm_ioctl(file, DRM_IOCTL_GET_MAP, (unsigned long)map);
 	if (err)
 		return err;
 
@@ -244,8 +241,7 @@ static int compat_drm_addmap(struct file *file, unsigned int cmd,
 	    || __put_user(m32.flags, &map->flags))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_ADD_MAP, (unsigned long)map);
+	err = drm_ioctl(file, DRM_IOCTL_ADD_MAP, (unsigned long)map);
 	if (err)
 		return err;
 
@@ -282,8 +278,7 @@ static int compat_drm_rmmap(struct file *file, unsigned int cmd,
 	if (__put_user((void *)(unsigned long)handle, &map->handle))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_RM_MAP, (unsigned long)map);
+	return drm_ioctl(file, DRM_IOCTL_RM_MAP, (unsigned long)map);
 }
 
 typedef struct drm_client32 {
@@ -312,8 +307,8 @@ static int compat_drm_getclient(struct file *file, unsigned int cmd,
 	if (__put_user(idx, &client->idx))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_GET_CLIENT, (unsigned long)client);
+	err = drm_ioctl(file, DRM_IOCTL_GET_CLIENT,
+					 (unsigned long)client);
 	if (err)
 		return err;
 
@@ -349,8 +344,8 @@ static int compat_drm_getstats(struct file *file, unsigned int cmd,
 	if (!access_ok(VERIFY_WRITE, stats, sizeof(*stats)))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_GET_STATS, (unsigned long)stats);
+	err = drm_ioctl(file, DRM_IOCTL_GET_STATS,
+				 (unsigned long)stats);
 	if (err)
 		return err;
 
@@ -393,8 +388,7 @@ static int compat_drm_addbufs(struct file *file, unsigned int cmd,
 	    || __put_user(agp_start, &buf->agp_start))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_ADD_BUFS, (unsigned long)buf);
+	err = drm_ioctl(file, DRM_IOCTL_ADD_BUFS, (unsigned long)buf);
 	if (err)
 		return err;
 
@@ -425,8 +419,7 @@ static int compat_drm_markbufs(struct file *file, unsigned int cmd,
 	    || __put_user(b32.high_mark, &buf->high_mark))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_MARK_BUFS, (unsigned long)buf);
+	return drm_ioctl(file, DRM_IOCTL_MARK_BUFS, (unsigned long)buf);
 }
 
 typedef struct drm_buf_info32 {
@@ -467,8 +460,7 @@ static int compat_drm_infobufs(struct file *file, unsigned int cmd,
 	    || __put_user(list, &request->list))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_INFO_BUFS, (unsigned long)request);
+	err = drm_ioctl(file, DRM_IOCTL_INFO_BUFS, (unsigned long)request);
 	if (err)
 		return err;
 
@@ -529,8 +521,7 @@ static int compat_drm_mapbufs(struct file *file, unsigned int cmd,
 	    || __put_user(list, &request->list))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_MAP_BUFS, (unsigned long)request);
+	err = drm_ioctl(file, DRM_IOCTL_MAP_BUFS, (unsigned long)request);
 	if (err)
 		return err;
 
@@ -576,8 +567,8 @@ static int compat_drm_freebufs(struct file *file, unsigned int cmd,
 			  &request->list))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_FREE_BUFS, (unsigned long)request);
+	return drm_ioctl(file, DRM_IOCTL_FREE_BUFS,
+				 (unsigned long)request);
 }
 
 typedef struct drm_ctx_priv_map32 {
@@ -603,8 +594,8 @@ static int compat_drm_setsareactx(struct file *file, unsigned int cmd,
 			  &request->handle))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_SET_SAREA_CTX, (unsigned long)request);
+	return drm_ioctl(file, DRM_IOCTL_SET_SAREA_CTX,
+				 (unsigned long)request);
 }
 
 static int compat_drm_getsareactx(struct file *file, unsigned int cmd,
@@ -626,8 +617,8 @@ static int compat_drm_getsareactx(struct file *file, unsigned int cmd,
 	if (__put_user(ctx_id, &request->ctx_id))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_GET_SAREA_CTX, (unsigned long)request);
+	err = drm_ioctl(file, DRM_IOCTL_GET_SAREA_CTX,
+					 (unsigned long)request);
 	if (err)
 		return err;
 
@@ -662,8 +653,7 @@ static int compat_drm_resctx(struct file *file, unsigned int cmd,
 			  &res->contexts))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_RES_CTX, (unsigned long)res);
+	err = drm_ioctl(file, DRM_IOCTL_RES_CTX, (unsigned long)res);
 	if (err)
 		return err;
 
@@ -716,8 +706,7 @@ static int compat_drm_dma(struct file *file, unsigned int cmd,
 			  &d->request_sizes))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_DMA, (unsigned long)d);
+	err = drm_ioctl(file, DRM_IOCTL_DMA, (unsigned long)d);
 	if (err)
 		return err;
 
@@ -749,8 +738,8 @@ static int compat_drm_agp_enable(struct file *file, unsigned int cmd,
 	if (put_user(m32.mode, &mode->mode))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_AGP_ENABLE, (unsigned long)mode);
+	return drm_ioctl(file, DRM_IOCTL_AGP_ENABLE,
+				 (unsigned long)mode);
 }
 
 typedef struct drm_agp_info32 {
@@ -779,8 +768,7 @@ static int compat_drm_agp_info(struct file *file, unsigned int cmd,
 	if (!access_ok(VERIFY_WRITE, info, sizeof(*info)))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_AGP_INFO, (unsigned long)info);
+	err = drm_ioctl(file, DRM_IOCTL_AGP_INFO, (unsigned long)info);
 	if (err)
 		return err;
 
@@ -825,16 +813,16 @@ static int compat_drm_agp_alloc(struct file *file, unsigned int cmd,
 	    || __put_user(req32.type, &request->type))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_AGP_ALLOC, (unsigned long)request);
+	err = drm_ioctl(file, DRM_IOCTL_AGP_ALLOC,
+				(unsigned long)request);
 	if (err)
 		return err;
 
 	if (__get_user(req32.handle, &request->handle)
 	    || __get_user(req32.physical, &request->physical)
 	    || copy_to_user(argp, &req32, sizeof(req32))) {
-		drm_ioctl(file->f_path.dentry->d_inode, file,
-			  DRM_IOCTL_AGP_FREE, (unsigned long)request);
+		drm_ioctl(file, DRM_IOCTL_AGP_FREE,
+				(unsigned long)request);
 		return -EFAULT;
 	}
 
@@ -854,8 +842,8 @@ static int compat_drm_agp_free(struct file *file, unsigned int cmd,
 	    || __put_user(handle, &request->handle))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_AGP_FREE, (unsigned long)request);
+	return drm_ioctl(file, DRM_IOCTL_AGP_FREE,
+				(unsigned long)request);
 }
 
 typedef struct drm_agp_binding32 {
@@ -879,8 +867,8 @@ static int compat_drm_agp_bind(struct file *file, unsigned int cmd,
 	    || __put_user(req32.offset, &request->offset))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_AGP_BIND, (unsigned long)request);
+	return drm_ioctl(file, DRM_IOCTL_AGP_BIND,
+				 (unsigned long)request);
 }
 
 static int compat_drm_agp_unbind(struct file *file, unsigned int cmd,
@@ -896,8 +884,8 @@ static int compat_drm_agp_unbind(struct file *file, unsigned int cmd,
 	    || __put_user(handle, &request->handle))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_AGP_UNBIND, (unsigned long)request);
+	return drm_ioctl(file, DRM_IOCTL_AGP_UNBIND,
+				 (unsigned long)request);
 }
 #endif				/* __OS_HAS_AGP */
 
@@ -921,8 +909,7 @@ static int compat_drm_sg_alloc(struct file *file, unsigned int cmd,
 	    || __put_user(x, &request->size))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_SG_ALLOC, (unsigned long)request);
+	err = drm_ioctl(file, DRM_IOCTL_SG_ALLOC, (unsigned long)request);
 	if (err)
 		return err;
 
@@ -948,8 +935,7 @@ static int compat_drm_sg_free(struct file *file, unsigned int cmd,
 	    || __put_user(x << PAGE_SHIFT, &request->handle))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_SG_FREE, (unsigned long)request);
+	return drm_ioctl(file, DRM_IOCTL_SG_FREE, (unsigned long)request);
 }
 
 struct drm_wait_vblank_request32 {
@@ -988,8 +974,8 @@ static int compat_drm_wait_vblank(struct file *file, unsigned int cmd,
 	    || __put_user(req32.request.signal, &request->request.signal))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_WAIT_VBLANK, (unsigned long)request);
+	err = drm_ioctl(file, DRM_IOCTL_WAIT_VBLANK,
+					 (unsigned long)request);
 	if (err)
 		return err;
 
@@ -1060,7 +1046,7 @@ long drm_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (fn != NULL)
 		ret = (*fn) (filp, cmd, arg);
 	else
-		ret = drm_ioctl(filp->f_path.dentry->d_inode, filp, cmd, arg);
+		ret = drm_ioctl(filp, cmd, arg);
 	unlock_kernel();
 
 	return ret;



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
