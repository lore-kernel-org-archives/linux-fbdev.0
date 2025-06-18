Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2C38F80;
	Wed, 18 Jun 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251681; cv=none; b=KLPOUtz02oZaM1kAIHiozAUpzZZMuDn2pvBE3DfI6EvNe+vbqOJlpE4nn2AUCBPOBS/qGqQTM5XrwzaavtR4no12ReKpYVw8ouVQKpRqEL1RMLOZPP3lSWAZ+rYbQ0nOXF5ihtf0YFfpTl0O2b2m5ivuL0A+pk9NrV9WH+zjQLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251681; c=relaxed/simple;
	bh=u7wvhY7UzWw1Kiz3j8CRU+e4HYpWNK/WmjXrT+hmz1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEiCZn5gPiXHREohlZ63Wn6yFjj7a9OClv4RrTOsnuhqMHeRldAeikngqcu1eqA4eDye9qA+C151I75guba36tl11KAe50qSW/nRHpX+dvK6uhxOjSU9nzjE/SsShHRv0IWT+Z/kYbgOHSExLBfaeb06nV/R05eQ2rEcIl3kp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9M5sjk9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9M5sjk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E20C4CEE7;
	Wed, 18 Jun 2025 13:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750251680;
	bh=u7wvhY7UzWw1Kiz3j8CRU+e4HYpWNK/WmjXrT+hmz1Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t9M5sjk9OMnqNmnD8XQpdhvdPF1id4DxIs9zMb2tisdrYNb2LRVjjwhXsr2PvHY8z
	 +VC4KrTR+Ge2MPX0Qc8/aseWBZQH6tIQZ2W9zbpP3peoaYUc64PHH3/pTCdQz6p/rq
	 GS4f3UAo/UdMi7mUvW1L3UHqPZRbX06+eTZSbIpmVLur0ch7XMXQZcH2irczT8jroM
	 xP6ThLv5Ojq/Gi6WhUP8lv8ZfEnwE+Nvy+biotp3EiEGASoiU/0POC1BGey0SC+VYJ
	 WszjFFf09BaB/QukhQ21YNnOqG5z/tvYEuepHd835awBrRJKTYb7EkYbE3PutlPBnY
	 LIKIdO5Zaxbyg==
Message-ID: <6f644654-c906-46f0-942e-ad50ba159786@kernel.org>
Date: Wed, 18 Jun 2025 15:01:14 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] platform/x86: dell-uart-backlight: Use blacklight
 power constant
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 danielt@kernel.org, jingoohan1@gmail.com, neil.armstrong@linaro.org,
 jessica.zhang@oss.qualcomm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 fnkl.kernel@gmail.com, j@jannau.net, ilpo.jarvinen@linux.intel.com,
 sven@kernel.org, alyssa@rosenzweig.io, neal@gompa.dev, deller@gmx.de,
 support.opensource@diasemi.com, duje.mihanovic@skole.hr
Cc: dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-fbdev@vger.kernel.org
References: <20250618122436.379013-1-tzimmermann@suse.de>
 <20250618122436.379013-2-tzimmermann@suse.de>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250618122436.379013-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Jun-25 2:16 PM, Thomas Zimmermann wrote:
> The backlight subsystem has gotten its own power constants. Replace
> FB_BLANK_UNBLANK with BACKLIGHT_POWER_ON.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans




> ---
>  drivers/platform/x86/dell/dell-uart-backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
> index 8f868f845350..f323a667dc2d 100644
> --- a/drivers/platform/x86/dell/dell-uart-backlight.c
> +++ b/drivers/platform/x86/dell/dell-uart-backlight.c
> @@ -305,7 +305,7 @@ static int dell_uart_bl_serdev_probe(struct serdev_device *serdev)
>  	dev_dbg(dev, "Firmware version: %.*s\n", resp[RESP_LEN] - 3, resp + RESP_DATA);
>  
>  	/* Initialize bl_power to a known value */
> -	ret = dell_uart_set_bl_power(dell_bl, FB_BLANK_UNBLANK);
> +	ret = dell_uart_set_bl_power(dell_bl, BACKLIGHT_POWER_ON);
>  	if (ret)
>  		return ret;
>  

