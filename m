From: Derek Robson <robsonde@gmail.com>
Date: Sun, 25 Jun 2017 01:54:59 +0000
Subject: [PATCH V3] staging: sm750fb - add parameter names
Message-Id: <20170625015459.30558-1-robsonde@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Derek Robson <robsonde@gmail.com>

Fixed checkpatch.pl warnings of the form "function definition argument
'foo' should also have an identifier name" in header files.

Signed-off-by: Derek Robson <robsonde@gmail.com>
---
V2 had V1 comment above the line
V1 had vauge subject line

 drivers/staging/sm750fb/sm750.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 5b186dafedec..4386122799b2 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -189,14 +189,22 @@ void hw_sm750_initAccel(struct sm750_dev *sm750_dev);
 int hw_sm750_deWait(void);
 int hw_sm750le_deWait(void);
 
-int hw_sm750_output_setMode(struct lynxfb_output*, struct fb_var_screeninfo*,
-			    struct fb_fix_screeninfo*);
-int hw_sm750_crtc_checkMode(struct lynxfb_crtc*, struct fb_var_screeninfo*);
-int hw_sm750_crtc_setMode(struct lynxfb_crtc*, struct fb_var_screeninfo*,
-			  struct fb_fix_screeninfo*);
-int hw_sm750_setColReg(struct lynxfb_crtc*, ushort, ushort, ushort, ushort);
-int hw_sm750_setBLANK(struct lynxfb_output*, int);
-int hw_sm750le_setBLANK(struct lynxfb_output*, int);
+int hw_sm750_output_setMode(struct lynxfb_output *output,
+			    struct fb_var_screeninfo *var,
+			    struct fb_fix_screeninfo *fix);
+
+int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc,
+			    struct fb_var_screeninfo *var);
+
+int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
+			  struct fb_var_screeninfo *var,
+			  struct fb_fix_screeninfo *fix);
+
+int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index,
+		       ushort red, ushort green, ushort blue);
+
+int hw_sm750_setBLANK(struct lynxfb_output *output, int blank);
+int hw_sm750le_setBLANK(struct lynxfb_output *output, int blank);
 int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
 			 const struct fb_var_screeninfo *var,
 			 const struct fb_info *info);
-- 
2.13.0

