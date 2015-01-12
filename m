From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Jan 2015 20:10:13 +0000
Subject: [PATCH v2 2/2] video: Drop superfluous "select VT_HW_CONSOLE_BINDING"
Message-Id: <1421093413-26336-2-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421093413-26336-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1421093413-26336-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

commit 765d5b9c2b72f5b99722cdfcf4bf8f88c556cf92 ("fbdev: fbcon: select
VT_HW_CONSOLE_BINDING") made FRAMEBUFFER_CONSOLE always select
VT_HW_CONSOLE_BINDING, but forgot to remove

	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE

from the individual drivers' sections that already did this before.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Split in two (drm and video) patches.
---
 drivers/video/fbdev/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 4916c97216f880fc..f2c3fb7d03992ad1 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2151,7 +2151,6 @@ config FB_PS3
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
 	select FB_SYS_FOPS
-	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
 	---help---
 	  Include support for the virtual frame buffer in the PS3 platform.
 
-- 
1.9.1

