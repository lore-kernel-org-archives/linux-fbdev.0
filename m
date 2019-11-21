From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 21 Nov 2019 14:02:07 +0000
Subject: [PATCH v1] fbtft: Fix the initialization from property algorithm
Message-Id: <20191121140207.65089-1-andriy.shevchenko@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

When converting to device property API the commit
8b2d3aeeb7ec ("fbtft: Make use of device property API")
mistakenly placed the reading of the first value inside the loop,
that jumps over value after initialization sequence or sleep commands.

Move the above mentioned reading outside of the loop to restore
correct behaviour.

Besides that, we are using pre-increment operation which may lead to
out of the boundary access at the end of sequence. Thus, allocate buffer
with an additional element at the end to prevent out of the boundary
access.

Fixes: 8b2d3aeeb7ec ("fbtft: Make use of device property API")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/fbtft/fbtft-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index e87d839d86ac..4fcc82b7de1b 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -913,7 +913,7 @@ static int fbtft_init_display_from_property(struct fbtft_par *par)
 	if (count = 0)
 		return -EINVAL;
 
-	values = kmalloc_array(count, sizeof(*values), GFP_KERNEL);
+	values = kmalloc_array(count + 1, sizeof(*values), GFP_KERNEL);
 	if (!values)
 		return -ENOMEM;
 
@@ -926,9 +926,9 @@ static int fbtft_init_display_from_property(struct fbtft_par *par)
 		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	index = -1;
-	while (index < count) {
-		val = values[++index];
+	val = values[++index];
 
+	while (index < count) {
 		if (val & FBTFT_OF_INIT_CMD) {
 			val &= 0xFFFF;
 			i = 0;
-- 
2.24.0
