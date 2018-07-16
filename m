From: Colin King <colin.king@canonical.com>
Date: Mon, 16 Jul 2018 13:44:58 +0000
Subject: [PATCH] video: fbdev: tridentfb: remove deadcode on unreachable case statement
Message-Id: <20180716134458.8654-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421173160-3644-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1421173160-3644-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The value of tmp being used in the switch statement has the range of
just 0..3 hence the case 4 statement can never be reached and is
deadcode and can be removed.

Detected by CoverityScan, CID#744384 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/tridentfb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tridentfb.c
index 284706184b1b..f4b745590600 100644
--- a/drivers/video/fbdev/tridentfb.c
+++ b/drivers/video/fbdev/tridentfb.c
@@ -777,9 +777,6 @@ static int get_nativex(struct tridentfb_par *par)
 	case 3:
 		x = 800; y = 600;
 		break;
-	case 4:
-		x = 1400; y = 1050;
-		break;
 	case 1:
 	default:
 		x = 640;  y = 480;
-- 
2.17.1

