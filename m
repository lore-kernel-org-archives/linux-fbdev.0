From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 20 Dec 2010 13:09:57 +0000
Subject: [PATCH 2/2] fbdev: Modify vsync timing calculation in wm8505fb
Message-Id: <20101220130957.GB3627@alchark-u3s>
List-Id: <linux-fbdev.vger.kernel.org>
In-Reply-To: <20101220130314.GA3627@alchark-u3s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: Alexey Charkov <alchark@gmail.com>, Paul Mundt <lethal@linux-sh.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vt8500-wm8505-linux-kernel@googlegroups.com" <vt8500-wm8505-linux-kernel@googlegroups.com>

This removes the '+1' in vsync timing calculation for wm8505fb to
directly use values provided from the board setup code.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/video/wm8505fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
index 9ca9dbb..96e34a5 100644
--- a/drivers/video/wm8505fb.c
+++ b/drivers/video/wm8505fb.c
@@ -88,7 +88,7 @@ static int wm8505fb_set_timing(struct fb_info *info)
 	int v_start = info->var.upper_margin;
 	int v_end = v_start + info->var.yres;
 	int v_all = v_end + info->var.lower_margin;
-	int v_sync = info->var.vsync_len + 1;
+	int v_sync = info->var.vsync_len;
 
 	writel(0, fbi->regbase + WMT_GOVR_TG);
 
-- 
1.7.3.4

