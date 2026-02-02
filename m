Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12932BDC32
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Feb 2026 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026104; cv=none; b=k24kDA+Fa0A3HEd3qeQS9xmxaXEgHlHRSMooe7zALA5aZjhSeSRgv5qHeg4YnBLhkh2g+BGqXXJ+ZJ6alsgAr36Y5qLqELEzeeT6fg8JrfXfnmNCVvVkPbOg96VTHlj3POCRZmISTTQ/hrLLR5uqG8El/H1yJqKTnEjkh3KnzzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026104; c=relaxed/simple;
	bh=tM0ZIIT0SfXkZEt1oAbpUmPlaEgJ06FHaFhzTDkP/rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIIbQw5bda+1l5l5/NH68jy/qm/i70sO3mj2BtGzFgBUSNMBwtGFRA8Su07Z7kli6hDy6XwyLdtKUPiIX21mYS/or/YnJu93Hhrcy3u5K2Fn1uETcwmzJIINQN7k43auLkLwx2j2/Ga6NneSkVHAE5sBn4VrhqtX4vEG8gHTiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=2MgS3h/E; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="2MgS3h/E"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so44854055e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Feb 2026 01:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1770026100; x=1770630900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x69aZ/PCgH5m4sapPYNqP9yFQBKilACu2vK1FG07GVk=;
        b=2MgS3h/E4Sew8FPWf/ZK2DOfvzx7hiytpqZvpvrqCZ+EQzYyfP3Rx00V7rKX7NnVC/
         hm5ju33tfGK0uWyHpqX+Fo1kGD7Qazz+qcc6awwIv44sOGXtLy2pwwkW8eG8ZfDe/lwy
         miZ17VCS+kC9QoJGvb6VON1BDvKCwckXNRTvesrdtQ6iXUgUyTDiSITXFca0Vl0uqm5G
         BsxGtXypg+erIR1Udl//hpPwbRFbEzd2NTWZpqJ+g2AzFVlJxeNcRt8HiPoeFnxfHpwd
         qNqbg5YCF9vRa+hBYcqlU1B56QDrFfmL5HOwY+d0TlMmnUWbuEEUgvbMSy8Uzb3lMS4v
         G5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770026100; x=1770630900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x69aZ/PCgH5m4sapPYNqP9yFQBKilACu2vK1FG07GVk=;
        b=EUV09xLurOVRSN2r/awQTY21uw+eqhZcNsmCBVbiJnsirX1rEtAgfcDRbLFTRy3zKE
         U+JNXcFvjf+cEKRyM3T1s4FU67jBIAgG+0dnFqb3arPjE+OnNvmM9tOkzq+l/JyDrU64
         96V5HETzcgHE4P8GdccTjLEmjtTmcI+s19Gnz+wjoi/2dIf2HfyjJgcnq32U/cjpGt5Z
         t6qXbreOlyDSliRAP4H8l7NexPYy+c8VeHUaA+XHRbpmfZT9em1AwPr9USI4ynxDHtjq
         lNzxQ31Fi72oH5NxVI3UFJxOog7w/LuJQr41BYJYqCrhiOkgMWlVNQV2PNhMkEUq0X3O
         XjIw==
X-Forwarded-Encrypted: i=1; AJvYcCUjGzzKQhS32wc5M+5kfsGe3Y+VDd71lenHqoqwa1cYt5XOPFKGGPiBslWIYsE2ojUwrjmGwL58pZ5wrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5CmyBAsC7Gh0R86YQ9bwH6MDNwxCe0fR8W6ERDrwjmCdJ1eS2
	H1YjSxSHoL+nfQ25Jxw20WzL+CZoMA2DA/1K+YFgeYw6nAFc6PZYutsREVTK4Yj3UMA=
X-Gm-Gg: AZuq6aIDKjlYqJXNvUUKzmv7p8OsmCaEpgoJuDhjO3W1QGmVDkP9bMnTkmaqzaStwJ+
	SMVNRdOEDtBFTF2Koy2NZsAIL7RDK0DHKfckzIWjzT9XNfNXgaPDtLiXpPBtj6dzJHCV3AMUHwW
	0hZUKBl5dO0SpqCUh9QsvLHtixA4mCZTbn7nR+GSGveAD+yjTjyzW+xOqSd7TgWTtiLJxlAwsTV
	o0inWON78wbgvVD0vqPjBbLS/cpIwGdWAYbJ0S6vTtuTd6C+CFJbPvKiPrOoPGFSu49OsbIljoC
	RODro9AIVfeOyjaywR0O1Gjmxp4iDPaSucqfBKKTQ//EhmYv41CV9xmCmeZfRNiewVo8S7OCkRq
	Ankc6mhJlBOYrFg7JwUliZuyau6oT3HOrRLLG4AbQsBJAdilJwWIoARbdNTC0chch90uEahOll5
	WFFL6lbuUBzQNYRWzZ7LJ1bcw5iENJc8PA+5UUo1X9TnOnQNQvjyUU4kx8SFhxOijULYygfpyJj
	3Dy4Sa9wpINun9uDk4bSM6Kyof6jCp7w9m9zz+V4sMXaIAB4QDOexdqnCp+nDnh+iV1EDGR
X-Received: by 2002:a05:600c:3b23:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-482db49fbdfmr150380875e9.35.1770026100077;
        Mon, 02 Feb 2026 01:55:00 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c4f3edsm433200195e9.15.2026.02.02.01.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 01:54:59 -0800 (PST)
Date: Mon, 2 Feb 2026 09:54:57 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	linusw@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: sky81452-backlight: Check return value of
 devm_gpiod_get_optional() in sky81452_bl_parse_dt()
Message-ID: <aYB0cRwmiIb0vVnq@aspen.lan>
References: <20260202075410.155375-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202075410.155375-1-nichen@iscas.ac.cn>

On Mon, Feb 02, 2026 at 03:54:10PM +0800, Chen Ni wrote:
> The devm_gpiod_get_optional() function may return an ERR_PTR in case of
> genuine GPIO acquisition errors, not just NULL which indicates the
> legitimate absence of an optional GPIO.
>
> Add an IS_ERR() check after the call in sky81452_bl_parse_dt(). On
> error, return the error code to ensure proper failure handling rather
> than proceeding with invalid pointers.
>
> Fixes: e1915eec54a6 ("backlight: sky81452: Convert to GPIO descriptors")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/video/backlight/sky81452-backlight.c | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks for the fix.

Small review comment below:

> diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
> index 2749231f0385..e3e5306fab84 100644
> --- a/drivers/video/backlight/sky81452-backlight.c
> +++ b/drivers/video/backlight/sky81452-backlight.c
> @@ -202,6 +202,10 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
>  	pdata->dpwm_mode = of_property_read_bool(np, "skyworks,dpwm-mode");
>  	pdata->phase_shift = of_property_read_bool(np, "skyworks,phase-shift");
>  	pdata->gpiod_enable = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);
> +	if (IS_ERR(pdata->gpiod_enable)) {
> +		dev_err(dev, "failed to get gpio\n");
> +		return ERR_CAST(pdata->gpiod_enable);
> +	}

Using dev_err_cast_probe() would make this change more compact and give
a better error message for the user.
>
>  	ret = of_property_count_u32_elems(np, "led-sources");
>  	if (ret < 0) {


Daniel.
