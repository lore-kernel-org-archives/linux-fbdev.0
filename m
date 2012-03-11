From: santosh nayak <santoshprasadnayak@gmail.com>
Date: Sun, 11 Mar 2012 13:26:25 +0000
Subject: [PATCH] Video : Amba: Use in_interrupt() in clcdfb_sleep().
Message-Id: <1331471665-22226-1-git-send-email-santoshprasadnayak@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFLxGvygW=DeSQbRq8Wbcdy5E3e4vYcN666_9oWgnuwzT1WKqw@mail.gmail.com>
In-Reply-To: <CAFLxGvygW=DeSQbRq8Wbcdy5E3e4vYcN666_9oWgnuwzT1WKqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@arm.linux.org.uk
Cc: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Santosh Nayak <santoshprasadnayak@gmail.com>

From: Santosh Nayak <santoshprasadnayak@gmail.com>

Instead of "in_atomic()", we can use in_interrupt() to check whether
its an interrupt context.

Signed-off-by: Santosh Nayak <santoshprasadnayak@gmail.com>
---
 drivers/video/amba-clcd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 0a2cce7..63c25da 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -39,7 +39,7 @@ static const char *clcd_name = "CLCD FB";
  */
 static inline void clcdfb_sleep(unsigned int ms)
 {
-	if (in_atomic()) {
+	if (in_interrupt()) {
 		mdelay(ms);
 	} else {
 		msleep(ms);
-- 
1.7.4.4

