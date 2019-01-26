From: Tom Li <tomli@tomli.me>
Date: Sat, 26 Jan 2019 18:57:10 +0000
Subject: [PATCH] staging: sm750fb: fix ASCII graph in comments.
Message-Id: <20190126185710.GA13855@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

In function sm750_hw_copyarea() of sm750_accel.c, there are
some comments in ASCII graphs, describing 4 possible scenarios
of overlapping areas when copying an area. However, the
formatting is broken and the graphs are confusing.

Previously, in staging/sm7xxfb (now fbdev/sm712fb), 2D ops
were also implemented (later removed due to a critical bug
in 3af805735a2538c38ec16014f19d19030544aaef), it also had
the ASCII graph comments, but were broken in another way.

In other words, all existing versions of these ASCII graphs
are broken.

Currently, I'm working on a re-implementation of 2D ops on
fbdev/sm712fb. Since the entire SiliconMotion SM7xx series
video controllers have similar 2D engines, the comments here
served an important purpose of explaining how copyarea()
works on the entire SM7xx family.

This commit fixes the misleading ASCII graphs.

Signed-off-by: Yifeng Li <tomli@tomli.me>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index eed840b251da..dbcbbd1055da 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -155,26 +155,26 @@ unsigned int rop2)   /* ROP value */
 	if (sBase = dBase && sPitch = dPitch) {
 		/* Determine direction of operation */
 		if (sy < dy) {
-			/* +----------+
-			 * |S         |
-			 * |   +----------+
-			 * |   |      |   |
-			 * |   |      |   |
-			 * +---|------+   |
-			 * |         D|
-			 * +----------+
+			/*  +----------+
+			 *  |S         |
+			 *  |   +----------+
+			 *  |   |      |   |
+			 *  |   |      |   |
+			 *  +---|------+   |
+			 *	|         D|
+			 *	+----------+
 			 */
 
 			nDirection = BOTTOM_TO_TOP;
 		} else if (sy > dy) {
-			/* +----------+
-			 * |D         |
-			 * |   +----------+
-			 * |   |      |   |
-			 * |   |      |   |
-			 * +---|------+   |
-			 * |         S|
-			 * +----------+
+			/*  +----------+
+			 *  |D         |
+			 *  |   +----------+
+			 *  |   |      |   |
+			 *  |   |      |   |
+			 *  +---|------+   |
+			 *	|         S|
+			 *	+----------+
 			 */
 
 			nDirection = TOP_TO_BOTTOM;
-- 
2.20.1
