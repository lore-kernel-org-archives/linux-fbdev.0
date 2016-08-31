From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 31 Aug 2016 11:44:03 +0000
Subject: Re: [PATCH] backlight: arcxcc: add support for ArcticSand devices
Message-Id: <20160831114403.GB8649@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471893103-4593-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1471893103-4593-1-git-send-email-olimpiu@arcticsand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Olimpiu Dejeu <olimpiu@arcticsand.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, jg1.han@samsung.com

Jingoo,

Are you still reviewing Backlight patches?

> This is the driver for the Arctic Sand Technologies Inc. ARCXCNN LED
> backlight IC family
>=20
> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
>=20
> ---
>  drivers/video/backlight/Kconfig      |   7 +
>  drivers/video/backlight/Makefile     |   1 +
>  drivers/video/backlight/arcxcnn_bl.c | 510 +++++++++++++++++++++++++++++=
++++++
>  include/linux/i2c/arcxcnn.h          |  42 +++
>  4 files changed, 560 insertions(+)
>  create mode 100644 drivers/video/backlight/arcxcnn_bl.c
>  create mode 100644 include/linux/i2c/arcxcnn.h
>=20
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kc=
onfig
> index 5a3eb2e..19ee87d 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -444,6 +444,13 @@ config BACKLIGHT_BD6107
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
> index bb82002..9d7f3ec 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -53,3 +53,4 @@ obj-$(CONFIG_BACKLIGHT_SAHARA)		+=3D kb3886_bl.o
>  obj-$(CONFIG_BACKLIGHT_TOSA)		+=3D tosa_bl.o
>  obj-$(CONFIG_BACKLIGHT_TPS65217)	+=3D tps65217_bl.o
>  obj-$(CONFIG_BACKLIGHT_WM831X)		+=3D wm831x_bl.o
> +obj-$(CONFIG_BACKLIGHT_ARCXCNN) 	+=3D arcxcnn_bl.o
> diff --git a/drivers/video/backlight/arcxcnn_bl.c b/drivers/video/backlig=
ht/arcxcnn_bl.c
> new file mode 100644
> index 0000000..7adfca3
> --- /dev/null
> +++ b/drivers/video/backlight/arcxcnn_bl.c
> @@ -0,0 +1,510 @@
> +/*
> + * Backlight driver for Arctic Sands ARC_X_C_0N_0N Devices
> + *
> + * Copyright 2016 Arctic Sands Inc.
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
> +static void arcxcnn_pwm_ctrl(struct arcxcnn *lp, int br, int max_br)
> +{
> +	unsigned int period =3D lp->pdata->period_ns;
> +	unsigned int duty =3D br * period / max_br;
> +	struct pwm_device *pwm;
> +
> +	/* request pwm device with the consumer name */
> +	if (!lp->pwm) {
> +		pwm =3D devm_pwm_get(lp->dev, lp->chipname);
> +		if (IS_ERR(pwm))
> +			return;
> +
> +		lp->pwm =3D pwm;
> +	}
> +
> +	pwm_config(lp->pwm, duty, period);
> +	if (duty)
> +		pwm_enable(lp->pwm);
> +	else
> +		pwm_disable(lp->pwm);
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
> +		arcxcnn_pwm_ctrl(lp, brightness, bl->props.max_brightness);
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
> +	return scnprintf(buf, PAGE_SIZE, "%02X\n", lp->pdata->ledstr);
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
> +	if (ledstr !=3D lp->pdata->ledstr) {
> +		/* don't allow 0 for ledstr, use power to turn all off */
> +		if (ledstr =3D 0)
> +			return 0;
> +		lp->pdata->ledstr =3D ledstr & 0x3F;
> +		arcxcnn_update_bit(lp, ARCXCNN_LEDEN,
> +			ARCXCNN_LEDEN_MASK, lp->pdata->ledstr);
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
> +	u32 prog_length, prog_val;
> +
> +	if (!node) {
> +		dev_err(dev, "no platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	of_property_read_string(node, "bl-name", &lp->pdata->name);
> +	of_property_read_u32(node, "init-brt", &prog_val);
> +	lp->pdata->initial_brightness =3D prog_val;
> +	of_property_read_u32(node, "pwm-period", &lp->pdata->period_ns);
> +
> +	if (lp->pdata->initial_brightness > MAX_BRIGHTNESS)
> +		lp->pdata->initial_brightness =3D MAX_BRIGHTNESS;
> +
> +	/* Fill program from platform data if defined
> +	*/
> +	lp->pdata->prog_entries =3D 0;
> +	prog_length =3D of_get_child_count(node);
> +	if (prog_length > 0) {
> +		struct device_node *child;
> +		u32 i =3D 0;
> +
> +		for_each_child_of_node(node, child) {
> +			if (i >=3D ARCXCNN_MAX_PROGENTRIES)
> +				break;
> +			of_property_read_u32(child, "prg-addr", &prog_val);
> +			lp->pdata->prog_addr[i] =3D (u8)prog_val;
> +			of_property_read_u32(child, "prg-data", &prog_val);
> +			lp->pdata->prog_data[i] =3D (u8)prog_val;
> +			i++;
> +		}
> +		lp->pdata->prog_entries =3D i;
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
> +	u32 i;
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
> +			/* no device tree, use defaults based on parms
> +			*/
> +			lp->pdata->name =3D NULL;
> +			lp->pdata->initial_brightness =3D s_ibright;
> +			lp->pdata->ledstr =3D s_iledstr;
> +			lp->pdata->period_ns =3D 0;
> +			lp->pdata->prog_entries =3D 0;
> +
> +			/* example of prog use: uncomment to test
> +			lp->pdata->prog_addr[0] =3D 0x06;
> +			lp->pdata->prog_data[0] =3D 0x15;
> +			lp->pdata->prog_entries =3D 1;
> +			*/
> +		}
> +	}
> +
> +	if (lp->pdata->period_ns > 0)
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
> +	/* enable internal register mode for brightness */
> +	arcxcnn_write_byte(lp, ARCXCNN_ILED_CONFIG, 0x57);
> +
> +	/* set initial LED Strings */
> +	arcxcnn_update_bit(lp, ARCXCNN_LEDEN,
> +		ARCXCNN_LEDEN_MASK, lp->pdata->ledstr);
> +
> +	snprintf(lp->chipname, sizeof(lp->chipname),
> +			"%s-%04X", id->name, chipid);
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
> +	/* playback program now that its all installed */
> +	for (i =3D 0; i < lp->pdata->prog_entries; i++) {
> +		arcxcnn_write_byte(lp, lp->pdata->prog_addr[i],
> +				lp->pdata->prog_data[i]);
> +		/*
> +		printk(KERN_ALERT "%02X, %02X\n",
> +			lp->pdata->prog_addr[i], lp->pdata->prog_data[i]);
> +		*/
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
> +	{ .compatible =3D "arc,arcxcnn" },
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
> +	{"arcxcnn", ARCXCNN},
> +	{"arc2c0608", ARC2C0608},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, arcxcnn_ids);
> +
> +static struct i2c_driver arcxcnn_driver =3D {
> +	.driver =3D {
> +		   .name =3D "arcxcnn",
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
> index 0000000..a9b7922
> --- /dev/null
> +++ b/include/linux/i2c/arcxcnn.h
> @@ -0,0 +1,42 @@
> +/*
> + * Backlight driver for Arctic Sands ARC2C0608 Backlight Devices
> + *
> + * Copyright 2016 Arctic Sands Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#ifndef _ARCXCNN_H
> +#define _ARCXCNN_H
> +
> +enum arcxcnn_chip_id {
> +	ARCXCNN,
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
> + * @period_ns : platform specific pwm period value. unit is nano.
> +		Only valid when mode is PWM_BASED.
> + * @led_str : initial LED string
> + */
> +struct arcxcnn_platform_data {
> +	const char *name;
> +	u16 initial_brightness;
> +	unsigned int period_ns;
> +	u8     ledstr;
> +	u8     prog_addr[ARCXCNN_MAX_PROGENTRIES];
> +	u8     prog_data[ARCXCNN_MAX_PROGENTRIES];
> +	u32    prog_entries;
> +};
> +
> +#endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
