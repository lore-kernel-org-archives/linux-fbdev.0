From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 21 Nov 2016 11:57:51 +0000
Subject: Re: [PATCH 1/2] backlight: arcxcnn: add support for ArticSand devices
Message-Id: <20161121115751.GL32509@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479482246-19024-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1479482246-19024-1-git-send-email-olimpiu@arcticsand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Olimpiu Dejeu <olimpiu@arcticsand.com>
Cc: robh@kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, jingoohan1@gmail.com

On Fri, 18 Nov 2016, Olimpiu Dejeu wrote:

> Re-submission of arcxcnn backlight driver addressing the naming convention
>  concerns raised by Rob H.
>=20
> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
>=20
> ---
>  drivers/video/backlight/Kconfig      |   7 +
>  drivers/video/backlight/Makefile     |   1 +
>  drivers/video/backlight/arcxcnn_bl.c | 541 +++++++++++++++++++++++++++++=
++++++
>  include/linux/i2c/arcxcnn.h          |  67 +++++
>  4 files changed, 616 insertions(+)
>  create mode 100644 drivers/video/backlight/arcxcnn_bl.c
>  create mode 100644 include/linux/i2c/arcxcnn.h

Same goes for this patch.

Also, make sure you submit you patches so that they are connected in
people's inboxes.

Use `git send-email` where --thread should be the default.

> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kc=
onfig
> index 5ffa4b4..4e1d2ad 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -460,6 +460,13 @@ config BACKLIGHT_BD6107
>  	help
>  	  If you have a Rohm BD6107 say Y to enable the backlight driver.
> =20
> +config BACKLIGHT_ARCXCNN
> +	tristate "Backlight driver for the Arctic Sands ARCxCnnnn family"
> +	depends on I2C
> +	help
> +	  If you have an ARCxCnnnn family backlight say Y to enable
> +	  the backlight driver.
> +
>  endif # BACKLIGHT_CLASS_DEVICE
> =20
>  endif # BACKLIGHT_LCD_SUPPORT
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/M=
akefile
> index 16ec534..8905129 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -55,3 +55,4 @@ obj-$(CONFIG_BACKLIGHT_SKY81452)	+=3D sky81452-backligh=
t.o
>  obj-$(CONFIG_BACKLIGHT_TOSA)		+=3D tosa_bl.o
>  obj-$(CONFIG_BACKLIGHT_TPS65217)	+=3D tps65217_bl.o
>  obj-$(CONFIG_BACKLIGHT_WM831X)		+=3D wm831x_bl.o
> +obj-$(CONFIG_BACKLIGHT_ARCXCNN) 	+=3D arcxcnn_bl.o
> diff --git a/drivers/video/backlight/arcxcnn_bl.c b/drivers/video/backlig=
ht/arcxcnn_bl.c
> new file mode 100644
> index 0000000..1dad680
> --- /dev/null
> +++ b/drivers/video/backlight/arcxcnn_bl.c
> @@ -0,0 +1,541 @@
> +/*
> + * Backlight driver for ArcticSand ARC_X_C_0N_0N Devices
> + *
> + * Copyright 2016 ArcticSand, Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/backlight.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/pwm.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include "linux/i2c/arcxcnn.h"
> +
> +#define ARCXCNN_CMD		(0x00)  /* Command Register */
> +#define ARCXCNN_CMD_STDBY	(0x80)	/* I2C Standby */
> +#define ARCXCNN_CMD_RESET	(0x40)	/* Reset */
> +#define ARCXCNN_CMD_BOOST	(0x10)	/* Boost */
> +#define ARCXCNN_CMD_OVP_MASK	(0x0C)	/* --- Over Voltage Threshold */
> +#define ARCXCNN_CMD_OVP_XXV	(0x0C)	/* <rsvrd> Over Voltage Threshold */
> +#define ARCXCNN_CMD_OVP_20V	(0x08)	/* 20v Over Voltage Threshold */
> +#define ARCXCNN_CMD_OVP_24V	(0x04)	/* 24v Over Voltage Threshold */
> +#define ARCXCNN_CMD_OVP_31V	(0x00)	/* 31.4v Over Voltage Threshold */
> +#define ARCXCNN_CMD_EXT_COMP	(0x01)	/* part (0) or full (1) external com=
p */
> +
> +#define ARCXCNN_CONFIG	(0x01)  /* Configuration */
> +#define ARCXCNN_STATUS1	(0x02)  /* Status 1 */
> +#define ARCXCNN_STATUS2	(0x03)  /* Status 2 */
> +#define ARCXCNN_FADECTRL	(0x04)  /* Fading Control */
> +#define ARCXCNN_ILED_CONFIG	(0x05)  /* ILED Configuration */
> +
> +#define ARCXCNN_LEDEN		(0x06)  /* LED Enable Register */
> +#define ARCXCNN_LEDEN_ISETEXT	(0x80)	/* Full-scale current set externall=
y */
> +#define ARCXCNN_LEDEN_MASK	(0x3F)	/* LED string enables */
> +#define ARCXCNN_LEDEN_LED1	(0x01)
> +#define ARCXCNN_LEDEN_LED2	(0x02)
> +#define ARCXCNN_LEDEN_LED3	(0x04)
> +#define ARCXCNN_LEDEN_LED4	(0x08)
> +#define ARCXCNN_LEDEN_LED5	(0x10)
> +#define ARCXCNN_LEDEN_LED6	(0x20)
> +
> +#define ARCXCNN_WLED_ISET_LSB	(0x07)  /* LED ISET LSB (in upper nibble) =
*/
> +#define ARCXCNN_WLED_ISET_MSB	(0x08)  /* LED ISET MSB (8 bits) */
> +
> +#define ARCXCNN_DIMFREQ		(0x09)
> +#define ARCXCNN_COMP_CONFIG	(0x0A)
> +#define ARCXCNN_FILT_CONFIG	(0x0B)
> +#define ARCXCNN_IMAXTUNE	(0x0C)
> +
> +#define DEFAULT_BL_NAME		"arctic_bl"
> +#define MAX_BRIGHTNESS		4095
> +
> +static int s_no_reset_on_remove;
> +module_param_named(noreset, s_no_reset_on_remove, int, 0644);
> +MODULE_PARM_DESC(noreset, "No reset on module removal");
> +
> +static int s_ibright =3D 60;
> +module_param_named(ibright, s_ibright, int, 0644);
> +MODULE_PARM_DESC(ibright, "Initial brightness (when no plat data)");
> +
> +static int s_iledstr =3D 0x3F;
> +module_param_named(iledstr, s_iledstr, int, 0644);
> +MODULE_PARM_DESC(iledstr, "Initial LED String (when no plat data)");
> +
> +static int s_retries =3D 2; /* 1 =3D only one try */
> +module_param_named(retries, s_retries, int, 0644);
> +MODULE_PARM_DESC(retries, "I2C retries attempted");
> +
> +enum arcxcnn_brightness_ctrl_mode {
> +	PWM_BASED =3D 1,
> +	REGISTER_BASED,
> +};
> +
> +struct arcxcnn;
> +
> +struct arcxcnn {
> +	char chipname[64];
> +	enum arcxcnn_chip_id chip_id;
> +	enum arcxcnn_brightness_ctrl_mode mode;
> +	struct i2c_client *client;
> +	struct backlight_device *bl;
> +	struct device *dev;
> +	struct arcxcnn_platform_data *pdata;
> +	struct pwm_device *pwm;
> +	struct regulator *supply;	/* regulator for VDD input */
> +};
> +
> +static int arcxcnn_write_byte(struct arcxcnn *lp, u8 reg, u8 data)
> +{
> +	s32 ret =3D -1;
> +	int att;
> +
> +	for (att =3D 0; att < s_retries; att++) {
> +		ret =3D i2c_smbus_write_byte_data(lp->client, reg, data);
> +		if (ret >=3D 0)
> +			return 0;
> +	}
> +	return ret;
> +}
> +
> +static u8 arcxcnn_read_byte(struct arcxcnn *lp, u8 reg)
> +{
> +	int val;
> +	int att;
> +
> +	for (att =3D 0; att < s_retries; att++) {
> +		val =3D i2c_smbus_read_byte_data(lp->client, reg);
> +		if (val >=3D 0)
> +			return (u8)val;
> +	}
> +	return 0;
> +}
> +
> +static int arcxcnn_update_bit(struct arcxcnn *lp, u8 reg, u8 mask, u8 da=
ta)
> +{
> +	int ret, att;
> +	u8 tmp;
> +
> +	for (att =3D 0, ret =3D -1; att < s_retries; att++) {
> +		ret =3D i2c_smbus_read_byte_data(lp->client, reg);
> +		if (ret >=3D 0)
> +			break;
> +	}
> +	if (ret < 0) {
> +		dev_err(lp->dev, "failed to read 0x%.2x\n", reg);
> +		return ret;
> +	}
> +
> +	tmp =3D (u8)ret;
> +	tmp &=3D ~mask;
> +	tmp |=3D data & mask;
> +
> +	return arcxcnn_write_byte(lp, reg, tmp);
> +}
> +
> +static int arcxcnn_set_brightness(struct arcxcnn *lp, u32 brightness)
> +{
> +	int ret;
> +	u8 val;
> +
> +	val =3D (brightness & 0xF) << 4;
> +	ret =3D arcxcnn_write_byte(lp, ARCXCNN_WLED_ISET_LSB, val);
> +	if (ret < 0)
> +		return ret;
> +	val =3D (brightness >> 4);
> +	ret =3D arcxcnn_write_byte(lp, ARCXCNN_WLED_ISET_MSB, val);
> +	return ret;
> +}
> +
> +static int arcxcnn_bl_update_status(struct backlight_device *bl)
> +{
> +	struct arcxcnn *lp =3D bl_get_data(bl);
> +	u32 brightness =3D bl->props.brightness;
> +
> +	if (bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
> +		brightness =3D 0;
> +
> +	/* set brightness */
> +	if (lp->mode =3D PWM_BASED)
> +		; /* via pwm */
> +	else if (lp->mode =3D REGISTER_BASED)
> +		arcxcnn_set_brightness(lp, brightness);
> +
> +	/* set power-on/off/save modes */
> +	if (bl->props.power =3D 0)
> +		/* take out of standby */
> +		arcxcnn_update_bit(lp, ARCXCNN_CMD, ARCXCNN_CMD_STDBY, 0);
> +	else
> +		/* 1-3 =3D power save, 4 =3D off
> +		 * place in low-power standby mode
> +		 */
> +		arcxcnn_update_bit(lp, ARCXCNN_CMD,
> +				ARCXCNN_CMD_STDBY, ARCXCNN_CMD_STDBY);
> +	return 0;
> +}
> +
> +static const struct backlight_ops arcxcnn_bl_ops =3D {
> +	.options =3D BL_CORE_SUSPENDRESUME,
> +	.update_status =3D arcxcnn_bl_update_status,
> +};
> +
> +static int arcxcnn_backlight_register(struct arcxcnn *lp)
> +{
> +	struct backlight_device *bl;
> +	struct backlight_properties props;
> +	struct arcxcnn_platform_data *pdata =3D lp->pdata;
> +	const char *name =3D pdata->name ? : DEFAULT_BL_NAME;
> +
> +	memset(&props, 0, sizeof(props));
> +	props.type =3D BACKLIGHT_PLATFORM;
> +	props.max_brightness =3D MAX_BRIGHTNESS;
> +
> +	if (pdata->initial_brightness > props.max_brightness)
> +		pdata->initial_brightness =3D props.max_brightness;
> +
> +	props.brightness =3D pdata->initial_brightness;
> +
> +	bl =3D devm_backlight_device_register(lp->dev, name, lp->dev, lp,
> +				       &arcxcnn_bl_ops, &props);
> +	if (IS_ERR(bl))
> +		return PTR_ERR(bl);
> +
> +	lp->bl =3D bl;
> +
> +	return 0;
> +}
> +
> +static ssize_t arcxcnn_get_chip_id(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct arcxcnn *lp =3D dev_get_drvdata(dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", lp->chipname);
> +}
> +
> +static ssize_t arcxcnn_get_led_str(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct arcxcnn *lp =3D dev_get_drvdata(dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%02X\n", lp->pdata->led_str);
> +}
> +
> +static ssize_t arcxcnn_set_led_str(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	struct arcxcnn *lp =3D dev_get_drvdata(dev);
> +	unsigned long ledstr;
> +
> +	if (kstrtoul(buf, 0, &ledstr))
> +		return 0;
> +
> +	if (ledstr !=3D lp->pdata->led_str) {
> +		/* don't allow 0 for ledstr, use power to turn all off */
> +		if (ledstr =3D 0)
> +			return 0;
> +		lp->pdata->led_str =3D ledstr & 0x3F;
> +		arcxcnn_update_bit(lp, ARCXCNN_LEDEN,
> +			ARCXCNN_LEDEN_MASK, lp->pdata->led_str);
> +	}
> +	return len;
> +}
> +
> +static ssize_t arcxcnn_get_bl_ctl_mode(struct device *dev,
> +	     struct device_attribute *attr, char *buf)
> +{
> +	struct arcxcnn *lp =3D dev_get_drvdata(dev);
> +	char *strmode =3D NULL;
> +
> +	if (lp->mode =3D PWM_BASED)
> +		strmode =3D "pwm based";
> +	else if (lp->mode =3D REGISTER_BASED)
> +		strmode =3D "register based";
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", strmode);
> +}
> +
> +static DEVICE_ATTR(chip_id, 0444, arcxcnn_get_chip_id, NULL);
> +static DEVICE_ATTR(led_str, 0664, arcxcnn_get_led_str, arcxcnn_set_led_s=
tr);
> +static DEVICE_ATTR(bl_ctl_mode, 0444, arcxcnn_get_bl_ctl_mode, NULL);
> +
> +static struct attribute *arcxcnn_attributes[] =3D {
> +	&dev_attr_chip_id.attr,
> +	&dev_attr_led_str.attr,
> +	&dev_attr_bl_ctl_mode.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group arcxcnn_attr_group =3D {
> +	.attrs =3D arcxcnn_attributes,
> +};
> +
> +#ifdef CONFIG_OF
> +static int arcxcnn_parse_dt(struct arcxcnn *lp)
> +{
> +	struct device *dev =3D lp->dev;
> +	struct device_node *node =3D dev->of_node;
> +	u32 prog_val, num_entry, sources[6];
> +	int ret;
> +
> +	if (!node) {
> +		dev_err(dev, "no platform data.\n");
> +		return -EINVAL;
> +	}
> +	lp->pdata->led_config_0_set =3D false;
> +	lp->pdata->led_config_1_set =3D false;
> +	lp->pdata->dim_freq_set =3D false;
> +	lp->pdata->comp_config_set =3D false;
> +	lp->pdata->filter_config_set =3D false;
> +	lp->pdata->trim_config_set =3D false;
> +
> +	ret =3D of_property_read_string(node, "label", &lp->pdata->name);
> +	if (ret < 0)
> +		lp->pdata->name =3D NULL;
> +
> +	ret =3D of_property_read_u32(node, "default-brightness", &prog_val);
> +	if (ret < 0)
> +		prog_val =3D s_ibright;
> +	lp->pdata->initial_brightness =3D prog_val;
> +	if (lp->pdata->initial_brightness > MAX_BRIGHTNESS)
> +		lp->pdata->initial_brightness =3D MAX_BRIGHTNESS;
> +
> +	ret =3D of_property_read_u32(node, "arc,led-config-0", &prog_val);
> +	if (ret =3D 0) {
> +		lp->pdata->led_config_0 =3D (u8)prog_val;
> +		lp->pdata->led_config_0_set =3D true;
> +	}
> +	ret =3D of_property_read_u32(node, "arc,led-config-1", &prog_val);
> +	if (ret =3D 0) {
> +		lp->pdata->led_config_1 =3D (u8)prog_val;
> +		lp->pdata->led_config_1_set =3D true;
> +	}
> +	ret =3D of_property_read_u32(node, "arc,dim-freq", &prog_val);
> +	if (ret =3D 0) {
> +		lp->pdata->dim_freq =3D (u8)prog_val;
> +		lp->pdata->dim_freq_set =3D true;
> +	}
> +	ret =3D of_property_read_u32(node, "arc,comp-config", &prog_val);
> +	if (ret =3D 0) {
> +		lp->pdata->comp_config =3D (u8)prog_val;
> +		lp->pdata->comp_config_set =3D true;
> +	}
> +	ret =3D of_property_read_u32(node, "arc,filter-config", &prog_val);
> +	if (ret =3D 0) {
> +		lp->pdata->filter_config =3D (u8)prog_val;
> +		lp->pdata->filter_config_set =3D true;
> +	}
> +	ret =3D of_property_read_u32(node, "arc,trim-config", &prog_val);
> +	if (ret =3D 0) {
> +		lp->pdata->trim_config =3D (u8)prog_val;
> +		lp->pdata->trim_config_set =3D true;
> +	}
> +	ret =3D of_property_count_u32_elems(node, "led-sources");
> +	if (ret < 0)
> +		lp->pdata->led_str =3D 0x3F;
> +	else {
> +		num_entry =3D ret;
> +		if (num_entry > 6)
> +			num_entry =3D 6;
> +
> +		ret =3D of_property_read_u32_array(node, "led-sources", sources,
> +					num_entry);
> +		if (ret < 0) {
> +			dev_err(dev, "led-sources node is invalid.\n");
> +			return -EINVAL;
> +		}
> +
> +		lp->pdata->led_str =3D 0;
> +		while (num_entry > 0)
> +			lp->pdata->led_str |=3D (1 << sources[--num_entry]);
> +	}
> +	return 0;
> +}
> +#else
> +static int arcxcnn_parse_dt(struct arcxcnn *lp)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
> +static int arcxcnn_probe(struct i2c_client *cl, const struct i2c_device_=
id *id)
> +{
> +	struct arcxcnn *lp;
> +	int ret;
> +	u8 regval;
> +	u16 chipid;
> +
> +	if (!i2c_check_functionality(cl->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EIO;
> +
> +	lp =3D devm_kzalloc(&cl->dev, sizeof(*lp), GFP_KERNEL);
> +	if (!lp)
> +		return -ENOMEM;
> +
> +	lp->client =3D cl;
> +	lp->dev =3D &cl->dev;
> +	lp->chip_id =3D id->driver_data;
> +	lp->pdata =3D dev_get_platdata(&cl->dev);
> +
> +	if (!lp->pdata) {
> +		lp->pdata =3D devm_kzalloc(lp->dev,
> +				sizeof(*lp->pdata), GFP_KERNEL);
> +		if (!lp->pdata)
> +			return -ENOMEM;
> +
> +		/* no platform data, parse the device-tree for info.  if there
> +		 * is no device tree entry, we are being told we exist because
> +		 * user-land said so, so make up the info we need
> +		 */
> +		ret =3D arcxcnn_parse_dt(lp);
> +		if (ret < 0) {
> +			/* no device tree, use defaults based on module params
> +			 */
> +			lp->pdata->led_config_0_set =3D false;
> +			lp->pdata->led_config_1_set =3D false;
> +			lp->pdata->dim_freq_set =3D false;
> +			lp->pdata->comp_config_set =3D false;
> +			lp->pdata->filter_config_set =3D false;
> +			lp->pdata->trim_config_set =3D false;
> +
> +			lp->pdata->name =3D NULL;
> +			lp->pdata->initial_brightness =3D s_ibright;
> +			lp->pdata->led_str =3D s_iledstr;
> +		}
> +	}
> +
> +	if (lp->pdata->dim_freq_set)
> +		lp->mode =3D PWM_BASED;
> +	else
> +		lp->mode =3D REGISTER_BASED;
> +
> +	i2c_set_clientdata(cl, lp);
> +
> +	/* read device ID */
> +	regval =3D arcxcnn_read_byte(lp, 0x1E);
> +	chipid =3D regval;
> +	chipid <<=3D 8;
> +	regval =3D arcxcnn_read_byte(lp, 0x1F);
> +	chipid |=3D regval;
> +
> +	/* make sure it belongs to this driver
> +	 * TODO - handle specific ids
> +	 */
> +	if (chipid !=3D 0x02A5) {
> +		#if 1
> +		dev_info(&cl->dev, "Chip Id is %04X\n", chipid);
> +		#else
> +		dev_err(&cl->dev, "%04X is not ARC2C\n", chipid);
> +		return -ENODEV;
> +		#endif
> +	}
> +	/* reset the device */
> +	arcxcnn_write_byte(lp, ARCXCNN_CMD, ARCXCNN_CMD_RESET);
> +
> +	/* set initial brightness */
> +	arcxcnn_set_brightness(lp, lp->pdata->initial_brightness);
> +
> +	/* if fadectrl set in DT, set the value directly, else leave default */
> +	if (lp->pdata->led_config_0_set)
> +		arcxcnn_write_byte(lp, ARCXCNN_FADECTRL,
> +			lp->pdata->led_config_0);
> +
> +	/* if iled config set in DT, set the value, else internal mode */
> +	if (lp->pdata->led_config_1_set)
> +		arcxcnn_write_byte(lp, ARCXCNN_ILED_CONFIG,
> +			lp->pdata->led_config_1);
> +	else
> +		arcxcnn_write_byte(lp, ARCXCNN_ILED_CONFIG, 0x57);
> +
> +	/* other misc DT settings */
> +	if (lp->pdata->dim_freq_set)
> +		arcxcnn_write_byte(lp, ARCXCNN_FADECTRL, lp->pdata->dim_freq);
> +	if (lp->pdata->comp_config_set)
> +		arcxcnn_write_byte(lp, ARCXCNN_COMP_CONFIG,
> +			lp->pdata->comp_config);
> +	if (lp->pdata->filter_config_set)
> +		arcxcnn_write_byte(lp, ARCXCNN_FILT_CONFIG,
> +			lp->pdata->filter_config);
> +	if (lp->pdata->trim_config_set)
> +		arcxcnn_write_byte(lp, ARCXCNN_IMAXTUNE,
> +			lp->pdata->trim_config);
> +
> +	/* set initial LED Strings */
> +	arcxcnn_update_bit(lp, ARCXCNN_LEDEN,
> +		ARCXCNN_LEDEN_MASK, lp->pdata->led_str);
> +
> +	snprintf(lp->chipname, sizeof(lp->chipname),
> +		"%s-%04X", id->name, chipid);
> +
> +	ret =3D arcxcnn_backlight_register(lp);
> +	if (ret) {
> +		dev_err(lp->dev,
> +			"failed to register backlight. err: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D sysfs_create_group(&lp->dev->kobj, &arcxcnn_attr_group);
> +	if (ret) {
> +		dev_err(lp->dev, "failed to register sysfs. err: %d\n", ret);
> +		return ret;
> +	}
> +
> +	backlight_update_status(lp->bl);
> +	return 0;
> +}
> +
> +static int arcxcnn_remove(struct i2c_client *cl)
> +{
> +	struct arcxcnn *lp =3D i2c_get_clientdata(cl);
> +
> +	if (!s_no_reset_on_remove) {
> +		/* disable all strings */
> +		arcxcnn_write_byte(lp, ARCXCNN_LEDEN, 0x00);
> +		/* reset the device */
> +		arcxcnn_write_byte(lp, ARCXCNN_CMD, ARCXCNN_CMD_RESET);
> +	}
> +	lp->bl->props.brightness =3D 0;
> +	backlight_update_status(lp->bl);
> +	if (lp->supply)
> +		regulator_disable(lp->supply);
> +	sysfs_remove_group(&lp->dev->kobj, &arcxcnn_attr_group);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id arcxcnn_dt_ids[] =3D {
> +	{ .compatible =3D "arc,arc2c0608" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, arcxcnn_dt_ids);
> +
> +/* Note that the device/chip ID is not fixed in silicon so
> + * auto-probing of these devices on the bus is most likely
> + * not possible, use device tree to set i2c bus address
> + */
> +static const struct i2c_device_id arcxcnn_ids[] =3D {
> +	{"arc2c0608", ARC2C0608},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, arcxcnn_ids);
> +
> +static struct i2c_driver arcxcnn_driver =3D {
> +	.driver =3D {
> +		   .name =3D "arcxcnn_bl",
> +		   .of_match_table =3D of_match_ptr(arcxcnn_dt_ids),
> +		   },
> +	.probe =3D arcxcnn_probe,
> +	.remove =3D arcxcnn_remove,
> +	.id_table =3D arcxcnn_ids,
> +};
> +
> +module_i2c_driver(arcxcnn_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Brian Dodge <bdodge09@outlook.com>");
> +MODULE_DESCRIPTION("ARCXCNN Backlight driver");
> diff --git a/include/linux/i2c/arcxcnn.h b/include/linux/i2c/arcxcnn.h
> new file mode 100644
> index 0000000..1c681dd
> --- /dev/null
> +++ b/include/linux/i2c/arcxcnn.h
> @@ -0,0 +1,67 @@
> +/*
> + * Backlight driver for ArcticSand ARC2C0608 Backlight Devices
> + *
> + * Copyright 2016 ArcticSand, Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#ifndef _ARCXCNN_H
> +#define _ARCXCNN_H
> +
> +enum arcxcnn_chip_id {
> +	ARC2C0608
> +};
> +
> +enum arcxcnn_brightness_source {
> +	ARCXCNN_PWM_ONLY,
> +	ARCXCNN_I2C_ONLY =3D 2,
> +};
> +
> +#define ARCXCNN_MAX_PROGENTRIES	48	/* max a/v pairs for custom */
> +
> +/**
> + * struct arcxcnn_platform_data
> + * @name : Backlight driver name. If it is not defined, default name is =
set.
> + * @initial_brightness : initial value of backlight brightness
> + * @led_str	 : initial LED string enables, upper bit is global on/off
> + * @led_config_0 : fading speed (period between intensity steps)
> + * @led_config_1 : misc settings, see datasheet
> + * @dim_freq	 : pwm dimming frequency if in pwm mode
> + * @comp_config	 : misc config, see datasheet
> + * @filter_config: RC/PWM filter config, see datasheet
> + * @trim_config	 : full scale current trim, see datasheet
> + * @led_config_0_set	: the value in led_config_0 is valid
> + * @led_config_1_set	: the value in led_config_1 is valid
> + * @dim_freq_set	: the value in dim_freq is valid
> + * @comp_config_set	: the value in comp_config is valid
> + * @filter_config_set	: the value in filter_config is valid
> + * @trim_config_set	: the value in trim_config is valid
> + *
> + * the _set flags are used to indicate that the value was explicitly set
> + * in the device tree or platform data. settings not set are left as def=
ault
> + * power-on default values of the chip except for led_str and led_config=
_1
> + * which are set by the driver (led_str is specified indirectly in the
> + * device tree via "led-sources")
> + */
> +struct arcxcnn_platform_data {
> +	const char *name;
> +	u16 initial_brightness;
> +	u8	led_str;
> +
> +	u8	led_config_0;
> +	u8	led_config_1;
> +	u8	dim_freq;
> +	u8	comp_config;
> +	u8	filter_config;
> +	u8	trim_config;
> +
> +	bool	led_config_0_set;
> +	bool	led_config_1_set;
> +	bool	dim_freq_set;
> +	bool	comp_config_set;
> +	bool	filter_config_set;
> +	bool	trim_config_set;
> +};
> +
> +#endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
