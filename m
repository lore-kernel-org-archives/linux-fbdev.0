From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Sep 2011 21:44:50 +0000
Subject: [PATCH 05/13] drivers/video: fsl-diu-fb: improve device tree usage
Message-Id: <1316123098-30967-6-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Implement various improvements to the way the Freescale DIU framebuffer
driver access the device tree.

1) Use of_iomap() instead of of_address_to_resource() and ioremap()

2) Use be32_to_cpup() instead of directly dereferencing the device_node
   pointer.

3) Rename variable 'ofdev' to 'pdev' to avoid any confusion that it's
   a platform_device pointer, not an of_device pointer (of_device no
   longer exists).

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   65 ++++++++++++++++---------------------------
 1 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 6c544cf..96417ab 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1425,13 +1425,12 @@ static ssize_t show_monitor(struct device *device,
 	return 0;
 }
 
-static int __devinit fsl_diu_probe(struct platform_device *ofdev)
+static int __devinit fsl_diu_probe(struct platform_device *pdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	struct mfb_info *mfbi;
 	phys_addr_t dummy_ad_addr = 0;
 	int ret, i, error = 0;
-	struct resource res;
 	struct fsl_diu_data *machine_data;
 	int diu_mode;
 
@@ -1441,9 +1440,9 @@ static int __devinit fsl_diu_probe(struct platform_device *ofdev)
 
 	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++) {
 		machine_data->fsl_diu_info[i] -			framebuffer_alloc(sizeof(struct mfb_info), &ofdev->dev);
+			framebuffer_alloc(sizeof(struct mfb_info), &pdev->dev);
 		if (!machine_data->fsl_diu_info[i]) {
-			dev_err(&ofdev->dev, "cannot allocate memory\n");
+			dev_err(&pdev->dev, "cannot allocate memory\n");
 			ret = -ENOMEM;
 			goto error2;
 		}
@@ -1463,19 +1462,9 @@ static int __devinit fsl_diu_probe(struct platform_device *ofdev)
 		}
 	}
 
-	ret = of_address_to_resource(np, 0, &res);
-	if (ret) {
-		dev_err(&ofdev->dev, "could not obtain DIU address\n");
-		goto error;
-	}
-	if (!res.start) {
-		dev_err(&ofdev->dev, "invalid DIU address\n");
-		goto error;
-	}
-
-	dr.diu_reg = ioremap(res.start, sizeof(struct diu));
+	dr.diu_reg = of_iomap(np, 0);
 	if (!dr.diu_reg) {
-		dev_err(&ofdev->dev, "Err: can't map DIU registers!\n");
+		dev_err(&pdev->dev, "cannot map DIU registers\n");
 		ret = -EFAULT;
 		goto error2;
 	}
@@ -1488,25 +1477,25 @@ static int __devinit fsl_diu_probe(struct platform_device *ofdev)
 	machine_data->irq = irq_of_parse_and_map(np, 0);
 
 	if (!machine_data->irq) {
-		dev_err(&ofdev->dev, "could not get DIU IRQ\n");
+		dev_err(&pdev->dev, "could not get DIU IRQ\n");
 		ret = -EINVAL;
 		goto error;
 	}
 	machine_data->monitor_port = monitor_port;
 
 	/* Area descriptor memory pool aligns to 64-bit boundary */
