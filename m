From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 18 Jan 2012 21:05:50 +0000
Subject: Re: [PATCH v6 1/2] video: support MIPI-DSI controller driver
Message-Id: <20120118130550.0bdb227e.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4F16288C.5020406@samsung.com>
In-Reply-To: <4F16288C.5020406@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 18 Jan 2012 11:03:56 +0900
Donghwa Lee <dh09.lee@samsung.com> wrote:

> Samsung S5PC210 and EXYNOS SoC platform has MIPI-DSI controller and MIPI-DSI
> based LCD Panel could be used with it. This patch supports MIPI-DSI driver
> based Samsung SoC chip.
> 
> LCD panel driver based MIPI-DSI should be registered to MIPI-DSI driver at
> machine code and LCD panel driver specific function registered to mipi_dsim_ddi
> structure at lcd panel init function called system init.
> In the MIPI-DSI driver, find lcd panel driver by using registered
> lcd panel name, and then initialize lcd panel driver.
> 

The code looks nice to me.  I assume that Florian will be processing
the patch?

A few minor comments:

>
> ...
>
> +#define master_to_driver(a)	(a->dsim_lcd_drv)
> +#define master_to_device(a)	(a->dsim_lcd_dev)
> +#define dev_to_dsim(a)		platform_get_drvdata(to_platform_device(a))

These aren't very type-safe: can be called on any struct whcih has a
field called "dsim_lcd_drv".  Also the "a" should be parenthesized to
prevent obscure compile problems.

Really, it's best to do away with all such problems by implementing
these helpers in C rather than in cpp!

>
> ...
>
> +int s5p_mipi_dsi_register_lcd_device(struct mipi_dsim_lcd_device *lcd_dev)
> +{
> +	struct mipi_dsim_ddi *dsim_ddi;
> +
> +	if (!lcd_dev) {
> +		pr_err("mipi_dsim_lcd_device is NULL.\n");
> +		return -EFAULT;
> +	}

Can this happen?  If not then BUG() is more appropriate.  Or just
remove the code altogether and let the kernel oops.


> +	if (!lcd_dev->name) {
> +		pr_err("dsim_lcd_device name is NULL.\n");
> +		return -EFAULT;
> +	}

Ditto.

> +	dsim_ddi = kzalloc(sizeof(struct mipi_dsim_ddi), GFP_KERNEL);
> +	if (!dsim_ddi) {
> +		pr_err("failed to allocate dsim_ddi object.\n");
> +		return -EFAULT;

Should be ENOMEM.

> +	}
> +
> +	dsim_ddi->dsim_lcd_dev = lcd_dev;
> +
> +	mutex_lock(&mipi_dsim_lock);
> +	list_add_tail(&dsim_ddi->list, &dsim_ddi_list);
> +	mutex_unlock(&mipi_dsim_lock);
> +
> +	return 0;
> +}
> +
> +struct mipi_dsim_ddi
> +	*s5p_mipi_dsi_find_lcd_device(struct mipi_dsim_lcd_driver *lcd_drv)

Strange code layout.

> +{
> +	struct mipi_dsim_ddi *dsim_ddi, *next;
> +	struct mipi_dsim_lcd_device *lcd_dev;
> +
> +	mutex_lock(&mipi_dsim_lock);
> +
> +	list_for_each_entry_safe(dsim_ddi, next, &dsim_ddi_list, list) {
> +		if (!dsim_ddi)
> +			goto out;
> +
> +		lcd_dev = dsim_ddi->dsim_lcd_dev;
> +		if (!lcd_dev)
> +			continue;
> +
> +		if ((strcmp(lcd_drv->name, lcd_dev->name)) = 0) {

hm, using strcmp() to compare devices in this way looks fishy.  But I
don't know what is going on here.

> +			/**
> +			 * bus_id would be used to identify
> +			 * connected bus.
> +			 */
> +			dsim_ddi->bus_id = lcd_dev->bus_id;
> +			mutex_unlock(&mipi_dsim_lock);
> +
> +			return dsim_ddi;
> +		}
> +
> +		list_del(&dsim_ddi->list);
> +		kfree(dsim_ddi);
> +	}
> +
> +out:
> +	mutex_unlock(&mipi_dsim_lock);
> +
> +	return NULL;
> +}
> +
> +int s5p_mipi_dsi_register_lcd_driver(struct mipi_dsim_lcd_driver *lcd_drv)
> +{
> +	struct mipi_dsim_ddi *dsim_ddi;
> +
> +	if (!lcd_drv) {
> +		pr_err("mipi_dsim_lcd_driver is NULL.\n");
> +		return -EFAULT;
> +	}
> +
> +	if (!lcd_drv->name) {
> +		pr_err("dsim_lcd_driver name is NULL.\n");
> +		return -EFAULT;
> +	}
> +
> +	dsim_ddi = s5p_mipi_dsi_find_lcd_device(lcd_drv);
> +	if (!dsim_ddi) {
> +		pr_err("mipi_dsim_ddi object not found.\n");
> +		return -EFAULT;
> +	}

Boy, someone really likes EFAULT!

> +	dsim_ddi->dsim_lcd_drv = lcd_drv;
> +
> +	pr_info("registered panel driver(%s) to mipi-dsi driver.\n",
> +		lcd_drv->name);
> +
> +	return 0;
> +
> +}
> +
> +struct mipi_dsim_ddi
> +	*s5p_mipi_dsi_bind_lcd_ddi(struct mipi_dsim_device *dsim,
> +			const char *name)

