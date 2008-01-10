From: Nikanth Karthikesan <knikanth@suse.de>
Subject: [PATCH 4/11 ] Change drm_ioctl as an
	unlocked_ioctl function : i915
Date: Thu, 10 Jan 2008 21:14:12 +0530
Message-ID: <1199979852.9154.5.camel@nikanth-laptop.blr.novell.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1844119954=="
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


--===============1844119954==
Content-Type: multipart/alternative; boundary="=-DPPxIOkHO+KlxdszpLiF"


--=-DPPxIOkHO+KlxdszpLiF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Register drm_ioctl as an unlocked_ioctl function.

Signed-off-by: Nikanth Karthikesan <knikanth@suse.de>

--- 
diff --git a/drivers/char/drm/i915_drv.c b/drivers/char/drm/i915_drv.c
index 85bcc27..70a882e 100644
--- a/drivers/char/drm/i915_drv.c
+++ b/drivers/char/drm/i915_drv.c
@@ -64,7 +64,7 @@ static struct drm_driver driver = {
 		 .owner = THIS_MODULE,
 		 .open = drm_open,
 		 .release = drm_release,
-		 .ioctl = drm_ioctl,
+		 .unlocked_ioctl = drm_ioctl,
 		 .mmap = drm_mmap,
 		 .poll = drm_poll,
 		 .fasync = drm_fasync,
diff --git a/drivers/char/drm/i915_ioc32.c b/drivers/char/drm/i915_ioc32.c
index 1fe68a2..f8b1d68 100644
--- a/drivers/char/drm/i915_ioc32.c
+++ b/drivers/char/drm/i915_ioc32.c
@@ -66,9 +66,8 @@ static int compat_i915_batchbuffer(struct file *file, unsigned int cmd,
 			  &batchbuffer->cliprects))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_I915_BATCHBUFFER,
-			 (unsigned long)batchbuffer);
+	return drm_ioctl(file, DRM_IOCTL_I915_BATCHBUFFER,
+					 (unsigned long)batchbuffer);
 }
 
 typedef struct _drm_i915_cmdbuffer32 {
@@ -102,8 +101,8 @@ static int compat_i915_cmdbuffer(struct file *file, unsigned int cmd,
 			  &cmdbuffer->cliprects))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_I915_CMDBUFFER, (unsigned long)cmdbuffer);
+	return drm_ioctl(file, DRM_IOCTL_I915_CMDBUFFER,
+				 (unsigned long)cmdbuffer);
 }
 
 typedef struct drm_i915_irq_emit32 {
@@ -125,8 +124,8 @@ static int compat_i915_irq_emit(struct file *file, unsigned int cmd,
 			  &request->irq_seq))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_I915_IRQ_EMIT, (unsigned long)request);
+	return drm_ioctl(file, DRM_IOCTL_I915_IRQ_EMIT,
+				 (unsigned long)request);
 }
 typedef struct drm_i915_getparam32 {
 	int param;
@@ -149,8 +148,8 @@ static int compat_i915_getparam(struct file *file, unsigned int cmd,
 			  &request->value))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_I915_GETPARAM, (unsigned long)request);
+	return drm_ioctl(file, DRM_IOCTL_I915_GETPARAM,
+					 (unsigned long)request);
 }
 
 typedef struct drm_i915_mem_alloc32 {
@@ -178,8 +177,8 @@ static int compat_i915_alloc(struct file *file, unsigned int cmd,
 			  &request->region_offset))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_I915_ALLOC, (unsigned long)request);
