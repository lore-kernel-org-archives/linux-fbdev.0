From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 04 Jul 2019 08:46:16 +0000
Subject: [PATCH 10/11] input: keyboard: gpio_keys: convert platform driver to use dev_groups
Message-Id: <20190704084617.3602-11-gregkh@linuxfoundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
In-Reply-To: <20190704084617.3602-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

Platform drivers now have the option to have the platform core create
and remove any needed sysfs attribute files.  So take advantage of that
and do not register "by hand" a bunch of sysfs files.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/keyboard/gpio_keys.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 6cd199e8a370..1f6547440edb 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -354,10 +354,7 @@ static struct attribute *gpio_keys_attrs[] = {
 	&dev_attr_disabled_switches.attr,
 	NULL,
 };
-
-static const struct attribute_group gpio_keys_attr_group = {
-	.attrs = gpio_keys_attrs,
-};
+ATTRIBUTE_GROUPS(gpio_keys);
 
 static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
 {
@@ -856,13 +853,6 @@ static int gpio_keys_probe(struct platform_device *pdev)
 
 	fwnode_handle_put(child);
 
-	error = devm_device_add_group(dev, &gpio_keys_attr_group);
-	if (error) {
-		dev_err(dev, "Unable to export keys/switches, error: %d\n",
-			error);
-		return error;
-	}
-
 	error = input_register_device(input);
 	if (error) {
 		dev_err(dev, "Unable to register input device, error: %d\n",
@@ -1025,6 +1015,7 @@ static void gpio_keys_shutdown(struct platform_device *pdev)
 }
 
 static struct platform_driver gpio_keys_device_driver = {
+	.dev_groups	= gpio_keys_groups,
 	.probe		= gpio_keys_probe,
 	.shutdown	= gpio_keys_shutdown,
 	.driver		= {
-- 
2.22.0
