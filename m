From: Nikanth Karthikesan <knikanth@suse.de>
Subject: [PATCH 8/11 ] Change drm_ioctl as an
	unlocked_ioctl function :	savage
Date: Thu, 10 Jan 2008 21:14:55 +0530
Message-ID: <1199979895.9154.9.camel@nikanth-laptop.blr.novell.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1201607367=="
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


--===============1201607367==
Content-Type: multipart/alternative; boundary="=-xRseF4MnFJw8nGDuE0yU"


--=-xRseF4MnFJw8nGDuE0yU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Register drm_ioctl as an unlocked_ioctl function.

Signed-off-by: Nikanth Karthikesan <knikanth@suse.de>

--- 
diff --git a/drivers/char/drm/savage_drv.c b/drivers/char/drm/savage_drv.c
index eee52aa..021de44 100644
--- a/drivers/char/drm/savage_drv.c
+++ b/drivers/char/drm/savage_drv.c
@@ -50,7 +50,7 @@ static struct drm_driver driver = {
 		 .owner = THIS_MODULE,
 		 .open = drm_open,
 		 .release = drm_release,
-		 .ioctl = drm_ioctl,
+		 .unlocked_ioctl = drm_ioctl,
 		 .mmap = drm_mmap,
 		 .poll = drm_poll,
 		 .fasync = drm_fasync,


--=-xRseF4MnFJw8nGDuE0yU
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
diff --git a/drivers/char/drm/savage_drv.c b/drivers/char/drm/savage_drv.c
index eee52aa..021de44 100644
--- a/drivers/char/drm/savage_drv.c
+++ b/drivers/char/drm/savage_drv.c
@@ -50,7 +50,7 @@ static struct drm_driver driver = {
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

--=-xRseF4MnFJw8nGDuE0yU--



--===============1201607367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1201607367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1201607367==--
