Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7273AE6EE
	for <linux-fbdev@vger.kernel.org>; Wed, 11 Mar 2026 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773240539; cv=none; b=XiYuEIuG+zMTGVaLmuS+OMbzWaqNkt+wUaQDoVeXNz9IyrYiYrwj98ntZ1EZpaHIsBBeHBwmmiQCHw31jn/8UC3z7iW5LqX/ZEoNFP/QinS3Hd3wkYRaMhddVz8IANS8ihpZcv6QXdODiGLF5ZidoBCNPUS/95P7ilZYs1bc3+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773240539; c=relaxed/simple;
	bh=VjTuVrNei2TqAitiUlEfhS/9ihnYTwEg9XLL8Y1VnFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihZRs99+DblJQrRqkbeNN3tnMRP9MNi6T9oIaaW67BoLnRwivX1rcJzCSvvM9Eo5SHUL0ic8dMXZ3dWc707p/NqVJcDQ7hf2I3Qw7flEUrWxyssbSd0Kh8IDH2pEl2ZU3nLZgrN5P9ae5p6XElmT+wmho+4FO3aTEOs072/F8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D6tc5Y3m; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D6tc5Y3m"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439f5abc829so1640954f8f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Mar 2026 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773240537; x=1773845337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4lgNy5yMCcnmCSkcJzhlt2CENGm8tHrdHSldEAqpwXg=;
        b=D6tc5Y3mULgec3q6FioUQvnDFThWAeYveQRTqnuGR3HgWGd+txEvRfrWUdLiLOGgmh
         BGQglR6qaM26FfU+wqmVkAognrbie8gdUerdiKaykCumjztR24QDzZpHgdp9e7+nd8Ki
         mB/aSKbMvWcDsCY1pMxrhKrK9sRp/YpzLU34yFBRBDAnsH5cqXg4/WP3LFP1I2OXxDHZ
         UKTLiBSZm/Bgv+Z5m6dhu7L3+KSs4fYkiyqvtSKGpDl8gV+mou9QjMCnPp1FvRcxhM3Q
         WkyZ5QxNnuho8wMGKzPzeMTA4LAICG8L9uXT9Cy3RuPvMdr+pzUv7X7utRwnriaIqwBr
         i3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773240537; x=1773845337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lgNy5yMCcnmCSkcJzhlt2CENGm8tHrdHSldEAqpwXg=;
        b=UaM25vKR/xqzmIYtKjJ8Ik10yjCGHaqoOHW3w9+CMbYN6qarlaX0fEzRV4cvvTKx4o
         4JDKc197KvZ+5fttzK880HL/TvVvhGu2oCO7vY0SIKz7MCKNCneeTn/JV4kCTaKn00Q6
         wKQotuSiVeVtcqiL2D0m80TCV+BJUIpLa8zImv8q+MSSw+KfCUjSK3f3c5FungiTxD5j
         CzEfPMy1Rv9XbRIzWcZgUIjR1b05Hvrd+XQ2kTdk/U2Y/xZPXSgwzrvYk3cPC6JVogSd
         PIq5SXAz/ORe1rdpzxJ1mo3aIvb+dfGJtlTS7ZKIsvTi4iJW5+PMY14xtJ/bwGzXa3uL
         +XRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgjFVo/iFS566RCw8jFc+RvQGXSTSNfIQMQ45Y6T7holBpzLp86ssIrBVGe6eByU/NwzaiBX5C+1JzgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EgO46la1UquwOPyx7Foq2hlHtEmzQYuO3z6g71pGNg25rC4r
	G6dIcC3LuFJ8vm9mfWbmkhDZjPhY2CpfmZdfHaHrwNkTjZFNwlp6lFgS1KIXN3d5qkQ=
X-Gm-Gg: ATEYQzwtdrG0SU/4C0kpGqyrGFfRygRoGNoBu0wCsGVKEEYVVW22LjIPkpU6PzTrgaX
	KNRA2ispxOjbXKwS/bjSyNO5nIxFn8drC9P8u0NEOnJKsR3jQYf+QQx1A3hv8KeaTnbImqQcEFL
	6Zh85u/6Y/yX0yzYMETY33bDVXOf++Vwd2hVv1dz8NQnqo+p9HUDtY/3S9fyt5lP5ntNngwWckm
	e+OG3tCaawWpRrwDpb46+5VQwlC9E/+8xL9muiXoei/QoS0sTZ3lnq2KMO22PI9JFkfdOaFm3Im
	9ciWxtSPhFuSYooBPc7YoZlv43wJdsZ0edA88PKKJ6zLxWz03o9eDHYKUk+DoA4mWAwFWYMfMOk
	CH21+4Wpb/yyuzfOpBr0rIJe5jk5z2MGI8F5KBMkesyV+XKItniaA+upq7fJSUpGMFXX1gwqbsG
	Soq6h/N6m/Is2sN63xAlQsypRlRlUy
X-Received: by 2002:a05:6000:288c:b0:439:cf1f:22a7 with SMTP id ffacd0b85a97d-439f81e295amr5406937f8f.6.1773240536680;
        Wed, 11 Mar 2026 07:48:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a0307sm7214870f8f.11.2026.03.11.07.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 07:48:56 -0700 (PDT)
Date: Wed, 11 Mar 2026 17:48:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Anas Iqbal <mohd.abd.6602@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_tinylcd: replace udelay() with
 usleep_range()
Message-ID: <abGA1WOvzvV8fusw@stanley.mountain>
References: <20260311142407.35403-1-mohd.abd.6602@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311142407.35403-1-mohd.abd.6602@gmail.com>

On Wed, Mar 11, 2026 at 02:24:07PM +0000, Anas Iqbal wrote:
> Replace udelay() with usleep_range() for a 250 microsecond delay
> as recommended by checkpatch.pl. usleep_range() avoids busy
> waiting and allows the scheduler to schedule other tasks.
> 
> Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index 9469248f2c50..51e6493b050f 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,10 +38,10 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>  	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);

Don't do this.
1) It's unrelated.
2) The previous alignment was done deliberate to make it easier to read.
   Checkpatch is not perfect so don't always do what it says.

>  	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
>  	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
> -	udelay(250);
> +	usleep_range(250, 500);

Do a search for init_display on lore

https://lore.kernel.org/all/?q=init_display

regards,
dan carpenter
