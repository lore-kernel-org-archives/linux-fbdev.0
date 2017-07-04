From: Lynn Lei <lynnl.yet@gmail.com>
Date: Tue, 04 Jul 2017 15:24:17 +0000
Subject: [PATCH 3/4] video: fbdev: sm712fb.c: fixed prefer unsigned int warning
Message-Id: <20170704152417.GA29324@lynnl.yet>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Fixed several prefer 'unsigned int' over 'unsigned' warnings checked by
scripts/checkpatch.pl:
  Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
---
 drivers/video/fbdev/sm712fb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index d492a9e9ac50..172e94146878 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -798,8 +798,8 @@ static void __init sm7xx_vga_setup(char *options)
 	}
 }
 
-static void sm712_setpalette(int regno, unsigned red, unsigned green,
-			     unsigned blue, struct fb_info *info)
+static void sm712_setpalette(int regno, unsigned int red, unsigned int green,
+			     unsigned int blue, struct fb_info *info)
 {
 	/* set bit 5:4 = 01 (write LCD RAM only) */
 	smtc_seqw(0x66, (smtc_seqr(0x66) & 0xC3) | 0x10);
@@ -896,8 +896,9 @@ static int smtc_blank(int blank_mode, struct fb_info *info)
 	return 0;
 }
 
-static int smtc_setcolreg(unsigned regno, unsigned red, unsigned green,
-			  unsigned blue, unsigned trans, struct fb_info *info)
+static int smtc_setcolreg(unsigned int regno, unsigned int red,
+			  unsigned int green, unsigned int blue,
+			  unsigned int trans, struct fb_info *info)
 {
 	struct smtcfb_info *sfb;
 	u32 val;
-- 
2.13.2

