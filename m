Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FA4280A56
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059047; cv=none; b=kSOo2yHLLx+VJLiUA8sloA4jdO33eF5WWqayEQlPAeXQTuugVzYNyfO2xH6jK6ZY09ijdUc9he9ltg5KU1rhYu/ny7kcK+ztT+/rcnQQ68tR9rtk33PpMUDJ2Kd74iiQMi9eYDTHkplRiX9QEFR4LWAQYsNfbKbV4zV+OSoiYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059047; c=relaxed/simple;
	bh=kjmAeA0WIYxplZf0lI6NSpHtYD/nF1xj0SWbgmpaoTo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=igQS/bwPDpta3hTvFKZnd9Ydr+W7A6i00h3x9nv3FTO123DhPbNIEWjrUW+c4FK5P+Vlq1rEZw82ECFttpD4v/rhqthp65KzJead/CNtzteTRcuPr4MtawdhaOFwNkvV61Rx7BtJpf7RJmYR8moIaHSY9DmxLkwNgovo0LWV1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yU8MOVZw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yU8MOVZw"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d77f6092eso7854210f8f.2
        for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780059045; x=1780663845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsdtKyBNIze1lqIATJulyFXg8jvRauNrlgVPkVHHWJU=;
        b=yU8MOVZwMaziJbTMGR6wkbcLLdAU+qRbrZGUUUAu23VSVV6JSNt+iZRrkeHuY1jkqu
         /NZQQt7hTAf3L8om0YINQGKroGR8TAhxuSFeEdpa3TRgswYyN0g45DdtcwPIULa/rlkd
         sDpfQzj1Wy7aPBzoVvOysiB15y2xY+Z/w3U4NFx+5lFVI6If3jQactlEvz8+dGnVdpne
         gMRVQdgstt+jfZUc7us5MjHgLgGYFc7f9vPQMGIbytYsPykAneNeN/6hPysl0BE4yGOS
         WC/o5nNzq4i+NXN8bdEEBMrn/ScQi9cQni6IOix70WneLyvLTbGCpDlKMh1CbNuxbhG9
         2dPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780059045; x=1780663845;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsdtKyBNIze1lqIATJulyFXg8jvRauNrlgVPkVHHWJU=;
        b=immDTkG57z55xeZooFLgiSkKn84NRBQlthEn5mXYLfhzZxEglc5LIPsiLuLAUWxk/g
         6Pvo/qNpBvsNLYAlhpR4XnDbY1NV96k+qFLmarGXUF8P2A0rVc6C0SFAPwSDEysZszYe
         3b8QP09s1yrpUCbM8f3ukuCRbilmPXifFlaU2o65YCOCpTI9p2CKbXqfbuA6o7RESKJu
         1kaEsr/j/O7rwQAj/qe6BQ8wDbBu9o9kWE0ebP4goAXKvJ4LuvL/VU5hGt7rBI+/7SXp
         PU0AAhVyrMqwJYEBYZA3GZNZpA5CH5CcdsAaEKiC3TBBXlgmJJL07RXs8TYBlsBgCmqG
         hiZw==
X-Forwarded-Encrypted: i=1; AFNElJ9W14LjlElHvDKHBl8nUSdI34AAI8ViVXWjCFkSX0RAgWnTYMDxEzjFNRVgEq5NGoTu8vS0J3OUPqWwug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8AgIeFdtVlkw+FLnuisgeq9k0e7ZZCsGyLkaZiO36Du8ASGy2
	50vZtzrMPWYvZ2WhWjZhJ6eRpCoGUmaf8rSJOCv8x32WFBsICiUV/cNw3uk/8gUDmhk=
X-Gm-Gg: Acq92OHSOeLfFj5mCiMrZXJfACipLevOygpiL63pzjuoMY+LAVZZzODna7spG3Hyo+2
	BFTKygC4PlySOWCGemy76h2aeShZ2OfAGTq0iQFUWqtmAG0bxJLWjowISIy4hoh3oJzhEMrOLKd
	KfSDHvrHbv/7po+1/NyvzPDojPSgrMwP9PjEdr1pUbZFEm/msNcSYfwuEAKSBZRQe3T4IWbvXPP
	4nkY78I0EA2R0N6m50YMwV3mnptqd79Q1jxVTzrpg8emJyhNOdQH2itxK8OCow/G2Dlc4OkyE8o
	5calmstt16WMD+/zFRS1jE6YYQwYUNLl00IdSXxuJsn39obVkWCKiJ27ENRqm+xSZ04BPz+K307
	GJWn4PWYsC4OdRItDsi5CuGXWrMv9F/SqecceKUtvSsFZ2EEGFsmzh97WlHjhPzy8JdY8aeCkFu
	FVczEE3/tRMy5xoppXZ5rfxKrTlAgNHb8rmhsUjhwOhJmQHAumwIKgTBnO0cFftL60C7pB2lHgm
	xc/m64hTgK4T9xe3H+ZeBsWbNvr
