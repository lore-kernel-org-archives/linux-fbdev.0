Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05603557E5
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Jan 2026 04:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768884702; cv=none; b=gFMJYAqb8x/XFaVJ06IqUyvvz1dcWZdlwJDuT8pAPe6PIVKQbESDW4RYYPoRGfkWP+paEXUMchVR0Z5ZIpiqZd13nekyQzhMn9AhTdMmAArK/XUJ07eFP5ybJShF6mzxKCxdk+kP7lhlbyrcDi6X88vI6KklmZEGuGh9Aq+cQaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768884702; c=relaxed/simple;
	bh=1EEJTv7saQIJVI1CVFQjCAJAHo6DbFSU2VPyzguN1bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sl6Jm6+1K857oO/2bvUaPSF7wtPzoy78Oo6rybjdS99INNfDJAEXok2tPKdwMqNVpRizUV+T378kbWPclgrL0gv529x0TamEQnBXevndlPk83Md2bpG6eOQbNdIf/OauvfRDZB1J/emkdUH7mb+sngZtlooRynPB8TG73UMhgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqzuRKFl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqzuRKFl"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0833b5aeeso50382005ad.1
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Jan 2026 20:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768884699; x=1769489499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrPpWhLizzqyrVdqRt9DE4t+jE309BmKnkyinv/DH0E=;
        b=iqzuRKFl9G3R2iqQ86K72TNaD9X8a/SXo/S92L4+kJDge2iIL+MAvs9RMJcXvbMM3f
         9J6RYmsmJExgSueKxG6Rs8DkR5arZxN1PsSv5u4bBOtmYzq5W3iPdvnunvQeDIypnnYG
         G9helpFyys+RXh/54tN3sILCWDTZiRtzs1ZoEwiUgSjq3bdCsJgzbBfmC9NXHsdyJfHJ
         Z7E3474IOjefuUi9/fX747xt4ZF3cr8rxpDwbnuS7SNSn+6xW50IIh9nLPQ9hN4LbIh+
         eBs9Uj/GTnpba4eonjL4gvjEPtEfurOnoFI+KSZvO1O2bFch6d3Hh8jxFB+iJs0dob+L
         zP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768884699; x=1769489499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrPpWhLizzqyrVdqRt9DE4t+jE309BmKnkyinv/DH0E=;
        b=lBOoZezha0WWz1ZAVTN79U9v/LpVF9ucx0N1YOEjMG3mDsdmmJAKpiQ5jgyKmcOD1j
         TUEmwMdoJJ8frPnvHAyyZ76Qq+lNULfdezU1ebJvegCXsbyCnzKAMCd9AYHIdExax7SR
         +YS3oiEVG+u1Ilh2HHQuzTsdCAHvZqp1baWWITq9lUM2qcKeQuvm+qg2kozKf0nAnV6W
         6jyUuZ+TIEUEHAJoswEAVEOIX7r8MCFEDExeY7vB7ujk3TMCuyTRt2mjY5uaguKhT1kX
         nFxMPTbb3VZrB90Er3/vRUuKB1R+W2tSobrGLe7+YIDUP1dssG65yLLJML2hcrVTwIoi
         x3ig==
X-Forwarded-Encrypted: i=1; AJvYcCUhBhVltkgD9RCKCvQXQb4evh6slpZlGf/URKTtPlrChpH72/9uc/wZsymF8qp9Sg9NXCZGILf+F9SaYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE4ce/DCXihoy1ULPN+qA0e9Wryt2OGFCWAQx0loP7fNCmjf4A
	1u7rd1MxMxiSVTybKjs4vvprXhF3qIOQFhFCOPYSm+NNO2b2q+Jtzrji
X-Gm-Gg: AZuq6aIa+roIL89eumwRMEWG4le5GfBpK1Ic3N53KVRPQjZJ1/rgz3aklx87KI65bnT
	dAcXTKyOOTR75gAUHHfLsYy33fifwhssEYLZsyRHLW9/oJAGEVyP+bQPdjkBN0wAJM1rD6tmt34
	WGAH6IYhpTaepH0T7zv/gKXcSuX5eBeAw0/Lq2vTGts2vqE/U7kiEdJYFFYqfSlgE2GZdSIH+G0
	yg1fla2+6UnuR88WjFL2yBHkUMYUPT5Tw1zqcU534GKFV204pFnLXMA84MHiMkZxeYmQcFVQxQ0
	glODl28REqp5HJNiUnsmWsFkoZFzd22F91fxYs7psaW9PMtAqdH1r006OAeNAKceoLTpPFpL7nZ
	wdHyhGx4bBWM60M7ev16tLWOWgmSxLKaVjy2EZ8mrjSWlUEKKE8DCyFfWyLUNjkNb8agY6ZC+vf
	GJe+uP3lMlOhDj2MX9a+wN3B7RD9s6ci+oXA==
X-Received: by 2002:a17:902:f788:b0:29e:9387:f2b7 with SMTP id d9443c01a7336-2a7188577d1mr133191665ad.11.1768884699087;
        Mon, 19 Jan 2026 20:51:39 -0800 (PST)
