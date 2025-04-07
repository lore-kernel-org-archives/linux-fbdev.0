Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715F209F46
	for <linux-fbdev@vger.kernel.org>; Mon,  7 Apr 2025 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042432; cv=none; b=p0RUx4HCUhY787dDytQwUVmBbDqwSbKRFEnVtNKmNwi6hXDzeHja5Pftur0jm5CvkAYdo+E1ezfLIkstpfysPjZ/WZ/D135qIUMWdGJHPX6OOg7iwEWpe2znT61t0z9m24qVE1m9JdYzha+XhyIZFlhfWqDj4gdLjj4lafvls50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042432; c=relaxed/simple;
	bh=momMVb5vlwB7w7QBIrh4FuJxBMr+DXof5tHLvIxbILc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ud/YKZfEZfJmnbXZnwSQtaBSHTYS0WHsORguFee2MNcfYEq5aI17VNIvN8b9p8CEHMW4WRBEGKbc1w6c+btX+uNvEce7NAOYC0Gv6hDoWmgF7Hsp16mx7k8sInrWXA1P69+zHtulAOqRj8/XMMN5mPIkKLDrdPAxXIWH+stwd9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=VUkcGvdZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="VUkcGvdZ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so44101005e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 07 Apr 2025 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744042428; x=1744647228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hAlufBsPlnjuTWbgusP8CYnzhAGj3Mnwll46JdWGBbE=;
        b=VUkcGvdZWUbu9OzL8xb/T9nIPABJp+EpwUB25HeDeqsIYBWHw/KxG+9HzB6zJ25efA
         IEVWesGAkZXnsKnEEQm5RrjsBBy/tM0vuvAVzxUKgGOfI/2MnZRk9eU1buIVmNaD/vyl
         7ohlvYtihiG99nc1Pjalgx9Cg3PhduK3ocW9+yDw355ftfxGvBo3YocEdBwq8pF8+NYx
         lMdNCYIYwmRxY1Ub0vqMljGY5ITbfI0syUZ0bCM41CmNbN56FnpgJML2mZso6zE4ctdw
         GGWGXp/DxpbSRR2/MomVoMl/GluMdqLScFL5xdZU1NcCHhUkH0KM61p8FLLG8T+nyt1b
         kttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744042428; x=1744647228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAlufBsPlnjuTWbgusP8CYnzhAGj3Mnwll46JdWGBbE=;
        b=AUnHfWG7U4rAp1wEEEY6s8ajG2sSuo3pCPtzsleIePVRgmswcT/16THKSraOYWprY+
         wZIDWEL3QAmB1E/y0PAugvH4ju9O6v6KxuPjfWzhvxMsoUbNAaHUzNelyGuSE//2iY67
         1HI+WhrgvcHEO5Xzp6HcmvnH8/QtJq1jx6OyD0eh7aKVxite40c6vrdJbeTBgq7VOafO
         fBNC0M8Z3obfE9CjDfkDwchdwm+d6fyyPbd5wJzgoVD0JI8YwbRrANziJOoOshXXksyt
         /0SESpWOqEPfYQvCYvQidKX5zf80A2BTLTFKUJzlWStYUxPiDf6dON8Gr4dN3CUNYhO1
         Q2KA==
X-Forwarded-Encrypted: i=1; AJvYcCW/r7a1FLmzLA11JT7ljUdQQYHnBDlKTLZm12YXOM6tW3VWbB1eLmD9hKZ3eFcslra7cYDc56zdEhvK4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1IDqCZH2XAG/fn0j0rWiTtgjBNrTLIfBKghsALCDSe2qScl0+
	/gOu3DWZwohWaC0T3SkjTw4+zbRA+pC12TgEQPI9yNthtNWFBa/MQOiPxz3LhxY=