X-Received: by 2002:a5d:5d0c:0:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-45ef1403b76mr5200312f8f.15.1780059044315;
        Fri, 29 May 2026 05:50:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b6d0:a628:be51:f552? ([2a01:e0a:106d:1080:b6d0:a628:be51:f552])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354b5bdsm3169110f8f.21.2026.05.29.05.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 05:50:43 -0700 (PDT)
Message-ID: <4001cf6a-b7de-4933-96bc-c9b4ccb53e4d@linaro.org>
Date: Fri, 29 May 2026 14:50:43 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
To: Daniel Thompson <danielt@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org>
 <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-1-ec8194bbc885@linaro.org>
 <ahllT_HVTAJ5MbkS@aspen.lan>
 <e3c99fe3-9279-4dfa-af69-d9366ab06837@linaro.org>
 <ahlr5PnX5O0tEd6G@aspen.lan>
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
In-Reply-To: <ahlr5PnX5O0tEd6G@aspen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/26 12:35, Daniel Thompson wrote:
> On Fri, May 29, 2026 at 12:16:07PM +0200, Neil Armstrong wrote:
>> On 5/29/26 12:07, Daniel Thompson wrote:
>>> On Tue, May 19, 2026 at 10:43:38AM +0200, Neil Armstrong wrote:
>>>> Document the Silergy SY7758 6-channel High Efficiency LED Driver
>>>> used for backlight brightness control.
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    .../bindings/leds/backlight/silergy,sy7758.yaml    | 53 ++++++++++++++++++++++
>>>>    1 file changed, 53 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
>>>> new file mode 100644
>>>> index 000000000000..80e978d691c2
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
>>>> @@ -0,0 +1,53 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/leds/backlight/silergy,sy7758.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Silergy SY7758 6-channel High Efficiency LED Driver
>>>> +
>>>> +maintainers:
>>>> +  - Neil Armstrong <neil.armstrong@linaro.org>
>>>> +
>>>> +description:
>>>> +  Silergy SY7758 is a high efficiency 6-channels LED backlight
>>>> +  driver with I2C brightness control.
>>>> +
>>>> +allOf:
>>>> +  - $ref: common.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: silergy,sy7758
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  vddio-supply: true
>>>> +
>>>> +  enable-gpios:
>>>> +    maxItems: 1
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - vddio-supply
>>>
>>> Sorry for missing this in v2 but is vddio-supply really a required
>>> property?
>>>
>>> It's unusual for supplies to be mandatory (and the it is not mandatory
>>> in the driver implementation).
>>
>> This device is a little bit special, the VDDIO regulator is used to provide
>> power for the I/O via the enable input, so basically the enable gpio power
>> level is provided by VDDIO.
> 
> I don't follow. The EN pin acts as both VDDIO and as an enable but it's
> still effectively a power rail isn't it (albeit one with very low current
> draw).

Here's the datasheet description:
```
Dual-purpose pin serving both as a chip enable and as a power supply
reference for PWM, SDA, and SCL inputs.
```

The VDD input is directly provided by the panel, so Linux has no control
of it so I haven't added it.

> 
> It looked to me like the correct way to model to two power rails
> going into the chip is vdd-supply (main power supply) and vddio-supply
> (EN/VDDIO) I don't understand why a single pin needs both a regulator
> *and* a GPIO in the DT bindings?

I don't have a the schematics of the board, but as I understood one gpio is
actually enabling an regulator which provides power to the IC (vddio) and
a second gpio will either drive the EN signal to GND or VDDIO to provide a
clean rising edge on the EN pin.

So it's not really 2 regulators, and having regulators means the enable
signal can be shared and would have regulator characteristics which it hasn't.

> 
>> This is the recommended way from the datasheet, and I assume it will be used
>> like that on other platforms (if it exists...)
>>
>> This is why it's mandatory and enabled first before setting the enable pin.
> 
> It's not mandatory for the C implementation. devm_regulator_get_enable()
> will provide a dummy regulator if the property is omitted.

So yeah if you prefer I'll re-spin with the vddio regulator as optional
because between both, the VDDIO is the only which could be shared with
other devices or always-on.

Neil

> 
> 
> Daniel.

