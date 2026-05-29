Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AB82F549F
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049773; cv=none; b=Oak5JmXsoGE1bvFGzwwO7suG/rdP2ctBV2GY32BP+3FkwTBe1dYDp7fg98hmhybJI81YPOrMHvPl+b8DDt6Ne5vJoJSv7a8kUQ5xRPyP/FbeBQM6UXEwM4A37X4ZLOLL5x+vC2ufhpNtwralNhWEiJkKI+cW2t5U1k7hqxpUXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049773; c=relaxed/simple;
	bh=Rb9pRMEWHB/11ewFIykCa7O3GdM34VtT66K9ppLOmLc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lOmCABATS5bb/SSwUqvDB3YM061vxuheaHBX7F7wFuXB3o8cxE2lsWTyXTY8ajCKOVVByixm4a8ksuSUp+gFA9NRwJeksn+Heo3g8/srlIVILtoNVZ78b2PbBQ6mjUNo2EHGNgHUnDxHrvxoOTqguUNGTvNK5dwDsSOd0frji+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uIUL9CNH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uIUL9CNH"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4908b92904fso22786395e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 03:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780049770; x=1780654570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zY32vo4wGSfZ5uOAVtxfFcwmsUjSGjI2ELbc4pDk6qU=;
        b=uIUL9CNHpLGPRwdFb21rsg/w1BFlOt1dVNsPtSC8bR0gaDfEyjuAvjL7TAGrOYQBJi
         XaFsGfdVrd+jzrnyuQl6NpJ3a2ATJlgdiiLsmIQUGTRVLQiusevdlTUOT0fzmm7x8zdN
         TjuaaHTQMpQe/rc+Tw5boYCMdTyKOLNVQUQjYsxTUjU0vImb64e9TFPCSWo1H6Es5r2K
         /qSjhGOxub+PgpW2+lI7/Q27b41te3+eNChnOnsi6asLTOlIguidxvD8QqhzDOk9SKuH
         gzFGhIMLi90cl4WQZFXDrKUCioONUrvY16oYLEowm++FcTK+6s9h8TwF0fXUh0/0YuO9
         Ncog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049770; x=1780654570;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zY32vo4wGSfZ5uOAVtxfFcwmsUjSGjI2ELbc4pDk6qU=;
        b=sJhIKXgXi59E+iZHXWiZeXjrkYOJ+7qujXjwo6ktuu3e7bl+O8CivIl/QBQkv9gxDw
         RiEzVfzBQVxwYNUczwIt+5mlOTM47Tnc7nb6iG0gxNxnbOdvedKsO2S7iyeWy2EpP1r2
         boepb5TEjdbgbGnqeEmu+exFd/u+qv/wWAihST5SZT0e/GTVIUTKY4w/KHdae6dq+Ifb
         gp3D2niY3MoLzQCl3Pkf+kcdyd/y4tNYBl2Y3f2+n/Dgf5P7+ZTLQPiddKXTTtU3ZFDE
         Vc8rVkWbaMhNPSxtXqkVTj3bhTiHvjwkFHRFr+nA1iU4qaGYC7OOzHOFKInfi/6rBHAS
         yC6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+R3gUhXZlYKKBuYirVtQls/Ift8SzsECd+j1pZSuidBiD9b7csT6LzI0Nu6+Wa6VLaaSHrZ5Gzw5YJUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnl85kc6nrqXWFLLEslGeWCh2Dg3QtRi9/nvwt5ho0myn8Ww5J
	ZwSzXa5glh/plfMeJ2xmJ3ZJOVarGQ3DotF0/BGPh8YUdLMBQMwU8qnjXCBEqkvIABM=
X-Gm-Gg: Acq92OEabn6R+dQ90bsjWe9VQ1lwNMskJwHDF9gM5GRCz8wWviOVgHu2wB6Vbl+WW/U
	OOx/unyJMurokfZpb/Pk+aHsVv1xSefJMd2BQlGmN5Zu3h36jptch0YESfBOpVymzgo6XDGMwAs
	SsGx7SIrAKvQbJzlgUtE14sBx0XmNYLXNup+P5c7TUrn3ZG8/5SdgSQ2ySAd6b1gCZPzTIXPxvg
	VfopBQbVcJGcvGvWAO5niA/z6q5odvViDLUTLf3Cs+qCwdtPqo06Oj8ZT8gvYk1EMMjYri2gc7t
	P2YgZBGMFDdKLtsFzQEv4iF7JXyjARiD0CVk7pcLeEn84DVVYweMz1WP2Ijd1/SezYXj+GpaLuO
	/8LNLiSIHZBRD+0NxOJG31+0P4IC0jOnm/d9MbmFAykrhb3tw67Dyc6EYYU92/on4rKjLmHeVoz
	5s4ZeHsphhmPNMw+sUc/n9DT2f1OpTXtSEddFxfXoWZHQ=
X-Received: by 2002:a05:600c:81c5:b0:490:3bad:3784 with SMTP id 5b1f17b1804b1-4909c0a7e03mr36047785e9.18.1780049770022;
        Fri, 29 May 2026 03:16:10 -0700 (PDT)
Received: from [172.20.10.3] ([37.167.116.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354b7edsm2332881f8f.22.2026.05.29.03.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 03:16:09 -0700 (PDT)
Message-ID: <e3c99fe3-9279-4dfa-af69-d9366ab06837@linaro.org>
Date: Fri, 29 May 2026 12:16:07 +0200
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
In-Reply-To: <ahllT_HVTAJ5MbkS@aspen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/26 12:07, Daniel Thompson wrote:
> On Tue, May 19, 2026 at 10:43:38AM +0200, Neil Armstrong wrote:
>> Document the Silergy SY7758 6-channel High Efficiency LED Driver
>> used for backlight brightness control.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../bindings/leds/backlight/silergy,sy7758.yaml    | 53 ++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
>> new file mode 100644
>> index 000000000000..80e978d691c2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/leds/backlight/silergy,sy7758.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Silergy SY7758 6-channel High Efficiency LED Driver
>> +
>> +maintainers:
>> +  - Neil Armstrong <neil.armstrong@linaro.org>
>> +
>> +description:
>> +  Silergy SY7758 is a high efficiency 6-channels LED backlight
>> +  driver with I2C brightness control.
>> +
>> +allOf:
>> +  - $ref: common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: silergy,sy7758
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vddio-supply: true
>> +
>> +  enable-gpios:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - vddio-supply
> 
> Sorry for missing this in v2 but is vddio-supply really a required
> property?
> 
> It's unusual for supplies to be mandatory (and the it is not mandatory
> in the driver implementation).

This device is a little bit special, the VDDIO regulator is used to provide
power for the I/O via the enable input, so basically the enable gpio power
level is provided by VDDIO.

This is the recommended way from the datasheet, and I assume it will be used
like that on other platforms (if it exists...)

This is why it's mandatory and enabled first before setting the enable pin.

This should probably be a comment in the code.

Neil

> 
> 
> Daniel.

