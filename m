Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591511BC08F
	for <linux-fbdev@vger.kernel.org>; Tue, 13 Jan 2026 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768288625; cv=none; b=Ch/x8VT80XFtQ+KZ1dapH99NrqVm/+AQ/6J307T46CgSmEl4tEyoy6fV2d1NhHwVyru0Z/jqBsaZ9kUXLtzW4o+V2RY3ej9XI/XPjq3bqqugVq9uydlYN+IbZjwRQ3tDBqqO4ZSV2itP/BrcauZYWrJ4oDQDQfxl+7D+WMcuv3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768288625; c=relaxed/simple;
	bh=TPsnQcTiXapnciwnTVuEo3q/nDTbVMjHMKFLOq9q0ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9d/wWN1Jr86GI87P9HArFw723IQMCGEHgfgf1dm/YAY9NctCa4L9OtTYQVhi+KnVGsE3zkdmXWjIO/51iR4WY2EmK1nvFOHO7RRaNCbmI/z9XXSbIwuadE/0UZBzauIBMBq7Hl1vhLXOjiysklJ2XiTeKMo7vb3VVBvmn29eDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f33VSMMz; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f33VSMMz"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso2693148a12.2
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jan 2026 23:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768288624; x=1768893424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvKer4HmMc5hx5FHqiulh9U9Ul3iO4PsRZgPY52JLDQ=;
        b=f33VSMMzLmdZ+YFcQSxVccSpsqXGfuO+Q3tVJahNBQZY/2soPZf8mBrLSiqV/xhNPh
         rK8Vq4z949FLAmP01ujUt7PaS0CHAUbuP1VuRJoE4iQpSTdYQyYkpGnR21gwWJ4q50J2
         l3fMz5UEF0m8ex7zjMT7Es9h4dTUT/XxBqKg/YF7uPYeeAMuGnSJkkqS1RejekU/x+4Y
         dpRTSHhpKz3KgVF3nmGVVHie1ZUgMCNjysBnn3d3bmcWeYWzbTUC06gic4rLZn/BYRXz
         ti+SgDpVAfiL0vHlaQx7b/tCHw2b6Gm+DJNLPLFTVD3Do8eG/L9cUAaHkY6nyoIjBnZn
         hrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768288624; x=1768893424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvKer4HmMc5hx5FHqiulh9U9Ul3iO4PsRZgPY52JLDQ=;
        b=ZIiZFgN0fU9waESpa15MRQ+APUnSjry92NOFjeXYFe+tn8sMHSh+1vmDBsUV6hYI35
         pt+gsIqirXmX1b3O5YspIrdoOApXXKs21Xf69M8Y5Qx9ATJUTtZkvT/IqkAmnNBfJFYq
         nLyuJ4IcW+9TsTzzuCAwEHW+vtXWBsD2o+EesFg1TvsIlFniNztjCxtFaQsKsOkwWAbU
         lLRgT79z6QAV1j6ID5DP+G59va5Mf8VetWz/RAUUdTxxap6RogBuER8hkSNo5aMVYVuX
         llXOmUEByQyw2eRKpuyp+I7CNYz8ZRKPpM7zUWie3Aj93H96FlQ55iOFbaPhErBKTkJc
         j2/g==
X-Forwarded-Encrypted: i=1; AJvYcCUqOExgQqKzmAriKWIYa8lpC1JsytPXU2+Dc+mEqbZ0o+OEV9+kQhvsY7iix4MQ0vwGd1tvVaVhlzItIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtL+qXYA6qwY+PbCB0WZi4AoZtj8k+fvd/iqSYXlR4CpWK76Sv
	mtg3B05Ho9HNPdlSanSnEwMBsM/qXSG1XRFsv5bGnWUKeABC16+gAQ0s
