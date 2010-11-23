From: Inki Dae <inki.dae@samsung.com>
Date: Tue, 23 Nov 2010 07:15:04 +0000
Subject: [PATCH 1/4] FB: added a structure for CPU interface to linux/fb.h
Message-Id: <1290496504-4867-1-git-send-email-inki.dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <>
In-Reply-To: <>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

RGB or CPU interfaces could be used as display mode but framebuffer
framework doesn't consider CPU interface so I added this structure
because fb_cpumode structure could be used commonly.

Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/linux/fb.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 7fca3dc..9b9842c 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -1147,6 +1147,18 @@ struct fb_videomode {
 	u32 flag;
 };
 
+struct fb_cpumode {
+	const char *name;	/* optional */
+	u32 refresh;		/* optional */
+	u32 xres;
+	u32 yres;
+	u32 pixclock;
+	u32 cs_setup;
+	u32 wr_setup;
+	u32 wr_act;
+	u32 wr_hold;
+};
+
 extern const char *fb_mode_option;
 extern const struct fb_videomode vesa_modes[];
 
-- 
1.5.4.3