+	return drm_ioctl(file, DRM_IOCTL_I915_ALLOC,
+				 (unsigned long)request);
 }
 
 drm_ioctl_compat_t *i915_compat_ioctls[] = {
@@ -215,7 +214,7 @@ long i915_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (fn != NULL)
 		ret = (*fn) (filp, cmd, arg);
 	else
-		ret = drm_ioctl(filp->f_path.dentry->d_inode, filp, cmd, arg);
+		ret = drm_ioctl(filp, cmd, arg);
 	unlock_kernel();
 
 	return ret;


--=-DPPxIOkHO+KlxdszpLiF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.2">
</HEAD>
<BODY>
<PRE>
Register drm_ioctl as an unlocked_ioctl function.

Signed-off-by: Nikanth Karthikesan &lt;<A HREF="mailto:knikanth@suse.de">knikanth@suse.de</A>&gt;

--- 
diff --git a/drivers/char/drm/i915_drv.c b/drivers/char/drm/i915_drv.c
index 85bcc27..70a882e 100644
--- a/drivers/char/drm/i915_drv.c
+++ b/drivers/char/drm/i915_drv.c
@@ -64,7 +64,7 @@ static struct drm_driver driver = {
 		 .owner = THIS_MODULE,
 		 .open = drm_open,
 		 .release = drm_release,
-		 .ioctl = drm_ioctl,
+		 .unlocked_ioctl = drm_ioctl,
 		 .mmap = drm_mmap,
 		 .poll = drm_poll,
 		 .fasync = drm_fasync,
diff --git a/drivers/char/drm/i915_ioc32.c b/drivers/char/drm/i915_ioc32.c
index 1fe68a2..f8b1d68 100644
--- a/drivers/char/drm/i915_ioc32.c
+++ b/drivers/char/drm/i915_ioc32.c
@@ -66,9 +66,8 @@ static int compat_i915_batchbuffer(struct file *file, unsigned int cmd,
 			  &amp;batchbuffer-&gt;cliprects))
 		return -EFAULT;
 
-	return drm_ioctl(file-&gt;f_path.dentry-&gt;d_inode, file,
-			 DRM_IOCTL_I915_BATCHBUFFER,
-			 (unsigned long)batchbuffer);
+	return drm_ioctl(file, DRM_IOCTL_I915_BATCHBUFFER,
+					 (unsigned long)batchbuffer);
 }
 
 typedef struct _drm_i915_cmdbuffer32 {
@@ -102,8 +101,8 @@ static int compat_i915_cmdbuffer(struct file *file, unsigned int cmd,
 			  &amp;cmdbuffer-&gt;cliprects))
 		return -EFAULT;
 
-	return drm_ioctl(file-&gt;f_path.dentry-&gt;d_inode, file,
-			 DRM_IOCTL_I915_CMDBUFFER, (unsigned long)cmdbuffer);
+	return drm_ioctl(file, DRM_IOCTL_I915_CMDBUFFER,
+				 (unsigned long)cmdbuffer);
 }
 
 typedef struct drm_i915_irq_emit32 {
@@ -125,8 +124,8 @@ static int compat_i915_irq_emit(struct file *file, unsigned int cmd,
 			  &amp;request-&gt;irq_seq))
 		return -EFAULT;
 
-	return drm_ioctl(file-&gt;f_path.dentry-&gt;d_inode, file,
-			 DRM_IOCTL_I915_IRQ_EMIT, (unsigned long)request);
+	return drm_ioctl(file, DRM_IOCTL_I915_IRQ_EMIT,
+				 (unsigned long)request);
 }
 typedef struct drm_i915_getparam32 {
 	int param;
@@ -149,8 +148,8 @@ static int compat_i915_getparam(struct file *file, unsigned int cmd,
 			  &amp;request-&gt;value))
 		return -EFAULT;
 
-	return drm_ioctl(file-&gt;f_path.dentry-&gt;d_inode, file,
-			 DRM_IOCTL_I915_GETPARAM, (unsigned long)request);
+	return drm_ioctl(file, DRM_IOCTL_I915_GETPARAM,
+					 (unsigned long)request);
 }
 
 typedef struct drm_i915_mem_alloc32 {
@@ -178,8 +177,8 @@ static int compat_i915_alloc(struct file *file, unsigned int cmd,
 			  &amp;request-&gt;region_offset))
 		return -EFAULT;
 
-	return drm_ioctl(file-&gt;f_path.dentry-&gt;d_inode, file,
-			 DRM_IOCTL_I915_ALLOC, (unsigned long)request);
+	return drm_ioctl(file, DRM_IOCTL_I915_ALLOC,
+				 (unsigned long)request);
 }
 
 drm_ioctl_compat_t *i915_compat_ioctls[] = {
@@ -215,7 +214,7 @@ long i915_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (fn != NULL)
 		ret = (*fn) (filp, cmd, arg);
 	else
-		ret = drm_ioctl(filp-&gt;f_path.dentry-&gt;d_inode, filp, cmd, arg);
+		ret = drm_ioctl(filp, cmd, arg);
 	unlock_kernel();
 
 	return ret;

</PRE>
</BODY>
</HTML>

--=-DPPxIOkHO+KlxdszpLiF--



--===============1844119954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1844119954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1844119954==--
