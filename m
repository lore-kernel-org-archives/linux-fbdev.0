From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Sat, 07 Feb 2015 14:59:33 +0000
Subject: Re: [PATCH 2/8] fbdev: ssd1307fb: Unify init code and make controller configurable from device tree
Message-Id: <20150207155933.4f1d0998@maestro.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
	<1423261694-5939-3-git-send-email-niederp@physik.uni-kl.de>
	<20150207104225.GM2079@lukather>
In-Reply-To: <20150207104225.GM2079@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org

Am Sat, 7 Feb 2015 11:42:25 +0100
schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:

> Hi,
> 
> On Fri, Feb 06, 2015 at 11:28:08PM +0100, niederp@physik.uni-kl.de
> wrote:
> > From: Thomas Niederprüm <niederp@physik.uni-kl.de>
> > 
> > This patches unifies the init code for the ssd130X chips and
> > adds device tree bindings to describe the hardware configuration
> > of the used controller. This gets rid of the magic bit values
> > used in the init code so far.
> > 
> > Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
> > ---
> >  .../devicetree/bindings/video/ssd1307fb.txt        |  11 +
> >  drivers/video/fbdev/ssd1307fb.c                    | 243
> > ++++++++++++++------- 2 files changed, 174 insertions(+), 80
> > deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/video/ssd1307fb.txt
> > b/Documentation/devicetree/bindings/video/ssd1307fb.txt index
> > 7a12542..1230f68 100644 ---
> > a/Documentation/devicetree/bindings/video/ssd1307fb.txt +++
> > b/Documentation/devicetree/bindings/video/ssd1307fb.txt @@ -15,6
> > +15,17 @@ Required properties: 
> >  Optional properties:
> >    - reset-active-low: Is the reset gpio is active on physical low?
> > +  - solomon,segment-remap: Invert the order of data column to
> > segment mapping
> > +  - solomon,offset: Map the display start line to one of COM0 -
> > COM63
> > +  - solomon,contrast: Set initial contrast of the display
> > +  - solomon,prechargep1: Set the duration of the precharge period
> > phase1
> > +  - solomon,prechargep2: Set the duration of the precharge period
> > phase2
> > +  - solomon,com-alt: Enable/disable alternate COM pin configuration
> > +  - solomon,com-lrremap: Enable/disable left-right remap of COM
> > pins
> > +  - solomon,com-invdir: Invert COM scan direction
> > +  - solomon,vcomh: Set VCOMH regulator voltage
> > +  - solomon,dclk-div: Set display clock divider
> > +  - solomon,dclk-frq: Set display clock frequency
> 
> I'm sorry, but this is the wrong approach, for at least two reasons:
> you broke all existing users of that driver, which is a clear no-go,

Unfortunately this is true. The problem is that the SSD130X controllers
allow for a very versatile wiring of the display to the controller.
It's over to the manufacturer of the OLED module (disp+controller) to
decide how it's actually wired and during device initialization the
driver has to take care to configure the SSD130X controller according
to that wiring. If the driver fails to do so you will end up having
your display showing garbage. Unfortunately the current sate of the
initialization code of the ssd1307fb driver is not very flexible in that
respect. Taking a look at the initialization code for the ssd1306 shows
that it was written with one very special display module in mind. Most
of the magic bit values set there are non-default values according to
the datasheet. The result is that the driver works with that one
particular display module but many other (differently wired) display
modules using a ssd1306 controller won't work without changing the
hardcoded magic bit values.

My idea here was to set all configuration to the default values (as
given in the datasheet) unless it is overwritten by DT. Of course,
without a change in DT, this breaks the driver for all existing users.
The only alternative would be to set the current values as default.
Somehow this feels wrong to me as these values look arbitrary when you
don't know what exact display module they were set for. But if you
insist, I will change the default values.

> and the DT itself should not contain any direct mapping of the
> registers.
> 

I think I don't get what you mean here. Is it because I do no sanity
checks of the numbers set in DT? I was just looking for a way to hand
over the information about the wiring of display to the driver. How
would you propose to solve this?

