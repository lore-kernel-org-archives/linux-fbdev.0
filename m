Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386DA7E1
	for <linux-fbdev@vger.kernel.org>; Wed,  2 Oct 2024 00:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727827955; cv=none; b=ZNe1BqVkwIS25eU4mh6nHFYklp4f8BfnCDpgDdYsXifWVt2Wa5SMZGOO5qaHtwSptdrUO/yHGDb8p6PdQGkLoJJQb1r5NJn2yqskPvDO+un9CwNqlmoqE51YRQ9dKy9uc2KvmXcm7HPhKSXw/kMi5eMewN0zveEktzzYJP82SCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727827955; c=relaxed/simple;
	bh=1dvAewY9SUvb0mk5qJ4rGjPDkImylQFiv3WD7bkPzv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCxfBm3249eLIh1HgFNsWmsyYFDVHVWP5E9APvtvTxviHF7IFFWJZOAt03J9/aYWu4EtWKcE416yFQv0sUx6XVrHmufgrNmjTwoEsPvq1FAuT8GXi2a+VqROrvQJbOkvpliCQ+dC/B/sN9vSokGy5yYVu5J/b9xxMBH06KxX5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bO03AL+3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bO03AL+3"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cba8340beso1637845e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Oct 2024 17:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727827951; x=1728432751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnlZlNXn2r5SdItECP2y/9nvB0cJmPdzYGUIF7uGZ04=;
        b=bO03AL+3bDEKFXQWWSDcEOAkKy6YCO0ay/c9IommrCjY9RheiNV1saQDYRINQl6eeH
         m3kmOL5cgwNUuhuYZm6jjsuZYxU4veO4onAbW9C7wm3AOE5aRqsqBhv9+TK3MvFQGzDx
         8KmMrqMquOlXdMgQLloDg+UxBjJzFkzmHWSK4HoX8osw8aqF3wBoUXoobJgOISwrogct
         lqa9TrikDCD9RqFhbgQWAp+m38Vre4wc3wtBQcDlauJgcwCjSmdrc91Websbvc4xUlxd
         n6qbkR1UxTHpNhxsyBN1hnHkHgXO/J+xPfOFkNw/WgvAf8qJAHC5gkK4jh3Q+BnN9tCG
         Zg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727827951; x=1728432751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnlZlNXn2r5SdItECP2y/9nvB0cJmPdzYGUIF7uGZ04=;
        b=fNkZGlzVVolqOBcQPw8g5j+wWQ+j2kJpo0lxCh29csqHzwDlFt41pFXnWQqmpPmUN5
         tTzWE+jrDHATQu2grZYG4KV/p+mB6llL9zY/6t4UYJdb55U1yAfqByLyW7zfPq8fa03i
         HutI9ev/MJ0Umg5iHaXt3flhJ1DrOHkXQyiHWwRIE1T9mCrJ2INtQ52LoDnHVaFvuyge
         o4FwJcxjmGTiyKPRA37pljQIsY1vvMvLY1Lc2iLtyZPNK/wW2L+CL/ZLzphW/O76LCOu
         INzOIqvsgGI1vSlUw0yzPmv98ChLmgXZz8TmBrZR7Q/nIezG9VWsfd9rXHnYlPUMYHVl
         9hWw==
X-Forwarded-Encrypted: i=1; AJvYcCWJGzDHIDydHCru31MzrfUQtcyJ/QI++dRyA1JJ7rLy3XllrdIJ3v8mKdvmVKQYe+ygYeyrz+e67hVFTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxnn8TaVDfoSlSt6bobROiYXPjwTx3P/xw6PPWh0O6pnh5qdBC
	hAZtArHZiFRavaXzsV8Jr9/ZGYS0YPQgTwvuZFmX8EFnIcjZ0azy/15TK2Ie2k0=
X-Google-Smtp-Source: AGHT+IFp1BBQhueLTaa7zDs8f+Zi5EqjDi4QIQvUe7MIuBWL3xI+PhtuHQuGbzZ+x1anGNvzpcEkAw==
X-Received: by 2002:a05:600c:1c1d:b0:42c:b98d:b993 with SMTP id 5b1f17b1804b1-42f776cf4f5mr6796725e9.2.1727827951070;
        Tue, 01 Oct 2024 17:12:31 -0700 (PDT)
