From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 15 Jul 2016 11:07:32 +0000
Subject: [patch] video: fbdev: pxafb: potential NULL dereference on error
Message-Id: <20160715110732.GC9258@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

If we "goto out;" then it calls display_timings_release(timings);
Since "timings" is NULL, that's going to oops.  Just return directly.

Fixes: 420a488278e8 ('video: fbdev: pxafb: initial devicetree conversion')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 2c0487f..ed41fdb 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2125,7 +2125,7 @@ static int of_get_pxafb_display(struct device *dev, struct device_node *disp,
 
 	timings = of_get_display_timings(disp);
 	if (!timings)
-		goto out;
+		return -EINVAL;
 
 	ret = -ENOMEM;
 	info->modes = kmalloc_array(timings->num_timings,
