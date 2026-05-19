Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C83E120E
	for <linux-fbdev@vger.kernel.org>; Tue, 19 May 2026 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178451; cv=none; b=koGvj8Vp21JDmT6DIYI3Lrj8uhGuMuwbbE27XWAGGQRZvTXhGEB+iREfRAGEH7axunLaoeBRd8Szn2sCQR4MxrUNsCJGSpMhJ9yTahAYBTpw+Z2BYwAcxYydOjLI09bmFXVABrz4g9ntAeB8V07wpcc6kJp3XZYe+2SwMeVG9jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178451; c=relaxed/simple;
	bh=dWLZe7QiX/lxLNJ9otbW4tMkazrMFLCdXjJlemEBlwE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oiaPUxDoXTldgdyE3XZdTYBLAegWjNySL+y7NE8IElBVTB2Hni0myIzgZviUz3U9mMgdgTnQBybBCzCo0is0imU9ZHMMLDafrjM+KUVcyF0IQHXEFKVcyONqadwLBmxHoTthz7HfVNzlNZpTUR6ClZ2TE8TAUtADHXOkaOGdcc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p0S7z2rH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p0S7z2rH"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso36408205e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 19 May 2026 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779178447; x=1779783247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTT0TEmFoUeONXI3O0UhC63GEEGa26mb7fZ2wgQ6t/A=;
        b=p0S7z2rHYfLMg5v1g8NyX7YB6Dji3dP34clONs9LA2P3KE1RdSG0L8Jo7mPUPhpl/G
         Cy7b8+zwIUozhNbAUgg98W3ktKenLgSiDBbFrbcDIz21VJtaPUd4/rx7lSN/IXrHS3JY
         TKw4o6dYrHBB7lgMXN/oN8d3/aBV6kaPRmMWjITGuqhcIpelW4/OVmPM0K4YUgIi2cMp
         lvfN8ThVoqWkWhaTv6HiP8H6xTa/UXVOQO8ixf7Se4kAC6Atdxzr3FK1jZbKvETlaHJt
         sS22a1J5GEogMgvPlJ0ngqbAItMJWwW27avG97YE3PF0CjtfQWEeWSlzvcjDm/tfli1O
         0f8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178447; x=1779783247;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTT0TEmFoUeONXI3O0UhC63GEEGa26mb7fZ2wgQ6t/A=;
        b=dZm3wuCDFNSluZ2J+bTkG4598TRWUEJ4DewUVI/F9TLuDZhkYweOX8TVRJVuoPgJYy
         penGVcudDidwGPv1pS4VNjWgl4qBq4iSIAiHzoqMrKzYesWUQNG5dX9S3Uwaik+Um9N8
         MrRsZxxaG8q3FndnlLKYms92cpXfXrnGzhhzAGkhWbNhnRZfF2etHcvVrTNw0SdoPINx
         RmGS3JY7oUv1MzB4FDiPUOpDzcSwC/Aw4hElwE1JP/HyMxOG0ptyuOt2d+bi1c2f20kg
         Af8+uVwboYcCwQTE7YDMwiKt1LJL73gVNOZEPxGZ+7tNHUecIqMTzC8e4/RA3fYGwsV3
         XM4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ckba0hRVQtTdBPKu1vvpnj55ueIdiljhYCvWrPcm5NRYu74YEni89eAOEc5XY63K5HH61Q7uzMZtNcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwymwAm/73lhJkdnRbIFbWPvlXRQUGGSw5wlQGZ5hFPmGxOQEo6
	aofIED8hcUaq6aefQ9ipTFH54W8bNZeaktkm7A5pzrf9i9SLbwdnyvBIwEZZxIyck1s=
X-Gm-Gg: Acq92OHVEu8Y/gX+JJgEMOxLidiMTIiHBiKMmsWD3GDS9TsTdlOVUTXzic3uXwZxvA4
	kILakLkOoAdVfYbYGt+9UYtOoaooi0JkrdpVRfDduSPhYNRAC/A+KDskgzhcD0BJTMaQiInVxo1
	b0phJXajxFpAkM9rEhO3IOXK2sEoTcu1SeJ3IRGM+q2mfRHCFn/wuLr7iXZ4JK4pTfLcGpg1pKM
	HQ24SF3l7qT/Q5h/e9A6BMacbaNsikexcKqd6lj+NKCuYo1XmsQH58XnZf06CEeNuX020Lz22cG
	q/OZX8Z1oFrCaCPqpieiR/MgH+Pt+qmUb2xeoXvbpJ9QbR7iRyuf9CfvCzB7Y1IV2NR1qWUi1Tr
	Ead+EZ+2DG0oHNyD5PFndJPEekyWsp0Zym7fSvX8vEDwx6c7IIVJGNlbb7g1jPwwXKQ99qOOuy2
	IVkyMQor0q92BbhJ0tYMoFr5/NIY0o6+BPS9elboWHxNAH7Zr32pbBd5Xj4OAhXdP0F6FifKO1w
	g/w
