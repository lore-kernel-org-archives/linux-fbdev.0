From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 11 Jul 2014 09:21:36 +0000
Subject: [patch] video: of: display_timing: double free on error
Message-Id: <20140711092136.GA9339@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The display_timings_release() function frees "disp" and we free it
again on the next line.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index 987edf1..5c098d5 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -236,6 +236,7 @@ timingfail:
 	if (native_mode)
 		of_node_put(native_mode);
 	display_timings_release(disp);
+	disp = NULL;
 entryfail:
 	kfree(disp);
 dispfail:
