Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C5421F03
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Jan 2026 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913610; cv=none; b=dDQQgVrAEmuVsPOXLzQPSK4TR1ahZ8HtDIhhkm6fpYmlXZKA9meYqLNlQzQHzDSyI/lEsbZCw+cfrAhz6XadLYCJRw0S8O5As2ksNEJzBvtm0Sq2z/Za1P1yhiKPSwajxEUzK4Jg8UI4+jv/UE4MlSrNDIf94ga4p3LwsBMh1yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913610; c=relaxed/simple;
	bh=sBYnhcqH6qEqlGJT2u1dzWA2jA2jeHDkJ4Fv8Ahehdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuvdMQ/DpN/R6IYResBymHlusm+logQxBAz8OoeVCVJuONILkkgaGsUxNuDjSs1FNSxlVEbpCycq5wmikWKczSWTFmpqE2r9U3x0w+CZUMeuSMMegcWipPmHkmAi/ZkVXghXMsPPrXpB79ctTwLtcy389pK9t0Qatm+6YjVxQOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Id5qHpG7; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id5qHpG7"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c0ec27cad8cso2257619a12.1
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Jan 2026 04:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768913608; x=1769518408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQA0UiXnoLM7Zoi1HosgUAoRgcMqa5i1Mjp3uZoByh0=;
        b=Id5qHpG769lMwU+Eev8Fnv+NSgWAb9//k+TgQzoP/HAky0WMaNS0p3C2UihCpuhSbV
         EjpGZjt8AsCw8aI5QYBPtP7hD8FmB7hFED3vh92OixCsghU9VKKF0VfKJO00XfqAoH9Q
         EBbOVS3KxSXOXCL18CBJsSH85DiCq/z5ThMVqBra9/jHU1pLZqe8POYigubTlBrCW0JJ
         SXrWOhAqf2pZvJmVx9s7VlT+RY/8mH1EzjfuxasToSYgRP6zIoK5bKJ0W2u6MaO3WpQy
         x+iXphdL4pqBa51L9Yf9N/t+oxukbcBfPG3RzgTz5UPAPf7Vc1HqtGz+Hp1HkyeIM1Qg
         n5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768913608; x=1769518408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQA0UiXnoLM7Zoi1HosgUAoRgcMqa5i1Mjp3uZoByh0=;
        b=CVSA/BVrbeOgPK+dzTnq2ecYINj5CtOROxnZCQlouf0oEdviZ75dG1Z8Fe+ccmakd6
         Q0RCCi8i8Zy3XoC7tEntvDb/n+Wjvzsx5y1acO/QH5/sraPTM1oSVtAHnLJt4n6GDMHK
         b8K7q9UOPT3oLgwqu1cOpt93h1eRQaAkr7Z2HaQ8EHbu5ORnTxhegZetc99zZ8G9dT2/
         ZgVdUuxD8O0iQTFqyv83YqGI+eLcyUx99HL0JNFjVTol6DFjP/YJnJqqeFIYY81IIVEJ
         htlD+7rbfPCfBT+PgOld3ghCdEHVHkPGreOY3XhDfLHMBoV6cSWYXc/WMkBU+kwF3ZGn
         zmcw==
X-Forwarded-Encrypted: i=1; AJvYcCV/GgoovPZ6W7eWsR/YKTphBGk6rtGQ0NeKaBj5eAdwLVCGVMmxwZh/TgXMjQz5IU2c5iTY5SQLSWkZpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIx12Z/6XrBcdYrdSe163grwU5AuXSoNf/ee8aodkjAWlXzquE
	RWP1guScFwdFTNOEvPhMiphPGq0N6mWMaTVAo05QoYKOqEQ/ZHzBdEby