X-Received: by 2002:a05:600c:3506:b0:48f:e44c:e058 with SMTP id 5b1f17b1804b1-48fe60e13e7mr274947375e9.1.1779178447146;
        Tue, 19 May 2026 01:14:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1d4b:274c:94d:a69f? ([2a01:e0a:106d:1080:1d4b:274c:94d:a69f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe5bc94sm189230825e9.4.2026.05.19.01.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 01:14:06 -0700 (PDT)
Message-ID: <bc61221c-f517-4c35-8fb0-265a0c34b442@linaro.org>
Date: Tue, 19 May 2026 10:14:05 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/2] backlight: Add SY7758 6-channel High Efficiency
 LED Driver support
To: Daniel Thompson <danielt@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>
References: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org>
 <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-2-308140640de9@linaro.org>
 <agdJnpz9O00lywRm@aspen.lan>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <agdJnpz9O00lywRm@aspen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/15/26 18:28, Daniel Thompson wrote:
> On Thu, Apr 30, 2026 at 11:47:16AM +0200, Neil Armstrong wrote:
>> From: KancyJoe <kancy2333@outlook.com>
>>
>> Implement support for the Silergy SY7758 6-channel High Efficiency LED
>> Driver used for backlight brightness control in the Ayaneo Pocket S2
>> dual-DSI panel.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: KancyJoe <kancy2333@outlook.com>
>> ---
>>   drivers/video/backlight/Kconfig  |   8 +
>>   drivers/video/backlight/Makefile |   1 +
>>   drivers/video/backlight/sy7758.c | 311 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 320 insertions(+)
>> <snip>
>> diff --git a/drivers/video/backlight/sy7758.c b/drivers/video/backlight/sy7758.c
>> new file mode 100644
>> index 000000000000..9b2d3bbb4ded
>> --- /dev/null
>> +++ b/drivers/video/backlight/sy7758.c
>> @@ -0,0 +1,311 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Silergy SY7758 6-channel High Efficiency LED Driver
>> + *
>> + * Copyright (C) 2025 Kancy Joe <kancy2333@outlook.com>
>> + * Copyright (C) 2026 Linaro Limited
>> + * Author: Neil Armstrong <neil.armstrong@linaro.org>
> 
> I'm a bit confused by this comment. The git author and the
> MODULE_AUTHOR() is Kancy Joe. What does this comment signify?

I'll fix this in v3

> 
> 
>> + */
>> <snip>
>> +/* OTP memory */
>> +#define REG_OTP_CFG98 0x98
>> +#define REG_OTP_CFG9E 0x9E
>> +#define REG_OTP_CFG0 0xA0
>> +#define REG_OTP_CFG1 0xA1
>> +#define REG_OTP_CFG2 0xA2
>> +#define REG_OTP_CFG3 0xA3
>> +#define REG_OTP_CFG4 0xA4
>> +#define REG_OTP_CFG5 0xA5
>> +#define REG_OTP_CFG6 0xA6
>> +#define REG_OTP_CFG7 0xA7
>> +#define REG_OTP_CFG9 0xA9
>> +#define REG_OTP_CFGA 0xAA
>> +#define REG_OTP_CFGE 0xAE
> 
> There seems to be a lot of unused macros here, especially
> combined with the unused bitfields that tell us how to interpret
> the values.
> 
> Do we need them?

I'll drop those

> 
> 
>> <snip>
>> +static int sy7758_probe(struct i2c_client *client)
>> +{
>> +	struct backlight_properties props = { };
>> +	struct device *dev = &client->dev;
>> +	struct sy7758 *sydev;
>> +	unsigned int dev_id;
>> +	int ret;
>> +
>> +	sydev = devm_kzalloc(dev, sizeof(*sydev), GFP_KERNEL);
>> +	if (!sydev)
>> +		return -ENOMEM;
>> +
>> +	i2c_set_clientdata(client, sydev);
>> +
>> +	/* Initialize regmap */
>> +	sydev->client = client;
>> +	sydev->regmap = devm_regmap_init_i2c(client, &sy7758_regmap_config);
>> +	if (IS_ERR(sydev->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(sydev->regmap),
>> +				     "failed to init regmap\n");
>> +
>> +	/* Get and enable regulators */
>> +	ret = devm_regulator_get_enable(dev, "vddio");
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to get regulator\n");
>> +
>> +	usleep_range(100, 200);
> 
> Any reason not to use fsleep() here?

Thanks, I'll switch to fsleep

> 
> 
>> +	/* Get enable GPIO and set to high */
>> +	sydev->gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(sydev->gpio))
>> +		return dev_err_probe(dev, PTR_ERR(sydev->gpio),
>> +				     "failed to get enable GPIO\n");
>> +
>> +	/* Let some time for HW to settle */
>> +	usleep_range(10000, 11000);
> 
> And here?
> 
> 
>> +
>> +	/* try read and check device id */
>> +	ret = regmap_read(sydev->regmap, REG_DEV_ID, &dev_id);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "failed to read device id\n");
>> +	if (dev_id != 0x63) {
>> +		dev_err(dev, "unexpected device id: 0x%02x\n", dev_id);
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* Initialize and set default brightness */
>> +	ret = sy7758_init(sydev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	props.type = BACKLIGHT_RAW;
>> +	props.max_brightness = MAX_BRIGHTNESS;
>> +	props.brightness = DEFAULT_BRIGHTNESS;
>> +	props.scale = BACKLIGHT_SCALE_LINEAR;
>> +
>> +	sydev->bl = devm_backlight_device_register(dev, "sy7758-backlight",
>> +						   dev, sydev, &sy7758_backlight_ops,
>> +						   &props);
>> +	if (IS_ERR(sydev->bl))
>> +		return dev_err_probe(dev, PTR_ERR(sydev->bl),
>> +				     "failed to register backlight device\n");
>> +
>> +	return backlight_update_status(sydev->bl);
>> +}
> 
> 
> Daniel.

Thanks,
Neil

