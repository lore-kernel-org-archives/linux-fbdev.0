From: Borislav Petkov <bp@alien8.de>
Date: Sun, 12 Feb 2017 14:57:31 +0000
Subject: [PATCH] video/viafbdev: Make PROC_FS dependency explicit
Message-Id: <20170212145731.7068-1-bp@alien8.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

Fix:

  drivers/video/fbdev/via/viafbdev.c: In function ‘viafb_remove_proc’:
  drivers/video/fbdev/via/viafbdev.c:1635:4: warning: unused variable ‘iga2_entry’ [-Wunused-variable]
     *iga2_entry = shared->iga2_proc_entry;
      ^~~~~~~~~~
  drivers/video/fbdev/via/viafbdev.c:1634:4: warning: unused variable ‘iga1_entry’ [-Wunused-variable]
     *iga1_entry = shared->iga1_proc_entry,

build warning from randconfig builds.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 5d3b0db5ce0a..86ec39784c5a 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1539,7 +1539,7 @@ config FB_SIS_315
 
 config FB_VIA
        tristate "VIA UniChrome (Pro) and Chrome9 display support"
-       depends on FB && PCI && X86 && GPIOLIB && I2C
+       depends on FB && PCI && X86 && GPIOLIB && I2C && PROC_FS
        select FB_CFB_FILLRECT
        select FB_CFB_COPYAREA
        select FB_CFB_IMAGEBLIT
-- 
2.11.0

