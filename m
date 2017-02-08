From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 08 Feb 2017 17:03:43 +0000
Subject: Re: [PATCH v5 1/2] backlight arcxcnn add support for ArcticSand devices
Message-Id: <e77c8574-d123-fb43-a834-78d3f92e17bd@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1485817292-9415-1-git-send-email-olimpiu@arcticsand.com>
 <a9d6c32b-a8e9-2b09-41f2-faa6a7380795@linaro.org>
 <f59601ea-9055-0d17-71fc-4ded72f22df2@arcticsand.com>
In-Reply-To: <f59601ea-9055-0d17-71fc-4ded72f22df2@arcticsand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Dodge <bdodge@arcticsand.com>, Olimpiu Dejeu <olimpiu@arcticsand.com>, robh@kernel.org
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, jingoohan1@gmail.com, joe@perches.com, medasaro@arcticsand.com

On 08/02/17 15:39, Brian Dodge wrote:
> Hi Daniel,
>
> Thanks for taking the time to review this patch.  The answer to most of
> your comments are that we develop and are developing a whole family of
> backlight controllers and we use this driver a lot for testing.

Even when there is a theme it would be useful to know which comments you 
plan to address and which ones you need or would like to discuss. Only a 
couple of my comments address unexpected user/kernel interfaces.

 > We need
> the ability to reload this module without resetting the hardware for
> development of the module itself as well as the hardware.

Not sure that makes sense from the PoV of testing the module because 
there is a also reset in the module init (meaning it is not possible to 
prevent a reset during an unload/reload based test).


 > We use
> user-space interfaces for testing and copied that ability directly from
> existing backlight drivers already in the kernel which are really the
> only standard we have to go by.

I'm afraid you might have to explain a bit more where your prior art is 
coming from.

There are ~50 existing backlight drivers, only two of these use module 
parameters and neither of those modules use them as you are doing. 
Likewise of the 10 drivers with extra sysfs attributes I can't see one 
that allows its physical topology to be altered from userspace.


> We have already removed a large amount
> of the debugging code from our module but it has become difficult to
> maintain two independent versions of the driver: 1 for dev and 1 for
> mainline. I'd really appreciate your advise on how others handle this
> issue which must be generic.

Excessive debug code in drivers is often caused when existing Linux 
frameworks are not exploited to the max.

For example your driver is (mercifully) free of pr_debug("%s: I got 
called", __function__) trace messages. These messages are fairly rare 
these days since ftrace is more convenient.

In a similar way, perhaps your driver could exploit regmap? That way 
you'd get userspace access to the registers for free (which can be great 
for hardware testing). Note also that regmap uses debugfs for debug 
access, and thus does not raise concerns about odd user/kernel interfaces.


Daniel.