Received: from ?IPV6:2a04:cec2:b:2aca:1b10:f81f:8179:6179? ([2a04:cec2:b:2aca:1b10:f81f:8179:6179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7727f72fsm11119285e9.1.2024.10.01.17.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 17:12:30 -0700 (PDT)
Message-ID: <57c5d8b1-295a-492f-b17c-b44caf8aeb2d@baylibre.com>
Date: Wed, 2 Oct 2024 02:12:28 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] iio: adc: ad7606: Add compatibility to fw_nodes
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Michal Marek <mmarek@suse.com>, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, aardelean@baylibre.com, dlechner@baylibre.com,
 jstephan@baylibre.com
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
 <20240920-ad7606_add_iio_backend_support-v2-7-0e78782ae7d0@baylibre.com>
 <20240929134412.506998db@jic23-huawei>
Content-Language: en-US
From: Guillaume Stols <gstols@baylibre.com>
In-Reply-To: <20240929134412.506998db@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/29/24 14:44, Jonathan Cameron wrote:
> On Fri, 20 Sep 2024 17:33:27 +0000
> Guillaume Stols <gstols@baylibre.com> wrote:
>
>> On the parallel version, the current implementation is only compatible
>> with id tables and won't work with fw_nodes, this commit intends to fix
>> it.
>>
>> Also, chip info is moved in the .h file so to be accessible to all the
> chip info is not moved (I was going to say no to that) but an
> extern is used to make it available. So say that rather than moved here.
>
>> driver files that can set a pointer to the corresponding chip as the
>> driver data.
>>
>>   
>> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
>> index c13dda444526..18c87fe9a41a 100644
>> --- a/drivers/iio/adc/ad7606.h
>> +++ b/drivers/iio/adc/ad7606.h
>> @@ -38,8 +38,19 @@
>>   	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
>>   		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
>>   
>> +enum ad7606_supported_device_ids {
>> +	ID_AD7605_4,
>> +	ID_AD7606_8,
>> +	ID_AD7606_6,
>> +	ID_AD7606_4,
>> +	ID_AD7606B,
>> +	ID_AD7616,
>> +};
>> +
>>   /**
>>    * struct ad7606_chip_info - chip specific information
>> + * @name		device name
>> + * @id			device id
> ID in chip info normally indicates something bad in the design. In that somewhere
> we have code that is ID dependent rather than all such code / data being
> found directly in this structure (or callbacks found from here).
> Can we avoid it here?

Hi Jonathan,

chip_info has to describe the chip hardwarewise, but there are different 
bops depending on the wiring (interface used, and backend/no backend).

The easiest way I found was to use the ID in a switch/case to 
determinate which bops I should take (well it was only needed in the spi 
version since it is the one supporting almost all the chips while the 
other ones still support only one). For instance, the ad7606B will use 
ad7606_bi_bops if it has a backend and ad7606B_spi_bops for spi version.

If I can't use the ID, the only way I see is creating 3 fields in 
chip_info (spi_ops, par_ops, backend_ops) and to initialize every 
chip_info structure with its associated op(s) for the associated 
interface. This would also lead to declare the different instances of 
ad7606_bus_ops directly in ad7606.h  (I dont like it very much but see 
no other option).

Do you think it's better that way ? Or do you have any other idea ?

Regards,

Guillaume

>
>>    * @channels:		channel specification
>>    * @num_channels:	number of channels
>>    * @oversampling_avail	pointer to the array which stores the available
>> @@ -50,6 +61,8 @@
> ...
>
>> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
>> index d651639c45eb..7bac39033955 100644
>> --- a/drivers/iio/adc/ad7606_par.c
>> +++ b/drivers/iio/adc/ad7606_par.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/module.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/property.h>
>>   #include <linux/types.h>
>>   
>>   #include <linux/iio/iio.h>
>> @@ -89,12 +90,20 @@ static const struct ad7606_bus_ops ad7606_par8_bops = {
>>   
>>   static int ad7606_par_probe(struct platform_device *pdev)
>>   {
>> -	const struct platform_device_id *id = platform_get_device_id(pdev);
>> +	const struct ad7606_chip_info *chip_info;
>> +	const struct platform_device_id *id;
>>   	struct resource *res;
>>   	void __iomem *addr;
>>   	resource_size_t remap_size;
>>   	int irq;
>>   
>> +	if (dev_fwnode(&pdev->dev)) {
>> +		chip_info = device_get_match_data(&pdev->dev);
>> +	} else {
>> +		id = platform_get_device_id(pdev);
>> +		chip_info = (const struct ad7606_chip_info *)id->driver_data;
>> +	}
>> +
>>   	irq = platform_get_irq(pdev, 0);
>>   	if (irq < 0)
>>   		return irq;
>> @@ -106,25 +115,25 @@ static int ad7606_par_probe(struct platform_device *pdev)
>>   	remap_size = resource_size(res);
>>   
>>   	return ad7606_probe(&pdev->dev, irq, addr,
>> -			    id->name, id->driver_data,
> Rewrap to move chip_info up a line perhaps.
>
>> +			    chip_info,
>>   			    remap_size > 1 ? &ad7606_par16_bops :
>>   			    &ad7606_par8_bops);
