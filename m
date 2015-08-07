From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 07 Aug 2015 13:13:15 +0000
Subject: [PATCH RESEND 3/3] MAINTAINERS: update maintainers list
Message-Id: <1438952475-22151-3-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438952475-22151-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1438952475-22151-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, devel@driverdev.osuosl.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Now since sm712fb has moved out of staging update the maintainers list
accordingly.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 MAINTAINERS | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9289ecb..ba6c537 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9324,6 +9324,15 @@ S:	Maintained
 F:	drivers/media/i2c/ov2659.c
 F:	include/media/ov2659.h
 
+SILICON MOTION SM712 FRAME BUFFER DRIVER
+M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
+M:	Teddy Wang <teddy.wang@siliconmotion.com>
+M:	Sudip Mukherjee <sudip@vectorindia.org>
+L:	linux-fbdev@vger.kernel.org
+S:	Maintained
+F:	drivers/video/fbdev/sm712*
+F:	Documentation/fb/sm712fb.txt
+
 SIS 190 ETHERNET DRIVER
 M:	Francois Romieu <romieu@fr.zoreil.com>
 L:	netdev@vger.kernel.org
@@ -9744,14 +9753,6 @@ L:	linux-wireless@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/rtl8723au/
 
-STAGING - SILICON MOTION SM7XX FRAME BUFFER DRIVER
-M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
-M:	Teddy Wang <teddy.wang@siliconmotion.com>
-M:	Sudip Mukherjee <sudip@vectorindia.org>
-L:	linux-fbdev@vger.kernel.org
-S:	Maintained
-F:	drivers/staging/sm7xxfb/
-
 STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER
 M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
 M:	Teddy Wang <teddy.wang@siliconmotion.com>
-- 
1.9.1

