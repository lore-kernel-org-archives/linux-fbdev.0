From: Yifeng Li <tomli@tomli.me>
Date: Sun, 03 Mar 2019 16:55:31 +0000
Subject: [RESEND][PATCH 1/2] staging: sm750fb: trivial comment indention fix.
Message-Id: <20190303165532.23727-2-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190303165532.23727-1-tomli@tomli.me>
In-Reply-To: <20190303165532.23727-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Kosina <trivial@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org
Cc: Yifeng Li <tomli@tomli.me>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org

In function sm750_hw_copyarea() of sm750_accel.c, there are
some comments in ASCII graphs, describing 4 possible scenarios
of overlapping areas when copying an area. However, the graphs
have broken indention.

The entire SiliconMotion series video controllers, including
SM501, SM712 and SM750 have similar 2D engines, yet, I have
not seen a single version of it with ASCII graphs properly
formatted...

Fix the the misleading ASCII graphs. It would eliminate the
confusions and improve code readability.

Signed-off-by: Yifeng Li <tomli@tomli.me>
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
