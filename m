From: Anatoly Stepanov <drivengroove@gmail.com>
Date: Sun, 28 Jun 2015 23:44:03 +0000
Subject: [PATCH 10/11] staging: sm750fb: fix open brace in function declaration
Message-Id: <1435535044-22042-11-git-send-email-drivengroove@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



Fix according to checkpatch.pl message:
"ERROR: open brace '{' following function declarations go on the next line"

Signed-off-by: Anatoly Stepanov <drivengroove@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 987da9e..a4f0cd0 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -423,7 +423,8 @@ int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index,
 	return 0;
 }
 
-int hw_sm750le_setBLANK(struct lynxfb_output *output, int blank) {
+int hw_sm750le_setBLANK(struct lynxfb_output *output, int blank)
+{
 	int dpms, crtdb;
 
 	switch (blank) {
-- 
2.1.0