-	if (allocate_buf(&ofdev->dev, &pool.ad,
+	if (allocate_buf(&pdev->dev, &pool.ad,
 			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8))
 		return -ENOMEM;
 
 	/* Get memory for Gamma Table  - 32-byte aligned memory */
-	if (allocate_buf(&ofdev->dev, &pool.gamma, 768, 32)) {
+	if (allocate_buf(&pdev->dev, &pool.gamma, 768, 32)) {
 		ret = -ENOMEM;
 		goto error;
 	}
 
 	/* For performance, cursor bitmap buffer aligns to 32-byte boundary */
-	if (allocate_buf(&ofdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2,
+	if (allocate_buf(&pdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2,
 			 32)) {
 		ret = -ENOMEM;
 		goto error;
@@ -1548,16 +1537,13 @@ static int __devinit fsl_diu_probe(struct platform_device *ofdev)
 		mfbi->ad->paddr = pool.ad.paddr + i * sizeof(struct diu_ad);
 		ret = install_fb(machine_data->fsl_diu_info[i]);
 		if (ret) {
-			dev_err(&ofdev->dev,
-				"Failed to register framebuffer %d\n",
-				i);
+			dev_err(&pdev->dev, "could not register fb %d\n", i);
 			goto error;
 		}
 	}
 
 	if (request_irq_local(machine_data->irq)) {
-		dev_err(machine_data->fsl_diu_info[0]->dev,
-			"could not request irq for diu.");
+		dev_err(&pdev->dev, "could not claim irq\n");
 		goto error;
 	}
 
@@ -1569,12 +1555,11 @@ static int __devinit fsl_diu_probe(struct platform_device *ofdev)
 	error = device_create_file(machine_data->fsl_diu_info[0]->dev,
 				  &machine_data->dev_attr);
 	if (error) {
-		dev_err(machine_data->fsl_diu_info[0]->dev,
-			"could not create sysfs %s file\n",
+		dev_err(&pdev->dev, "could not create sysfs file %s\n",
 			machine_data->dev_attr.attr.name);
 	}
 
-	dev_set_drvdata(&ofdev->dev, machine_data);
+	dev_set_drvdata(&pdev->dev, machine_data);
 	return 0;
 
 error:
@@ -1582,12 +1567,12 @@ error:
 		i > 0; i--)
 		uninstall_fb(machine_data->fsl_diu_info[i - 1]);
 	if (pool.ad.vaddr)
-		free_buf(&ofdev->dev, &pool.ad,
+		free_buf(&pdev->dev, &pool.ad,
 			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8);
 	if (pool.gamma.vaddr)
-		free_buf(&ofdev->dev, &pool.gamma, 768, 32);
+		free_buf(&pdev->dev, &pool.gamma, 768, 32);
 	if (pool.cursor.vaddr)
-		free_buf(&ofdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2,
+		free_buf(&pdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2,
 			 32);
 	if (machine_data->dummy_aoi_virt)
 		fsl_diu_free(machine_data->dummy_aoi_virt, 64);
@@ -1602,25 +1587,23 @@ error2:
 	return ret;
 }
 
-
-static int fsl_diu_remove(struct platform_device *ofdev)
+static int fsl_diu_remove(struct platform_device *pdev)
 {
 	struct fsl_diu_data *machine_data;
 	int i;
 
-	machine_data = dev_get_drvdata(&ofdev->dev);
+	machine_data = dev_get_drvdata(&pdev->dev);
 	disable_lcdc(machine_data->fsl_diu_info[0]);
 	free_irq_local(machine_data->irq);
 	for (i = ARRAY_SIZE(machine_data->fsl_diu_info); i > 0; i--)
 		uninstall_fb(machine_data->fsl_diu_info[i - 1]);
 	if (pool.ad.vaddr)
-		free_buf(&ofdev->dev, &pool.ad,
+		free_buf(&pdev->dev, &pool.ad,
 			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8);
 	if (pool.gamma.vaddr)
-		free_buf(&ofdev->dev, &pool.gamma, 768, 32);
+		free_buf(&pdev->dev, &pool.gamma, 768, 32);
 	if (pool.cursor.vaddr)
-		free_buf(&ofdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2,
-			 32);
+		free_buf(&pdev->dev, &pool.cursor, MAX_CURS * MAX_CURS * 2, 32);
 	if (machine_data->dummy_aoi_virt)
 		fsl_diu_free(machine_data->dummy_aoi_virt, 64);
 	iounmap(dr.diu_reg);
@@ -1722,7 +1705,7 @@ static int __init fsl_diu_init(void)
 	 * Freescale PLRU requires 13/8 times the cache size to do a proper
 	 * displacement flush
 	 */
-	coherence_data_size = *prop * 13;
+	coherence_data_size = be32_to_cpup(prop) * 13;
 	coherence_data_size /= 8;
 
 	prop = of_get_property(np, "d-cache-line-size", NULL);
@@ -1732,7 +1715,7 @@ static int __init fsl_diu_init(void)
 		of_node_put(np);
 		return -ENODEV;
 	}
-	d_cache_line_size = *prop;
+	d_cache_line_size = be32_to_cpup(prop);
 
 	of_node_put(np);
 	coherence_data = vmalloc(coherence_data_size);
-- 
1.7.3.4