X-Gm-Gg: ASbGncupMxt8uI+NeDxt0hi74DM0hwRv0L5gzsgihnNi6cQHY2L48uxAG5T9V0jU8jl
	nROUqgFwz4s1ZrvBQqsxpbcl5aDxVN2LcNlobNCGYZI1drrjH0UrenmC1E+wJRI26460aic9xQF
	kzmyuYepSZCR5QwZYMC0qmEixm5JJIKmfdhbygX1KJWBcUdNGIOfibtHl13dmD1rskgkFZOVrKT
	CcBmYXqUH3mi18Q/VLign8cpci6RXp8LdzF5RIO/DwEATqyVU5uuPXOcxkm/NXlJNr3MDAsJxok
	yB14YrUX3R23DQKeHIO7Q6kKRbo6RSZxW6tg1ohQ1lerv1EgA3QEHa/X/DCU2QKzrp+GPkBjEEj
	IL2hndOoZHDpeFZYTjV/0x+lCq5s=
X-Google-Smtp-Source: AGHT+IF9E+Yu68SivmKTZ/2oBu6XpMDyufJhLClsxWUTbSHDLDqi5DwsmXJhaL8CEGG/v/moBPNDvw==
X-Received: by 2002:a05:600c:1d28:b0:43c:fad6:fa5a with SMTP id 5b1f17b1804b1-43ed0d9ce1dmr107471025e9.24.1744042427942;
        Mon, 07 Apr 2025 09:13:47 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1630ddesm137924675e9.5.2025.04.07.09.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:13:46 -0700 (PDT)
Date: Mon, 7 Apr 2025 17:13:44 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Jianhua Lu <lujianhua000@gmail.com>, Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 3/4] backlight: ktz8866: improve current sinks setting
Message-ID: <Z_P5uLrGiQWez0jv@aspen.lan>
References: <20250407095119.588920-1-mitltlatltl@gmail.com>
 <20250407095119.588920-4-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407095119.588920-4-mitltlatltl@gmail.com>

On Mon, Apr 07, 2025 at 05:51:18PM +0800, Pengyu Luo wrote:
> I polled all registers when the module was loading, found that
> current sinks have already been configured. Bootloader would set
> when booting. So checking it before setting the all channels.

Can you rephrase this so the problem and solution are more clearly
expressed. Perhaps template Ingo suggests here would be good:
https://www.spinics.net/lists/kernel/msg1633438.html


> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>  drivers/video/backlight/ktz8866.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/backlight/ktz8866.c b/drivers/video/backlight/ktz8866.c
> index 017ad80dd..b67ca136d 100644
> --- a/drivers/video/backlight/ktz8866.c
> +++ b/drivers/video/backlight/ktz8866.c
> @@ -46,6 +46,8 @@
>  #define LCD_BIAS_EN 0x9F
>  #define PWM_HYST 0x5
>
> +#define CURRENT_SINKS_MASK GENMASK(5, 0)
> +

Call this BL_EN_CURRENT_SINKS_MASK and keep it next to the register it
applies to.


>  struct ktz8866_slave {
>  	struct i2c_client *client;
>  	struct regmap *regmap;
> @@ -112,11 +120,18 @@ static void ktz8866_init(struct ktz8866 *ktz)
>  {
>  	unsigned int val = 0;
>
> -	if (!of_property_read_u32(ktz->client->dev.of_node, "current-num-sinks", &val))
> +	if (!of_property_read_u32(ktz->client->dev.of_node, "current-num-sinks", &val)) {
>  		ktz8866_write(ktz, BL_EN, BIT(val) - 1);
> -	else
> -		/* Enable all 6 current sinks if the number of current sinks isn't specified. */
> -		ktz8866_write(ktz, BL_EN, BIT(6) - 1);
> +	} else {
> +		/*
> +		 * Enable all 6 current sinks if the number of current
> +		 * sinks isn't specified and the bootloader didn't set
> +		 * the value.
> +		 */
> +		ktz8866_read(ktz, BL_EN, &val);
> +		if (!(val && CURRENT_SINKS_MASK))

This is the wrong form of AND.

> +			ktz8866_write(ktz, BL_EN, CURRENT_SINKS_MASK);
> +	}


Daniel.
