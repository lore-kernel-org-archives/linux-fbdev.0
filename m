From: Pawel Osciak <p.osciak@samsung.com>
Date: Fri, 09 Jul 2010 08:50:06 +0000
Subject: [PATCH 18/19] s3c-fb: fix section mismatch
Message-Id: <1278665407-18002-19-git-send-email-p.osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
In-Reply-To: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

This patch fixes the following section mismatch errors:

WARNING: vmlinux.o(.data+0x20b40): Section mismatch in reference from the variable s3c_fb_driver_ids to the (unknown reference) .devinit.data:(unknown)
The variable s3c_fb_driver_ids references
the (unknown reference) __devinitdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: vmlinux.o(.data+0x20b58): Section mismatch in reference from the variable s3c_fb_driver_ids to the (unknown reference) .devinit.data:(unknown)
The variable s3c_fb_driver_ids references
the (unknown reference) __devinitdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: vmlinux.o(.data+0x20b70): Section mismatch in reference from the variable s3c_fb_driver_ids to the (unknown reference) .devinit.data:(unknown)
The variable s3c_fb_driver_ids references
the (unknown reference) __devinitdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/s3c-fb.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index b10d16d..a95314d 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1478,7 +1478,7 @@ static int s3c_fb_resume(struct platform_device *pdev)
 #define VALID_BPP124 (VALID_BPP(1) | VALID_BPP(2) | VALID_BPP(4))
 #define VALID_BPP1248 (VALID_BPP124 | VALID_BPP(8))
 
-static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] __devinitdata = {
+static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] = {
 	[0] = {
 		.has_osd_c	= 1,
 		.osd_size_off	= 0x8,
@@ -1526,7 +1526,7 @@ static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] __devinitdata = {
 	},
 };
 
-static struct s3c_fb_driverdata s3c_fb_data_64xx __devinitdata = {
+static struct s3c_fb_driverdata s3c_fb_data_64xx = {
 	.variant = {
 		.nr_windows	= 5,
 		.vidtcon	= VIDTCON0,
@@ -1556,7 +1556,7 @@ static struct s3c_fb_driverdata s3c_fb_data_64xx __devinitdata = {
 	.win[4]	= &s3c_fb_data_64xx_wins[4],
 };
 
-static struct s3c_fb_driverdata s3c_fb_data_s5pc100 __devinitdata = {
+static struct s3c_fb_driverdata s3c_fb_data_s5pc100 = {
 	.variant = {
 		.nr_windows	= 5,
 		.vidtcon	= VIDTCON0,
@@ -1586,7 +1586,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s5pc100 __devinitdata = {
 	.win[4]	= &s3c_fb_data_64xx_wins[4],
 };
 
-static struct s3c_fb_driverdata s3c_fb_data_s5pv210 __devinitdata = {
+static struct s3c_fb_driverdata s3c_fb_data_s5pv210 = {
 	.variant = {
 		.nr_windows	= 5,
 		.vidtcon	= VIDTCON0,
@@ -1617,7 +1617,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s5pv210 __devinitdata = {
 };
 
 /* S3C2443/S3C2416 style hardware */
-static struct s3c_fb_driverdata s3c_fb_data_s3c2443 __devinitdata = {
+static struct s3c_fb_driverdata s3c_fb_data_s3c2443 = {
 	.variant = {
 		.nr_windows	= 2,
 		.is_2443	= 1,
-- 
1.7.1.569.g6f426

