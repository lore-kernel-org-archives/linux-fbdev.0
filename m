From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Thu, 06 Sep 2012 16:09:15 +0000
Subject: [PATCH 7/10] drivers/video/sis/initextlfb.c: removes unnecessary semicolon
Message-Id: <1346947757-10481-8-git-send-email-peter.senna@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346947757-10481-1-git-send-email-peter.senna@gmail.com>
In-Reply-To: <1346947757-10481-1-git-send-email-peter.senna@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: kernel-janitors@vger.kernel.org, Peter Senna Tschudin <peter.senna@gmail.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Peter Senna Tschudin <peter.senna@gmail.com>

removes unnecessary semicolon

Found by Coccinelle: http://coccinelle.lip6.fr/

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>

---
 drivers/video/sis/initextlfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/video/sis/initextlfb.c b/drivers/video/sis/initextlfb.c
--- a/drivers/video/sis/initextlfb.c
+++ b/drivers/video/sis/initextlfb.c
@@ -65,7 +65,7 @@ sisfb_mode_rate_to_dclock(struct SiS_Pri
     }
 #endif
 
-    if(!(SiS_SearchModeID(SiS_Pr, &ModeNo, &ModeIdIndex))) {;
+    if(!(SiS_SearchModeID(SiS_Pr, &ModeNo, &ModeIdIndex))) {
        printk(KERN_ERR "Could not find mode %x\n", ModeNo);
        return 65000;
     }

