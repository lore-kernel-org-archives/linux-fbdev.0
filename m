From: Nikanth Karthikesan <knikanth@suse.de>
Subject: [PATCH 5/11 ] Change drm_ioctl as an
	unlocked_ioctl function : mga
Date: Thu, 10 Jan 2008 21:14:24 +0530
Message-ID: <1199979864.9154.6.camel@nikanth-laptop.blr.novell.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1963841773=="
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


--===============1963841773==
Content-Type: multipart/alternative; boundary="=-kLblV+LDxpvrEXRtNKX4"


--=-kLblV+LDxpvrEXRtNKX4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Register drm_ioctl as an unlocked_ioctl function.

Signed-off-by: Nikanth Karthikesan <knikanth@suse.de>

--- 
diff --git a/drivers/char/drm/mga_drv.c b/drivers/char/drm/mga_drv.c
index 5572939..be31707 100644
--- a/drivers/char/drm/mga_drv.c
+++ b/drivers/char/drm/mga_drv.c
@@ -67,7 +67,7 @@ static struct drm_driver driver = {
 		 .owner = THIS_MODULE,
 		 .open = drm_open,
 		 .release = drm_release,
-		 .ioctl = drm_ioctl,
+		 .unlocked_ioctl = drm_ioctl,
 		 .mmap = drm_mmap,
 		 .poll = drm_poll,
 		 .fasync = drm_fasync,
diff --git a/drivers/char/drm/mga_ioc32.c b/drivers/char/drm/mga_ioc32.c
index 30d0047..a4581d9 100644
--- a/drivers/char/drm/mga_ioc32.c
+++ b/drivers/char/drm/mga_ioc32.c
@@ -100,8 +100,7 @@ static int compat_mga_init(struct file *file, unsigned int cmd,
 	if (err)
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_MGA_INIT, (unsigned long)init);
+	return drm_ioctl(file, DRM_IOCTL_MGA_INIT, (unsigned long)init);
 }
 
 typedef struct drm_mga_getparam32 {
@@ -125,8 +124,8 @@ static int compat_mga_getparam(struct file *file, unsigned int cmd,
 			  &getparam->value))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_MGA_GETPARAM, (unsigned long)getparam);
+	return drm_ioctl(file, DRM_IOCTL_MGA_GETPARAM,
+					 (unsigned long)getparam);
 }
 
 typedef struct drm_mga_drm_bootstrap32 {
@@ -166,9 +165,8 @@ static int compat_mga_dma_bootstrap(struct file *file, unsigned int cmd,
 	    || __put_user(dma_bootstrap32.agp_size, &dma_bootstrap->agp_size))
 		return -EFAULT;
 
-	err = drm_ioctl(file->f_path.dentry->d_inode, file,
-			DRM_IOCTL_MGA_DMA_BOOTSTRAP,
-			(unsigned long)dma_bootstrap);
+	err = drm_ioctl(file, DRM_IOCTL_MGA_DMA_BOOTSTRAP,
+					(unsigned long)dma_bootstrap);
 	if (err)
 		return err;
 
@@ -224,7 +222,7 @@ long mga_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (fn != NULL)
 		ret = (*fn) (filp, cmd, arg);
 	else
-		ret = drm_ioctl(filp->f_path.dentry->d_inode, filp, cmd, arg);
+		ret = drm_ioctl(filp, cmd, arg);
 	unlock_kernel();
 
 	return ret;


--=-kLblV+LDxpvrEXRtNKX4
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
diff --git a/drivers/char/drm/mga_drv.c b/drivers/char/drm/mga_drv.c
index 5572939..be31707 100644
--- a/drivers/char/drm/mga_drv.c
+++ b/drivers/char/drm/mga_drv.c
@@ -67,7 +67,7 @@ static struct drm_driver driver = {
 		 .owner = THIS_MODULE,
 		 .open = drm_open,
 		 .release = drm_release,
-		 .ioctl = drm_ioctl,
+		 .unlocked_ioctl = drm_ioctl,
 		 .mmap = drm_mmap,
 		 .poll = drm_poll,
 		 .fasync = drm_fasync,
diff --git a/drivers/char/drm/mga_ioc32.c b/drivers/char/drm/mga_ioc32.c
index 30d0047..a4581d9 100644
--- a/drivers/char/drm/mga_ioc32.c
+++ b/drivers/char/drm/mga_ioc32.c
@@ -100,8 +100,7 @@ static int compat_mga_init(struct file *file, unsigned int cmd,
 	if (err)
 		return -EFAULT;
 
-	return drm_ioctl(file-&gt;f_path.dentry-&gt;d_inode, file,
-			 DRM_IOCTL_MGA_INIT, (unsigned long)init);
+	return drm_ioctl(file, DRM_IOCTL_MGA_INIT, (unsigned long)init);
 }
 
 typedef struct drm_mga_getparam32 {
@@ -125,8 +124,8 @@ static int compat_mga_getparam(struct file *file, unsigned int cmd,
 			  &amp;getparam-&gt;value))
 		return -EFAULT;
 
-	return drm_ioctl(file-&gt;f_path.dentry-&gt;d_inode, file,
-			 DRM_IOCTL_MGA_GETPARAM, (unsigned long)getparam);
+	return drm_ioctl(file, DRM_IOCTL_MGA_GETPARAM,
+					 (unsigned long)getparam);
 }
 
 typedef struct drm_mga_drm_bootstrap32 {
@@ -166,9 +165,8 @@ static int compat_mga_dma_bootstrap(struct file *file, unsigned int cmd,
 	    || __put_user(dma_bootstrap32.agp_size, &amp;dma_bootstrap-&gt;agp_size))
 		return -EFAULT;
 
-	err = drm_ioctl(file-&gt;f_path.dentry-&gt;d_inode, file,
-			DRM_IOCTL_MGA_DMA_BOOTSTRAP,
-			(unsigned long)dma_bootstrap);
+	err = drm_ioctl(file, DRM_IOCTL_MGA_DMA_BOOTSTRAP,
+					(unsigned long)dma_bootstrap);
 	if (err)
 		return err;
 
@@ -224,7 +222,7 @@ long mga_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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

--=-kLblV+LDxpvrEXRtNKX4--



--===============1963841773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1963841773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1963841773==--
