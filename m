From: Zac Storer <zac.3.14159@gmail.com>
Date: Fri, 18 Nov 2011 04:50:45 +0000
Subject: [PATCH 6/6] Drivers: video: riva: riva_hw: fixed a brace coding style issue
Message-Id: <1321591845-8610-1-git-send-email-zac.3.14159@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@gmail.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Zac Storer <zac.3.14159@gmail.com>

Fixed a brace coding style issue.

Signed-off-by: Zac Storer <zac.3.14159@gmail.com>
---
 drivers/video/riva/riva_hw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/riva/riva_hw.c b/drivers/video/riva/riva_hw.c
index c4b8a6f..5cd1d71 100644
--- a/drivers/video/riva/riva_hw.c
+++ b/drivers/video/riva/riva_hw.c
@@ -1038,7 +1038,7 @@ static void nv10CalcArbitration
             min_mclk_extra--;
           }
       } else {
-        if (clwm > 1023){ /* Have some margin */
+        if (clwm > 1023) { /* Have some margin */
           fifo->valid = 0;
           found = 0;
           if(min_mclk_extra = 0)   
-- 
1.7.7.3