X-Gm-Gg: AZuq6aLgd7JkNQRdkkFoMZ0iyEtx+LgnKl0MfVfC+LR/VeT/eWURVrmP4DM/Es2LI7t
	5tbFEQciHk1SW2gdkr/beuArfo27SiTwVl7ys0++qq5HTw2OK54YzW5UcfPXe9B+K8k9b72vG4b
	wj2HSb4vZa6sZdvZ2O1+1iTUmU00cP201qXwmfdwfYqzyJMYjoAjE7SIGRfZRhHajekYdONIuN6
	CAFg4nw9FVoQX5byxmqiZjO8e9GDptx/cHqGraroGQALVebAiwJqcNtsnYYMPdkofmctAKhgxS7
	LLPmyQ7r97J2MmQNk54MEXF45xlruJziugV6wTUs/VlGg5gQJlYkUoY4osrbh11wXKQvJ4n1SIe
	bnvlDun2cJjx0xhySb0/pSF4uUx/V2Ed5+eOCMAIYN2yUIFq36B2jqVcdMviUp2kZuEOXQYoxr0
	Oq+cClMhHwKzrTaeaEhS0z7vh8gvkbviVBpw==
X-Received: by 2002:a17:902:e84a:b0:2a0:c942:8adf with SMTP id d9443c01a7336-2a7690523c5mr13664115ad.8.1768913608371;
        Tue, 20 Jan 2026 04:53:28 -0800 (PST)
