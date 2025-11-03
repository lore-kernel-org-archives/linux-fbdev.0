Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2C316911
	for <linux-fbdev@vger.kernel.org>; Mon,  3 Nov 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187413; cv=none; b=MOuPnch9XoL4pbCbN+MBjoNZZ47aY8/uIhLpKvERRt787btVN3Yp7S9lpFjq3kEgkx7x3lODZY5SHyMp1hLpF+rjHmWPispUmmbPPYFr29chyJ61tWw7PwP1ZAOPCyuSOZCAjoLLmp/Nl/hj4f68MJKqi0O+x1hgyr4VVJK8moA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187413; c=relaxed/simple;
	bh=bEvIZ6b3ZPoI56NZVv/yoSC/UVLKTxOb/khDUfqNXZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxe6mNVNp1s6Xvb6xzPhJvsd2DyhbFrBP7h7TXIGoLKQbAG9PuA/FWTUoHrYLe4Wm4/iBM++buqNNDu2gYCoPJOyWgAhzsSkDp1mVCWXMNuABv3I8/olIejAj9flUbK1n9edC13GKIYudJluY60uzk0ZdHVQ/s6Sur/080t6DB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=F4kAPPtc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="F4kAPPtc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47112a73785so30803635e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 03 Nov 2025 08:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762187408; x=1762792208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84F0QgR4+jds+lqPjKDSBSqClUiU/2oz/AngUspSNH8=;
        b=F4kAPPtcZZVu3wZgcaCHUtPsottZ6u5GzyBptAODlIGAnm6CnH8jVIRrOuWQQhFnMa
         QMwF2YkaQbr7Ueoos65dmmiVbIAiWoHhovBuJtX87K7P6salpJ4umMAuQnoKQwmDKJrQ
         Q+e1h9Lz5t2GBN+zV5niKSJMRype73Dfc20Fi89W7AL4zRfpOwcXwBsLxLukaFDdHVPU
         aNlarHPqZ18b0cchO1o7jyP9gfnTpuxsJjslNYHo83/O3UmMOds/HqnOlysK32c2VhLJ
         x5Zu2Rbiq4Xb/qUlSZ4IoxBwsz05zqNLTHPWJf4Om2J1HZVT2WSd9aAU+zitlHijKgeX
         Hs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187408; x=1762792208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84F0QgR4+jds+lqPjKDSBSqClUiU/2oz/AngUspSNH8=;
        b=uU7OWg3B0l0t3JxRrql8xVgrBe2fSwtBwn1K8VVcA4FzTwmPozputslYMBK1Dp5dC0
         pQBwMibBpNlX2BLB+viVvc+McxrWYD/KKCVnBZ1gvBfetArwk2BT94+li5T9kx/CqxG1
         ec4kYtfOfChcoz9KSMNHvl6RTSEo4ndjHzof6FShESuTvowqw07xqO/93f4Z3EJljNL9
         JYoAZ0V51UapYdR8wpc5t2uL/l49+wMOSHB3/PdDalc8w4NNLOf+u6mMOc2Vj5LRn3+y
         LwJm0MwsAbJisPftHyyChDu/wazGKPlWD2FMW+uKeZnNKYeyzjjukMPiFXDgb4PqNimZ
         XKww==
X-Forwarded-Encrypted: i=1; AJvYcCWK1QUHEsg2kQgO14lJOYjHdUy6PPFgJCkZ+86+HUy7OBUi3fpZaWjy7d+r6YpHQIWgJ26465cPIcS6+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyE0EgvTCChOd+8qeLfyStEUKeM7sF3H2cu1HjimPjY6Z+Aodd4
	seTP0zfFoOk+VxpuPE3a0p9FmoaYx6yHxFWu2+EEkpAnk+AWSsckYh2f4mxs+RsPlMs=
X-Gm-Gg: ASbGnct2m2vYA04jfRjFc+w+RSu91aqh2003hvdcWJ0nooPvJDx8+3/YNkappCCs/Wg
	6062gHq8JqZe7uSL2b89VT1ahC1tYVB2xPQ4AOEqiQ/WmgpsHTiC3jB5y5NZTjjSIiyEYPWz5n7
	AIiUQVSRQ+5JI6UO1KB0b4x0HvQOhi/LfxnqJng/ULjR+TaDRLaH9222c/jCdHzjdju5buysY+h
	5xF+HDEmG74nbqo5mP5GI0g2Sqt+3HzOehOMKabwtUTWSAw0/LhSgI/knnjIeU4XnmMe/ovfLpc
	va+CPH71JVNCM5Lhro5ZD01UZ6naeK9CRTPehgAXo+uXnm+lTsOmC1r1dO3+ulQHjOXSFShHLAL
	fHWA9cNiTNtnqK4gEnV9Wu70vWE8BfRNgtreHdC/XFl62lK+BckS9ax628lMZAnU23LkWe0fP/K
	hAiRbbcYZqPfgPt6Muqed7YEEdJg6nnqTOo2xf4xp9fneBB5koOCjCi7X+Oo6yX3AlrJJFcA==
X-Google-Smtp-Source: AGHT+IF/kGs5jea5FahI1rZFZGhV1Eh4Fy1sLd4uiFaXvIWVe3vieePJLCoPtu7DkEqIeKjkJL2wCg==
X-Received: by 2002:a05:600c:83ce:b0:471:989:9d85 with SMTP id 5b1f17b1804b1-47730871fa6mr144953305e9.19.1762187406607;
        Mon, 03 Nov 2025 08:30:06 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429d1061efasm9781324f8f.24.2025.11.03.08.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:30:05 -0800 (PST)
Date: Mon, 3 Nov 2025 16:31:35 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Junjie Cao <caojunjie650@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>
Subject: Re: [PATCH v2 2/2] backlight: aw99706: Add support for Awinic
 AW99706 backlight
Message-ID: <aQjY5_uEaTv4_L2s@aspen.lan>
References: <20251103110648.878325-1-caojunjie650@gmail.com>
 <20251103110648.878325-3-caojunjie650@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103110648.878325-3-caojunjie650@gmail.com>

On Mon, Nov 03, 2025 at 07:06:48PM +0800, Junjie Cao wrote:
> From: Pengyu Luo <mitltlatltl@gmail.com>
>
> Add support for Awinic AW99706 backlight, which can be found in
> tablet and notebook backlight, one case is the Lenovo Legion Y700
> Gen4. This driver refers to the official datasheets and android
> driver, they can be found in [1].
>
> [1] https://www.awinic.com/en/productDetail/AW99706QNR
>
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
> ---
> Changes in v2:
> - add handler for max-brightness and default-brightness
> - use proper units for properties (Krzysztof)
> - drop non-fixed properties (Krzysztof)
> - include default values in the aw99706_dt_props table (Daniel)
> - warn when a property value from DT is invalid (Daniel)
> - drop warning when optional properties are missing (Daniel)
> - add a function pointer into the aw99706_dt_props table to handle lookup (Daniel)
> - use a lookup function instead of hardcoding the formula for the iLED max (Daniel)
> - move BL enalbe handler into aw99706_update_brightness (Daniel)
> - Link to v1: https://lore.kernel.org/linux-leds/20251026123923.1531727-3-caojunjie650@gmail.com

Thanks for the changes.

I'm afraid I don't like encoding the `shift` in the DT properties table.
Caching something that is so easy to recalculate makes no sense to me.
See below:


> +struct aw99706_dt_prop {
> +	const char * const name;
> +	int (*lookup)(const struct aw99706_dt_prop *prop, u32 dt_val, u8 *val);
> +	const u32 * const lookup_tbl;
> +	u8 tbl_size;
> +	u8 reg;
> +	u8 mask;
> +	u8 shift;

There should bee no need to record `shift` here. It's just a
duplicating information already held in `mask`.


> +	u32 def_val;
> +};
> +
> +static int aw99706_dt_property_lookup(const struct aw99706_dt_prop *prop,
> +				      u32 dt_val, u8 *val)
> +{
> +	int i;
> +
> +	if (!prop->lookup_tbl) {
> +		*val = dt_val;
> +		return 0;
> +	}
> +
> +	for (i = 0; i < prop->tbl_size; i++)
> +		if (prop->lookup_tbl[i] == dt_val)
> +			break;
> +
> +	*val = i;
> +
> +	return i == prop->tbl_size ? -1 : 0;
> +}
> +
> +#define MIN_ILED_MAX	5000
> +#define MAX_ILED_MAX	50000
> +#define STEP_ILED_MAX	500
> +
> +static int
> +aw99706_dt_property_iled_max_convert(const struct aw99706_dt_prop *prop,
> +				     u32 dt_val, u8 *val)
> +{
> +	if (dt_val > MAX_ILED_MAX || dt_val < MIN_ILED_MAX)
> +		return -1;
> +
> +	*val = (dt_val - MIN_ILED_MAX) / STEP_ILED_MAX;
> +
> +	return (dt_val - MIN_ILED_MAX) % STEP_ILED_MAX;
> +}
> +
> +static const struct aw99706_dt_prop aw99706_dt_props[] = {
> +	{
> +		"awinic,dim-mode", aw99706_dt_property_lookup,
> +		NULL, 0,
> +		AW99706_CFG0_REG,
> +		AW99706_DIM_MODE_MASK, __builtin_ctz(AW99706_DIM_MODE_MASK),

These __builtin_ctz() calls shouldn't be in the lookup table (if they
are not in the lookup table then can never be inconsistant with the
mask).


> +		1,
> +	},
<snip>
> +	{
> +		"awinic,ramp-ctl", aw99706_dt_property_lookup,
> +		NULL, 0,
> +		AW99706_CFG6_REG,
> +		AW99706_RAMP_CTL_MASK, __builtin_ctz(AW99706_RAMP_CTL_MASK),
> +		2,
> +	},
> +};
> +
> +struct reg_init_data {
> +	u8 reg;
> +	u8 mask;
> +	u8 val;
> +};
> +
> +static struct reg_init_data reg_init_tbl[ARRAY_SIZE(aw99706_dt_props)];
> +
> +static void aw99706_dt_parse(struct aw99706_device *aw,
> +			     struct backlight_properties *bl_props)
> +{
> +	const struct aw99706_dt_prop *prop;
> +	u32 dt_val;
> +	int ret, i;
> +	u8 val;
> +
> +	for (i = 0; i < ARRAY_SIZE(aw99706_dt_props); i++) {
> +		prop = &aw99706_dt_props[i];
> +		ret = device_property_read_u32(aw->dev, prop->name, &dt_val);
> +		if (ret < 0)
> +			dt_val = prop->def_val;
> +
> +		if (prop->lookup(prop, dt_val, &val)) {
> +			dev_warn(aw->dev, "invalid value %d for property %s, using default value %d\n",
> +				 dt_val, prop->name, prop->def_val);
> +
> +			prop->lookup(prop, prop->def_val, &val);
> +		}
> +
> +		reg_init_tbl[i].reg = prop->reg;
> +		reg_init_tbl[i].mask = prop->mask;
> +		reg_init_tbl[i].val = val << prop->shift;

Can't you just use FIELD_PREP() to set val (either here or at the point
the init table is consumed)? That why there's no ffs() or clz() at all.


> +	}
> +
> +	aw->init_tbl = reg_init_tbl;
> +	aw->init_tbl_size = ARRAY_SIZE(reg_init_tbl);

Copying a pointer to a single instance static data buffer into a
dynamically allocated data structure isn't right.

You should include the init table as part of `struct aw99706_device`.


> +
> +	bl_props->brightness = AW99706_MAX_BRT_LVL >> 1;
> +	bl_props->max_brightness = AW99706_MAX_BRT_LVL;
> +	device_property_read_u32(aw->dev, "default-brightness",
> +				 &bl_props->brightness);
> +	device_property_read_u32(aw->dev, "max-brightness",
> +				 &bl_props->max_brightness);
> +
> +	if (bl_props->max_brightness > AW99706_MAX_BRT_LVL)
> +		bl_props->max_brightness = AW99706_MAX_BRT_LVL;
> +
> +	if (bl_props->brightness > bl_props->max_brightness)
> +		bl_props->brightness = bl_props->max_brightness;
> +}
> +
> +static int aw99706_hw_init(struct aw99706_device *aw)
> +{
> +	int ret, i;
> +
> +	gpiod_set_value_cansleep(aw->hwen_gpio, 1);
> +
> +	for (i = 0; i < aw->init_tbl_size; i++) {
> +		ret = aw99706_i2c_update_bits(aw, aw->init_tbl[i].reg,
> +					      aw->init_tbl[i].mask,
> +					      aw->init_tbl[i].val);
> +		if (ret < 0) {
> +			dev_err(aw->dev, "Failed to write init data %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw99706_bl_enable(struct aw99706_device *aw, bool en)
> +{
> +	int ret;
> +	u8 val;
> +
> +	FIELD_MODIFY(AW99706_BACKLIGHT_EN_MASK, &val, en);

This should use FIELD_PREP() not FIELD_MODIFY();


> +	ret = aw99706_i2c_update_bits(aw, AW99706_CFGD_REG,
> +				      AW99706_BACKLIGHT_EN_MASK, val);
> +	if (ret)
> +		dev_err(aw->dev, "Failed to enable backlight!\n");
> +
> +	return ret;
> +}


Daniel.
