From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 15/16] cg3fb: Kconfig fix
Date: Wed, 30 Nov 2005 09:05:42 +0800
Message-ID: <438CFAE6.7090108@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhGph-0002W0-OC
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:32:29 -0800
Received: from zproxy.gmail.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhGpg-0002py-I2
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:32:29 -0800
Received: by zproxy.gmail.com with SMTP id r28so881935nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 17:32:28 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Mark Fortescue <mark@mtfhpc.demon.co.uk>

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>

A cut and past error regarding the CG3 frame buffer needs to be fixed. It
also affects Creator/Creator3D/Elite3D.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/Kconfig |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 25b6ca6..3e470c8 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -534,6 +534,12 @@ config FB_SUN3
 	bool "Sun3 framebuffer support"
 	depends on (FB = y) && (SUN3 || SUN3X) && BROKEN
 
+config FB_SBUS
+	bool "SBUS and UPA framebuffers"
+	depends on (FB = y) && (SPARC32 || SPARC64)
+	help
+	  Say Y if you want support for SBUS or UPA based frame buffer device.
+
 config FB_BW2
 	bool "BWtwo support"
 	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
@@ -546,6 +552,7 @@ config FB_BW2
 config FB_CG3
 	bool "CGthree support"
 	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
+	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	help
@@ -1210,12 +1217,6 @@ config FB_AU1100
 
 source "drivers/video/geode/Kconfig"
 
-config FB_SBUS
-	bool "SBUS and UPA framebuffers"
-	depends on (FB = y) && (SPARC32 || SPARC64)
-	help
-	  Say Y if you want support for SBUS or UPA based frame buffer device.
-
 config FB_FFB
 	bool "Creator/Creator3D/Elite3D support"
 	depends on FB_SBUS && SPARC64



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
