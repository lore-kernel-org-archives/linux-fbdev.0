Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9018921CC58
	for <linux-fbdev@vger.kernel.org>; Fri,  7 Nov 2025 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531948; cv=none; b=oMm9kIQGUQokAjryP/EB6/lp/qaKZ2AMK+HxaGnXbRuu6rohcfaxidSMLaG8lHhvsDhsjbXcNOKOHnZvP+5MWlFLoR1ghfAPcB+UDGoy4UPtXlZFOuusD5FuDoc+hj5NYG7ODqioksm9Q2/oJOsrwSJOy55nwkF7aoPNlLpguNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531948; c=relaxed/simple;
	bh=e1BqN2xUtIgwvbFQi+eIxxSm5aSMM2ruQwQa3oEQ9/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXg5nHQxBwsaz3cNJTGC8ZHwTgi7XHsKwBZg50lIGqUyO7XtlyGsAUt0Uc2sor5eHpS3qjDFbNl5akx4tB1NbR39wWIBJq1WvHAK363WlWn9QUpL9LXQ+7AflKsNuqFpamm31bIh181dNLkLSi1jLAk7DSDZZzLplbrl1i9xmpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=yy2gdQ6o; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="yy2gdQ6o"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-427007b1fe5so526913f8f.1
        for <linux-fbdev@vger.kernel.org>; Fri, 07 Nov 2025 08:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762531943; x=1763136743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4I9Nmi0x1XRh5MmNss3uO6kHDeCcgFZXdE1zsROAGYg=;
        b=yy2gdQ6ok+pIyaUKSx4p1de4Yk4FihWddQn7zX1byh4z/5qez7TXR38W4i27pvMfkj
         L/YXO7a8h7NNpfOTA0qCptZ8tJuM1C6mENr+D1So8loNIfIaJTG2HmVW9F8ITMuvELLN
         EXX54gLWKwCaeikHAmDQ//mFExh7IlndKFASAWdv65PDVuIAgjTpxeFewNRbqX5AHEDL
         6rIokXUZKyUgw6Ecl7dlbKo2mp2ypmJken2vkO5QJkZ9ZfgRvmkEnMxSZ2ZJmCl/u7yj
         2TrqkjhYXHoPb+J6THq+zXFSJzzL8z2HF8hPcx0j31aPDI+A392JT55Cnl9BrE2QoOk1
         RpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531943; x=1763136743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4I9Nmi0x1XRh5MmNss3uO6kHDeCcgFZXdE1zsROAGYg=;
        b=YEWx4CPeIyeSEZSgncQ0XFz7q6zpZQGmaxeWesJ144JfGFKHNR/KOq4pV9cZ/X1EQp
         MLJTflpjUhRUi2HUp2BAJ7kP0URL5SvKO4DxrzqXllRCAT94pNMpwV5BMjYIvtjUlLWp
         kkOyVW5TKVyFneIGhB2jkUzoXQ26sR1YUqET3qACZPGi0AFyA7qgznTKRDtZQOOK6i+I
         VIC7NNSXP1y9Vt1W6vXrScPS9JSZryeueih2dREeTmyyQnq8KB4dgeB/wBhGNZTFGTFH
         j4FdDiL3njs3rUUGcQMwpGgPobhfZdkQ/R9GGMDKeBL0jqHGInjKCaZytz3Nm5etw7PY
         FJkg==
X-Forwarded-Encrypted: i=1; AJvYcCW5sTfuQ+inLWXrPBF/3wNfGT88MSsgybnH+d2AaI6WdDQ4L3SCftb+vlF4suKlmMj9oU0a5CeJoxlGug==@vger.kernel.org
X-Gm-Message-State: AOJu0YypRSI7CIooViwuk2o5692nDb+dj+wTO9q30lcrJP4tNX/mL+um
	9f1h32B2r+tMP03pdPVnFvedtLy37rkj57tGTHEWWrTMXGiP5BgOvrrTqNLutCBMx9U=
