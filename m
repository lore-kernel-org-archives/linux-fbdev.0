From: Juston Li <juston.h.li@gmail.com>
Date: Wed, 24 Jun 2015 16:25:11 +0000
Subject: [PATCH v3 10/19] staging: sm750fb: add space after return type
Message-Id: <1435163120-3253-10-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
In-Reply-To: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Cc: Juston Li <juston.h.li@gmail.com>

fixes checkpatch.pl warning:
WARNING: missing space after return type

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/sm750.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 124921e..320908bc 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -108,12 +108,12 @@ struct lynxfb_crtc {
 
 	void *priv;
 
-	int(*proc_setMode)(struct lynxfb_crtc*,
+	int (*proc_setMode)(struct lynxfb_crtc*,
 						struct fb_var_screeninfo*,
 						struct fb_fix_screeninfo*);
 
-	int(*proc_checkMode)(struct lynxfb_crtc*, struct fb_var_screeninfo*);
-	int(*proc_setColReg)(struct lynxfb_crtc*, ushort, ushort, ushort, ushort);
+	int (*proc_checkMode)(struct lynxfb_crtc*, struct fb_var_screeninfo*);
+	int (*proc_setColReg)(struct lynxfb_crtc*, ushort, ushort, ushort, ushort);
 	void (*clear)(struct lynxfb_crtc*);
         /* pan display */
 	int (*proc_panDisplay)(struct lynxfb_crtc *,
@@ -140,12 +140,12 @@ struct lynxfb_output {
 	*/
 	void *priv;
 
-	int(*proc_setMode)(struct lynxfb_output*,
+	int (*proc_setMode)(struct lynxfb_output*,
 						struct fb_var_screeninfo*,
 						struct fb_fix_screeninfo*);
 
-	int(*proc_checkMode)(struct lynxfb_output*, struct fb_var_screeninfo*);
-	int(*proc_setBLANK)(struct lynxfb_output*, int);
+	int (*proc_checkMode)(struct lynxfb_output*, struct fb_var_screeninfo*);
+	int (*proc_setBLANK)(struct lynxfb_output*, int);
 	void  (*clear)(struct lynxfb_output*);
 };
 
-- 
2.4.4

