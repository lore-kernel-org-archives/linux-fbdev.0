Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2EC1F3D4C
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jan 2025 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738358869; cv=none; b=X2b0zuCskY3NfCrbqijK7PuBv/gA1g3XaXw0A0Ng8nz/25LF0ax/S77V98fCDBFXMPkMU3KaF4hYTdTBZGye1rS3PHdCeCXKJahm8DfchgcL0SejfjnjnR1jRPME7yH/RL3sYiYrgfrX9QUyDO/N92O0Hjq7XY6Vi72bEOWJSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738358869; c=relaxed/simple;
	bh=FDeA4+B4xxJNSnAzEXIAJkVJ3PT2yy8D1E7IuSV3R88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nu8KxouidofSyKr03l3lXis3iL/hCD1MjrEb45QnIDxN+SwMXoMUYcdH3m4WBSeIe44MMTyGtuRTHd9deibu2N6cP4CEFVdWDnsO8/Fk6TfiHFGvaBmC9rWwpf6b+gXqlt1gqgZHxrrZSPS7leCBxf+qTzdeMnUgo7J+npvHxjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e4Y2HIpN; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e4Y2HIpN"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb7ca55c3bso1415226b6e.3
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jan 2025 13:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738358866; x=1738963666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KVkeKDp8BQvTTjbPQCb4QrIee9efxV1gjW786NpzUDs=;
        b=e4Y2HIpNPOehBcQ62KnLSDVdiZeuhR/hkb6MfarMJpdP2IkfPUktCRbtU60WMSR/Ka
         8nXPWepALROf00EBfMTeIyOLDC5RQqGDruP/1gxACEwoHx+HtJhLQqNt5sEjk5+yVABO
         Mn4XD1ybl6wNVERAeH6sXljGolDQn8tTb5585NwWrhUEOQaAi8Zf/TlLMymU0c36osKA
         2M07WVZBdKs+XroXX2H/mCk2RcBG+9VSkMKfA0FKa5AeKpytlq5L8t6U8p2v4H/cIJFp
         BuQ1wNbK38sXCgSDDi5ZcowgD/Na4lfWM8RChd6O6dPP5Vt5466ph7ryRJq8aQrxS6Te
         90zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738358866; x=1738963666;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVkeKDp8BQvTTjbPQCb4QrIee9efxV1gjW786NpzUDs=;
        b=m4pSy0/FZxJzLMQcK0bkhSe/fFm3p9e/XEZf2mpArMjhCiLwfTPnym8Dwd6XI/NnKf
         DF9cjevUf3AFL9XD33n0wup9dJcrvklYGzi3by9vlzQGr1PltecDJ35/Qa+QXvG29sEU
         DNE5joAhiw2uZ1/86FkVOWwI7JY9bWyV9Y9Rb2HlJ06vCN8lJDRZ0RMvB9kAJ2cUcxdt
         ilmrM7w3ptZmYZgQdGrhfgU91hzmT3H9OQW60ETWFoNbbg83JMNmCSQYP7biJeKjAGpI
         TqqhwakSQQXrGzUn4gK/lme8YdhoN2V0OUGw7cybGkcNpNQFsFu+htyTgBk1qUxyh7pa
         7EiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvgKzXdqzknYNIQRcMpRSFtzTeDQfjZMJFi6AxPlY+WvWNx/cWMR5cK2W6g87LX5UhiKmB4KcCGsm0pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZG+fYSCWsQTaX4Y2xWQ22jto4X8C+wnx96Xwfoqj55xoIN75I
	ZyohvDpa2VCgN/uxNWt0Eo5wML/xEYMgq/2ZGWWTJ4RkrmBMKCVApMwiN9/lZxY=
