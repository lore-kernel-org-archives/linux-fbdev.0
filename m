From: Juston Li <juston.h.li@gmail.com>
Date: Wed, 24 Jun 2015 16:25:16 +0000
Subject: [PATCH v3 15/19] staging: sm750fb: remove unnecessary whitespace
Message-Id: <1435163120-3253-15-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
In-Reply-To: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Cc: Juston Li <juston.h.li@gmail.com>

fixes checkpatch.pl warning:
WARNING: unnecessary whitespace before a quoted newline

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 2 +-
 drivers/staging/sm750fb/sm750_hw.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8e201f1..1ff14b2 100644
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
index 3b8107c..d397382 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -253,7 +253,7 @@ int hw_sm750_output_setMode(struct lynxfb_output* output,
 		POKE32(DISPLAY_CONTROL_750LE, reg);
 	}
 
-	pr_info("ddk setlogicdispout done \n");
+	pr_info("ddk setlogicdispout done\n");
 	return ret;
 }
 
@@ -493,14 +493,14 @@ int hw_sm750_setBLANK(struct lynxfb_output* output, int blank)
 #else
 		case VESA_NO_BLANKING:
 #endif
-			pr_info("flag = FB_BLANK_UNBLANK \n");
+			pr_info("flag = FB_BLANK_UNBLANK\n");
 			dpms = SYSTEM_CTRL_DPMS_VPHP;
 			pps = PANEL_DISPLAY_CTRL_DATA_ENABLE;
 			crtdb = CRT_DISPLAY_CTRL_BLANK_OFF;
 			break;
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
 		case FB_BLANK_NORMAL:
-			pr_info("flag = FB_BLANK_NORMAL \n");
+			pr_info("flag = FB_BLANK_NORMAL\n");
 			dpms = SYSTEM_CTRL_DPMS_VPHP;
 			pps = PANEL_DISPLAY_CTRL_DATA_DISABLE;
 			crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
-- 
2.4.4

