From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Thu, 17 Sep 2020 11:56:45 +0000
Subject: [PATCH v1] fbdev: aty: remove CONFIG_PM container
Message-Id: <20200917115313.725622-1-vaibhavgupta40@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <bjorn@helgaas.com>, Vaibhav Gupta <vaibhav.varodek@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sam Ravnborg <sam@ravnborg.org>, Paul Mackerras <paulus@samba.org>, Russell King <linux@armlinux.org.uk>, Andres Salomon <dilinger@queued.net>, Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, kernel test robot <lkp@intel.com>, Vaibhav Gupta <vaibhavgupta40@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-geode@lists.infradead.org, linux-kernel-mentees@lists.linuxfoundation.org, linux-arm-kernel@lists.infradead.org

The changes made in below mentioned commit removed CONFIG_PM containers
from drivers/video/fbdev/aty/atyfb_base.c but not from
drivers/video/fbdev/aty/atyfb.h for respective callbacks.

This resulted in error for implicit declaration for those callbacks.

Fixes: 348b2956d5e6 ("fbdev: aty: use generic power management")

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/video/fbdev/aty/atyfb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb.h b/drivers/video/fbdev/aty/atyfb.h
index a7833bc98225..551372f9b9aa 100644
--- a/drivers/video/fbdev/aty/atyfb.h
+++ b/drivers/video/fbdev/aty/atyfb.h
@@ -287,8 +287,8 @@ static inline void aty_st_8(int regindex, u8 val, const struct atyfb_par *par)
 #endif
 }
 
-#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || \
-defined (CONFIG_FB_ATY_GENERIC_LCD) || defined (CONFIG_FB_ATY_BACKLIGHT)
+#if defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) || \
+defined (CONFIG_FB_ATY_BACKLIGHT)
 extern void aty_st_lcd(int index, u32 val, const struct atyfb_par *par);
 extern u32 aty_ld_lcd(int index, const struct atyfb_par *par);
 #endif
-- 
2.28.0
