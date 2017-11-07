From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 07 Nov 2017 14:13:06 +0000
Subject: [PATCH 2/2] fbdev: radeon: stop use ktime_get() for HZ calibration
Message-Id: <20171107141319.3390036-2-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171107141319.3390036-1-arnd@arndb.de>
In-Reply-To: <20171107141319.3390036-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Colin Ian King <colin.king@canonical.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org

do_gettimeofday() is deprecated and a bit clumsy. This changes
radeon_probe_pll_params() over to using ktime_get() with monotonic
times. There is no need to check for negative values any more
since the monotonic clocksource cannot go backwards, but I'm
adding a check for zero-division in case of a bad clocksource.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/aty/radeon_base.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 8ad1643e7d1c..8b7048fbf6dc 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -583,8 +583,8 @@ static int radeon_probe_pll_params(struct radeonfb_info *rinfo)
 	int hTotal, vTotal, num, denom, m, n;
 	unsigned long long hz, vclk;
 	long xtal;
-	struct timeval start_tv, stop_tv;
-	long total_secs, total_usecs;
+	ktime_t start_time, stop_time;
+	u64 total_usecs;
 	int i;
 
 	/* Ugh, we cut interrupts, bad bad bad, but we want some precision
@@ -600,7 +600,7 @@ static int radeon_probe_pll_params(struct radeonfb_info *rinfo)
 		if (((INREG(CRTC_VLINE_CRNT_VLINE) >> 16) & 0x3ff) = 0)
 			break;
 
-	do_gettimeofday(&start_tv);
+	start_time = ktime_get();
 
 	for(i=0; i<1000000; i++)
 		if (((INREG(CRTC_VLINE_CRNT_VLINE) >> 16) & 0x3ff) != 0)
@@ -610,18 +610,14 @@ static int radeon_probe_pll_params(struct radeonfb_info *rinfo)
 		if (((INREG(CRTC_VLINE_CRNT_VLINE) >> 16) & 0x3ff) = 0)
 			break;
 	
-	do_gettimeofday(&stop_tv);
+	stop_time = ktime_get();
 	
 	local_irq_enable();
 
-	total_secs = stop_tv.tv_sec - start_tv.tv_sec;
-	if (total_secs > 10)
+	total_usecs = ktime_us_delta(stop_time, start_time);
+	if (total_usecs >= 10 * USEC_PER_SEC || total_usecs = 0)
 		return -1;
-	total_usecs = stop_tv.tv_usec - start_tv.tv_usec;
-	total_usecs += total_secs * 1000000;
-	if (total_usecs < 0)
-		total_usecs = -total_usecs;
-	hz = 1000000/total_usecs;
+	hz = USEC_PER_SEC/(u32)total_usecs;
  
 	hTotal = ((INREG(CRTC_H_TOTAL_DISP) & 0x1ff) + 1) * 8;
 	vTotal = ((INREG(CRTC_V_TOTAL_DISP) & 0x3ff) + 1);
-- 
2.9.0