> 
> >  
> >  [0]: Documentation/devicetree/bindings/pwm/pwm.txt
> >  
> > diff --git a/drivers/video/fbdev/ssd1307fb.c
> > b/drivers/video/fbdev/ssd1307fb.c index 3d6611f..4f435aa 100644
> > --- a/drivers/video/fbdev/ssd1307fb.c
> > +++ b/drivers/video/fbdev/ssd1307fb.c
> > @@ -16,6 +16,9 @@
> >  #include <linux/pwm.h>
> >  #include <linux/delay.h>
> >  
> > +#define DEVID_SSD1306 6
> > +#define DEVID_SSD1307 7
> > +
> >  #define SSD1307FB_DATA			0x40
> >  #define SSD1307FB_COMMAND		0x80
> >  
> > @@ -40,20 +43,33 @@
> >  
> >  struct ssd1307fb_par;
> >  
> > -struct ssd1307fb_ops {
> > -	int (*init)(struct ssd1307fb_par *);
> > -	int (*remove)(struct ssd1307fb_par *);
> > +struct ssd1307fb_deviceinfo {
> > +	int device_id;
> > +	u32 default_vcomh;
> > +	u32 default_dclk_div;
> > +	u32 default_dclk_frq;
> >  };
> >  
> >  struct ssd1307fb_par {
> > +	u32 com_alt;
> > +	u32 com_invdir;
> > +	u32 com_lrremap;
> > +	u32 contrast;
> > +	u32 dclk_div;
> > +	u32 dclk_frq;
> > +	struct ssd1307fb_deviceinfo *device_info;
> >  	struct i2c_client *client;
> >  	u32 height;
> >  	struct fb_info *info;
> > -	struct ssd1307fb_ops *ops;
> > +	u32 offset;
> >  	u32 page_offset;
> > +	u32 prechargep1;
> > +	u32 prechargep2;
> >  	struct pwm_device *pwm;
> >  	u32 pwm_period;
> >  	int reset;
> > +	u32 seg_remap;
> > +	u32 vcomh;
> >  	u32 width;
> >  };
> >  
> > @@ -254,127 +270,151 @@ static struct fb_deferred_io
> > ssd1307fb_defio = { .deferred_io	= ssd1307fb_deferred_io,
> >  };
> >  
> > -static int ssd1307fb_ssd1307_init(struct ssd1307fb_par *par)
> > +static int ssd1307fb_init(struct ssd1307fb_par *par)
> >  {
> >  	int ret;
> > +	u32 precharge, dclk, com_invdir, compins;
> >  
> > -	par->pwm = pwm_get(&par->client->dev, NULL);
> > -	if (IS_ERR(par->pwm)) {
> > -		dev_err(&par->client->dev, "Could not get PWM from
> > device tree!\n");
> > -		return PTR_ERR(par->pwm);
> > -	}
> > -
> > -	par->pwm_period = pwm_get_period(par->pwm);
> > -	/* Enable the PWM */
> > -	pwm_config(par->pwm, par->pwm_period / 2, par->pwm_period);
> > -	pwm_enable(par->pwm);
> > -
> > -	dev_dbg(&par->client->dev, "Using PWM%d with a %dns
> > period.\n",
> > -		par->pwm->pwm, par->pwm_period);
> > -
> > -	/* Map column 127 of the OLED to segment 0 */
> > -	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SEG_REMAP_ON);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	/* Turn on the display */
> > -	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_DISPLAY_ON);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	return 0;
> > -}
> > -
> > -static int ssd1307fb_ssd1307_remove(struct ssd1307fb_par *par)
> > -{
> > -	pwm_disable(par->pwm);
> > -	pwm_put(par->pwm);
> > -	return 0;
> > -}
> > +	if (par->device_info->device_id = DEVID_SSD1307) {
> > +		par->pwm = pwm_get(&par->client->dev, NULL);
> > +		if (IS_ERR(par->pwm)) {
> > +			dev_err(&par->client->dev, "Could not get
> > PWM from device tree!\n");
> > +			return PTR_ERR(par->pwm);
> > +		}
> >  
> > -static struct ssd1307fb_ops ssd1307fb_ssd1307_ops = {
> > -	.init	= ssd1307fb_ssd1307_init,
> > -	.remove	= ssd1307fb_ssd1307_remove,
> > -};
> > +		par->pwm_period = pwm_get_period(par->pwm);
> > +		/* Enable the PWM */
> > +		pwm_config(par->pwm, par->pwm_period / 2,
> > par->pwm_period);
> > +		pwm_enable(par->pwm);
> >  
> > -static int ssd1307fb_ssd1306_init(struct ssd1307fb_par *par)
> > -{
> > -	int ret;
> > +		dev_dbg(&par->client->dev, "Using PWM%d with a
> > %dns period.\n",
> > +			par->pwm->pwm, par->pwm_period);
> > +	};
> >  
> >  	/* Set initial contrast */
> >  	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_CONTRAST);
> > -	ret = ret & ssd1307fb_write_cmd(par->client, 0x7f);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	/* Set COM direction */
> > -	ret = ssd1307fb_write_cmd(par->client, 0xc8);
> > +	ret = ssd1307fb_write_cmd(par->client, par->contrast);
> >  	if (ret < 0)
> >  		return ret;
> >  
> >  	/* Set segment re-map */
> > -	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SEG_REMAP_ON);
> > +	if (par->seg_remap) {
> > +		ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SEG_REMAP_ON);
> > +		if (ret < 0)
> > +			return ret;
> > +	};
> > +
> > +	/* Set COM direction */
> > +	com_invdir = 0xc0 | (par->com_invdir & 0xf) << 3;
> > +	ret = ssd1307fb_write_cmd(par->client,  com_invdir);
> >  	if (ret < 0)
> >  		return ret;
> >  
> >  	/* Set multiplex ratio value */
> >  	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SET_MULTIPLEX_RATIO);
> > -	ret = ret & ssd1307fb_write_cmd(par->client, par->height -
> > 1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = ssd1307fb_write_cmd(par->client, par->height - 1);
> >  	if (ret < 0)
> >  		return ret;
> >  
> >  	/* set display offset value */
> >  	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SET_DISPLAY_OFFSET);
> > -	ret = ssd1307fb_write_cmd(par->client, 0x20);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = ssd1307fb_write_cmd(par->client, par->offset);
> >  	if (ret < 0)
> >  		return ret;
> >  
> >  	/* Set clock frequency */
> > +	dclk = (par->dclk_div & 0xf) | (par->dclk_frq & 0xf) << 4;
> >  	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SET_CLOCK_FREQ);
> > -	ret = ret & ssd1307fb_write_cmd(par->client, 0xf0);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	/* Set precharge period in number of ticks from the
> > internal clock */
> > +	ret = ssd1307fb_write_cmd(par->client, dclk);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Set precharge period in number of ticks from the
> > internal clock*/
> > +	precharge = (par->prechargep1 & 0xf) | (par->prechargep2 &
> > 0xf) << 4; ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SET_PRECHARGE_PERIOD);
> > -	ret = ret & ssd1307fb_write_cmd(par->client, 0x22);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = ssd1307fb_write_cmd(par->client, precharge);
> >  	if (ret < 0)
> >  		return ret;
> >  
> >  	/* Set COM pins configuration */
> > +	compins = 0x02 | (par->com_alt & 0x1) << 4
> > +				   | (par->com_lrremap & 0x1) << 5;
> >  	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SET_COM_PINS_CONFIG);
> > -	ret = ret & ssd1307fb_write_cmd(par->client, 0x22);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = ssd1307fb_write_cmd(par->client, compins);
> >  	if (ret < 0)
> >  		return ret;
> >  
> >  	/* Set VCOMH */
> >  	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SET_VCOMH);
> > -	ret = ret & ssd1307fb_write_cmd(par->client, 0x49);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	/* Turn on the DC-DC Charge Pump */
> > -	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_CHARGE_PUMP);
> > -	ret = ret & ssd1307fb_write_cmd(par->client, 0x14);
> > +	ret = ssd1307fb_write_cmd(par->client, par->vcomh);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	if (par->device_info->device_id = DEVID_SSD1306) {
> > +		/* Turn on the DC-DC Charge Pump */
> > +		ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_CHARGE_PUMP);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret = ssd1307fb_write_cmd(par->client, 0x14);
> > +		if (ret < 0)
> > +			return ret;
> > +	};
> > +
> >  	/* Switch to horizontal addressing mode */
> >  	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SET_ADDRESS_MODE);
> > -	ret = ret & ssd1307fb_write_cmd(par->client,
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = ssd1307fb_write_cmd(par->client,
> >  					SSD1307FB_SET_ADDRESS_MODE_HORIZONTAL);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +    /* Set column range */
> >  	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SET_COL_RANGE);
> > -	ret = ret & ssd1307fb_write_cmd(par->client, 0x0);
> > -	ret = ret & ssd1307fb_write_cmd(par->client, par->width -
> > 1); if (ret < 0)
> >  		return ret;
> >  
> > +	ret = ssd1307fb_write_cmd(par->client, 0x0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = ssd1307fb_write_cmd(par->client, par->width - 1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +    /* Set page range */
> >  	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SET_PAGE_RANGE);
> > -	ret = ret & ssd1307fb_write_cmd(par->client, 0x0);
> > -	ret = ret & ssd1307fb_write_cmd(par->client,
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = ssd1307fb_write_cmd(par->client, 0x0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = ssd1307fb_write_cmd(par->client,
> >  					par->page_offset +
> > (par->height / 8) - 1); if (ret < 0)
> >  		return ret;
> > @@ -387,18 +427,28 @@ static int ssd1307fb_ssd1306_init(struct
> > ssd1307fb_par *par) return 0;
> >  }
> >  
> > -static struct ssd1307fb_ops ssd1307fb_ssd1306_ops = {
> > -	.init	= ssd1307fb_ssd1306_init,
> > +static struct ssd1307fb_deviceinfo ssd1307fb_ssd1306_deviceinfo = {
> > +	.device_id  = DEVID_SSD1306,
> > +	.default_vcomh = 0x20,
> > +	.default_dclk_div = 0,
> > +	.default_dclk_frq = 8,
> > +};
> > +
> > +static struct ssd1307fb_deviceinfo ssd1307fb_ssd1307_deviceinfo = {
> > +	.device_id  = DEVID_SSD1307,
> > +	.default_vcomh = 0x20,
> > +	.default_dclk_div = 1,
> > +	.default_dclk_frq = 12,
> >  };
> >  
> >  static const struct of_device_id ssd1307fb_of_match[] = {
> >  	{
> >  		.compatible = "solomon,ssd1306fb-i2c",
> > -		.data = (void *)&ssd1307fb_ssd1306_ops,
> > +		.data = (void *)&ssd1307fb_ssd1306_deviceinfo,
> >  	},
> >  	{
> >  		.compatible = "solomon,ssd1307fb-i2c",
> > -		.data = (void *)&ssd1307fb_ssd1307_ops,
> > +		.data = (void *)&ssd1307fb_ssd1307_deviceinfo,
> >  	},
> >  	{},
> >  };
> > @@ -429,8 +479,8 @@ static int ssd1307fb_probe(struct i2c_client
> > *client, par->info = info;
> >  	par->client = client;
> >  
> > -	par->ops = (struct ssd1307fb_ops
> > *)of_match_device(ssd1307fb_of_match,
> > -
> > &client->dev)->data;
> > +	par->device_info = (struct ssd1307fb_deviceinfo
> > *)of_match_device(
> > +			ssd1307fb_of_match, &client->dev)->data;
> >  
> >  	par->reset = of_get_named_gpio(client->dev.of_node,
> >  					 "reset-gpios", 0);
> > @@ -449,8 +499,40 @@ static int ssd1307fb_probe(struct i2c_client
> > *client, par->page_offset = 1;
> >  
> >  	vmem_size = par->width * par->height / 8;
> > +	if (of_property_read_u32(node, "solomon,segment-remap",
> > &par->seg_remap))
> > +		par->seg_remap = 0;
> > +
> > +	if (of_property_read_u32(node, "solomon,offset",
> > &par->offset))
> > +		par->offset = 0;
> > +
> > +	if (of_property_read_u32(node, "solomon,contrast",
> > &par->contrast))
> > +		par->contrast = 128;
> > +
> > +	if (of_property_read_u32(node, "solomon,prechargep1",
> > &par->prechargep1))
> > +		par->prechargep1 = 2;
> > +
> > +	if (of_property_read_u32(node, "solomon,prechargep2",
> > &par->prechargep2))
> > +		par->prechargep2 = 2;
> > +
> > +	if (of_property_read_u32(node, "solomon,com-alt",
> > &par->com_alt))
> > +		par->com_alt = 1;
> > +
> > +	if (of_property_read_u32(node, "solomon,com-lrremap",
> > &par->com_lrremap))
> > +		par->com_lrremap = 0;
> > +
> > +	if (of_property_read_u32(node, "solomon,com-invdir",
> > &par->com_invdir))
> > +		par->com_invdir = 0;
> > +
> > +	if (of_property_read_u32(node, "solomon,vcomh",
> > &par->vcomh))
> > +		par->vcomh = par->device_info->default_vcomh;
> >  
> >  	vmem = devm_kzalloc(&client->dev, vmem_size, GFP_KERNEL);
> > +	if (of_property_read_u32(node, "solomon,dclk-div",
> > &par->dclk_div))
> > +		par->dclk_div = par->device_info->default_dclk_div;
> > +
> > +	if (of_property_read_u32(node, "solomon,dclk-frq",
> > &par->dclk_frq))
> > +		par->dclk_frq  > > par->device_info->default_dclk_frq; +
> >  	if (!vmem) {
> >  		dev_err(&client->dev, "Couldn't allocate graphical
> > memory.\n"); ret = -ENOMEM;
> > @@ -499,11 +581,9 @@ static int ssd1307fb_probe(struct i2c_client
> > *client, gpio_set_value(par->reset, 1);
> >  	udelay(4);
> >  
> > -	if (par->ops->init) {
> > -		ret = par->ops->init(par);
> > -		if (ret)
> > -			goto reset_oled_error;
> > -	}
> > +	ret = ssd1307fb_init(par);
> > +	if (ret)
> > +		goto reset_oled_error;
> >  
> >  	ret = register_framebuffer(info);
> >  	if (ret) {
> > @@ -516,8 +596,10 @@ static int ssd1307fb_probe(struct i2c_client
> > *client, return 0;
> >  
> >  panel_init_error:
> > -	if (par->ops->remove)
> > -		par->ops->remove(par);
> > +	if (par->device_info->device_id = DEVID_SSD1307) {
> > +		pwm_disable(par->pwm);
> > +		pwm_put(par->pwm);
> > +	};
> >  reset_oled_error:
> >  	fb_deferred_io_cleanup(info);
> >  fb_alloc_error:
> > @@ -531,11 +613,12 @@ static int ssd1307fb_remove(struct i2c_client
> > *client) struct ssd1307fb_par *par = info->par;
> >  
> >  	unregister_framebuffer(info);
> > -	if (par->ops->remove)
> > -		par->ops->remove(par);
> > +	if (par->device_info->device_id = DEVID_SSD1307) {
> > +		pwm_disable(par->pwm);
> > +		pwm_put(par->pwm);
> > +	};
> >  	fb_deferred_io_cleanup(info);
> >  	framebuffer_release(info);
> > -
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.1.1
> > 
> 

