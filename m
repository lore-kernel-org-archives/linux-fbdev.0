From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 08 Dec 2014 12:03:09 +0000
Subject: Re: [PATCH 3/4] backlight/lp855x: Merge lp855x_platform_data with lp855x
Message-Id: <000d01d012de$eebb5b00$cc321100$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417805069-20441-3-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1417805069-20441-3-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Monday, December 08, 2014 9:01 PM, Jingoo Han wrote:
> 
> On Saturday, December 06, 2014 3:44 AM, Sean Paul wrote:
> >
> > Now that we have removed the platform_data header, merge lp855x_platform_data
> > with lp855x and remove all traces of platform_data from the driver.
> >
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > ---
> >  drivers/video/backlight/lp855x_bl.c | 100 +++++++++++++++++-------------------
> >  1 file changed, 46 insertions(+), 54 deletions(-)
> >
> > diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
> > index d19b61c..8b81d8e 100644
> > --- a/drivers/video/backlight/lp855x_bl.c
> > +++ b/drivers/video/backlight/lp855x_bl.c
> > @@ -78,8 +78,16 @@ struct lp855x_rom_data {
> >  };
> >
> >  /**
> > - * struct lp855x_platform_data
> > - * @name : Backlight driver name. If it is not defined, default name is set.
> > + * struct lp855x
> > + * @chipname : Chip name, comes from the i2c_device_id
> > + * @blname : Backlight driver name. If it is not defined, default name is set.
> > + * @chip_id : The type of lp855x
> > + * @mode : Whether brightness is controlled via pwm or register
> > + * @cfg : Chip specific hooks & register offsets
> > + * @client : The i2c client
> > + * @bl : The backlight device
> > + * @dev : Device pointer
> > + * @pwm : The pwm device (if available)
> >   * @device_control : value of DEVICE CONTROL register
> >   * @initial_brightness : initial value of backlight brightness
> >   * @period_ns : platform specific pwm period value. unit is nano.
> > @@ -88,26 +96,23 @@ struct lp855x_rom_data {
> >   * @rom_data : list of new eeprom/eprom registers
> >   * @supply : regulator that supplies 3V input
> >   */
> > -struct lp855x_platform_data {
> > -	const char *name;
> > -	u8 device_control;
> > -	u8 initial_brightness;
> > -	unsigned int period_ns;
> > -	int size_program;
> > -	struct lp855x_rom_data *rom_data;
> > -	struct regulator *supply;
> > -};
> > -
> >  struct lp855x {
> >  	const char *chipname;
> > +	const char *blname;
> >  	enum lp855x_chip_id chip_id;
> >  	enum lp855x_brightness_ctrl_mode mode;
> >  	struct lp855x_device_config *cfg;
> >  	struct i2c_client *client;
> >  	struct backlight_device *bl;
> >  	struct device *dev;
> > -	struct lp855x_platform_data *pdata;
> >  	struct pwm_device *pwm;
> > +
> > +	u8 device_control;
> > +	u8 initial_brightness;
> > +	unsigned int period_ns;
> > +	int size_program;
> > +	struct lp855x_rom_data *rom_data;
> > +	struct regulator *supply;
> >  };
> 
> Now, 'struct lp855x_platform_data' is removed.
> But, there is still remaining in 'Documentation/backlight/lp855x-driver.txt'.
> Would you clean this lp855x-driver.txt file?
> 
> >
> >  static int lp855x_write_byte(struct lp855x *lp, u8 reg, u8 data)
> > @@ -204,7 +209,6 @@ static int lp855x_configure(struct lp855x *lp)
> >  {
> >  	u8 val, addr;
> >  	int i, ret;
> > -	struct lp855x_platform_data *pd = lp->pdata;
> >
> >  	switch (lp->chip_id) {
> >  	case LP8550:
> > @@ -230,20 +234,20 @@ static int lp855x_configure(struct lp855x *lp)
> >  		}
> >  	}
> >
> > -	val = pd->initial_brightness;
> > +	val = lp->initial_brightness;
> >  	ret = lp855x_write_byte(lp, lp->cfg->reg_brightness, val);
> >  	if (ret)
> >  		goto err;
> >
> > -	val = pd->device_control;
> > +	val = lp->device_control;
> >  	ret = lp855x_write_byte(lp, lp->cfg->reg_devicectrl, val);
> >  	if (ret)
> >  		goto err;
> >
> > -	if (pd->size_program > 0) {
> > -		for (i = 0; i < pd->size_program; i++) {
> > -			addr = pd->rom_data[i].addr;
> > -			val = pd->rom_data[i].val;
> > +	if (lp->size_program > 0) {
> > +		for (i = 0; i < lp->size_program; i++) {
> > +			addr = lp->rom_data[i].addr;
> > +			val = lp->rom_data[i].val;
> >  			if (!lp855x_is_valid_rom_area(lp, addr))
> >  				continue;
> >
> > @@ -269,7 +273,7 @@ err:
> >
> >  static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
> >  {
> > -	unsigned int period = lp->pdata->period_ns;
> > +	unsigned int period = lp->period_ns;
> >  	unsigned int duty = br * period / max_br;
> >  	struct pwm_device *pwm;
> >
> > @@ -320,16 +324,15 @@ static int lp855x_backlight_register(struct lp855x *lp)
> >  {
> >  	struct backlight_device *bl;
> >  	struct backlight_properties props;
> > -	struct lp855x_platform_data *pdata = lp->pdata;
> > -	const char *name = pdata->name ? : DEFAULT_BL_NAME;
> > +	const char *name = lp->blname ? : DEFAULT_BL_NAME;
> >
> >  	props.type = BACKLIGHT_PLATFORM;
> >  	props.max_brightness = MAX_BRIGHTNESS;
> >
> > -	if (pdata->initial_brightness > props.max_brightness)
> > -		pdata->initial_brightness = props.max_brightness;
> > +	if (lp->initial_brightness > props.max_brightness)
> > +		lp->initial_brightness = props.max_brightness;
> >
> > -	props.brightness = pdata->initial_brightness;
> > +	props.brightness = lp->initial_brightness;
> >
> >  	bl = devm_backlight_device_register(lp->dev, name, lp->dev, lp,
> >  				       &lp855x_bl_ops, &props);
> > @@ -381,7 +384,6 @@ static int lp855x_parse_dt(struct lp855x *lp)
> >  {
> >  	struct device *dev = lp->dev;
> >  	struct device_node *node = dev->of_node;
> > -	struct lp855x_platform_data *pdata;
> >  	int rom_length;
> >
> >  	if (!node) {
> > @@ -389,14 +391,10 @@ static int lp855x_parse_dt(struct lp855x *lp)
> >  		return -EINVAL;
> >  	}
> >
> > -	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > -	if (!pdata)
> > -		return -ENOMEM;
> > -
> > -	of_property_read_string(node, "bl-name", &pdata->name);
> > -	of_property_read_u8(node, "dev-ctrl", &pdata->device_control);
> > -	of_property_read_u8(node, "init-brt", &pdata->initial_brightness);
> > -	of_property_read_u32(node, "pwm-period", &pdata->period_ns);
> > +	of_property_read_string(node, "bl-name", &lp->blname);
> > +	of_property_read_u8(node, "dev-ctrl", &lp->device_control);
> > +	of_property_read_u8(node, "init-brt", &lp->initial_brightness);
> > +	of_property_read_u32(node, "pwm-period", &lp->period_ns);
> >
> >  	/* Fill ROM platform data if defined */
> >  	rom_length = of_get_child_count(node);
> > @@ -415,19 +413,16 @@ static int lp855x_parse_dt(struct lp855x *lp)
> >  			i++;
> >  		}
> >
> > -		pdata->size_program = rom_length;
> > -		pdata->rom_data = &rom[0];
> > +		lp->size_program = rom_length;
> > +		lp->rom_data = &rom[0];
> >  	}
> >
> > -	pdata->supply = devm_regulator_get(dev, "power");
> > -	if (IS_ERR(pdata->supply)) {
> > -		if (PTR_ERR(pdata->supply) = -EPROBE_DEFER)
> > +	lp->supply = devm_regulator_get(dev, "power");
> > +	if (IS_ERR(lp->supply)) {
> > +		if (PTR_ERR(lp->supply) = -EPROBE_DEFER)
> >  			return -EPROBE_DEFER;
> > -		pdata->supply = NULL;
> 
> Is 'lp->supply' not optional?
> If 'lp->supply' is optional, please add the following.
> 
> +		lp->supply = NULL;
> 
> >  	}
> >
> > -	lp->pdata = pdata;
> > -
> >  	return 0;
> >  }
> >  #else
> > @@ -453,21 +448,18 @@ static int lp855x_probe(struct i2c_client *cl, const struct i2c_device_id *id)
> >  	lp->dev = &cl->dev;
> >  	lp->chipname = id->name;
> >  	lp->chip_id = id->driver_data;
> > -	lp->pdata = dev_get_platdata(&cl->dev);
> >
> > -	if (!lp->pdata) {
> > -		ret = lp855x_parse_dt(lp);
> > -		if (ret < 0)
> > -			return ret;
> > -	}
> > +	ret = lp855x_parse_dt(lp);
> > +	if (ret < 0)
> > +		return ret;
> >
> > -	if (lp->pdata->period_ns > 0)
> > +	if (lp->period_ns > 0)
> >  		lp->mode = PWM_BASED;
> >  	else
> >  		lp->mode = REGISTER_BASED;
> >
> > -	if (lp->pdata->supply) {
> > -		ret = regulator_enable(lp->pdata->supply);
> > +	if (lp->supply) {
> > +		ret = regulator_enable(lp->supply);
> >  		if (ret < 0) {
> >  			dev_err(&cl->dev, "failed to enable supply: %d\n", ret);
> >  			return ret;
> > @@ -505,8 +497,8 @@ static int lp855x_remove(struct i2c_client *cl)
> >
> >  	lp->bl->props.brightness = 0;
> >  	backlight_update_status(lp->bl);
> > -	if (lp->pdata->supply)
> > -		regulator_disable(lp->pdata->supply);
> > +	if (lp->supply)
> > +		regulator_disable(lp->supply);
> 
> If 'lp->supply' is optional, this "if (lp->supply)" might
> be unnecessary.

Sorry for my typo.
Please refer to the following.

If 'lp->supply' is _NOT_ optional, this "if (lp->supply)" might
be unnecessary.


> 
> Best regards,
> Jingoo Han
> 
> >  	sysfs_remove_group(&lp->dev->kobj, &lp855x_attr_group);
> >
> >  	return 0;
> > --
> > 2.2.0.rc0.207.ga3a616c