More code layout oddness.

> +{
> +	struct mipi_dsim_ddi *dsim_ddi, *next;
> +	struct mipi_dsim_lcd_driver *lcd_drv;
> +	struct mipi_dsim_lcd_device *lcd_dev;
> +	int ret;
> +
> +	mutex_lock(&dsim->lock);
> +
> +	list_for_each_entry_safe(dsim_ddi, next, &dsim_ddi_list, list) {
> +		lcd_drv = dsim_ddi->dsim_lcd_drv;
> +		lcd_dev = dsim_ddi->dsim_lcd_dev;
> +		if (!lcd_drv || !lcd_dev ||
> +			(dsim->id != dsim_ddi->bus_id))
> +				continue;
> +
> +		dev_dbg(dsim->dev, "lcd_drv->id = %d, lcd_dev->id = %d\n",
> +				lcd_drv->id, lcd_dev->id);
> +		dev_dbg(dsim->dev, "lcd_dev->bus_id = %d, dsim->id = %d\n",
> +				lcd_dev->bus_id, dsim->id);
> +
> +		if ((strcmp(lcd_drv->name, name) = 0)) {
> +			lcd_dev->master = dsim;
> +
> +			lcd_dev->dev.parent = dsim->dev;
> +			dev_set_name(&lcd_dev->dev, "%s", lcd_drv->name);
> +
> +			ret = device_register(&lcd_dev->dev);
> +			if (ret < 0) {
> +				dev_err(dsim->dev,
> +					"can't register %s, status %d\n",
> +					dev_name(&lcd_dev->dev), ret);
> +				mutex_unlock(&dsim->lock);
> +
> +				return NULL;
> +			}
> +
> +			dsim->dsim_lcd_dev = lcd_dev;
> +			dsim->dsim_lcd_drv = lcd_drv;
> +
> +			mutex_unlock(&dsim->lock);
> +
> +			return dsim_ddi;
> +		}
> +	}
> +
> +	mutex_unlock(&dsim->lock);
> +
> +	return NULL;
> +}
>
> ...
>
> +static int s5p_mipi_dsi_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct mipi_dsim_device *dsim;
> +	struct mipi_dsim_config *dsim_config;
> +	struct mipi_dsim_platform_data *dsim_pd;
> +	struct mipi_dsim_ddi *dsim_ddi;
> +	int ret = -EINVAL;
> +
> +	dsim = kzalloc(sizeof(struct mipi_dsim_device), GFP_KERNEL);
> +	if (!dsim) {
> +		dev_err(&pdev->dev, "failed to allocate dsim object.\n");
> +		return -EFAULT;

ENOMEM!

> +	}
> +
> +	dsim->pd = to_dsim_plat(pdev);
> +	dsim->dev = &pdev->dev;
> +	dsim->id = pdev->id;
> +
> +	/* get mipi_dsim_platform_data. */
> +	dsim_pd = (struct mipi_dsim_platform_data *)dsim->pd;
> +	if (dsim_pd = NULL) {
> +		dev_err(&pdev->dev, "failed to get platform data for dsim.\n");
> +		goto err_clock_get;
> +	}
>
> ...
>
> +irqreturn_t s5p_mipi_dsi_interrupt_handler(int irq, void *dev_id)
> +{
> +	unsigned int intsrc = 0;
> +	unsigned int intmsk = 0;
> +	struct mipi_dsim_device *dsim = NULL;
> +
> +	dsim = (struct mipi_dsim_device *)dev_id;

unneeded and undesirable cast of void*

> +	if (!dsim) {
> +		dev_dbg(dsim->dev, KERN_ERR "%s:error: wrong parameter\n",
> +							__func__);
> +		return IRQ_HANDLED;
> +	}
> +
> +	intsrc = s5p_mipi_dsi_read_interrupt(dsim);
> +	intmsk = s5p_mipi_dsi_read_interrupt_mask(dsim);
> +
> +	intmsk = ~(intmsk) & intsrc;
> +
> +	switch (intmsk) {
> +	case INTMSK_RX_DONE:
> +		complete(&dsim_rd_comp);
> +		dev_dbg(dsim->dev, "MIPI INTMSK_RX_DONE\n");
> +		break;
> +	case INTMSK_FIFO_EMPTY:
> +		complete(&dsim_wr_comp);
> +		dev_dbg(dsim->dev, "MIPI INTMSK_FIFO_EMPTY\n");
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	s5p_mipi_dsi_clear_interrupt(dsim, intmsk);
> +
> +	return IRQ_HANDLED;
> +}
>
> ...
>

Generally: the use of the Efoo errno codes is chaotic.  Please check it
all over.

