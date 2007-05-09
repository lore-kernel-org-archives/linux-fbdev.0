From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/5] nvidiafb: Enable debugging messages
	a Kconfig option
Date: Thu, 10 May 2007 07:47:28 +0800
Message-ID: <46425D90.9090506@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hlvug-0002MU-JS for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 May 2007 16:49:42 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hlvug-0005Lu-9t
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 May 2007 16:49:42 -0700
Received: by py-out-1112.google.com with SMTP id a29so322085pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 09 May 2007 16:49:42 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Jean Delvare <khali@linux-fr.org>

Let the user enable debugging messages in nvidiafb.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Kconfig         |   11 ++++++++++-
 drivers/video/nvidia/nvidia.c |    1 -
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6f31842..3606c4f 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -795,6 +795,15 @@ config FB_NVIDIA_I2C
 	  independently validate video mode parameters, you should say Y
 	  here.
 
+config FB_NVIDIA_DEBUG
+	bool "Lots of debug output"
+	depends on FB_NVIDIA
+	default n
+	help
+	  Say Y here if you want the nVidia driver to output all sorts
+	  of debugging information to provide to the maintainer when
+	  something goes wrong.
+
 config FB_NVIDIA_BACKLIGHT
 	bool "Support for backlight control"
 	depends on FB_NVIDIA
@@ -834,7 +843,7 @@ config FB_RIVA_I2C
 	  here.
 
 config FB_RIVA_DEBUG
-	bool "Lots of debug output from Riva(nVidia) driver"
+	bool "Lots of debug output"
 	depends on FB_RIVA
 	default n
 	help
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index f85edf0..41f6365 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -37,7 +37,6 @@ #include "nv_type.h"
 #include "nv_proto.h"
 #include "nv_dma.h"
 
-#undef CONFIG_FB_NVIDIA_DEBUG
 #ifdef CONFIG_FB_NVIDIA_DEBUG
 #define NVTRACE          printk
 #else


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
