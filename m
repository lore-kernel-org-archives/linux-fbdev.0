From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Tue, 05 Dec 2017 02:01:07 +0000
Subject: Re: [PATCH V1 1/4] qcom: spmi-wled: Add support for qcom wled driver
Message-Id: <20171205020107.GD28761@minitux>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1510834717-21765-1-git-send-email-kgunda@codeaurora.org>
 <1510834717-21765-2-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1510834717-21765-2-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org

On Thu 16 Nov 04:18 PST 2017, Kiran Gunda wrote:

> WLED driver provides the interface to the display driver to
> adjust the brightness of the display backlight.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  .../bindings/leds/backlight/qcom-spmi-wled.txt     |  90 ++++
>  drivers/video/backlight/Kconfig                    |   9 +
>  drivers/video/backlight/Makefile                   |   1 +
>  drivers/video/backlight/qcom-spmi-wled.c           | 504 +++++++++++++++++++++
>  4 files changed, 604 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
>  create mode 100644 drivers/video/backlight/qcom-spmi-wled.c
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
> new file mode 100644
> index 0000000..f1ea25b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
> @@ -0,0 +1,90 @@
> +Binding for Qualcomm WLED driver
> +

This binding document quite well describe the pm8941 as well, so please
improve the existing binding (changing to this style is preferable).

> +WLED (White Light Emitting Diode) driver is used for controlling display
> +backlight that is part of PMIC on Qualcomm Technologies reference platforms.
> +The PMIC is connected to the host processor via SPMI bus.
> +
> +- compatible
> +	Usage:      required
> +	Value type: <string>
> +	Definition: should be "qcom,pm8998-spmi-wled".

There's no WLED in the pm8998, so please make this pmi8998. This pmic is
SPMI only, so there's no need to keep "spmi" in the compatible.

> +
> +- reg
> +	Usage:      required
> +	Value type: <prop-encoded-array>
> +	Definition:  Base address and size of the WLED modules.
> +
> +- reg-names
> +	Usage:      required
> +	Value type: <string>
> +	Definition:  Names associated with base addresses. should be
> +		     "qcom-wled-ctrl-base", "qcom-wled-sink-base".
> +
> +- label
> +	Usage:      required
> +	Value type: <string>
> +	Definition: The name of the backlight device.
> +
> +- default-brightness
> +	Usage:      optional
> +	Value type: <u32>
> +	Definition: brightness value on boot, value from: 0-4095
> +		    default: 2048
> +
> +- qcom,fs-current-limit
> +	Usage:      optional
> +	Value type: <u32>
> +	Definition: per-string full scale current limit in uA. value from
> +		    0 to 30000 with 5000 uA resolution. default: 25000 uA

"in steps of 5mA"

> +
> +- qcom,current-boost-limit
> +	Usage:      optional
> +	Value type: <u32>
> +	Definition: ILIM threshold in mA. values are 105, 280, 450, 620, 970,
> +		    1150, 1300, 1500. default: 970 mA
> +
> +- qcom,switching-freq
> +	Usage:      optional
> +	Value type: <u32>
> +	Definition: Switching frequency in KHz. values are
> +		    600, 640, 685, 738, 800, 872, 960, 1066, 1200, 1371,
> +		    1600, 1920, 2400, 3200, 4800, 9600.
> +		    default: 800 KHz
> +
> +- qcom,ovp
> +	Usage:      optional
> +	Value type: <u32>
> +	Definition: Over-voltage protection limit in mV. values are 31100,
> +		    29600, 19600, 18100.
> +	            default: 29600 mV
> +
> +- qcom,string-cfg
> +	Usage:      optional
> +	Value type: <u32>
> +	Definition: Bit mask of the wled strings. Bit 0 to 3 indicates strings
> +		    0 to 3 respectively. Wled module has four strings of leds
> +		    numbered from 0 to 3. Each string of leds are operated
> +		    individually. Specify the strings using the bit mask. Any
> +		    combination of led strings can be used.
> +		    default value is 15 (b1111).

Please try to avoid expressing things as bitmasks in DT.

The only difference from 8941 here is that there's one additional
string, so please start off by expressing this as the existing binding.

If you really need this flexibility you can follow up with an addition
of a property like this, but name it something like
"qcom,enabled-strings" and make this support available for pm8941 as
well.

> +
> +- qcom,en-cabc

No need for the "en", the presence of a bool property means that it's
enabled.

> +	Usage:      optional
> +	Value type: <bool>
> +	Definition: Specify if cabc (content adaptive backlight control) is
> +		    needed.

I presume cabc isn't ever "needed", just make the description "Enable
content adaptive backlight control".