X-Gm-Gg: AY/fxX7gt5pHToNga1f+We+SXQRz2UCkNGR3jvQ+uJsMckl+M/3aReTU3jbdratOdG3
	OMTo1O7Wz6C2dpmMM0c+V5xQm+M3Mfz9ue7dgGSNxET2s9/ZvVbw8VxJQwuvdfvqOkPtCmxWMe5
	9jHRq4cv69FvG4lUuKBNq+efyz8MAl3MLbzyRmQzVw4DflTirzIq2YHBscE+JjWsl39HG2kPNPA
	xntRvAC7qF+aqFStusNNoxvMd1B/aaCTUwPRq/u+4kTER3KCn1IsU2un9B4AcDVVqgeP7Vs2WAe
	XOn56JeUYy2UcENMEfzdYUqFhb6DDJFzgS5+HFThnolRLxK//1e5pC6r4C2ZdRl75Nac8aS91Ly
	FV108k0K/nk352ydsfy1eMVlf5aiiHZF0VbHaiDC9UUJfaI4Px4CxUN9C89hNTvVlD15qxDrk+X
	/ubyydOK5w91ArHqZTvwOM0SuiKaDVDmxx4g==
X-Google-Smtp-Source: AGHT+IGycyqSgqnKXtUwOpZwa1uFrCeCy1ot/yCOkWRUaczihN0aqz+rrtY+DvAGGlu2iBfjLIOe4g==
X-Received: by 2002:a05:6300:210d:b0:364:be7:6fe9 with SMTP id adf61e73a8af0-3898f8cbb93mr15641886637.32.1768288623537;
        Mon, 12 Jan 2026 23:17:03 -0800 (PST)