> On 02/08/2017 08:36 AM, Daniel Thompson wrote:
>> On 30/01/17 23:01, Olimpiu Dejeu wrote:
>>> diff --git a/drivers/video/backlight/arcxcnn_bl.c
>>> b/drivers/video/backlight/arcxcnn_bl.c
>>> new file mode 100644
>>> index 0000000..284df08
>>> --- /dev/null
>>> +++ b/drivers/video/backlight/arcxcnn_bl.c
>>> @@ -0,0 +1,451 @@
>>> +/*
>>> + * Backlight driver for ArcticSand ARC_X_C_0N_0N Devices
>>> + *
>>> + * Copyright 2016 ArcticSand, Inc.
>>> + * Author : Brian Dodge <bdodge@arcticsand.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> modify it
>>> + * under the terms of the GNU General Public License version 2
>>> + * as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful, but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + * General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> along
>>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#include <linux/backlight.h>
>>> +#include <linux/err.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#include "linux/i2c/arcxcnn.h"
>>> +
>>> +#define ARCXCNN_CMD        0x00    /* Command Register */
>>> +#define ARCXCNN_CMD_STDBY    0x80    /*   I2C Standby */
>>> +#define ARCXCNN_CMD_RESET    0x40    /*   Reset */
>>> +#define ARCXCNN_CMD_BOOST    0x10    /*   Boost */
>>> +#define ARCXCNN_CMD_OVP_MASK    0x0C    /*   --- Over Voltage
>>> Threshold */
>>> +#define ARCXCNN_CMD_OVP_XXV    0x0C    /*   <rsvrd> Over Voltage
>>> Threshold */
>>> +#define ARCXCNN_CMD_OVP_20V    0x08    /*   20v Over Voltage
>>> Threshold */
>>> +#define ARCXCNN_CMD_OVP_24V    0x04    /*   24v Over Voltage
>>> Threshold */
>>> +#define ARCXCNN_CMD_OVP_31V    0x00    /*   31.4v Over Voltage
>>> Threshold */
>>> +#define ARCXCNN_CMD_EXT_COMP    0x01    /*   part (0) or full (1)
>>> ext. comp */
>>> +
>>> +#define ARCXCNN_CONFIG        0x01    /* Configuration */
>>> +#define ARCXCNN_STATUS1        0x02    /* Status 1 */
>>> +#define ARCXCNN_STATUS2        0x03    /* Status 2 */
>>> +#define ARCXCNN_FADECTRL    0x04    /* Fading Control */
>>> +#define ARCXCNN_ILED_CONFIG    0x05    /* ILED Configuration */
>>> +#define ARCXCNN_ILED_DIM_PWM    0x00    /*   config dim mode pwm */
>>> +#define ARCXCNN_ILED_DIM_INT    0x04    /*   config dim mode
>>> internal */
>>> +#define ARCXCNN_LEDEN        0x06    /* LED Enable Register */
>>> +#define ARCXCNN_LEDEN_ISETEXT    0x80    /*   Full-scale current set
>>> extern */
>>> +#define ARCXCNN_LEDEN_MASK    0x3F    /*   LED string enables mask */
>>> +#define ARCXCNN_LEDEN_BITS    0x06    /*   Bits of LED string
>>> enables */
>>> +#define ARCXCNN_LEDEN_LED1    0x01
>>> +#define ARCXCNN_LEDEN_LED2    0x02
>>> +#define ARCXCNN_LEDEN_LED3    0x04
>>> +#define ARCXCNN_LEDEN_LED4    0x08
>>> +#define ARCXCNN_LEDEN_LED5    0x10
>>> +#define ARCXCNN_LEDEN_LED6    0x20
>>> +
>>> +#define ARCXCNN_WLED_ISET_LSB    0x07    /* LED ISET LSB (in upper
>>> nibble) */
>>> +#define ARCXCNN_WLED_ISET_LSB_SHIFT 0x04  /* ISET LSB Left Shift */
>>> +#define ARCXCNN_WLED_ISET_MSB    0x08    /* LED ISET MSB (8 bits) */
>>> +
>>> +#define ARCXCNN_DIMFREQ        0x09
>>> +#define ARCXCNN_COMP_CONFIG    0x0A
>>> +#define ARCXCNN_FILT_CONFIG    0x0B
>>> +#define ARCXCNN_IMAXTUNE    0x0C
>>> +#define ARCXCNN_ID_MSB        0x1E
>>> +#define ARCXCNN_ID_LSB        0x1F
>>> +
>>> +#define MAX_BRIGHTNESS        4095
>>> +
>>> +static int no_reset_on_remove;
>>> +module_param_named(noreset, no_reset_on_remove, int, 0644);
>>> +MODULE_PARM_DESC(noreset, "No reset on module removal");
>>> +
>>> +static int ibright = 60;
>>> +module_param_named(ibright, ibright, int, 0644);
>>
>> Use module_param() when names match.
>>
>>> +MODULE_PARM_DESC(ibright, "Initial brightness (when no plat data)");
>>
>> When will there be no platform data. Hotpluggable I2C backlight
>> controllers aren't very common.
>>
>> Also, if this *is* needed, shouldn't the permissions should be 0444?
>>
>>> +
>>> +static int ileden = ARCXCNN_LEDEN_MASK;
>>> +module_param_named(ileden, ileden, int, 0644);
>>> +MODULE_PARM_DESC(ileden, "Initial LED String Enables (when no plat
>>> data)");
>>
>> Both, as above.
>>
>>> +
>>> +struct arcxcnn {
>>> +    char chipname[64];
>>
>> This is more than double the size required. Actually if the chipid is
>> useful to userspace it should be stored numerically.
>>
>>> +    struct i2c_client *client;
>>> +    struct backlight_device *bl;
>>> +    struct device *dev;
>>> +    struct arcxcnn_platform_data *pdata;
>>> +};
>>> +
>>> +static int arcxcnn_update_bit(struct arcxcnn *lp, u8 reg, u8 mask,
>>> u8 data)
>>
>> s/_bit/_field/
>>
>>> +{
>>> +    int ret;
>>> +    u8 tmp;
>>> +
>>> +    ret = i2c_smbus_read_byte_data(lp->client, reg);
>>> +    if (ret < 0) {
>>> +        dev_err(lp->dev, "failed to read 0x%.2x\n", reg);
>>> +        return ret;
>>> +    }
>>> +
>>> +    tmp = (u8)ret;
>>> +    tmp &= ~mask;
>>> +    tmp |= data & mask;
>>> +
>>> +    return i2c_smbus_write_byte_data(lp->client, reg, tmp);
>>> +}
>>> +
>>> +static int arcxcnn_set_brightness(struct arcxcnn *lp, u32 brightness)
>>> +{
>>> +    int ret;
>>> +    u8 val;
>>> +
>>> +    /* lower nibble of brightness goes in upper nibble of LSB
>>> register */
>>> +    val = (brightness & 0xF) << ARCXCNN_WLED_ISET_LSB_SHIFT;
>>> +    ret = i2c_smbus_write_byte_data(lp->client,
>>> ARCXCNN_WLED_ISET_LSB, val);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    /* remaining 8 bits of brightness go in MSB register */
>>> +    val = (brightness >> 4);
>>> +    ret = i2c_smbus_write_byte_data(lp->client,
>>> ARCXCNN_WLED_ISET_MSB, val);
>>> +
>>> +    return ret;
>>
>> This can be a direct return from _write_byte_data.
>>
>>> +}
>>> +
>>> +static int arcxcnn_bl_update_status(struct backlight_device *bl)
>>> +{
>>> +    struct arcxcnn *lp = bl_get_data(bl);
>>> +    u32 brightness = bl->props.brightness;
>>> +
>>> +    if (bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
>>> +        brightness = 0;
>>> +
>>> +    arcxcnn_set_brightness(lp, brightness);
>>
>> Return code is ignored here...
>>
>>> +
>>> +    /* set power-on/off/save modes */
>>> +    arcxcnn_update_bit(lp, ARCXCNN_CMD, ARCXCNN_CMD_STDBY,
>>> +        (bl->props.power = 0) ? 0 : ARCXCNN_CMD_STDBY);
>>
>> ... and here.
>>
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct backlight_ops arcxcnn_bl_ops = {
>>> +    .options = BL_CORE_SUSPENDRESUME,
>>> +    .update_status = arcxcnn_bl_update_status,
>>> +};
>>> +
>>> +static int arcxcnn_backlight_register(struct arcxcnn *lp)
>>> +{
>>> +    struct backlight_properties *props;
>>> +    const char *name = lp->pdata->name ? : "arctic_bl";
>>> +
>>> +    props = devm_kzalloc(lp->dev, sizeof(*props), GFP_KERNEL);
>>> +    if (!props)
>>> +        return -ENOMEM;
>>> +
>>> +    props->type = BACKLIGHT_PLATFORM;
>>> +    props->max_brightness = MAX_BRIGHTNESS;
>>> +
>>> +    if (lp->pdata->initial_brightness > props->max_brightness)
>>> +        lp->pdata->initial_brightness = props->max_brightness;
>>> +
>>> +    props->brightness = lp->pdata->initial_brightness;
>>> +
>>> +    lp->bl = devm_backlight_device_register(lp->dev, name, lp->dev, lp,
>>> +                       &arcxcnn_bl_ops, props);
>>> +    if (IS_ERR(lp->bl))
>>> +        return PTR_ERR(lp->bl);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static ssize_t arcxcnn_chip_id_show(struct device *dev,
>>> +        struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct arcxcnn *lp = dev_get_drvdata(dev);
>>> +
>>> +    return scnprintf(buf, PAGE_SIZE, "%s\n", lp->chipname);
>>> +}
>>> +
>>> +static ssize_t arcxcnn_leden_show(struct device *dev,
>>> +        struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct arcxcnn *lp = dev_get_drvdata(dev);
>>> +
>>> +    return scnprintf(buf, PAGE_SIZE, "%02X\n", lp->pdata->leden);
>>> +}
>>> +
>>> +static ssize_t arcxcnn_leden_store(struct device *dev,
>>> +        struct device_attribute *attr, const char *buf, size_t len)
>>
>> Under what circumstances can the led-sources change at runtime and
>> motivate this kind of interface?
>>
>>> +{
>>> +    struct arcxcnn *lp = dev_get_drvdata(dev);
>>> +    unsigned long leden;
>>> +
>>> +    if (kstrtoul(buf, 0, &leden))
>>> +        return 0;
>>> +
>>> +    if (leden != lp->pdata->leden) {
>>> +        /* don't allow 0 for leden, use power to turn all off */
>>> +        if (leden = 0)
>>> +            return -EINVAL;
>>> +        lp->pdata->leden = leden & ARCXCNN_LEDEN_MASK;
>>> +        arcxcnn_update_bit(lp, ARCXCNN_LEDEN,
>>> +            ARCXCNN_LEDEN_MASK, lp->pdata->leden);
>>
>> Should be a return (to pass the error code back).
>>
>>> +    }
>>> +
>>> +    return len;
>>> +}
>>> +
>>> +static DEVICE_ATTR(chip_id, 0444, arcxcnn_chip_id_show, NULL);
>>> +static DEVICE_ATTR(leden, 0664, arcxcnn_leden_show,
>>> arcxcnn_leden_store);
>>> +
>>> +static struct attribute *arcxcnn_attributes[] = {
>>> +    &dev_attr_chip_id.attr,
>>> +    &dev_attr_leden.attr,
>>> +    NULL,
>>> +};
>>> +
>>> +static const struct attribute_group arcxcnn_attr_group = {
>>> +    .attrs = arcxcnn_attributes,
>>> +};
>>> +
>>> +static void arcxcnn_parse_dt(struct arcxcnn *lp)
>>> +{
>>> +    struct device *dev = lp->dev;
>>> +    struct device_node *node = dev->of_node;
>>> +    u32 prog_val, num_entry, entry, sources[ARCXCNN_LEDEN_BITS];
>>> +    int ret;
>>> +
>>> +    /* device tree entry isn't required, defaults are OK */
>>> +    if (!node)
>>> +        return;
>>> +
>>> +    ret = of_property_read_string(node, "label", &lp->pdata->name);
>>> +    if (ret < 0)
>>> +        lp->pdata->name = NULL;
>>> +
>>> +    ret = of_property_read_u32(node, "default-brightness", &prog_val);
>>> +    if (ret = 0)
>>> +        lp->pdata->initial_brightness = prog_val;
>>> +
>>> +    ret = of_property_read_u32(node, "arc,led-config-0", &prog_val);
>>> +    if (ret = 0)
>>> +        lp->pdata->led_config_0 = (u8)prog_val;
>>> +
>>> +    ret = of_property_read_u32(node, "arc,led-config-1", &prog_val);
>>> +    if (ret = 0)
>>> +        lp->pdata->led_config_1 = (u8)prog_val;
>>> +
>>> +    ret = of_property_read_u32(node, "arc,dim-freq", &prog_val);
>>> +    if (ret = 0)
>>> +        lp->pdata->dim_freq = (u8)prog_val;
>>> +
>>> +    ret = of_property_read_u32(node, "arc,comp-config", &prog_val);
>>> +    if (ret = 0)
>>> +        lp->pdata->comp_config = (u8)prog_val;
>>> +
>>> +    ret = of_property_read_u32(node, "arc,filter-config", &prog_val);
>>> +    if (ret = 0)
>>> +        lp->pdata->filter_config = (u8)prog_val;
>>> +
>>> +    ret = of_property_read_u32(node, "arc,trim-config", &prog_val);
>>> +    if (ret = 0)
>>> +        lp->pdata->trim_config = (u8)prog_val;
>>> +
>>> +    ret = of_property_count_u32_elems(node, "led-sources");
>>> +    if (ret < 0) {
>>> +        lp->pdata->leden = ARCXCNN_LEDEN_MASK; /* all on is default */
>>> +    } else {
>>> +        num_entry = ret;
>>> +        if (num_entry > ARCXCNN_LEDEN_BITS)
>>> +            num_entry = ARCXCNN_LEDEN_BITS;
>>> +
>>> +        ret = of_property_read_u32_array(node, "led-sources", sources,
>>> +                    num_entry);
>>> +        if (ret < 0) {
>>> +            dev_err(dev, "led-sources node is invalid.\n");
>>> +            return;
>>> +        }
>>> +
>>> +        lp->pdata->leden = 0;
>>> +
>>> +        /* for each enable in source, set bit in led enable */
>>> +        for (entry = 0; entry < num_entry; entry++) {
>>> +            u8 onbit = 1 << sources[entry];
>>> +            lp->pdata->leden |= onbit;
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +static int arcxcnn_probe(struct i2c_client *cl, const struct
>>> i2c_device_id *id)
>>> +{
>>> +    struct arcxcnn *lp;
>>> +    int ret;
>>> +    u8 regval;
>>> +    u16 chipid;
>>> +
>>> +    if (!i2c_check_functionality(cl->adapter,
>>> I2C_FUNC_SMBUS_BYTE_DATA))
>>> +        return -EIO;
>>> +
>>> +    lp = devm_kzalloc(&cl->dev, sizeof(*lp), GFP_KERNEL);
>>> +    if (!lp)
>>> +        return -ENOMEM;
>>> +
>>> +    lp->client = cl;
>>> +    lp->dev = &cl->dev;
>>> +    lp->pdata = dev_get_platdata(&cl->dev);
>>> +
>>> +    /* reset the device */
>>> +    i2c_smbus_write_byte_data(lp->client,
>>> +        ARCXCNN_CMD, ARCXCNN_CMD_RESET);
>>> +
>>> +    /* read device ID */
>>> +    regval = i2c_smbus_read_byte_data(lp->client, ARCXCNN_ID_MSB);
>>> +    chipid = regval;
>>> +    chipid <<= 8;
>>> +
>>> +    regval = i2c_smbus_read_byte_data(lp->client, ARCXCNN_ID_LSB);
>>> +    chipid |= regval;
>>> +
>>> +    snprintf(lp->chipname, sizeof(lp->chipname),
>>> +        "%s-%04X", id->name, chipid);
>>
>> I'm curious what the chip id is and why the id is a userspace concern
>> rather than something the *driver* uses to confirm the probe is correct.
>>
>>> +
>>> +    if (!lp->pdata) {
>>> +        lp->pdata = devm_kzalloc(lp->dev,
>>> +                sizeof(*lp->pdata), GFP_KERNEL);
>>> +        if (!lp->pdata)
>>> +            return -ENOMEM;
>>> +
>>> +        /* Setup defaults based on power-on defaults */
>>> +        lp->pdata->name = NULL;
>>> +        lp->pdata->initial_brightness = ibright;
>>> +        lp->pdata->leden = ileden;
>>> +
>>> +        lp->pdata->led_config_0 = i2c_smbus_read_byte_data(
>>> +            lp->client, ARCXCNN_FADECTRL);
>>> +
>>> +        lp->pdata->led_config_1 = i2c_smbus_read_byte_data(
>>> +            lp->client, ARCXCNN_ILED_CONFIG);
>>> +        /* insure dim mode is not default pwm */
>>> +        lp->pdata->led_config_1 |= ARCXCNN_ILED_DIM_INT;
>>> +
>>> +        lp->pdata->dim_freq = i2c_smbus_read_byte_data(
>>> +            lp->client, ARCXCNN_DIMFREQ);
>>> +
>>> +        lp->pdata->comp_config = i2c_smbus_read_byte_data(
>>> +            lp->client, ARCXCNN_COMP_CONFIG);
>>> +
>>> +        lp->pdata->filter_config = i2c_smbus_read_byte_data(
>>> +            lp->client, ARCXCNN_FILT_CONFIG);
>>> +
>>> +        lp->pdata->trim_config = i2c_smbus_read_byte_data(
>>> +            lp->client, ARCXCNN_IMAXTUNE);
>>> +
>>> +        if (IS_ENABLED(CONFIG_OF))
>>> +            arcxcnn_parse_dt(lp);
>>> +    }
>>> +
>>> +    i2c_set_clientdata(cl, lp);
>>> +
>>> +    /* constrain settings to what is possible */
>>> +    if (lp->pdata->initial_brightness > MAX_BRIGHTNESS)
>>> +        lp->pdata->initial_brightness = MAX_BRIGHTNESS;
>>> +
>>> +    /* set initial brightness */
>>> +    arcxcnn_set_brightness(lp, lp->pdata->initial_brightness);
>>> +
>>> +    /* set other register values directly */
>>> +    i2c_smbus_write_byte_data(lp->client, ARCXCNN_FADECTRL,
>>> +        lp->pdata->led_config_0);
>>> +    i2c_smbus_write_byte_data(lp->client, ARCXCNN_ILED_CONFIG,
>>> +        lp->pdata->led_config_1);
>>> +    i2c_smbus_write_byte_data(lp->client, ARCXCNN_DIMFREQ,
>>> +        lp->pdata->dim_freq);
>>> +    i2c_smbus_write_byte_data(lp->client, ARCXCNN_COMP_CONFIG,
>>> +        lp->pdata->comp_config);
>>> +    i2c_smbus_write_byte_data(lp->client, ARCXCNN_FILT_CONFIG,
>>> +        lp->pdata->filter_config);
>>> +    i2c_smbus_write_byte_data(lp->client, ARCXCNN_IMAXTUNE,
>>> +        lp->pdata->trim_config);
>>> +
>>> +    /* set initial LED Enables */
>>> +    arcxcnn_update_bit(lp, ARCXCNN_LEDEN,
>>> +        ARCXCNN_LEDEN_MASK, lp->pdata->leden);
>>
>> Pretty much *all* of the above functions return error codes.
>>
>>> +    ret = arcxcnn_backlight_register(lp);
>>> +    if (ret) {
>>> +        dev_err(lp->dev,
>>> +            "failed to register backlight. err: %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret = sysfs_create_group(&lp->dev->kobj, &arcxcnn_attr_group);
>>> +    if (ret) {
>>> +        dev_err(lp->dev, "failed to register sysfs. err: %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    backlight_update_status(lp->bl);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int arcxcnn_remove(struct i2c_client *cl)
>>> +{
>>> +    struct arcxcnn *lp = i2c_get_clientdata(cl);
>>> +
>>> +    if (!no_reset_on_remove) {
>>> +        /* disable all strings */
>>> +        i2c_smbus_write_byte_data(lp->client,
>>> +            ARCXCNN_LEDEN, 0x00);
>>> +        /* reset the device */
>>> +        i2c_smbus_write_byte_data(lp->client,
>>> +            ARCXCNN_CMD, ARCXCNN_CMD_RESET);
>>> +    }
>>
>> Why would userspace want to suppress this reset?
>>
>>
>>> +    lp->bl->props.brightness = 0;
>>> +
>>> +    backlight_update_status(lp->bl);
>>> +
>>> +    sysfs_remove_group(&lp->dev->kobj, &arcxcnn_attr_group);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct of_device_id arcxcnn_dt_ids[] = {
>>> +    { .compatible = "arc,arc2c0608" },
>>> +    { }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, arcxcnn_dt_ids);
>>> +
>>> +static const struct i2c_device_id arcxcnn_ids[] = {
>>> +    {"arc2c0608", ARC2C0608},
>>> +    { }
>>> +};
>>> +MODULE_DEVICE_TABLE(i2c, arcxcnn_ids);
>>> +
>>> +static struct i2c_driver arcxcnn_driver = {
>>> +    .driver = {
>>> +        .name = "arcxcnn_bl",
>>> +        .of_match_table = of_match_ptr(arcxcnn_dt_ids),
>>> +    },
>>> +    .probe = arcxcnn_probe,
>>> +    .remove = arcxcnn_remove,
>>> +    .id_table = arcxcnn_ids,
>>> +};
>>> +module_i2c_driver(arcxcnn_driver);
>>> +
>>> +MODULE_LICENSE("GPL v2");
>>> +MODULE_AUTHOR("Brian Dodge <bdodge@arcticsand.com>");
>>> +MODULE_DESCRIPTION("ARCXCNN Backlight driver");
>>> diff --git a/include/linux/i2c/arcxcnn.h b/include/linux/i2c/arcxcnn.h
>>> new file mode 100644
>>> index 0000000..e378d63
>>> --- /dev/null
>>> +++ b/include/linux/i2c/arcxcnn.h
>>
>> There's a general trend to move unused header files out of this
>> directory and fold things back into the C code.
>>
>> Are you expecting to add anything to the kernel (other than the
>> driver) that actually includes this header, if not we probably don't
>> need it.
>>
>>
>> Daniel.
>