> +
> +Example:
> +
> +qcom-wled@d800 {
> +	compatible = "qcom,pm8998-spmi-wled";
> +	reg = <0xd800 0xd900>;
> +	reg-names = "qcom-wled-ctrl-base", "qcom-wled-sink-base";
> +	label = "backlight";
> +
> +	qcom,fs-current-limit = <25000>;
> +	qcom,current-boost-limit = <970>;
> +	qcom,switching-freq = <800>;
> +	qcom,ovp = <29600>;
> +	qcom,string-cfg = <15>;
> +};
[..]
> diff --git a/drivers/video/backlight/qcom-spmi-wled.c b/drivers/video/backlight/qcom-spmi-wled.c

After reviewing your arguments and comparing the drivers I still think
it's beneficial to support both these hardware revisions in the same
driver.

The majority of the register differences relates to the current sink
being split out, but this can easily be handled by a few well places
accessor functions - which depends on this being the case or not.

The addition of OVP handling would benefit 8941 as well.

The short circuit handling in your patches are isolated and not taking
this code path on 8941 should not pose any problems.

[..]
> +/* General definitions */
> +#define QCOM_WLED_DEFAULT_BRIGHTNESS		2048
> +#define  QCOM_WLED_MAX_BRIGHTNESS		4095
> +
> +/* WLED control registers */
> +#define QCOM_WLED_CTRL_MOD_ENABLE		0x46
> +#define  QCOM_WLED_CTRL_MOD_EN_MASK		BIT(7)
> +#define  QCOM_WLED_CTRL_MODULE_EN_SHIFT		7
> +
> +#define QCOM_WLED_CTRL_SWITCH_FREQ		0x4c
> +#define  QCOM_WLED_CTRL_SWITCH_FREQ_MASK	GENMASK(3, 0)
> +
> +#define QCOM_WLED_CTRL_OVP			0x4d
> +#define  QCOM_WLED_CTRL_OVP_MASK		GENMASK(1, 0)
> +
> +#define QCOM_WLED_CTRL_ILIM			0x4e
> +#define  QCOM_WLED_CTRL_ILIM_MASK		GENMASK(2, 0)
> +
> +/* WLED sink registers */
> +#define QCOM_WLED_SINK_CURR_SINK_EN		0x46
> +#define  QCOM_WLED_SINK_CURR_SINK_MASK		GENMASK(7, 4)
> +#define  QCOM_WLED_SINK_CURR_SINK_SHFT		0x04

Shifts are typically not given as hex...

> +
> +#define QCOM_WLED_SINK_SYNC			0x47
> +#define  QCOM_WLED_SINK_SYNC_MASK		GENMASK(3, 0)
> +#define  QCOM_WLED_SINK_SYNC_LED1		BIT(0)
> +#define  QCOM_WLED_SINK_SYNC_LED2		BIT(1)
> +#define  QCOM_WLED_SINK_SYNC_LED3		BIT(2)
> +#define  QCOM_WLED_SINK_SYNC_LED4		BIT(3)
> +#define  QCOM_WLED_SINK_SYNC_CLEAR		0x00
> +
> +#define QCOM_WLED_SINK_MOD_EN_REG(n)		(0x50 + (n * 0x10))
> +#define  QCOM_WLED_SINK_REG_STR_MOD_MASK	BIT(7)
> +#define  QCOM_WLED_SINK_REG_STR_MOD_EN		BIT(7)
> +
> +#define QCOM_WLED_SINK_SYNC_DLY_REG(n)		(0x51 + (n * 0x10))
> +#define QCOM_WLED_SINK_FS_CURR_REG(n)		(0x52 + (n * 0x10))
> +#define  QCOM_WLED_SINK_FS_MASK			GENMASK(3, 0)
> +
> +#define QCOM_WLED_SINK_CABC_REG(n)		(0x56 + (n * 0x10))
> +#define  QCOM_WLED_SINK_CABC_MASK		BIT(7)
> +#define  QCOM_WLED_SINK_CABC_EN			BIT(7)
> +
> +#define QCOM_WLED_SINK_BRIGHT_LSB_REG(n)	(0x57 + (n * 0x10))
> +#define QCOM_WLED_SINK_BRIGHT_MSB_REG(n)	(0x58 + (n * 0x10))
> +
> +struct qcom_wled_config {
> +	u32 i_boost_limit;
> +	u32 ovp;
> +	u32 switch_freq;
> +	u32 fs_current;
> +	u32 string_cfg;
> +	bool en_cabc;
> +};
> +
> +struct qcom_wled {
> +	const char *name;
> +	struct platform_device *pdev;

Lug around the struct device * instead of the platform_device, and use
this for dev_* prints throughout the code.

> +	struct regmap *regmap;
> +	u16 sink_addr;
> +	u16 ctrl_addr;
> +	u32 brightness;
> +	bool prev_state;

You can derive prev_state from wled->brightness in
qcom_wled_update_status().

> +
> +	struct qcom_wled_config cfg;
> +};
> +
> +static int qcom_wled_module_enable(struct qcom_wled *wled, int val)
> +{
> +	int rc;
> +
> +	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
> +			QCOM_WLED_CTRL_MOD_ENABLE, QCOM_WLED_CTRL_MOD_EN_MASK,
> +			val << QCOM_WLED_CTRL_MODULE_EN_SHIFT);