Received: from [172.16.20.12] ([136.226.253.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc8d2952dsm6490255a12.17.2026.01.12.23.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 23:17:03 -0800 (PST)
Message-ID: <1fedb7d7-3a30-4f0f-961f-09613f2a95d0@gmail.com>
Date: Tue, 13 Jan 2026 12:47:26 +0530
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] backlight: gpio: add support for multiple GPIOs
 for backlight control
To: Daniel Thompson <daniel@riscstar.com>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
 pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260105085120.230862-1-tessolveupstream@gmail.com>
 <20260105085120.230862-3-tessolveupstream@gmail.com>
 <aVuN7zVUWJ1qsVh8@aspen.lan>
Content-Language: en-US
From: tessolveupstream@gmail.com
In-Reply-To: <aVuN7zVUWJ1qsVh8@aspen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05-01-2026 15:39, Daniel Thompson wrote:
> On Mon, Jan 05, 2026 at 02:21:20PM +0530, Sudarshan Shetty wrote:
>> Extend the gpio-backlight driver to handle multiple GPIOs instead of a
>> single one. This allows panels that require driving several enable pins
>> to be controlled by the backlight framework.
>>
>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>> ---
>>  drivers/video/backlight/gpio_backlight.c | 61 +++++++++++++++++-------
>>  1 file changed, 45 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
>> index 728a546904b0..037e1c111e48 100644
>> --- a/drivers/video/backlight/gpio_backlight.c
>> +++ b/drivers/video/backlight/gpio_backlight.c
>> @@ -17,14 +17,18 @@
>>
>>  struct gpio_backlight {
>>  	struct device *dev;
>> -	struct gpio_desc *gpiod;
>> +	struct gpio_desc **gpiods;
>> +	unsigned int num_gpios;
> 
> Why not use struct gpio_descs for this?
> 
> Once you do that, then most of the gbl->num_gpios loops can be replaced with
> calls to the array based accessors.
>

Based on your feedback, I have updated the implementation to use
struct gpio_descs and array-based accessors, as recommended like
below:

git diff drivers/video/backlight/gpio_backlight.c
diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 037e1c111e48..e99d7a9dc670 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -14,22 +14,37 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/bitmap.h>

 struct gpio_backlight {
        struct device *dev;
-       struct gpio_desc **gpiods;
+       struct gpio_descs *gpiods;
        unsigned int num_gpios;
 };

 static int gpio_backlight_update_status(struct backlight_device *bl)
 {
        struct gpio_backlight *gbl = bl_get_data(bl);
-       unsigned int i;
+       unsigned int n = gbl->num_gpios;
        int br = backlight_get_brightness(bl);
+       unsigned long *value_bitmap;
+       int words = BITS_TO_LONGS(n);
+
+       value_bitmap = kcalloc(words, sizeof(unsigned long), GFP_KERNEL);
+       if (!value_bitmap)
+               return -ENOMEM;
+
+       if (br)
+               bitmap_fill(value_bitmap, n);
+       else
+               bitmap_zero(value_bitmap, n);

-       for (i = 0; i < gbl->num_gpios; i++)
-               gpiod_set_value_cansleep(gbl->gpiods[i], br);
+       gpiod_set_array_value_cansleep(gbl->gpiods->ndescs,
+                                  gbl->gpiods->desc,
+                                  gbl->gpiods->info,
+                                  value_bitmap);

+       kfree(value_bitmap);
        return 0;
 }

@@ -67,22 +82,18 @@ static int gpio_backlight_probe(struct platform_device *pdev)

        def_value = device_property_read_bool(dev, "default-on");

-       gbl->num_gpios = gpiod_count(dev, NULL);
+       gbl->gpiods = devm_gpiod_get_array(dev, NULL, GPIOD_ASIS);
+       if (IS_ERR(gbl->gpiods)) {
+               if (PTR_ERR(gbl->gpiods) == -ENODEV)
+                       return dev_err_probe(dev, -EINVAL,
+                       "The gpios parameter is missing or invalid\n");
+               return PTR_ERR(gbl->gpiods);
+       }
+
+       gbl->num_gpios = gbl->gpiods->ndescs;
        if (gbl->num_gpios == 0)
                return dev_err_probe(dev, -EINVAL,
                        "The gpios parameter is missing or invalid\n");
-       gbl->gpiods = devm_kcalloc(dev, gbl->num_gpios, sizeof(*gbl->gpiods),
-                                  GFP_KERNEL);
-       if (!gbl->gpiods)
-               return -ENOMEM;
-
-       for (i = 0; i < gbl->num_gpios; i++) {
-               gbl->gpiods[i] =
-                       devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
-               if (IS_ERR(gbl->gpiods[i]))
-                       return dev_err_probe(dev, PTR_ERR(gbl->gpiods[i]),
-                                       "Failed to get GPIO at index %u\n", i);
-       }

        memset(&props, 0, sizeof(props));
        props.type = BACKLIGHT_RAW;
@@ -101,14 +112,26 @@ static int gpio_backlight_probe(struct platform_device *pdev)
                                                    : BACKLIGHT_POWER_OFF;
        } else {
                bool all_high = true;
-
-               for (i = 0; i < gbl->num_gpios; i++) {
-                       if (gpiod_get_value_cansleep(gbl->gpiods[i]) != 0) {
-                               all_high = false;
-                               break;
-                       }
+               unsigned long *value_bitmap;
+               int words = BITS_TO_LONGS(gbl->num_gpios);
+
+               value_bitmap = kcalloc(words, sizeof(unsigned long), GFP_KERNEL);
+               if (!value_bitmap)
+                       return -ENOMEM;
+
+               ret = gpiod_get_array_value_cansleep(gbl->gpiods->ndescs,
+                                           gbl->gpiods->desc,
+                                           gbl->gpiods->info,
+                                           value_bitmap);
+               if (ret) {
+                       kfree(value_bitmap);
+                       return dev_err_probe(dev, ret,
+                                           "failed to read initial gpio values\n");
                }

+               all_high = bitmap_full(value_bitmap, gbl->num_gpios);
+
+               kfree(value_bitmap);
                bl->props.power =
                        all_high ? BACKLIGHT_POWER_ON :  BACKLIGHT_POWER_OFF;
        }
@@ -118,7 +141,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
        init_brightness = backlight_get_brightness(bl);

        for (i = 0; i < gbl->num_gpios; i++) {
-               ret = gpiod_direction_output(gbl->gpiods[i], init_brightness);
+               ret = gpiod_direction_output(gbl->gpiods->desc[i], init_brightness);
                if (ret)
                        return dev_err_probe(dev, ret,
                                        "failed to set gpio %u direction\n",

Could you please share your thoughts on whether this approach 
aligns with your expectations?
 
> 
>>  };
>>
>>  static int gpio_backlight_update_status(struct backlight_device *bl)
>>  {
>>  	struct gpio_backlight *gbl = bl_get_data(bl);
>> +	unsigned int i;
>> +	int br = backlight_get_brightness(bl);
>>
>> -	gpiod_set_value_cansleep(gbl->gpiod, backlight_get_brightness(bl));
>> +	for (i = 0; i < gbl->num_gpios; i++)
>> +		gpiod_set_value_cansleep(gbl->gpiods[i], br);
>>
>>  	return 0;
>>  }
>> @@ -52,6 +56,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>>  	struct backlight_device *bl;
>>  	struct gpio_backlight *gbl;
>>  	int ret, init_brightness, def_value;
>> +	unsigned int i;
>>
>>  	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
>>  	if (gbl == NULL)
>> @@ -62,10 +67,22 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>>
>>  	def_value = device_property_read_bool(dev, "default-on");
>>
>> -	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
>> -	if (IS_ERR(gbl->gpiod))
>> -		return dev_err_probe(dev, PTR_ERR(gbl->gpiod),
>> -				     "The gpios parameter is missing or invalid\n");
>> +	gbl->num_gpios = gpiod_count(dev, NULL);
>> +	if (gbl->num_gpios == 0)
>> +		return dev_err_probe(dev, -EINVAL,
>> +			"The gpios parameter is missing or invalid\n");
>> +	gbl->gpiods = devm_kcalloc(dev, gbl->num_gpios, sizeof(*gbl->gpiods),
>> +				   GFP_KERNEL);
>> +	if (!gbl->gpiods)
>> +		return -ENOMEM;
> 
> This is definitely easier if you simply use devm_get_array().
> 
> 
>> +
>> +	for (i = 0; i < gbl->num_gpios; i++) {
>> +		gbl->gpiods[i] =
>> +			devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
>> +		if (IS_ERR(gbl->gpiods[i]))
>> +			return dev_err_probe(dev, PTR_ERR(gbl->gpiods[i]),
>> +					"Failed to get GPIO at index %u\n", i);
>> +	}
>>
>>  	memset(&props, 0, sizeof(props));
>>  	props.type = BACKLIGHT_RAW;
>> @@ -78,22 +95,34 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>>  	}
>>
>>  	/* Set the initial power state */
>> -	if (!of_node || !of_node->phandle)
>> +	if (!of_node || !of_node->phandle) {
>>  		/* Not booted with device tree or no phandle link to the node */
>>  		bl->props.power = def_value ? BACKLIGHT_POWER_ON
>> -					    : BACKLIGHT_POWER_OFF;
>> -	else if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
>> -		bl->props.power = BACKLIGHT_POWER_OFF;
>> -	else
>> -		bl->props.power = BACKLIGHT_POWER_ON;
>> +						    : BACKLIGHT_POWER_OFF;
>> +	} else {
>> +		bool all_high = true;
>> +
>> +		for (i = 0; i < gbl->num_gpios; i++) {
>> +			if (gpiod_get_value_cansleep(gbl->gpiods[i]) != 0) {
> 
> Why is there a != here?
> 
> 
>> +				all_high = false;
>> +				break;
>> +			}
>> +		}
>> +
>> +		bl->props.power =
>> +			all_high ? BACKLIGHT_POWER_ON :  BACKLIGHT_POWER_OFF;
>> +	}
>>
>>  	bl->props.brightness = 1;
>>
>>  	init_brightness = backlight_get_brightness(bl);
>> -	ret = gpiod_direction_output(gbl->gpiod, init_brightness);
>> -	if (ret) {
>> -		dev_err(dev, "failed to set initial brightness\n");
>> -		return ret;
>> +
>> +	for (i = 0; i < gbl->num_gpios; i++) {
>> +		ret = gpiod_direction_output(gbl->gpiods[i], init_brightness);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					"failed to set gpio %u direction\n",
>> +					i);
>>  	}
>>
>>  	platform_set_drvdata(pdev, bl);
> 
> 
> Daniel.