Received: from [172.16.20.12] ([136.226.253.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190abcf0sm125579405ad.12.2026.01.20.04.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 04:53:27 -0800 (PST)
Message-ID: <c8d539f1-bebd-445b-b0a4-9f3fc62770c0@gmail.com>
Date: Tue, 20 Jan 2026 18:23:50 +0530
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
 <aWe-QA_grqNwnE4n@aspen.lan> <ec7b7af7-1343-4988-b783-9ce9b045c8ae@gmail.com>
 <aW9NH5GTwSR-m7VQ@aspen.lan>
Content-Language: en-US
From: tessolveupstream@gmail.com
In-Reply-To: <aW9NH5GTwSR-m7VQ@aspen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20-01-2026 15:08, Daniel Thompson wrote:
> On Tue, Jan 20, 2026 at 10:22:02AM +0530, tessolveupstream@gmail.com wrote:
>>
>>
>> On 14-01-2026 21:33, Daniel Thompson wrote:
>>> On Tue, Jan 13, 2026 at 12:47:26PM +0530, tessolveupstream@gmail.com wrote:
>>>>
>>>>
>>>> On 05-01-2026 15:39, Daniel Thompson wrote:
>>>>> On Mon, Jan 05, 2026 at 02:21:20PM +0530, Sudarshan Shetty wrote:
>>>>>> Extend the gpio-backlight driver to handle multiple GPIOs instead of a
>>>>>> single one. This allows panels that require driving several enable pins
>>>>>> to be controlled by the backlight framework.
>>>>>>
>>>>>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>>>>>> ---
>>>>>>  drivers/video/backlight/gpio_backlight.c | 61 +++++++++++++++++-------
>>>>>>  1 file changed, 45 insertions(+), 16 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
>>>>>> index 728a546904b0..037e1c111e48 100644
>>>>>> --- a/drivers/video/backlight/gpio_backlight.c
>>>>>> +++ b/drivers/video/backlight/gpio_backlight.c
>>>>>> @@ -17,14 +17,18 @@
>>>>>>
>>>>>>  struct gpio_backlight {
>>>>>>  	struct device *dev;
>>>>>> -	struct gpio_desc *gpiod;
>>>>>> +	struct gpio_desc **gpiods;
>>>>>> +	unsigned int num_gpios;
>>>>>
>>>>> Why not use struct gpio_descs for this?
>>>>>
>>>>> Once you do that, then most of the gbl->num_gpios loops can be replaced with
>>>>> calls to the array based accessors.
>>>>>
>>>>
>>>> Based on your feedback, I have updated the implementation to use
>>>> struct gpio_descs and array-based accessors, as recommended like
>>>> below:
>>>>
>>>> git diff drivers/video/backlight/gpio_backlight.c
>>>> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
>>>> index 037e1c111e48..e99d7a9dc670 100644
>>>> --- a/drivers/video/backlight/gpio_backlight.c
>>>> +++ b/drivers/video/backlight/gpio_backlight.c
>>>> @@ -14,22 +14,37 @@
>>>>  #include <linux/platform_device.h>
>>>>  #include <linux/property.h>
>>>>  #include <linux/slab.h>
>>>> +#include <linux/bitmap.h>
>>>>
>>>>  struct gpio_backlight {
>>>>         struct device *dev;
>>>> -       struct gpio_desc **gpiods;
>>>> +       struct gpio_descs *gpiods;
>>>>         unsigned int num_gpios;
>>>>  };
>>>>
>>>>  static int gpio_backlight_update_status(struct backlight_device *bl)
>>>>  {
>>>>         struct gpio_backlight *gbl = bl_get_data(bl);
>>>> -       unsigned int i;
>>>> +       unsigned int n = gbl->num_gpios;
>>>>         int br = backlight_get_brightness(bl);
>>>> +       unsigned long *value_bitmap;
>>>> +       int words = BITS_TO_LONGS(n);
>>>> +
>>>> +       value_bitmap = kcalloc(words, sizeof(unsigned long), GFP_KERNEL);
>>>
>>> Not sure you need a kcalloc() here. If you want to support more than 32
>>> GPIOs then you can pre-allocate space with a devm_kcalloc() in the probe
>>> method rather than reallocate every time it is used.
>>>
>>> To be honest I don't really mind putting a hard limit on the maximum
>>> gpl->num_gpios (so you can just use a local variable) and having no
>>> allocation at all.
>>>
>>
>> Thanks for the suggestion. I addressed the kcalloc() concern by
>> moving the bitmap allocation to probe using devm_kcalloc() as
>> below:
>>
>> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
>> index 0eb42d8bf1d9..7af5dc4f0315 100644
>> --- a/drivers/video/backlight/gpio_backlight.c
>> +++ b/drivers/video/backlight/gpio_backlight.c
>> @@ -19,32 +19,25 @@
>>  struct gpio_backlight {
>>         struct device *dev;
>>         struct gpio_descs *gpiods;
>> -       unsigned int num_gpios;
>> +       unsigned long *bitmap;
>>  };
>>
>>  static int gpio_backlight_update_status(struct backlight_device *bl)
>>  {
>>         struct gpio_backlight *gbl = bl_get_data(bl);
>> -       unsigned int n = gbl->num_gpios;
>> +       unsigned int n = gbl->gpiods->ndescs;
>>         int br = backlight_get_brightness(bl);
>> -       unsigned long *value_bitmap;
>> -       int words = BITS_TO_LONGS(n);
>> -
>> -       value_bitmap = kcalloc(words, sizeof(unsigned long), GFP_KERNEL);
>> -       if (!value_bitmap)
>> -               return -ENOMEM;
>>
>>         if (br)
>> -               bitmap_fill(value_bitmap, n);
>> +               bitmap_fill(gbl->bitmap, n);
>>         else
>> -               bitmap_zero(value_bitmap, n);
>> +               bitmap_zero(gbl->bitmap, n);
>>
>> -       gpiod_set_array_value_cansleep(gbl->gpiods->ndescs,
>> +       gpiod_set_array_value_cansleep(n,
>>                                        gbl->gpiods->desc,
>>                                        gbl->gpiods->info,
>> -                                      value_bitmap);
>> +                                      gbl->bitmap);
>>
>> -       kfree(value_bitmap);
>>         return 0;
>>  }
>>
>> @@ -67,22 +60,25 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>>         struct device *dev = &pdev->dev;
>>         struct gpio_backlight_platform_data *pdata = dev_get_platdata(dev);
>>         struct device_node *of_node = dev->of_node;
>> -       struct backlight_properties props;
>> +       struct backlight_properties props = { };
>>         struct backlight_device *bl;
>>         struct gpio_backlight *gbl;
>> -       int ret, init_brightness, def_value;
>> -       unsigned int i;
>> +       bool def_value;
>> +       enum gpiod_flags flags;
>> +       unsigned int n;
>> +       int words;
>>
>> -       gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
>> -       if (gbl == NULL)
>> +       gbl = devm_kcalloc(dev, 1, sizeof(*gbl), GFP_KERNEL);
>> +       if (!gbl)
>>                 return -ENOMEM;
>>
>>         if (pdata)
>>                 gbl->dev = pdata->dev;
>>
>>         def_value = device_property_read_bool(dev, "default-on");
>> -
>> -       gbl->gpiods = devm_gpiod_get_array(dev, NULL, GPIOD_ASIS);
>> +       flags = def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
>> +
>> +       gbl->gpiods = devm_gpiod_get_array(dev, NULL, flags);
>>         if (IS_ERR(gbl->gpiods)) {
>>                 if (PTR_ERR(gbl->gpiods) == -ENODEV)
>>                         return dev_err_probe(dev, -EINVAL,
>> @@ -90,12 +86,17 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>>                 return PTR_ERR(gbl->gpiods);
>>         }
>>
>> -       gbl->num_gpios = gbl->gpiods->ndescs;
>> -       if (gbl->num_gpios == 0)
>> +       n = gbl->gpiods->ndescs;
>> +       if (!n)
>>                 return dev_err_probe(dev, -EINVAL,
>> -                       "The gpios parameter is missing or invalid\n");
>> +                       "No GPIOs provided\n");
>> +
>> +       words = BITS_TO_LONGS(n);
>> +       gbl->bitmap = devm_kcalloc(dev, words, sizeof(unsigned long),
>> +                                  GFP_KERNEL);
>> +       if (!gbl->bitmap)
>> +               return -ENOMEM;
>>
>> -       memset(&props, 0, sizeof(props));
>>         props.type = BACKLIGHT_RAW;
>>         props.max_brightness = 1;
>>         bl = devm_backlight_device_register(dev, dev_name(dev), dev, gbl,
>> @@ -106,50 +107,19 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>>         }
>>
>>         /* Set the initial power state */
>> -       if (!of_node || !of_node->phandle) {
>> +       if (!of_node || !of_node->phandle)
>>                 /* Not booted with device tree or no phandle link to the node */
>>                 bl->props.power = def_value ? BACKLIGHT_POWER_ON
>>                                                     : BACKLIGHT_POWER_OFF;
>> -       } else {
>> -               bool all_high = true;
>> -               unsigned long *value_bitmap;
>> -               int words = BITS_TO_LONGS(gbl->num_gpios);
>> -
>> -               value_bitmap = kcalloc(words, sizeof(unsigned long),
>> -                                      GFP_KERNEL);
>> -               if (!value_bitmap)
>> -                       return -ENOMEM;
>> -
>> -               ret = gpiod_get_array_value_cansleep(gbl->gpiods->ndescs,
>> -                                                    gbl->gpiods->desc,
>> -                                                    gbl->gpiods->info,
>> -                                                    value_bitmap);
>> -               if (ret) {
>> -                       kfree(value_bitmap);
>> -                       return dev_err_probe(dev, ret,
>> -                               "failed to read initial gpio values\n");
>> -               }
>> -
>> -               all_high = bitmap_full(value_bitmap, gbl->num_gpios);
>> -
>> -               kfree(value_bitmap);
>> -               bl->props.power =
>> -                       all_high ? BACKLIGHT_POWER_ON :  BACKLIGHT_POWER_OFF;
>> -       }
>> -
>> -       bl->props.brightness = 1;
>> -
>> -       init_brightness = backlight_get_brightness(bl);
>> +       else if (gpiod_get_value_cansleep(gbl->gpiods->desc[0]) == 0)
>> +               bl->props.power = BACKLIGHT_POWER_OFF;
>> +       else
>> +               bl->props.power = BACKLIGHT_POWER_ON;
>>
>> -       for (i = 0; i < gbl->num_gpios; i++) {
>> -               ret = gpiod_direction_output(gbl->gpiods->desc[i],
>> -                                            init_brightness);
>> -               if (ret)
>> -                       return dev_err_probe(dev, ret,
>> -                                       "failed to set gpio %u direction\n",
>> -                                       i);
>> -       }
>> +       bl->props.brightness = def_value ? 1 : 0;
>>
>> +       gpio_backlight_update_status(bl);
>> +
>>         platform_set_drvdata(pdev, bl);
>>         return 0;
>>  }
>>
>> Kindly confirm whether this approach aligns with your
>> expectations.
> 
> As mentioned yesterday, I'd rather just review a v2 patch than this kind of
> meta-patch. Please send a v2 patch instead.
>

Got it, will send v2 patch.
 
> 
> Daniel.

