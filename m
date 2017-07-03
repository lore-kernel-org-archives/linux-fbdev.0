From: Lynn Lei <lynnl.wit@gmail.com>
Date: Mon, 03 Jul 2017 01:26:47 +0000
Subject: [PATCH] staging: sm750fb: skip unnecessary comparisons
Message-Id: <20170703001809.GA1480@lynnl.wit>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org

introduced early checks to skip unnecessary comparisons when flags set.

Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 386d4adcd91d..9e57a2d32465 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1171,11 +1171,16 @@ static int __init lynxfb_setup(char *options)
 	 */
 	while ((opt = strsep(&options, ":")) != NULL) {
 		/* options that mean for any lynx chips are configured here */
-		if (!strncmp(opt, "noaccel", strlen("noaccel"))) {
+
+		/*
+		 * NOTE: the length of options is hard-coded
+		 * if any of those options changed  please update its length
+		 */
+		if (!g_noaccel && !strncmp(opt, "noaccel", 7)) {
 			g_noaccel = 1;
-		} else if (!strncmp(opt, "nomtrr", strlen("nomtrr"))) {
+		} else if (!g_nomtrr && !strncmp(opt, "nomtrr", 6)) {
 			g_nomtrr = 1;
-		} else if (!strncmp(opt, "dual", strlen("dual"))) {
+		} else if (!g_dualview && !strncmp(opt, "dual", 4)) {
 			g_dualview = 1;
 		} else {
 			strcat(tmp, opt);
-- 
2.13.2

