From: Lad Prabhakar <prabhakar.csengg@gmail.com>
Date: Thu, 16 May 2013 07:22:56 +0000
Subject: [PATCH 1/2] video: da8xx-fb: remove unwanted header inclusion and sort the alphabetically
Message-Id: <1368688257-18705-2-git-send-email-prabhakar.csengg@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1368688257-18705-1-git-send-email-prabhakar.csengg@gmail.com>
In-Reply-To: <1368688257-18705-1-git-send-email-prabhakar.csengg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DLOS <davinci-linux-open-source@linux.davincidsp.com>, LFBDEV <linux-fbdev@vger.kernel.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

From: Lad, Prabhakar <prabhakar.csengg@gmail.com>

This patch removes unwanted header inclusion and sorts them alphabetically

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 drivers/video/da8xx-fb.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 0810939..aafe8b9 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -19,25 +19,22 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/fb.h>
+
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/cpufreq.h>
 #include <linux/dma-mapping.h>
-#include <linux/device.h>
+#include <linux/fb.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
-#include <linux/interrupt.h>
-#include <linux/wait.h>
-#include <linux/clk.h>
-#include <linux/cpufreq.h>
-#include <linux/console.h>
-#include <linux/spinlock.h>
-#include <linux/slab.h>
+#include <linux/uaccess.h>
+
 #include <linux/delay.h>
 #include <linux/lcm.h>
+
 #include <video/da8xx-fb.h>
-#include <asm/div64.h>
 
 #define DRIVER_NAME "da8xx_lcdc"
 
-- 
1.7.4.1

