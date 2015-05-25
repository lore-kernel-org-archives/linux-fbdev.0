From: Tina Ruchandani <ruchandani.tina@gmail.com>
Date: Mon, 25 May 2015 04:19:16 +0000
Subject: [PATCH] fbdev: radeon: Remove 'struct timeval' usage
Message-Id: <20150525040716.GA4448@tinar>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

'struct timeval' uses a 32-bit representation for the
seconds field which will overflow in the year 2038 and beyond.
This patch replaces the usage of 'struct timeval' with
ktime_t which uses a 64-bit time representation and does not
suffer from the y2038 problem. This patch is part of a larger
effort to remove all instances of 'struct timeval', 'struct
timespec', time_t and other 32-bit timekeeping variables
from the kernel.
The patch also replaces the use of real time (do_gettimeofday)
with monotonic time (ktime_get).

Signed-off-by: Tina Ruchandani <ruchandani.tina@gmail.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 01237c8..9747e9e 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -64,6 +64,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/time.h>
+#include <linux/ktime.h>
 #include <linux/fb.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
@@ -461,8 +462,8 @@ static int radeon_probe_pll_params(struct radeonfb_info *rinfo)
 	int hTotal, vTotal, num, denom, m, n;
 	unsigned long long hz, vclk;
 	long xtal;
-	struct timeval start_tv, stop_tv;
-	long total_secs, total_usecs;
+	ktime_t start, stop;
+	s64 delta;
 	int i;
 
 	/* Ugh, we cut interrupts, bad bad bad, but we want some precision
@@ -478,7 +479,7 @@ static int radeon_probe_pll_params(struct radeonfb_info *rinfo)
 		if (((INREG(CRTC_VLINE_CRNT_VLINE) >> 16) & 0x3ff) = 0)
 			break;
 
-	do_gettimeofday(&start_tv);
+	start = ktime_get();
 
 	for(i=0; i<1000000; i++)
 		if (((INREG(CRTC_VLINE_CRNT_VLINE) >> 16) & 0x3ff) != 0)
@@ -487,20 +488,18 @@ static int radeon_probe_pll_params(struct radeonfb_info *rinfo)
 	for(i=0; i<1000000; i++)
 		if (((INREG(CRTC_VLINE_CRNT_VLINE) >> 16) & 0x3ff) = 0)
 			break;
-	
-	do_gettimeofday(&stop_tv);
-	
+
+	stop = ktime_get();
+
 	local_irq_enable();
 
-	total_secs = stop_tv.tv_sec - start_tv.tv_sec;
-	if (total_secs > 10)
+	delta = ktime_us_delta(stop, start);
+
+	/* Return -1 if more than 10 seconds have elapsed */
+	if (delta > (10*1000000))
 		return -1;
-	total_usecs = stop_tv.tv_usec - start_tv.tv_usec;
-	total_usecs += total_secs * 1000000;
-	if (total_usecs < 0)
-		total_usecs = -total_usecs;
-	hz = 1000000/total_usecs;
- 
+	hz = 1000000/delta;
+
 	hTotal = ((INREG(CRTC_H_TOTAL_DISP) & 0x1ff) + 1) * 8;
 	vTotal = ((INREG(CRTC_V_TOTAL_DISP) & 0x3ff) + 1);
 	vclk = (long long)hTotal * (long long)vTotal * hz;
@@ -548,7 +547,7 @@ static int radeon_probe_pll_params(struct radeonfb_info *rinfo)
 		denom *= 3;
 		break;
 	case 6:
-		denom *= 6;   
+		denom *= 6;
 		break;
 	case 7:
 		denom *= 12;
-- 
2.2.0.rc0.207.ga3a616c