This shift obfuscate the fact that val is only 0 or 1, make val a bool
and make the macro for the enabled state be BIT(7).

> +	return rc;
> +}
> +
> +static int qcom_wled_get_brightness(struct backlight_device *bl)
> +{
> +	struct qcom_wled *wled = bl_get_data(bl);
> +
> +	return wled->brightness;
> +}
> +
> +static int qcom_wled_sync_toggle(struct qcom_wled *wled)
> +{
> +	int rc;
> +
> +	rc = regmap_update_bits(wled->regmap,
> +			wled->sink_addr + QCOM_WLED_SINK_SYNC,
> +			QCOM_WLED_SINK_SYNC_MASK, QCOM_WLED_SINK_SYNC_MASK);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = regmap_update_bits(wled->regmap,
> +			wled->sink_addr + QCOM_WLED_SINK_SYNC,
> +			QCOM_WLED_SINK_SYNC_MASK, QCOM_WLED_SINK_SYNC_CLEAR);
> +
> +	return rc;
> +}
> +
> +static int qcom_wled_set_brightness(struct qcom_wled *wled, u16 brightness)
> +{
> +	int rc, i;
> +	u16 low_limit = QCOM_WLED_MAX_BRIGHTNESS * 4 / 1000;
> +	u8 string_cfg = wled->cfg.string_cfg;
> +	u8 v[2];
> +
> +	/* WLED's lower limit of operation is 0.4% */
> +	if (brightness > 0 && brightness < low_limit)
> +		brightness = low_limit;

What happens between 0 and 0.4%? Is this policy or is this related to
some hardware issue?

Also, this function will not be called with brightness = 0, so you don't
need to check that case.

> +
> +	v[0] = brightness & 0xff;
> +	v[1] = (brightness >> 8) & 0xf;
> +
> +	for (i = 0; (string_cfg >> i) != 0; i++) {

The condition looks optimal... Just loop from 0 to 3 and it will be
easier to read without any measurable losses.

> +		if (string_cfg & BIT(i)) {

Flip this condition around and use "continue" to reduce the indentation
level of the rest of the block.

> +			rc = regmap_bulk_write(wled->regmap, wled->sink_addr +
> +					QCOM_WLED_SINK_BRIGHT_LSB_REG(i), v, 2);
> +			if (rc < 0)
> +				return rc;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_wled_update_status(struct backlight_device *bl)
> +{
> +	struct qcom_wled *wled = bl_get_data(bl);
> +	u16 brightness = bl->props.brightness;
> +	int rc;
> +
> +	if (bl->props.power != FB_BLANK_UNBLANK ||
> +	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
> +	    bl->props.state & BL_CORE_FBBLANK)
> +		brightness = 0;
> +
> +	if (brightness) {
> +		rc = qcom_wled_set_brightness(wled, brightness);
> +		if (rc < 0) {
> +			pr_err("wled failed to set brightness rc:%d\n", rc);

Use dev_err() and dev_dbg() throughout the driver.

> +			return rc;
> +		}
> +
> +		if (!!brightness != wled->prev_state) {
> +			rc = qcom_wled_module_enable(wled, !!brightness);
> +			if (rc < 0) {
> +				pr_err("wled enable failed rc:%d\n", rc);
> +				return rc;
> +			}
> +		}

This block is exactly the same as the else statement, there's no need to
repeat yourself.

> +	} else {
> +		rc = qcom_wled_module_enable(wled, brightness);
> +		if (rc < 0) {
> +			pr_err("wled disable failed rc:%d\n", rc);
> +			return rc;
> +		}
> +	}
> +
> +	wled->prev_state = !!brightness;
> +
> +	rc = qcom_wled_sync_toggle(wled);
> +	if (rc < 0) {
> +		pr_err("wled sync failed rc:%d\n", rc);
> +		return rc;
> +	}
> +
> +	wled->brightness = brightness;
> +
> +	return rc;
> +}
> +
> +static int qcom_wled_setup(struct qcom_wled *wled)
> +{
> +	int rc, temp, i;
> +	u8 sink_en = 0;
> +	u8 string_cfg = wled->cfg.string_cfg;
> +
> +	rc = regmap_update_bits(wled->regmap,
> +			wled->ctrl_addr + QCOM_WLED_CTRL_OVP,
> +			QCOM_WLED_CTRL_OVP_MASK, wled->cfg.ovp);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = regmap_update_bits(wled->regmap,
> +			wled->ctrl_addr + QCOM_WLED_CTRL_ILIM,
> +			QCOM_WLED_CTRL_ILIM_MASK, wled->cfg.i_boost_limit);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = regmap_update_bits(wled->regmap,
> +			wled->ctrl_addr + QCOM_WLED_CTRL_SWITCH_FREQ,
> +			QCOM_WLED_CTRL_SWITCH_FREQ_MASK, wled->cfg.switch_freq);
> +	if (rc < 0)
> +		return rc;
> +
> +	for (i = 0; (string_cfg >> i) != 0; i++) {
> +		if (string_cfg & BIT(i)) {

Same as above.

> +			u16 addr = wled->sink_addr +
> +					QCOM_WLED_SINK_MOD_EN_REG(i);
> +
> +			rc = regmap_update_bits(wled->regmap, addr,
> +					QCOM_WLED_SINK_REG_STR_MOD_MASK,
> +					QCOM_WLED_SINK_REG_STR_MOD_EN);
> +			if (rc < 0)
> +				return rc;
> +
> +			addr = wled->sink_addr +
> +					QCOM_WLED_SINK_FS_CURR_REG(i);
> +			rc = regmap_update_bits(wled->regmap, addr,
> +					QCOM_WLED_SINK_FS_MASK,
> +					wled->cfg.fs_current);
> +			if (rc < 0)
> +				return rc;
> +
> +			addr = wled->sink_addr +
> +					QCOM_WLED_SINK_CABC_REG(i);
> +			rc = regmap_update_bits(wled->regmap, addr,
> +					QCOM_WLED_SINK_CABC_MASK,
> +					wled->cfg.en_cabc ?
> +					QCOM_WLED_SINK_CABC_EN : 0);
> +			if (rc)
> +				return rc;
> +
> +			temp = i + QCOM_WLED_SINK_CURR_SINK_SHFT;
> +			sink_en |= 1 << temp;

I'm failing to see the reason for the "temp" variable here. Please do:

  sink_en |= BIT(i + QCOM_WLED_SINK_CURR_SINK_SHFT)

> +		}
> +	}
> +
> +	rc = regmap_update_bits(wled->regmap,
> +			wled->sink_addr + QCOM_WLED_SINK_CURR_SINK_EN,
> +			QCOM_WLED_SINK_CURR_SINK_MASK, sink_en);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = qcom_wled_sync_toggle(wled);
> +	if (rc < 0) {
> +		pr_err("Failed to toggle sync reg rc:%d\n", rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
[..]
> +static int qcom_wled_configure(struct qcom_wled *wled, struct device *dev)
> +{
> +	struct qcom_wled_config *cfg = &wled->cfg;
> +	const __be32 *prop_addr;
> +	u32 val, c;
> +	int rc, i, j;
> +
> +	const struct {
> +		const char *name;
> +		u32 *val_ptr;
> +		const struct qcom_wled_var_cfg *cfg;
> +	} u32_opts[] = {

I suggest that you tie this list of options to the compatible (through
of_device_id->data) and pass it as a parameter to this function. That
way you can handle variation in properties and their values between
different compatibles.

[..]
> +	*cfg = wled_config_defaults;
> +	for (i = 0; i < ARRAY_SIZE(u32_opts); ++i) {
> +		rc = of_property_read_u32(dev->of_node, u32_opts[i].name, &val);

of_property_read_u32() returns -ENODATA when there's no associated data,
you can probably use this to implement support for the boolean types in
the same list of opts.

[..]
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(bool_opts); ++i) {
> +		if (of_property_read_bool(dev->of_node, bool_opts[i].name))
> +			*bool_opts[i].val_ptr = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct backlight_ops qcom_wled_ops = {
> +	.update_status = qcom_wled_update_status,
> +	.get_brightness = qcom_wled_get_brightness,
> +};
> +
> +static int qcom_wled_probe(struct platform_device *pdev)
> +{
> +	struct backlight_properties props;
> +	struct backlight_device *bl;
> +	struct qcom_wled *wled;
> +	struct regmap *regmap;
> +	u32 val;
> +	int rc;
> +
> +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap) {
> +		pr_err("Unable to get regmap\n");
> +		return -EINVAL;
> +	}
> +
> +	wled = devm_kzalloc(&pdev->dev, sizeof(*wled), GFP_KERNEL);
> +	if (!wled)
> +		return -ENOMEM;
> +
> +	wled->regmap = regmap;
> +	wled->pdev = pdev;
> +
> +	rc = qcom_wled_configure(wled, &pdev->dev);
> +	if (rc < 0) {
> +		pr_err("wled configure failed rc:%d\n", rc);

qcom_wled_configure() already printed an error message for you, no need
to repeat this.

> +		return rc;
> +	}
> +

Please also run checkpatch.pl with the --strict option and fix the
indentation issues reported.

Regards,
Bjorn
