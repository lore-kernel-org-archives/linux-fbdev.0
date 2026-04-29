Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182AE39B4A6
	for <linux-fbdev@vger.kernel.org>; Wed, 29 Apr 2026 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453434; cv=none; b=j5ZXfBwZV/uNGT8uDs6o/OorL+UETEgp4iAwfeJQfTNNZ1kVuicPtio9CNu6+21oK6EHzbx8v7b4t1V10MAm5sQL7/eyU/8ayEe1aw+AbzN2hXOi2UH654hjQ/pE4fHLdELRckuBsBFCiW1NFa/xr0ogOeMLx5RMtazZ3211X+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453434; c=relaxed/simple;
	bh=HMbidjnXWQ7dqAUl70UddiBL/hKnsrslsSh+V6/N6Xc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hbp7eo0EmTfuijhjQcVXoM8je7gElQxWuyF3Xw26guN/jcqthlRs/0Bt+my8p5XcoUCuqzmeHDbEVB3RVJET+3nl8DGbHTnw5ZhtvJVlrIReSUeajUtvCeEkVLTjZ7GqEiHIXbTdM5gWsOgfDkJiL6iEbBX3hO8dD4KDlDE0bXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WHsQlU8f; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WHsQlU8f"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-445795cf6f1so1593995f8f.1
        for <linux-fbdev@vger.kernel.org>; Wed, 29 Apr 2026 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777453431; x=1778058231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSpsznma6FPd297vSkEgjiyMuhjrOLr3Zucu2Me0roU=;
        b=WHsQlU8foQ+rzkhUOSJTTx2gyC9NjYHFKsqO3zg/q7Nj23wX3qJP7EZ9jGdN0iiGCB
         peyYnog+3C9YbqDd/PVLomDIAHviw9blPFmAHOYsznzK08+jZjN9bcElTBDFYkJ8JqQ/
         lM+HJGaQGpmi9AfAoVVpZWK8JzTHnOUFdNQiOS/PATO74t2dEeK8J98oZyI5ZsFjHVtf
         rYL7GxDVzodOMYZRaDuGTXFd1ldLBm7fWfNoyHHUDb47ZN7J1PGwXuQiRmCE0Bth6Ryv
         8Obb0CrTtYeUFa5r2eL/XhmLl8d9JMP64mB4BdIzEorGsY8guXP2LuaEoCChzPzPLCJ5
         xDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777453431; x=1778058231;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSpsznma6FPd297vSkEgjiyMuhjrOLr3Zucu2Me0roU=;
        b=VmsxmkHYl0AV4RoNawbct+g/3kkZ1o1ZyWRkdaML5/ZXXFf2itRZcq0XhWUKb6/J5F
         cshXUfUCSFiHCeaboFHiJYXCPMw+OfCCIwGjqb2N+b9bMhR1kZR1rZdTigA4t85ZpAmG
         5/II9fevbWqJdtfnImUi9n+hV2HxGwLohXO+7sgOna2N8QSG9UeIYt6jeYS+F7r15hQz
         66GvDlKgImujYjGIi4+W8ZAvvnHi0JBCrZJpGnQEuMbfGsP0rLnPL30/jxbjk85Kogvb
         MLtWuGKlZnjJRamj1Mmfa3+zBZ68z6scN6TmpKxuDvZRevjq+UfPUXCu+swrp8MPbFxo
         GjJw==
X-Forwarded-Encrypted: i=1; AFNElJ9rHYIHxZkdwNfKKa8JO/43YbmwtQHcRJPZBASUPM1+k1ITIGT7CNCeRXmbUrz+XGp1dcPBTdfhTTVs0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUTxm8kaB6UZ5a0LoNcMx7XQtWnTIy2OrcPdzJe/kwiR6B8gjQ
	3KWmkNFD5f4OgVN5xzrVs7SqcXh371om+G2IDH4E+rscKT/pdP6fjoO4F8yzH0dEtBo=
X-Gm-Gg: AeBDietzPRoK0AaRu6KDl/icleoMqNE6HsOahvjnlTNibGv/YKzs+Oh6IdR9Y2P2vEv
	OaE5mMWpKtiOtvJ47E4xrA/9ht0T3ld13PpGHDxMXSH5cGSPqyLaFZc9m4VXafL5MvzZ12EXxkW
	bXwu/qQA8XF6+tcODe9HKoNhM73ArPvF8YQOl7Z2blvaS4/JWdU3dN0OgbvxpBBSiMBOSmC9Q5k
	tOp0G2ZAlIIs7ycHi0r3jeVw4Sx1FYp1cRsyRamoUozVP/OgrGlAHm0dZXZ3pDKS3kr3ZnDHEG3
	At4HuVLM8+VQo4WakP4N/4gaU0yqcu3CFDy9kPxsSpkLuVdrjUnF2KHZHqen3GkQm9dZsUdDOGi
	m2JmGt3xPOCBsQrgmYum6JewNvKXb1nkVg+v9xxtFRn1+VZ6FnWpLwqDmzDgH20IhZfbWG8ebRV
	lFOZxeVQdXv6cRmemDJqPafgXFMSdZz8kpGDpGFrxM3EiEqqNyuu4ObFSjWZ+hW8ILVSrzKvFmy
	jM/M8bk0gRuqJeNyA==
X-Received: by 2002:a05:6000:2dc2:b0:43d:7403:4b65 with SMTP id ffacd0b85a97d-44648f28e88mr11536798f8f.6.1777453431182;
        Wed, 29 Apr 2026 02:03:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b679:2e1c:a552:545b? ([2a01:e0a:106d:1080:b679:2e1c:a552:545b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5bf2sm4322188f8f.27.2026.04.29.02.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:03:50 -0700 (PDT)
Message-ID: <bac23b70-758f-4944-b040-753fc40a53c5@linaro.org>
Date: Wed, 29 Apr 2026 11:03:49 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] backlight: Add SY7758 6-channel High Efficiency LED
 Driver support
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>
References: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org>
 <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-2-0caade5fdb32@linaro.org>
 <CAKbEznvPAYFUt-ykH7rCQwMFUq6N68B9x7Dd97WRDm3Mvj34fw@mail.gmail.com>
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
In-Reply-To: <CAKbEznvPAYFUt-ykH7rCQwMFUq6N68B9x7Dd97WRDm3Mvj34fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/26 01:35, Gyeyoung Baek wrote:
> Hi,
> 
>> +
>> +static int sy7758_probe(struct i2c_client *client)
>> +{
> 
>> +
>> +       /* try read and check device id */
>> +       ret = regmap_read(sydev->regmap, REG_DEV_ID, &dev_id);
>> +       if (ret < 0)
>> +               return dev_err_probe(dev, -EPROBE_DEFER,
>> +                                    "failed to read device id\n");
> 
> regmap_read() seems it can return errors other than -EPROBE_DEFER
> (like -EINVAL,), and hardcoding -EPROBE_DEFER here might drop the
> actual error.
> And maybe would keep retrying probe forever

I forgot to change it, initially the powering was clunky and we had a read error
in the first probe, but now it's solved so I'll remove it.

Neil

> 
> How about this?
>> +               return dev_err_probe(dev, ret, "failed to read device id\n");
> 
> 

