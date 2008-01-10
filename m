From: Nikanth Karthikesan <knikanth@suse.de>
Subject: [PATCH 3/11 ] Change drm_ioctl as an
	unlocked_ioctl function : i830
Date: Thu, 10 Jan 2008 21:13:59 +0530
Message-ID: <1199979839.9154.4.camel@nikanth-laptop.blr.novell.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1867476354=="
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


--===============1867476354==
Content-Type: multipart/alternative; boundary="=-eZbvkZYW4ITU+I+a2qrL"


--=-eZbvkZYW4ITU+I+a2qrL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Register drm_ioctl as an unlocked_ioctl function.

Signed-off-by: Nikanth Karthikesan <knikanth@suse.de>

--- 
diff --git a/drivers/char/drm/i830_dma.c b/drivers/char/drm/i830_dma.c
index 69a363e..2f82480 100644
--- a/drivers/char/drm/i830_dma.c
+++ b/drivers/char/drm/i830_dma.c
@@ -117,7 +117,7 @@ static int i830_mmap_buffers(struct file *filp, struct vm_area_struct *vma)
 static const struct file_operations i830_buffer_fops = {
 	.open = drm_open,
 	.release = drm_release,
-	.ioctl = drm_ioctl,
+	.unlocked_ioctl = drm_ioctl,
 	.mmap = i830_mmap_buffers,
 	.fasync = drm_fasync,
 };
diff --git a/drivers/char/drm/i830_drv.c b/drivers/char/drm/i830_drv.c
index 389597e..44f990b 100644
--- a/drivers/char/drm/i830_drv.c
+++ b/drivers/char/drm/i830_drv.c
@@ -70,7 +70,7 @@ static struct drm_driver driver = {
 		 .owner = THIS_MODULE,
 		 .open = drm_open,
 		 .release = drm_release,
-		 .ioctl = drm_ioctl,
+		 .unlocked_ioctl = drm_ioctl,
 		 .mmap = drm_mmap,
 		 .poll = drm_poll,
 		 .fasync = drm_fasync,


--=-eZbvkZYW4ITU+I+a2qrL
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
diff --git a/drivers/char/drm/i830_dma.c b/drivers/char/drm/i830_dma.c
index 69a363e..2f82480 100644
--- a/drivers/char/drm/i830_dma.c
+++ b/drivers/char/drm/i830_dma.c
@@ -117,7 +117,7 @@ static int i830_mmap_buffers(struct file *filp, struct vm_area_struct *vma)
 static const struct file_operations i830_buffer_fops = {
 	.open = drm_open,
 	.release = drm_release,
-	.ioctl = drm_ioctl,
+	.unlocked_ioctl = drm_ioctl,
 	.mmap = i830_mmap_buffers,
 	.fasync = drm_fasync,
 };
diff --git a/drivers/char/drm/i830_drv.c b/drivers/char/drm/i830_drv.c
index 389597e..44f990b 100644
--- a/drivers/char/drm/i830_drv.c
+++ b/drivers/char/drm/i830_drv.c
@@ -70,7 +70,7 @@ static struct drm_driver driver = {
 		 .owner = THIS_MODULE,
 		 .open = drm_open,
 		 .release = drm_release,
-		 .ioctl = drm_ioctl,
+		 .unlocked_ioctl = drm_ioctl,
 		 .mmap = drm_mmap,
 		 .poll = drm_poll,
 		 .fasync = drm_fasync,

</PRE>
</BODY>
</HTML>

--=-eZbvkZYW4ITU+I+a2qrL--



--===============1867476354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1867476354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1867476354==--