X-Gm-Gg: ASbGncuqLPOECrXn0h7J7l3m7sMCvODv9hehlU8dG3PlqnQlGo3OyWJ2aVBF4rlVQyR
	AqGiVFNybbvIHml9+wBCYGna5avm6Et5V68BkpguqFKohOD0X+/FUUbXjT+JZJvUTfJfJlqzvJI
	T3g1HWLyt6xshsq6Y7eypPWkB8c+oTIthAeA/5+opcj2Pm9b0rR66IpeTcZV0/BVdXuMxD+SDH6
	11E5R1Bm/G86q0yztm1GQVhATFmO4NCcxqE6lg4huYbzKRVUiGlQwTd75Z+ejHNZzFp+AK+v8kL
	/kd1TQoILeQW/nqLWdZxFL5ISUl7PJCxAkAFJMEU1u2rZf3JgdoE
X-Google-Smtp-Source: AGHT+IEEpoW16oUpV4LltsxdkHnvZnJdHh1ZTd/FlmpTGCBVtpCPewZ9omSGGA1Q5C14YqPjOnjbAw==
X-Received: by 2002:a05:6808:1649:b0:3eb:5c03:2508 with SMTP id 5614622812f47-3f323a591ccmr8758300b6e.18.1738358866490;
        Fri, 31 Jan 2025 13:27:46 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33367f6c6sm1016692b6e.42.2025.01.31.13.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 13:27:45 -0800 (PST)
Message-ID: <1da68f05-9d53-44dc-bef4-4364e841b791@baylibre.com>
Date: Fri, 31 Jan 2025 15:27:43 -0600
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] iio: adc: adi-axi-adc: add support for AD7606
 register writing
To: Angelo Dureghello <adureghello@baylibre.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandru Ardelean <aardelean@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Guillaume Stols <gstols@baylibre.com>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
 <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-7-c3aec77c0ab7@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-7-c3aec77c0ab7@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/25 5:03 AM, Angelo Dureghello wrote:
> From: Guillaume Stols <gstols@baylibre.com>
> 
> Since we must access the bus parallel bus using a custom procedure,
> let's add a specialized compatible, and define specialized callbacks for
> writing the registers using the parallel interface.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/adc/adi-axi-adc.c | 100 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 0923565cf5bb..aaeb445a8a3e 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -27,6 +27,7 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  
> +#include "ad7606_bus_iface.h"
>  /*
>   * Register definitions:
>   *   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip#register_map
> @@ -73,6 +74,12 @@
>  #define ADI_AXI_ADC_REG_DELAY(l)		(0x0800 + (l) * 0x4)
>  #define   AXI_ADC_DELAY_CTRL_MASK		GENMASK(4, 0)
>  
> +#define ADI_AXI_REG_CONFIG_WR			0x0080
> +#define ADI_AXI_REG_CONFIG_RD			0x0084
> +#define ADI_AXI_REG_CONFIG_CTRL			0x008c
> +#define   ADI_AXI_REG_CONFIG_CTRL_READ		0x03
> +#define   ADI_AXI_REG_CONFIG_CTRL_WRITE		0x01
> +
>  #define ADI_AXI_ADC_MAX_IO_NUM_LANES		15
>  
>  #define ADI_AXI_REG_CHAN_CTRL_DEFAULTS		\
> @@ -80,6 +87,10 @@
>  	 ADI_AXI_REG_CHAN_CTRL_FMT_EN |		\
>  	 ADI_AXI_REG_CHAN_CTRL_ENABLE)
>  
> +#define ADI_AXI_REG_READ_BIT			0x8000
> +#define ADI_AXI_REG_ADDRESS_MASK		0xff00
> +#define ADI_AXI_REG_VALUE_MASK			0x00ff
> +
>  struct axi_adc_info {
>  	unsigned int version;
>  	const struct iio_backend_info *backend_info;
> @@ -313,6 +324,81 @@ static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>  	return iio_dmaengine_buffer_setup(st->dev, indio_dev, dma_name);
>  }
>  
> +static int axi_adc_raw_write(struct iio_backend *back, void *buf, unsigned int len)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	u32 data;
> +
> +	data = *(u32 *)(buf);

Hmm... could result in unaligned access and len is not used. Can we just have
`u32 val` as the parameter instead of buf and len?

> +
> +	regmap_write(st->regmap, ADI_AXI_REG_CONFIG_WR, data);
> +	regmap_write(st->regmap, ADI_AXI_REG_CONFIG_CTRL,
> +		     ADI_AXI_REG_CONFIG_CTRL_WRITE);
> +	usleep_range(50, 100);

Use fsleep().

> +	regmap_write(st->regmap, ADI_AXI_REG_CONFIG_CTRL, 0x00);
> +	usleep_range(50, 100);
> +
> +	return 0;
> +}
> +
> +static int axi_adc_raw_read(struct iio_backend *back, void *buf, unsigned int len)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	u32 *bdata = buf;

ditto (about buf and len)

> +
> +	regmap_write(st->regmap, ADI_AXI_REG_CONFIG_CTRL,
> +		     ADI_AXI_REG_CONFIG_CTRL_READ);
> +	usleep_range(50, 100);
> +	regmap_read(st->regmap, ADI_AXI_REG_CONFIG_RD, bdata);
> +	regmap_write(st->regmap, ADI_AXI_REG_CONFIG_CTRL, 0x00);
> +	usleep_range(50, 100);

ditto (fsleep)

> +
> +	return 0;
> +}
> +
> +static int ad7606_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	u32 buf;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/*
> +	 * The address is written on the highest weight byte, and the MSB set
> +	 * at 1 indicates a read operation.
> +	 */
> +	buf = FIELD_PREP(ADI_AXI_REG_ADDRESS_MASK, reg) | ADI_AXI_REG_READ_BIT;
> +	axi_adc_raw_write(back, &buf, sizeof(buf));
> +	axi_adc_raw_read(back, val, 4);
> +
> +	/* Write 0x0 on the bus to get back to ADC mode */
> +	buf = 0;
> +	axi_adc_raw_write(back, &buf, sizeof(buf));
> +	return 0;
> +}
> +
> +static int ad7606_bus_reg_write(struct iio_backend *back, u32 reg, u32 val)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	u32 buf;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* Write any register to switch to register mode */
> +	buf = 0xaf00;
> +	axi_adc_raw_write(back, &buf, sizeof(buf));
> +
> +	buf = FIELD_PREP(ADI_AXI_REG_ADDRESS_MASK, reg) |
> +	      FIELD_PREP(ADI_AXI_REG_VALUE_MASK, val);
> +	axi_adc_raw_write(back, &buf, sizeof(buf));
> +
> +	/* Write 0x0 on the bus to get back to ADC mode */
> +	buf = 0;
> +	axi_adc_raw_write(back, &buf, sizeof(buf));
> +
> +	return 0;
> +}
> +
>  static void axi_adc_free_buffer(struct iio_backend *back,
>  				struct iio_buffer *buffer)
>  {
> @@ -484,9 +570,23 @@ static const struct axi_adc_info adc_generic = {
>  	.backend_info = &adi_axi_adc_generic,
>  };
>  
> +static const struct ad7606_platform_data ad7606_pdata = {
> +	.bus_reg_read = ad7606_bus_reg_read,
> +	.bus_reg_write = ad7606_bus_reg_write,
> +};
> +
> +static const struct axi_adc_info adc_ad7606 = {
> +	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),

Is this the actual current version we are testing with? IIRC there were some
changes made recently for this variant of the IP block so would be best to make
sure we have the latest version here since older versions might not be working.

> +	.backend_info = &adi_axi_adc_generic,
> +	.bus_controller = true,
> +	.pdata = &ad7606_pdata,
> +	.pdata_sz = sizeof(ad7606_pdata),
> +};
> +
>  /* Match table for of_platform binding */
>  static const struct of_device_id adi_axi_adc_of_match[] = {
>  	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
> +	{ .compatible = "adi,axi-ad7606x", .data = &adc_ad7606 },
>  	{ /* end of list */ }
>  };
>  MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);
> 

