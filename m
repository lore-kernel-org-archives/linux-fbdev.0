Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C52E9EDF
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Jun 2025 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254179; cv=none; b=gJ2j7M9vA9FD1B0X796id/GphdeAxF0B1Vqx3USKByK6hfrURtvC6GcVkP4to9s19W+Ln3g+xigECvwGMqjOIHcugVJWbXI5CSJjVIpCttASXOgbjmh75iVHPSf+a1dA1BHKzgg/sJEmc/rdK/1Ij/yWdriyCvxo23ZSppRkBYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254179; c=relaxed/simple;
	bh=0mUwlorZack9EZTeWHONLuPTPCVraK6g7EJxQmCJnQg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ox+USF1RW2B772v8aJ7aCEH4Y3jMEZYP3jj+V1L/FciNuCz0C07zLAtfwhvblt4bq4sAAtRh9eQXbujFhMM3WPZ6sUDt9JX0rwj9pA+TH91As/GxTDfJkahvDBnKInbPVIBsrjYV22oZvxSKBIH660jxWPjij4Q6VJIEAM6e9EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oB6ZrEUa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oB6ZrEUa"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso56586045e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Jun 2025 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750254176; x=1750858976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCiChb1QXFLYp+J+syrxrTXK706oTK1XE1OYkmW6jPo=;
        b=oB6ZrEUayhYo/zvaY1nPTLorK/DH3PdhY4+NVSBplQpz2fe+gKo1a2zl1LkBQesZjC
         egcZz83ol/PYlKFKv9Y7gJYDTVudN5IdNZTLP5nLQjW8ojYwTVWnruLkMe//lk3Guy6Z
         2BQ7jVck3NaFc6niKWhPnnk2FMto4TTjcsVltHKcYUdAiqCm3se9Vzy7tABDVWAQD0GB
         xtlu2Nt8K/SbFMm76uIlsaL6kRvtElxbLYudmQ4uEATRq4mfTeiusGg6M/NGo3hYFovT
         IcsN0Hnfz+22vENG/f2rh5D3k+tvqaK5hIg17PSYL+PeOjO01Xo4KJR76JQJfJN2RZZY
         wWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254176; x=1750858976;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nCiChb1QXFLYp+J+syrxrTXK706oTK1XE1OYkmW6jPo=;
        b=AHgH67B7j8U5KzoAAIH5Qm8oPlEMe9lO5Fo/+wpE9DDYAP7XiYlGWVk0pjd/xaMz3d
         9da3X4YS26d9IYABwZX8qoVRYR2w/x5XblsI2uSeo8nUwNgsUjewPO2/h2qaUvdPLt65
         eMVas+DMsbGtq5E5qs0pEebm1KS9Mzz01lj5KMw4Hh+OdAGvf3u31t5snsSSYAxFV+XF
         bJSkLfL/LjrJhX4OWLYZ04uomwZx6dPE9ZoT/0TZ5GhVTJHBYbygkR4Qdi8OOwa2wlS/
         c3Arqa+yYwdsrJbP9B7qB4KXC4EP3FKAilgEhohBr714LAgVg8HDUqwm7/ZPmD4/0x7f
         2Mhw==
X-Forwarded-Encrypted: i=1; AJvYcCV6JdqGfmBLCWNVBXER3qOFJewPAOG0Sa4aM6c/9134LjxRF6JCKD4Iqbf3zF6FjitUMLQFNwyOwaGzUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbLw3sFpvtAeYHyh1llnsAUh5WhyPWPPlsbISiur0yIwShlvP+
	NSwNd/KLpnIToeH62reABr7cZ/ZGW4El2XO0hxsp3aBW6YSSemEcoCrrzZaAf/TpDJA=
X-Gm-Gg: ASbGnctAyl9gHwaPIR409DMhufx4uMiZf8sM0ljo2JrGzX6ne6qTJ+ZESeMGeHsOixQ
	eDY7hF+tWurqB4/NhRP2MVCL+htTYGk5DLHjdG5ap8K1+xUEOugkzYVS7KI0dV5tgwv85txYZtm
	rKZT9MZTai3V5y/vt27N/1MWAU+yzbWyHqQ7xtMBWpVHQjDYLQc8+/XRVDQuAhsyngTJPVKWNPC
	tdOaDla0r90Aa8sok0jgyXlpreTQqzxeUjJXzXUHNEPS/QsLz916ud4IQ6zw+OC5sRuOjw2D7/i
	IrVyyJ4pA5Y+4fprNpWl6j0Vm+Ml0rSzWrrEF49jps/vsqk3PilzoMuPANXW7csLj/tbXcYDIb0
	r686HoJY00AzdfSo5ZCCQ2C0Kr9JuKlGxX1nS
X-Google-Smtp-Source: AGHT+IFYjXSzI2dMaGAAgqsOrkzwB1KxP63uuJ7AOWNd44e2f4HlRrKeC45xFQOdkM6Iz1JDQ6qBiA==
X-Received: by 2002:a05:600c:4e02:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-4533caaeb57mr147595075e9.21.1750254175671;
        Wed, 18 Jun 2025 06:42:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a29:d3c:4dad:4edf? ([2a01:e0a:3d9:2080:7a29:d3c:4dad:4edf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b1bc97sm17087804f8f.68.2025.06.18.06.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 06:42:55 -0700 (PDT)
Message-ID: <87908c15-5527-46ca-8fef-481a6f3d67c8@linaro.org>
Date: Wed, 18 Jun 2025 15:42:54 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 03/12] drm/panel: panel-samsung-s6e88a0-ams427ap24:
 Include <linux/of.h>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 danielt@kernel.org, jingoohan1@gmail.com, jessica.zhang@oss.qualcomm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, fnkl.kernel@gmail.com, j@jannau.net, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, sven@kernel.org, alyssa@rosenzweig.io,
 neal@gompa.dev, deller@gmx.de, support.opensource@diasemi.com,
 duje.mihanovic@skole.hr
Cc: dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-fbdev@vger.kernel.org
References: <20250618122436.379013-1-tzimmermann@suse.de>
 <20250618122436.379013-4-tzimmermann@suse.de>
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
In-Reply-To: <20250618122436.379013-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/06/2025 14:16, Thomas Zimmermann wrote:
> Include <linux/of.h> to declare device_property_read_bool(). Avoids
> dependency on backlight header to include it.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
> index e91f50662997..b6d04f8ad561 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
> @@ -8,6 +8,7 @@
>   #include <linux/delay.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/module.h>
> +#include <linux/of.h>
>   #include <linux/regulator/consumer.h>
>   
>   #include <video/mipi_display.h>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
