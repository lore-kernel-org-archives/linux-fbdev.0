From: Juston Li <juston.h.li@gmail.com>
Date: Mon, 29 Jun 2015 17:55:27 +0000
Subject: [PATCH v4 10/19] staging: sm750fb: add space after return type
Message-Id: <1435600536-13135-10-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F-+fT0iRmFd+H_X-1gBmvCsgehxXeyr7A8Zk9TtfD0aBA@mail.gmail.com>
In-Reply-To: <CAFow2F-+fT0iRmFd+H_X-1gBmvCsgehxXeyr7A8Zk9TtfD0aBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Cc: Juston Li <juston.h.li@gmail.com>

Fixes checkpatch.pl warning:
WARNING: missing space after return type

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/sm750.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 9989ff6..2d04c0f 100644
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

