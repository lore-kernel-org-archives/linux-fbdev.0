From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Wed, 25 Mar 2015 20:03:15 +0000
Subject: Re: [PATCHv5 04/11] fbdev: ssd1307fb: Unify init code and obtain hw specific bits from DT
Message-Id: <20150325210315.232d379f@maestro.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
	<1427232238-21099-1-git-send-email-niederp@physik.uni-kl.de>
	<1427232238-21099-5-git-send-email-niederp@physik.uni-kl.de>
	<20150324221428.GD23664@lukather>
In-Reply-To: <20150324221428.GD23664@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Am Tue, 24 Mar 2015 15:14:28 -0700
schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:

> On Tue, Mar 24, 2015 at 10:23:51PM +0100, Thomas Niederprüm wrote:
> > The 130X controllers are very similar from the configuration point
> > of view. The configuration registers for the SSD1305/6/7 are bit
> > identical (except the the VHCOM register and the the default values
> > for clock setup register). This patch unifies the init code of the
> > controller and adds hardware specific properties to DT that are
> > needed to correctly initialize the device.
> > 
> > The SSD130X can be wired to the OLED panel in various ways. Even
> > for the same controller this wiring can differ from one display
> > module to another and can not be probed by software. The added DT
> > properties reflect these hardware decisions of the display module
> > manufacturer. The 'com-sequential', 'com-lrremap' and 'com-invdir'
> > values define different possibilities for the COM signals pin
> > configuration and readout direction of the video memory. The
> > 'segment-no-remap' allows the inversion of the memory-to-pin
> > mapping ultimately inverting the order of the controllers output
> > pins. The 'prechargepX' values need to be adapted according to the
> > capacitance of the OLEDs pixel cells.
> > 
> > So far these hardware specific bits are hard coded in the init
> > code, making the driver usable only for one certain wiring of the
> > controller. This patch makes the driver usable with all possible
> > hardware setups, given a valid hw description in DT. If these
> > values are not set in DT the default values, as they are set in the
> > ssd1307 init code right now, are used. This implies that without
> > the corresponding DT property "segment-no-remap" the segment remap
> > of the ssd130X controller gets activated. Even though this is not
> > the default behaviour according to the datasheet it maintains
> > backward compatibility with older DTBs.
> > 
> > Note that the SSD1306 does not seem to be using the configuration
> > written to the registers at all. Therefore this patch does not try
> > to maintain these values without changes in DT. For reference an
> > example is added to the DT bindings documentation that reproduces
> > the configuration that is set in the current init code.
> > 
> > Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
> > ---
> >  .../devicetree/bindings/video/ssd1307fb.txt        |  21 +++
> >  drivers/video/fbdev/ssd1307fb.c                    | 192
> > ++++++++++++--------- 2 files changed, 134 insertions(+), 79
> > deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/video/ssd1307fb.txt
> > b/Documentation/devicetree/bindings/video/ssd1307fb.txt index
> > 7a12542..637690f 100644 ---
> > a/Documentation/devicetree/bindings/video/ssd1307fb.txt +++
> > b/Documentation/devicetree/bindings/video/ssd1307fb.txt @@ -15,6
> > +15,16 @@ Required properties: 
> >  Optional properties:
> >    - reset-active-low: Is the reset gpio is active on physical low?
> > +  - solomon,segment-no-remap: Display needs normal (non-inverted)
> > data column
> > +                              to segment mapping
> > +  - solomon,com-sequential: Display uses sequential COM pin
> > configuration
> > +  - solomon,com-lrremap: Display uses left-right COM pin remap
> > +  - solomon,com-invdir: Display uses inverted COM pin scan
> > direction
> > +  - solomon,com-offset: Number of the COM pin wired to the first
> > display line
> > +  - solomon,prechargep1: Length of deselect period (phase 1) in
> > clock cycles.
> > +  - solomon,prechargep2: Length of precharge period (phase 2) in
> > clock cycles.
> > +                         This needs to be the higher, the higher
> > the capacitance
> > +                         of the OLED's pixels is
> >  
> >  [0]: Documentation/devicetree/bindings/pwm/pwm.txt
> >  
> > @@ -26,3 +36,14 @@ ssd1307: oled@3c {
> >          reset-gpios = <&gpio2 7>;
> >          reset-active-low;
> >  };
> > +
> > +ssd1306: oled@3c {
> > +        compatible = "solomon,ssd1306fb-i2c";
> > +        reg = <0x3c>;
> > +        pwms = <&pwm 4 3000>;
> > +        reset-gpios = <&gpio2 7>;
> > +        reset-active-low;
> > +        solomon,com-lrremap;
> > +        solomon,com-invdir;
> > +        solomon,com-offset = <32>;
> > +};
> > diff --git a/drivers/video/fbdev/ssd1307fb.c
> > b/drivers/video/fbdev/ssd1307fb.c index 8d34c56..d16aad4 100644
> > --- a/drivers/video/fbdev/ssd1307fb.c
> > +++ b/drivers/video/fbdev/ssd1307fb.c
> > @@ -40,20 +40,34 @@
> >  
> >  struct ssd1307fb_par;
> >  
> > -struct ssd1307fb_ops {
> > -	int (*init)(struct ssd1307fb_par *);
> > -	int (*remove)(struct ssd1307fb_par *);
> > +struct ssd1307fb_deviceinfo {
> > +	u32 default_vcomh;
> > +	u32 default_dclk_div;
> > +	u32 default_dclk_frq;
> > +	int need_pwm;
> > +	int need_chargepump;
> >  };
> >  
> >  struct ssd1307fb_par {
> > +	u32 com_invdir;
> > +	u32 com_lrremap;
> > +	u32 com_offset;
> > +	u32 com_seq;
> > +	u32 contrast;
> > +	u32 dclk_div;
> > +	u32 dclk_frq;
> > +	struct ssd1307fb_deviceinfo *device_info;
> >  	struct i2c_client *client;
> >  	u32 height;
> >  	struct fb_info *info;
> > -	struct ssd1307fb_ops *ops;
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
> > @@ -254,69 +268,46 @@ static struct fb_deferred_io ssd1307fb_defio
> > = { .deferred_io	= ssd1307fb_deferred_io,
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
> > +	if (par->device_info->need_pwm) {
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
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	ret = ssd1307fb_write_cmd(par->client, 0x7f);
> > -	if (ret < 0)
> > -		return ret;
> > -
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
> > @@ -334,7 +325,7 @@ static int ssd1307fb_ssd1306_init(struct
> > ssd1307fb_par *par) if (ret < 0)
> >  		return ret;
> >  
> > -	ret = ssd1307fb_write_cmd(par->client, 0x20);
> > +	ret = ssd1307fb_write_cmd(par->client, par->com_offset);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > @@ -343,7 +334,8 @@ static int ssd1307fb_ssd1306_init(struct
> > ssd1307fb_par *par) if (ret < 0)
> >  		return ret;
> >  
> > -	ret = ssd1307fb_write_cmd(par->client, 0xf0);
> > +	dclk = (par->dclk_div & 0xf) | (par->dclk_frq & 0xf) << 4;
> > +	ret = ssd1307fb_write_cmd(par->client, dclk);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > @@ -352,7 +344,8 @@ static int ssd1307fb_ssd1306_init(struct
> > ssd1307fb_par *par) if (ret < 0)
> >  		return ret;
> >  
> > -	ret = ssd1307fb_write_cmd(par->client, 0x22);
> > +	precharge = (par->prechargep1 & 0xf) | (par->prechargep2 &
> > 0xf) << 4;
> > +	ret = ssd1307fb_write_cmd(par->client, precharge);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > @@ -361,7 +354,9 @@ static int ssd1307fb_ssd1306_init(struct
> > ssd1307fb_par *par) if (ret < 0)
> >  		return ret;
> >  
> > -	ret = ssd1307fb_write_cmd(par->client, 0x22);
> > +	compins = 0x02 | (!par->com_seq & 0x1) << 4
> > +				   | (par->com_lrremap & 0x1) << 5;
> > +	ret = ssd1307fb_write_cmd(par->client, compins);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > @@ -370,18 +365,20 @@ static int ssd1307fb_ssd1306_init(struct
> > ssd1307fb_par *par) if (ret < 0)
> >  		return ret;
> >  
> > -	ret = ssd1307fb_write_cmd(par->client, 0x49);
> > +	ret = ssd1307fb_write_cmd(par->client, par->vcomh);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	/* Turn on the DC-DC Charge Pump */
> > -	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_CHARGE_PUMP);
> > -	if (ret < 0)
> > -		return ret;
> > +	if (par->device_info->need_chargepump) {
> > +		/* Turn on the DC-DC Charge Pump */
> > +		ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_CHARGE_PUMP);
> > +		if (ret < 0)
> > +			return ret;
> >  
> > -	ret = ssd1307fb_write_cmd(par->client, 0x14);
> > -	if (ret < 0)
> > -		return ret;
> > +		ret = ssd1307fb_write_cmd(par->client, 0x14);
> > +		if (ret < 0)
> > +			return ret;
> > +	};
> >  
> >  	/* Switch to horizontal addressing mode */
> >  	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SET_ADDRESS_MODE); @@ -393,6 +390,7 @@ static int
> > ssd1307fb_ssd1306_init(struct ssd1307fb_par *par) if (ret < 0)
> >  		return ret;
> >  
> > +	/* Set column range */
> >  	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SET_COL_RANGE); if (ret < 0)
> >  		return ret;
> > @@ -405,6 +403,7 @@ static int ssd1307fb_ssd1306_init(struct
> > ssd1307fb_par *par) if (ret < 0)
> >  		return ret;
> >  
> > +	/* Set page range */
> >  	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SET_PAGE_RANGE); if (ret < 0)
> >  		return ret;
> > @@ -426,18 +425,30 @@ static int ssd1307fb_ssd1306_init(struct
> > ssd1307fb_par *par) return 0;
> >  }
> >  
> > -static struct ssd1307fb_ops ssd1307fb_ssd1306_ops = {
> > -	.init	= ssd1307fb_ssd1306_init,
> > +static struct ssd1307fb_deviceinfo ssd1307fb_ssd1306_deviceinfo = {
> > +	.default_vcomh = 0x20,
> > +	.default_dclk_div = 0,
> 
> A division by 0 ?

default_dclk_div stores the bit value for the divider register. The
bit encodes the divider as follows: bit = (divider - 1). But I guess
your are right that it makes more sense to store the actual divider
here and just calculate the bit value when writing to the device.

> 
> > +	.default_dclk_frq = 8,
> > +	.need_pwm = 0,
> 
> You don't need to declare this field, its value will already be
> initialized to 0.
I wasn't sure whether this is necessarily the case. But your hint and
a bit more reading on initialization of static structs convinced me. I
will remove the unnecessary fields.

Thomas
