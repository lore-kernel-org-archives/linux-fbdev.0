From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 3/5] FB: Add support for the ILI9320
 video display controller.
Date: Tue, 24 Jun 2008 00:07:25 -0700
Message-ID: <20080624000725.3622c57f.akpm@linux-foundation.org>
References: <20080622210439.018928412@fluff.org.uk>
	<20080622210614.627586051@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KB2e0-0007oj-CC for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Jun 2008 00:08:48 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KB2dz-0005mR-40
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Jun 2008 00:08:48 -0700
In-Reply-To: <20080622210614.627586051@fluff.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, 22 Jun 2008 22:04:42 +0100 Ben Dooks <ben-linux@fluff.org> wrote:

> Provide support for the ILI9320 display controller chip
> which is found in many LCD displays. Included with this
> is support for an example LCD using this chip, the
> VGG2432A4.
> 

Please pass this patch (and indeed all patches) through
scripts/checkpatch.pl.  It finds things which you wouldn't have sent
had you known they were there.

>
> ...
>
> +int __devinit ili9320_probe_spi(struct spi_device *spi,
> +				struct ili9320_client *client)
> +{
> +	struct ili9320_platdata *cfg = spi->dev.platform_data;
> +	struct device *dev = &spi->dev;
> +	struct ili9320 *ili;
> +	struct lcd_device *lcd;
> +	int ret = 0;
> +
> +	/* verify we where given some information */
> +
> +	if (cfg == NULL) {
> +		dev_err(dev, "no platform data supplied\n");
> +		return -EINVAL;
> +	}
> +
> +	if (cfg->hsize <= 0 || cfg->vsize <= 0 || cfg->reset == NULL) {
> +		dev_err(dev, "invalid platform data supplied\n");
> +		return -EINVAL;
> +	}
> +
> +	/* allocate and initialse our state */
> +
> +	ili = kzalloc(sizeof(struct ili9320), GFP_KERNEL);
> +	if (ili == NULL) {
> +		dev_err(dev, "no memory for device\n");
> +		return -ENOMEM;
> +	}
> +
> +	ili->access.spi.id = ILI9320_SPI_IDCODE | ILI9320_SPI_ID(1);
> +
> +	ili->dev = dev;
> +	ili->client = client;
> +	ili->power = FB_BLANK_POWERDOWN;
> +	ili->platdata = cfg;
> +
> +	dev_set_drvdata(&spi->dev, ili);
> +
> +	ili9320_setup_spi(ili, spi);
> +
> +	lcd = lcd_device_register("ili9320", dev, ili, &ili9320_ops);
> +	if (IS_ERR(lcd)) {
> +		dev_err(dev, "failed to register lcd device\n");
> +		ret = PTR_ERR(lcd);
> +		goto err_free;
> +	}
> +
> +	ili->lcd = lcd;
> +
> +	dev_info(dev, "initialising %s\n", client->name);
> +
> +	ret = ili9320_power(ili, FB_BLANK_UNBLANK);
> +	if (ret != 0) {
> +		dev_err(dev, "failed to set lcd power state\n");
> +		goto err_unregister;
> +	}
> +
> +	return 0;
> +
> + err_unregister:
> +	lcd_device_unregister(lcd);
> +
> + err_free:
> +	kfree(lcd);
> +	return ret;
> +}

urgh.  lcd_device_register() returns kmalloced memory which the caller
must kfree() after having run lcd_device_unregister()?  Who thought
that scheme up?  :(

Does this function leaks *ili on errors?

> +EXPORT_SYMBOL_GPL(ili9320_probe_spi);
> +
> +int __devexit ili9320_remove(struct ili9320 *lcd)
> +{
> +	ili9320_power(lcd, FB_BLANK_POWERDOWN);
> +
> +	lcd_device_unregister(lcd->lcd);
> +	kfree(lcd);
> +
> +	return 0;
> +}
> +
> +EXPORT_SYMBOL_GPL(ili9320_remove);

Did ili get freed in here?

>
> ...
>
> +/* Holder for register and value pairs. */
> +struct ili9320_reg {
> +	unsigned short		address;
> +	unsigned short		value;
> +};
> +
> +struct ili9320;
> +
> +struct ili9320_client {
> +	const char	*name;
> +	int	(*init)(struct ili9320 *ili, struct ili9320_platdata *cfg);
> +
> +};
> +/* Device attached via an SPI bus. */
> +struct  ili9320_spi {

s/  / /

> +	struct spi_device	*dev;
> +	struct spi_message	message;
> +	struct spi_transfer	xfer[2];
> +
> +	unsigned char		id;
> +	unsigned char		buffer_addr[4];
> +	unsigned char		buffer_data[4];
> +};
> +
>
> ...
>
> +static int vgg2432a4_lcd_init(struct ili9320 *lcd,
> +			      struct ili9320_platdata *cfg)
> +{
> +	unsigned int addr;
> +	int ret;
> +
> +	/* Set VCore before anything else (VGG243237-6UFLWA) */
> +	ret = ili9320_write(lcd, 0x00e5, 0x8000);
> +	if (ret)
> +		goto err_initial;
> +
> +	/* Start the oscillator up before we can do anything else. */
> +	ret = ili9320_write(lcd, ILI9320_OSCILATION, ILI9320_OSCILATION_OSC);
> +	if (ret)
> +		goto err_initial;
> +
> +	/* must wait at-lesat 10ms after starting */
> +	mdelay(15);

msleep()?  And everywhere else.  This function alone consumes maybe
half a second CPU time.

>
> ...
>

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
