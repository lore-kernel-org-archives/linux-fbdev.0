From: Nikanth Karthikesan <knikanth@suse.de>
Subject: [PATCH 6/11 ] Change drm_ioctl as an
	unlocked_ioctl function : r128
Date: Thu, 10 Jan 2008 21:14:35 +0530
Message-ID: <1199979875.9154.7.camel@nikanth-laptop.blr.novell.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1191692192=="
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


--===============1191692192==
Content-Type: multipart/alternative; boundary="=-DiRXlvBSZcHtigr7P2+B"


--=-DiRXlvBSZcHtigr7P2+B
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Register drm_ioctl as an unlocked_ioctl function.

Signed-off-by: Nikanth Karthikesan <knikanth@suse.de>

--- 
diff --git a/drivers/char/drm/r128_drv.c b/drivers/char/drm/r128_drv.c
index 6108e75..b2a16a7 100644
--- a/drivers/char/drm/r128_drv.c
+++ b/drivers/char/drm/r128_drv.c
@@ -62,7 +62,7 @@ static struct drm_driver driver = {
 		 .owner = THIS_MODULE,
 		 .open = drm_open,
 		 .release = drm_release,
-		 .ioctl = drm_ioctl,
+		 .unlocked_ioctl = drm_ioctl,
 		 .mmap = drm_mmap,
 		 .poll = drm_poll,
 		 .fasync = drm_fasync,
diff --git a/drivers/char/drm/r128_ioc32.c b/drivers/char/drm/r128_ioc32.c
index d3cb676..1f3c5e5 100644
--- a/drivers/char/drm/r128_ioc32.c
+++ b/drivers/char/drm/r128_ioc32.c
@@ -95,8 +95,8 @@ static int compat_r128_init(struct file *file, unsigned int cmd,
 			  &init->agp_textures_offset))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_R128_INIT, (unsigned long)init);
+	return drm_ioctl(file, DRM_IOCTL_R128_INIT,
+					 (unsigned long)init);
 }
 
 typedef struct drm_r128_depth32 {
@@ -129,8 +129,8 @@ static int compat_r128_depth(struct file *file, unsigned int cmd,
 			  &depth->mask))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_R128_DEPTH, (unsigned long)depth);
+	return drm_ioctl(file, DRM_IOCTL_R128_DEPTH,
+				 (unsigned long)depth);
 
 }
 
@@ -153,8 +153,8 @@ static int compat_r128_stipple(struct file *file, unsigned int cmd,
 			  &stipple->mask))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_R128_STIPPLE, (unsigned long)stipple);
+	return drm_ioctl(file, DRM_IOCTL_R128_STIPPLE,
+					 (unsigned long)stipple);
 }
 
 typedef struct drm_r128_getparam32 {
@@ -178,8 +178,8 @@ static int compat_r128_getparam(struct file *file, unsigned int cmd,
 			  &getparam->value))
 		return -EFAULT;
 
-	return drm_ioctl(file->f_path.dentry->d_inode, file,
-			 DRM_IOCTL_R128_GETPARAM, (unsigned long)getparam);
+	return drm_ioctl(file, DRM_IOCTL_R128_GETPARAM,
+					 (unsigned long)getparam);
 }
 
 drm_ioctl_compat_t *r128_compat_ioctls[] = {
@@ -214,7 +214,7 @@ long r128_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (fn != NULL)
 		ret = (*fn) (filp, cmd, arg);
 	else
-		ret = drm_ioctl(filp->f_path.dentry->d_inode, filp, cmd, arg);
+		ret = drm_ioctl(filp, cmd, arg);
 	unlock_kernel();
 
 	return ret;


--=-DiRXlvBSZcHtigr7P2+B
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
diff --git a/drivers/char/drm/r128_drv.c b/drivers/char/drm/r128_drv.c
index 6108e75..b2a16a7 100644
--- a/drivers/char/drm/r128_drv.c
+++ b/drivers/char/drm/r128_drv.c
@@ -62,7 +62,7 @@ static struct drm_driver driver = {
 		 .owner = THIS_MODULE,
 		 .open = drm_open,
 		 .release = drm_release,
-		 .ioctl = drm_ioctl,
+		 .unlocked_ioctl = drm_ioctl,
 		 .mmap = drm_mmap,
 		 .poll = drm_poll,
 		 .fasync = drm_fasync,
diff --git a/drivers/char/drm/r128_ioc32.c b/drivers/char/drm/r128_ioc32.c
index d3cb676..1f3c5e5 100644
--- a/drivers/char/drm/r128_ioc32.c
+++ b/drivers/char/drm/r128_ioc32.c
@@ -95,8 +95,8 @@ static int compat_r128_init(struct file *file, unsigned int cmd,
 			  &amp;init-&gt;agp_textures_offset))
 		return -EFAULT;
 
-	return drm_ioctl(file-&gt;f_path.dentry-&gt;d_inode, file,
-			 DRM_IOCTL_R128_INIT, (unsigned long)init);
+	return drm_ioctl(file, DRM_IOCTL_R128_INIT,
+					 (unsigned long)init);
 }
 
 typedef struct drm_r128_depth32 {
@@ -129,8 +129,8 @@ static int compat_r128_depth(struct file *file, unsigned int cmd,
 			  &amp;depth-&gt;mask))
 		return -EFAULT;
 
-	return drm_ioctl(file-&gt;f_path.dentry-&gt;d_inode, file,
-			 DRM_IOCTL_R128_DEPTH, (unsigned long)depth);
+	return drm_ioctl(file, DRM_IOCTL_R128_DEPTH,
+				 (unsigned long)depth);
 
 }
 
@@ -153,8 +153,8 @@ static int compat_r128_stipple(struct file *file, unsigned int cmd,
 			  &amp;stipple-&gt;mask))
 		return -EFAULT;
 
-	return drm_ioctl(file-&gt;f_path.dentry-&gt;d_inode, file,
-			 DRM_IOCTL_R128_STIPPLE, (unsigned long)stipple);
+	return drm_ioctl(file, DRM_IOCTL_R128_STIPPLE,
+					 (unsigned long)stipple);
 }
 
 typedef struct drm_r128_getparam32 {
@@ -178,8 +178,8 @@ static int compat_r128_getparam(struct file *file, unsigned int cmd,
 			  &amp;getparam-&gt;value))
 		return -EFAULT;
 
-	return drm_ioctl(file-&gt;f_path.dentry-&gt;d_inode, file,
-			 DRM_IOCTL_R128_GETPARAM, (unsigned long)getparam);
+	return drm_ioctl(file, DRM_IOCTL_R128_GETPARAM,
+					 (unsigned long)getparam);
 }
 
 drm_ioctl_compat_t *r128_compat_ioctls[] = {
@@ -214,7 +214,7 @@ long r128_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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

--=-DiRXlvBSZcHtigr7P2+B--



--===============1191692192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1191692192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1191692192==--