X-Gm-Gg: ASbGnctwHd82A0kt9hukrdyylvyjBxbWtHwVndhElbTUgsR4So2W7Lw4L99/w/FwN41
	ycLM9RrQoaHaRWSe54PsohgD63lDlKXXxjFa/Dv3dbZJkAcDgm0xhReQkpbmy0ZT8MFnxs6+wZB
	AgvjhekXX4rVssvrA0B+xgvJ9oAFE36MblVvGJnH4upGUPBB0wohNkzkwf1XftpUGKVdodZf28e
	+nJFuH3zMK3U/5wHiJkOb+obBNPGUmjXU85Fvz7Lu3mZLcIvF5qubAlTZ3ZNPNcwbM7Z9yFiBfM
	9mpTdwYMQ9wMqMe3ZoAzB970loEJeMrtaGELyJIZHjLJow/GG5t05OsCumipOBBP7y6TITzVGYS
	MMn1Dc6Z8kri0fKPuuoeJUUk3qT7WLv4uzOkxQxK+1DEU5qCQlGgS1P158pLauCs9sA4KWUYISu
	mo6Hhu8w5O1QUsPxCiIs7hK7o/6+zhHhjMFgH9D8LnXE8xDYsZwE12qHWhkMg=
X-Google-Smtp-Source: AGHT+IGHroTzRo1cJ44LOHTxL+NRy7sTi9c/ImeIIStaKdw3lsU0/qp1TjSL/vM3MWErBezrq59Q0A==
X-Received: by 2002:a05:6000:1884:b0:429:cbba:b247 with SMTP id ffacd0b85a97d-42ae58d03b4mr3192709f8f.23.1762531942614;
        Fri, 07 Nov 2025 08:12:22 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b23csm6015125f8f.10.2025.11.07.08.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:12:21 -0800 (PST)
Date: Fri, 7 Nov 2025 16:14:17 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: maudspierings@gocontroll.com
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] backlight: add max25014atg backlight
Message-ID: <aQ4a2SBDldYgQb56@aspen.lan>
References: <20251107-max25014-v5-0-9a6aa57306bf@gocontroll.com>
 <20251107-max25014-v5-2-9a6aa57306bf@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-max25014-v5-2-9a6aa57306bf@gocontroll.com>

On Fri, Nov 07, 2025 at 01:49:59PM +0100, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
>
> The Maxim MAX25014 is a 4-channel automotive grade backlight driver IC
> with integrated boost controller.
>
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> diff --git a/drivers/video/backlight/max25014.c b/drivers/video/backlight/max25014.c
> new file mode 100644
> index 000000000000..36bae508697e
> --- /dev/null
> +++ b/drivers/video/backlight/max25014.c
> @@ -0,0 +1,409 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Backlight driver for Maxim MAX25014
> + *
> + * Copyright (C) 2025 GOcontroll B.V.
> + * Author: Maud Spierings <maudspierings@gocontroll.com>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define MAX25014_ISET_DEFAULT_100 11
> +#define MAX_BRIGHTNESS            100
> +#define MIN_BRIGHTNESS            0
> +#define TON_MAX                   130720 /* @153Hz */
> +#define TON_STEP                  1307 /* @153Hz */
> +#define TON_MIN                   0
> +
> +#define MAX25014_DEV_ID           0x00
> +#define MAX25014_REV_ID           0x01
> +#define MAX25014_ISET             0x02
> +#define MAX25014_IMODE            0x03
> +#define MAX25014_TON1H            0x04
> +#define MAX25014_TON1L            0x05
> +#define MAX25014_TON2H            0x06
> +#define MAX25014_TON2L            0x07
> +#define MAX25014_TON3H            0x08
> +#define MAX25014_TON3L            0x09
> +#define MAX25014_TON4H            0x0A
> +#define MAX25014_TON4L            0x0B
> +#define MAX25014_TON_1_4_LSB      0x0C
> +#define MAX25014_SETTING          0x12
> +#define MAX25014_DISABLE          0x13
> +#define MAX25014_BSTMON           0x14
> +#define MAX25014_IOUT1            0x15
> +#define MAX25014_IOUT2            0x16
> +#define MAX25014_IOUT3            0x17
> +#define MAX25014_IOUT4            0x18
> +#define MAX25014_OPEN             0x1B
> +#define MAX25014_SHORT_GND        0x1C
> +#define MAX25014_SHORT_LED        0x1D
> +#define MAX25014_MASK             0x1E
> +#define MAX25014_DIAG             0x1F
> +
> +#define MAX25014_IMODE_HDIM       BIT(2)
> +#define MAX25014_ISET_ENABLE      BIT(5)
> +#define MAX25014_ISET_PSEN        BIT(4)
> +#define MAX25014_DIAG_HW_RST      BIT(2)
> +#define MAX25014_SETTING_FPWM     GENMASK(6, 4)
> +
> +struct max25014 {
> +	struct i2c_client *client;
> +	struct backlight_device *bl;
> +	struct regmap *regmap;
> +	struct gpio_desc *enable;
> +	struct regulator *vin; /* regulator for boost converter Vin rail */
> +	uint32_t iset;
> +	uint8_t strings_mask;
> +};
> +
> +static const struct regmap_config max25014_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MAX25014_DIAG,
> +};
> +
> +/**
> + * @brief control the brightness with i2c registers
> + *
> + * @param regmap trivial
> + * @param brt brightness
> + * @return int
> + */
> +static int max25014_register_control(struct regmap *regmap, uint32_t brt)