Received: from [172.16.20.12] ([136.226.253.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fd35esm107003535ad.81.2026.01.19.20.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 20:51:38 -0800 (PST)
Message-ID: <ec7b7af7-1343-4988-b783-9ce9b045c8ae@gmail.com>
Date: Tue, 20 Jan 2026 10:22:02 +0530
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
 <aVuN7zVUWJ1qsVh8@aspen.lan> <1fedb7d7-3a30-4f0f-961f-09613f2a95d0@gmail.com>
 <aWe-QA_grqNwnE4n@aspen.lan>
Content-Language: en-US
From: tessolveupstream@gmail.com
In-Reply-To: <aWe-QA_grqNwnE4n@aspen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14-01-2026 21:33, Daniel Thompson wrote:
> On Tue, Jan 13, 2026 at 12:47:26PM +0530, tessolveupstream@gmail.com wrote:
>>
>>
>> On 05-01-2026 15:39, Daniel Thompson wrote:
>>> On Mon, Jan 05, 2026 at 02:21:20PM +0530, Sudarshan Shetty wrote:
>>>> Extend the gpio-backlight driver to handle multiple GPIOs instead of a
>>>> single one. This allows panels that require driving several enable pins
>>>> to be controlled by the backlight framework.
>>>>
>>>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>>>> ---
>>>>  drivers/video/backlight/gpio_backlight.c | 61 +++++++++++++++++-------
>>>>  1 file changed, 45 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
>>>> index 728a546904b0..037e1c111e48 100644
>>>> --- a/drivers/video/backlight/gpio_backlight.c
>>>> +++ b/drivers/video/backlight/gpio_backlight.c
>>>> @@ -17,14 +17,18 @@
>>>>
>>>>  struct gpio_backlight {
>>>>  	struct device *dev;
>>>> -	struct gpio_desc *gpiod;
>>>> +	struct gpio_desc **gpiods;
>>>> +	unsigned int num_gpios;
>>>
>>> Why not use struct gpio_descs for this?
>>>
>>> Once you do that, then most of the gbl->num_gpios loops can be replaced with
>>> calls to the array based accessors.
>>>
>>
>> Based on your feedback, I have updated the implementation to use
>> struct gpio_descs and array-based accessors, as recommended like
>> below:
>>
>> git diff drivers/video/backlight/gpio_backlight.c
>> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
>> index 037e1c111e48..e99d7a9dc670 100644
>> --- a/drivers/video/backlight/gpio_backlight.c
>> +++ b/drivers/video/backlight/gpio_backlight.c
>> @@ -14,22 +14,37 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/property.h>
>>  #include <linux/slab.h>
>> +#include <linux/bitmap.h>
>>
>>  struct gpio_backlight {
>>         struct device *dev;
>> -       struct gpio_desc **gpiods;
>> +       struct gpio_descs *gpiods;
>>         unsigned int num_gpios;
>>  };
>>
>>  static int gpio_backlight_update_status(struct backlight_device *bl)
>>  {
>>         struct gpio_backlight *gbl = bl_get_data(bl);
>> -       unsigned int i;
>> +       unsigned int n = gbl->num_gpios;
>>         int br = backlight_get_brightness(bl);
>> +       unsigned long *value_bitmap;
>> +       int words = BITS_TO_LONGS(n);
>> +
>> +       value_bitmap = kcalloc(words, sizeof(unsigned long), GFP_KERNEL);
> 
> Not sure you need a kcalloc() here. If you want to support more than 32
> GPIOs then you can pre-allocate space with a devm_kcalloc() in the probe
> method rather than reallocate every time it is used.
> 
> To be honest I don't really mind putting a hard limit on the maximum
> gpl->num_gpios (so you can just use a local variable) and having no
> allocation at all.
>

Thanks for the suggestion. I addressed the kcalloc() concern by 
moving the bitmap allocation to probe using devm_kcalloc() as 
below:

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 0eb42d8bf1d9..7af5dc4f0315 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -19,32 +19,25 @@
 struct gpio_backlight {
        struct device *dev;
        struct gpio_descs *gpiods;
-       unsigned int num_gpios;
+       unsigned long *bitmap;
 };

 static int gpio_backlight_update_status(struct backlight_device *bl)
 {
        struct gpio_backlight *gbl = bl_get_data(bl);
-       unsigned int n = gbl->num_gpios;
+       unsigned int n = gbl->gpiods->ndescs;
        int br = backlight_get_brightness(bl);
-       unsigned long *value_bitmap;
-       int words = BITS_TO_LONGS(n);
-
-       value_bitmap = kcalloc(words, sizeof(unsigned long), GFP_KERNEL);
-       if (!value_bitmap)
-               return -ENOMEM;

        if (br)
-               bitmap_fill(value_bitmap, n);
+               bitmap_fill(gbl->bitmap, n);
        else
-               bitmap_zero(value_bitmap, n);
+               bitmap_zero(gbl->bitmap, n);

-       gpiod_set_array_value_cansleep(gbl->gpiods->ndescs,
+       gpiod_set_array_value_cansleep(n,
                                       gbl->gpiods->desc,
                                       gbl->gpiods->info,
-                                      value_bitmap);
+                                      gbl->bitmap);

-       kfree(value_bitmap);
        return 0;
 }

@@ -67,22 +60,25 @@ static int gpio_backlight_probe(struct platform_device *pdev)
        struct device *dev = &pdev->dev;
        struct gpio_backlight_platform_data *pdata = dev_get_platdata(dev);
        struct device_node *of_node = dev->of_node;
-       struct backlight_properties props;
+       struct backlight_properties props = { };
        struct backlight_device *bl;
        struct gpio_backlight *gbl;
-       int ret, init_brightness, def_value;
-       unsigned int i;
+       bool def_value;
+       enum gpiod_flags flags;
+       unsigned int n;
+       int words;

-       gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
-       if (gbl == NULL)
+       gbl = devm_kcalloc(dev, 1, sizeof(*gbl), GFP_KERNEL);
+       if (!gbl)
                return -ENOMEM;

        if (pdata)
                gbl->dev = pdata->dev;

        def_value = device_property_read_bool(dev, "default-on");
-
-       gbl->gpiods = devm_gpiod_get_array(dev, NULL, GPIOD_ASIS);
+       flags = def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+
+       gbl->gpiods = devm_gpiod_get_array(dev, NULL, flags);
        if (IS_ERR(gbl->gpiods)) {
                if (PTR_ERR(gbl->gpiods) == -ENODEV)
                        return dev_err_probe(dev, -EINVAL,
@@ -90,12 +86,17 @@ static int gpio_backlight_probe(struct platform_device *pdev)
                return PTR_ERR(gbl->gpiods);
        }

-       gbl->num_gpios = gbl->gpiods->ndescs;
-       if (gbl->num_gpios == 0)
+       n = gbl->gpiods->ndescs;
+       if (!n)
                return dev_err_probe(dev, -EINVAL,
-                       "The gpios parameter is missing or invalid\n");
+                       "No GPIOs provided\n");
+
+       words = BITS_TO_LONGS(n);
+       gbl->bitmap = devm_kcalloc(dev, words, sizeof(unsigned long),
+                                  GFP_KERNEL);
+       if (!gbl->bitmap)
+               return -ENOMEM;

-       memset(&props, 0, sizeof(props));
        props.type = BACKLIGHT_RAW;
        props.max_brightness = 1;
        bl = devm_backlight_device_register(dev, dev_name(dev), dev, gbl,
@@ -106,50 +107,19 @@ static int gpio_backlight_probe(struct platform_device *pdev)
        }

        /* Set the initial power state */
-       if (!of_node || !of_node->phandle) {
+       if (!of_node || !of_node->phandle)
                /* Not booted with device tree or no phandle link to the node */
                bl->props.power = def_value ? BACKLIGHT_POWER_ON
                                                    : BACKLIGHT_POWER_OFF;
-       } else {
-               bool all_high = true;
-               unsigned long *value_bitmap;
-               int words = BITS_TO_LONGS(gbl->num_gpios);
-
-               value_bitmap = kcalloc(words, sizeof(unsigned long),
-                                      GFP_KERNEL);
-               if (!value_bitmap)
-                       return -ENOMEM;
-
-               ret = gpiod_get_array_value_cansleep(gbl->gpiods->ndescs,
-                                                    gbl->gpiods->desc,
-                                                    gbl->gpiods->info,
-                                                    value_bitmap);
-               if (ret) {
-                       kfree(value_bitmap);
-                       return dev_err_probe(dev, ret,
-                               "failed to read initial gpio values\n");
-               }
-
-               all_high = bitmap_full(value_bitmap, gbl->num_gpios);
-
-               kfree(value_bitmap);
-               bl->props.power =
-                       all_high ? BACKLIGHT_POWER_ON :  BACKLIGHT_POWER_OFF;
-       }
-
-       bl->props.brightness = 1;
-
-       init_brightness = backlight_get_brightness(bl);
+       else if (gpiod_get_value_cansleep(gbl->gpiods->desc[0]) == 0)
+               bl->props.power = BACKLIGHT_POWER_OFF;
+       else
+               bl->props.power = BACKLIGHT_POWER_ON;

-       for (i = 0; i < gbl->num_gpios; i++) {
-               ret = gpiod_direction_output(gbl->gpiods->desc[i],
-                                            init_brightness);
-               if (ret)
-                       return dev_err_probe(dev, ret,
-                                       "failed to set gpio %u direction\n",
-                                       i);
-       }
+       bl->props.brightness = def_value ? 1 : 0;

+       gpio_backlight_update_status(bl);
+
        platform_set_drvdata(pdev, bl);
        return 0;
 }

Kindly confirm whether this approach aligns with your 
expectations.
 
> 
>> Could you please share your thoughts on whether this approach
>> aligns with your expectations?
> 
> Looks like it is going in the right direction, yes.
> 
> 
> Daniel.

