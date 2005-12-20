From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: [PATCH] FB: Typoes in Kconfig
Date: Tue, 20 Dec 2005 17:05:48 +0900 (JST)
Message-ID: <20051220.170548.108869605.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750838AbVLTIF3@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: Text/Plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

FB: Fix typoes in Kconfig.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3e470c8..2fd2d18 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1376,7 +1376,7 @@ config FB_PXA
 
 	  This driver is also available as a module ( = code which can be
 	  inserted and removed from the running kernel whenever you want). The
-	  module will be called vfb. If you want to compile it as a module,
+	  module will be called pxafb. If you want to compile it as a module,
 	  say M here and read <file:Documentation/modules.txt>.
 
 	  If unsure, say N.
@@ -1409,7 +1409,7 @@ config FB_W100
 
 	  This driver is also available as a module ( = code which can be
 	  inserted and removed from the running kernel whenever you want). The
-	  module will be called vfb. If you want to compile it as a module,
+	  module will be called w100fb. If you want to compile it as a module,
 	  say M here and read <file:Documentation/modules.txt>.
 
 	  If unsure, say N.

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