This isn't a good name for a function. It doesn't really say what it
does. Please find a more descriptive name.


> +{
> +	uint32_t reg = TON_STEP * brt;
> +	int ret;
> +	/*
> +	 * 18 bit number lowest, 2 bits in first register,
> +	 * next lowest 8 in the L register, next 8 in the H register
> +	 * Seemingly setting the strength of only one string controls all of
> +	 * them, individual settings don't affect the outcome.
> +	 */
> +
> +	ret = regmap_write(regmap, MAX25014_TON_1_4_LSB, reg & 0b00000011);
> +	if (ret != 0)
> +		return ret;
> +	ret = regmap_write(regmap, MAX25014_TON1L, (reg >> 2) & 0b11111111);
> +	if (ret != 0)
> +		return ret;
> +	return regmap_write(regmap, MAX25014_TON1H, (reg >> 10) & 0b11111111);
> +}
> +
> +static int max25014_check_errors(struct max25014 *maxim)
> +{
> +	uint8_t i;
> +	int ret;
> +	uint32_t val;
> +
> +	ret = regmap_read(maxim->regmap, MAX25014_OPEN, &val);
> +	if (ret != 0)
> +		return ret;
> +	if (val > 0) {
> +		dev_err(&maxim->client->dev, "Open led strings detected on:\n");
> +		for (i = 0; i < 4; i++) {
> +			if (val & 1 << i)
> +				dev_err(&maxim->client->dev, "string %d\n", i + 1);
> +		}
> +		return -EIO;
> +	}
> +
> +	ret = regmap_read(maxim->regmap, MAX25014_SHORT_GND, &val);
> +	if (ret != 0)
> +		return ret;
> +	if (val > 0) {
> +		dev_err(&maxim->client->dev, "Short to ground detected on:\n");
> +		for (i = 0; i < 4; i++) {
> +			if (val & 1 << i)
> +				dev_err(&maxim->client->dev, "string %d\n", i + 1);
> +		}
> +		return -EIO;
> +	}
> +
> +	ret = regmap_read(maxim->regmap, MAX25014_SHORT_GND, &val);
> +	if (ret != 0)
> +		return ret;
> +	if (val > 0) {
> +		dev_err(&maxim->client->dev, "Shorted led detected on:\n");
> +		for (i = 0; i < 4; i++) {
> +			if (val & 1 << i)
> +				dev_err(&maxim->client->dev, "string %d\n", i + 1);
> +		}
> +		return -EIO;
> +	}
> +
> +	ret = regmap_read(maxim->regmap, MAX25014_DIAG, &val);
> +	if (ret != 0)
> +		return ret;
> +	/*
> +	 * The HW_RST bit always starts at 1 after power up.
> +	 * It is reset on first read, does not indicate an error.
> +	 */
> +	if (val > 0 && val != MAX25014_DIAG_HW_RST) {
> +		if (val & 0b1)
> +			dev_err(&maxim->client->dev,
> +				"Overtemperature shutdown\n");
> +		if (val & 0b10)
> +			dev_err(&maxim->client->dev,
> +				 "Chip is getting too hot (>125C)\n");
> +		if (val & 0b1000)
> +			dev_err(&maxim->client->dev,
> +				"Boost converter overvoltage\n");
> +		if (val & 0b10000)
> +			dev_err(&maxim->client->dev,
> +				"Boost converter undervoltage\n");
> +		if (val & 0b100000)
> +			dev_err(&maxim->client->dev, "IREF out of range\n");
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * 1. disable unused strings
> + * 2. set dim mode
> + * 3. set initial brightness

How does this code set the initial brightness? It doens't set the
MAX25014_TON* registers.


> + * 4. set setting register
> + * 5. enable the backlight
> + */
> +static int max25014_configure(struct max25014 *maxim)
> +{
> +	int ret;
> +	uint32_t val;
> +
> +	ret = regmap_write(maxim->regmap, MAX25014_DISABLE,
> +			   maxim->strings_mask);
> +	if (ret != 0)
> +		return ret;
> +
> +	ret = regmap_write(maxim->regmap, MAX25014_IMODE, MAX25014_IMODE_HDIM);
> +	if (ret != 0)
> +		return ret;
> +
> +	ret = regmap_read(maxim->regmap, MAX25014_SETTING, &val);
> +	if (ret != 0)
> +		return ret;
> +
> +	ret = regmap_write(maxim->regmap, MAX25014_SETTING,
> +			   val & ~MAX25014_SETTING_FPWM);
> +	if (ret != 0)
> +		return ret;
> +
> +	ret = regmap_write(maxim->regmap, MAX25014_ISET,
> +			   maxim->iset | MAX25014_ISET_ENABLE |
> +			   MAX25014_ISET_PSEN);
> +	return ret;
> +}
> +
> +static int max25014_update_status(struct backlight_device *bl_dev)
> +{
> +	struct max25014 *maxim = bl_get_data(bl_dev);
> +
> +	if (backlight_is_blank(maxim->bl))
> +		bl_dev->props.brightness = 0;
> +
> +	return max25014_register_control(maxim->regmap,
> +					 bl_dev->props.brightness);
> +}
> +
> +static const struct backlight_ops max25014_bl_ops = {
> +	.options = BL_CORE_SUSPENDRESUME,
> +	.update_status = max25014_update_status,
> +};
> +
> +static int max25014_parse_dt(struct max25014 *maxim,
> +			     uint32_t *initial_brightness)
> +{
> +	struct device *dev = &maxim->client->dev;
> +	struct device_node *node = dev->of_node;
> +	struct fwnode_handle *child;
> +	uint32_t strings[4];
> +	int res, i;
> +
> +	if (!node) {
> +		dev_err(dev, "no platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	child = device_get_next_child_node(dev, NULL);
> +	if (child) {
> +		res = fwnode_property_count_u32(child, "led-sources");
> +		if (res > 0) {
> +			fwnode_property_read_u32_array(child, "led-sources",
> +						       strings, res);
> +
> +			/* set all strings as disabled, then enable those in led-sources*/
> +			maxim->strings_mask = 0xf;
> +			for (i = 0; i < res; i++) {
> +				if (strings[i] <= 4)
> +					maxim->strings_mask &= ~BIT(strings[i]);
> +			}
> +		}
> +
> +		fwnode_property_read_u32(child, "default-brightness",
> +					 initial_brightness);
> +
> +		fwnode_handle_put(child);
> +	}
> +
> +	maxim->iset = MAX25014_ISET_DEFAULT_100;
> +	of_property_read_u32(node, "maxim,iset", &maxim->iset);
> +
> +	if (maxim->iset < 0 || maxim->iset > 15) {
> +		dev_err(dev,
> +			"Invalid iset, should be a value from 0-15, entered was %d\n",
> +			maxim->iset);
> +		return -EINVAL;
> +	}
> +
> +	if (*initial_brightness < 0 || *initial_brightness > 100) {
> +		dev_err(dev,
> +			"Invalid initial brightness, should be a value from 0-100, entered was %d\n",
> +			*initial_brightness);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max25014_probe(struct i2c_client *cl)
> +{
> +	struct backlight_device *bl;
> +	const struct i2c_device_id *id = i2c_client_get_device_id(cl);
> +	struct max25014 *maxim;
> +	struct backlight_properties props;
> +	int ret;
> +	uint32_t initial_brightness = 50;
> +
> +	maxim = devm_kzalloc(&cl->dev, sizeof(struct max25014), GFP_KERNEL);
> +	if (!maxim)
> +		return -ENOMEM;
> +
> +	maxim->client = cl;
> +
> +	ret = max25014_parse_dt(maxim, &initial_brightness);
> +	if (ret < 0)
> +		return ret;
> +
> +	maxim->vin = devm_regulator_get_optional(&maxim->client->dev, "power");

I would have expected to see devm_regulator_get() here. Why do you care
whether you get a real regulator or a dummy if you just NULL check
maxim->vin everywhere?


> +	if (IS_ERR(maxim->vin)) {
> +		if (PTR_ERR(maxim->vin) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		maxim->vin = NULL;
> +	}
> +
> +	if (maxim->vin) {

If you had called devm_regulator_get() there would be no need for a NULL
check here.


> +		ret = regulator_enable(maxim->vin);
> +		if (ret < 0) {
> +			dev_err(&maxim->client->dev,
> +				"failed to enable Vin: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	maxim->enable = devm_gpiod_get_optional(&maxim->client->dev, "enable",
> +						GPIOD_ASIS);
> +	if (IS_ERR(maxim->enable)) {
> +		ret = PTR_ERR(maxim->enable);
> +		dev_err(&maxim->client->dev, "failed to get enable gpio: %d\n",
> +			ret);
> +		goto disable_vin;
> +	}
> +
> +	if (maxim->enable)
> +		gpiod_set_value_cansleep(maxim->enable, 1);

No need for NULL pointer check here (see
https://elixir.bootlin.com/linux/v6.18-rc4/source/drivers/gpio/gpiolib.c#L358-L363 ).


> +
> +	/* Enable can be tied to vin rail wait if either is available */
> +	if (maxim->enable || maxim->vin) {
> +		/* Datasheet Electrical Characteristics tSTARTUP 2ms */
> +		usleep_range(2000, 2500);
> +	}

If you really want to keep the devm_regulator_get_optional() I guess
maybe you could persuade me it's need to avoid this sleep... although
I'd be fairly happy to remove the NULL checks here too!


> +
> +	maxim->regmap = devm_regmap_init_i2c(cl, &max25014_regmap_config);
> +	if (IS_ERR(maxim->regmap)) {
> +		ret = PTR_ERR(maxim->regmap);
> +		dev_err(&maxim->client->dev,
> +			"failed to initialize the i2c regmap: %d\n", ret);
> +		goto disable_full;
> +	}
> +
> +	i2c_set_clientdata(cl, maxim);
> +
> +	ret = max25014_check_errors(maxim);
> +	if (ret) { /* error is already reported in the above function */
> +		goto disable_full;
> +	}
> +
> +	ret = max25014_configure(maxim);
> +	if (ret) {
> +		dev_err(&maxim->client->dev, "device config err: %d", ret);
> +		goto disable_full;
> +	}
> +
> +	memset(&props, 0, sizeof(props));
> +	props.type = BACKLIGHT_PLATFORM;
> +	props.max_brightness = MAX_BRIGHTNESS;
> +	props.brightness = initial_brightness;
> +	props.scale = BACKLIGHT_SCALE_LINEAR;
> +
> +	bl = devm_backlight_device_register(&maxim->client->dev, id->name,
> +					    &maxim->client->dev, maxim,
> +					    &max25014_bl_ops, &props);
> +	if (IS_ERR(bl))
> +		return PTR_ERR(bl);
> +
> +	maxim->bl = bl;
> +
> +	return 0;
> +
> +disable_full:
> +	if (maxim->enable)
> +		gpiod_set_value_cansleep(maxim->enable, 0);

Again, NULL check isn't needed.

> +disable_vin:
> +	if (maxim->vin)
> +		regulator_disable(maxim->vin);
> +	return ret;
> +}
> +
> +static void max25014_remove(struct i2c_client *cl)
> +{
> +	struct max25014 *maxim = i2c_get_clientdata(cl);
> +
> +	maxim->bl->props.brightness = 0;
> +	max25014_update_status(maxim->bl);
> +	if (maxim->enable)
> +		gpiod_set_value_cansleep(maxim->enable, 0);

Lose the NULL check.

> +	if (maxim->vin)
> +		regulator_disable(maxim->vin);
> +}
> +
> +static const struct of_device_id max25014_dt_ids[] = {
> +	{ .compatible = "maxim,max25014", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max25014_dt_ids);
> +
> +static const struct i2c_device_id max25014_ids[] = {
> +	{ "max25014" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max25014_ids);
> +
> +static struct i2c_driver max25014_driver = {
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = of_match_ptr(max25014_dt_ids),
> +	},
> +	.probe = max25014_probe,
> +	.remove = max25014_remove,
> +	.id_table = max25014_ids,
> +};
> +module_i2c_driver(max25014_driver);
> +
> +MODULE_DESCRIPTION("Maxim MAX25014 backlight driver");
> +MODULE_AUTHOR("Maud Spierings <maudspierings@gocontroll.com>");
> +MODULE_LICENSE("GPL");


Daniel.
