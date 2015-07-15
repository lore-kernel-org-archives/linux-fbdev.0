From: Juston Li <juston.h.li@gmail.com>
Date: Wed, 15 Jul 2015 04:14:44 +0000
Subject: [PATCH v5 15/19] staging: sm750fb: remove unnecessary whitespace
Message-Id: <1436933688-5408-15-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
In-Reply-To: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

Fixes checkpatch.pl warning:
WARNING: unnecessary whitespace before a quoted newline

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 2 +-
 drivers/staging/sm750fb/sm750_hw.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 4d165ca..c7ab818 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -967,7 +967,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	var->accel_flags = 0;
 	var->vmode = FB_VMODE_NONINTERLACED;
 
-	pr_debug("#1 show info->cmap : \nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
+	pr_debug("#1 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
 		 info->cmap.start, info->cmap.len,
 		 info->cmap.red, info->cmap.green, info->cmap.blue,
 		 info->cmap.transp);
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 359165d..fb9c631 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -250,7 +250,7 @@ int hw_sm750_output_setMode(struct lynxfb_output *output,
 		POKE32(DISPLAY_CONTROL_750LE, reg);
 	}
 
-	pr_info("ddk setlogicdispout done \n");
+	pr_info("ddk setlogicdispout done\n");
 	return ret;
 }
 
@@ -489,14 +489,14 @@ int hw_sm750_setBLANK(struct lynxfb_output *output, int blank)
 #else
 	case VESA_NO_BLANKING:
 #endif
-		pr_info("flag = FB_BLANK_UNBLANK \n");
+		pr_info("flag = FB_BLANK_UNBLANK\n");
 		dpms = SYSTEM_CTRL_DPMS_VPHP;
 		pps = PANEL_DISPLAY_CTRL_DATA_ENABLE;
 		crtdb = CRT_DISPLAY_CTRL_BLANK_OFF;
 		break;
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
 	case FB_BLANK_NORMAL:
-		pr_info("flag = FB_BLANK_NORMAL \n");
+		pr_info("flag = FB_BLANK_NORMAL\n");
 		dpms = SYSTEM_CTRL_DPMS_VPHP;
 		pps = PANEL_DISPLAY_CTRL_DATA_DISABLE;
 		crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
-- 
2.4.5

