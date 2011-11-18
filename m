From: Zac Storer <zac.3.14159@gmail.com>
Date: Fri, 18 Nov 2011 04:45:37 +0000
Subject: [PATCH 5/5] Drivers: video: riva: riva_hw: fixed a brace coding style issue
Message-Id: <1321591537-8475-1-git-send-email-zac.3.14159@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Zac Storer <zac.3.14159@gmail.com>

Fixed a brace coding style issue.

Signed-off-by: Zac Storer <zac.3.14159@gmail.com>
---
 drivers/video/riva/riva_hw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/riva/riva_hw.c b/drivers/video/riva/riva_hw.c
index 78fdbf5..c4b8a6f 100644
--- a/drivers/video/riva/riva_hw.c
+++ b/drivers/video/riva/riva_hw.c
@@ -994,7 +994,7 @@ static void nv10CalcArbitration
               clwm = clwm_mt;
   */
           /* Finally, a heuristic check when width = 64 bits */
-          if(width = 1){
+          if(width = 1) {
               nvclk_fill = nvclk_freq * 8;
               if(crtc_drain_rate * 100 >= nvclk_fill * 102)
                       clwm = 0xfff; /*Large number to fail */
-- 
1.7.7.3

