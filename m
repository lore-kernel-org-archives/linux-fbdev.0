Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA3C30BB87
	for <linux-fbdev@vger.kernel.org>; Mon,  5 Jan 2026 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623996; cv=none; b=kQbEqV9GbbhcvsIPg3cWsxlv7vuzRYe9ASWx6KfSKNmhvRC5Lv3/IaeiN2/nFk+NfyopVZpJb5yQ+6Nad/qENQei2ocNwAYEpW2XpuHzsdiSBQkbybGT36Y+R3o0Wo3tOL7rKv1ZEB55/bY42GahDKTKmzxIjka4+zwippnu8cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623996; c=relaxed/simple;
	bh=3FyR+xajdgHmjWeefYApeotjJhW3fQL9qbBbALSP4so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnPP4fBcI5zhyRyKALBQoHUT8tU+9PrfPdd0LKkO0cu47fGCKc1xUFo1noLh2OTG6OwcWBqRGT1xkmYbe+q9/WQZEDspNhiMEyWq2agRQNd3ag7BHXJHvdVG98hXr70PGus2/5dqQYk5e4z3hN/ljpUNWmbEFukM88WT1I0ZXOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GkSUmy1H; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkSUmy1H"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fed090e5fso6483829f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 05 Jan 2026 06:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767623977; x=1768228777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ljlfQTMdubiXy6Trb6w37rOF+8B2DpqBmlsGz29D7zE=;
        b=GkSUmy1HpeMSyJLSZIICDagzk0PCGx4jBPqW8A6WBwQHy9xbvv53oQqXSlRuUSrrvl
         E7kuU2R5lieyUv2wWAUHqC3plHRERrIM3WTd1CjSseoatVzgUE2PgG2q1aCZ5dojbvHZ
         xMjHDXbDN9/TFmL69DJWbn5Z1tXFwbwb925zpwCHwpepRIcOvIcoLpYIV9l8K3E0b3jL
         DvDckePHjattUoxpW/uRqs1xoe2leL1dTqHhRYMVXatlrdTMA8W82SuugEpiKQuCAnYB
         Y8M12NGQ15svvSH774vSJuA4VXJCoepBQmJHNkQpmLdNnvT9O0/4ZTMOWFQEaB/6RThN
         gu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767623977; x=1768228777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljlfQTMdubiXy6Trb6w37rOF+8B2DpqBmlsGz29D7zE=;
        b=BSkfz2/KL+Rg9/pFS+dht+yQd7v6NE6QyRoJZMiOKbj0YyTb+TzNsXvGNyqZ07/GCO
         UnbK3Yl/qSAtI68WArJeIa8aEUlnKhFLBuF9WQ+jXQBiZdA25IfjZYHG8ETPUnp80T5d
         MHNSo0PU5yRiYjHF8F28IcolG7Go53jUvjafjQaigGMDjxmOuVzJI55j3HJsCtcSH/BR
         /C1NpGD+4LxRREukrI0uDwZPv21waKz1OSD8BQ1uTkKLPAd89WcTfZhq7sVZV3GIY4KL
         nQNivnuIVePc1/+YpLjiGhKtY2hCG9WHMtFbrUqroL4AzGBws/xugAXroJYHkpVaUXHi
         /c8g==
X-Forwarded-Encrypted: i=1; AJvYcCW6/U5B0HAWNi1p7UxAal185g8Dd+5065GMd6JnSZDsQKueUAnjivpgTF/ZCA/wCQzOEinYGUO9nDt6Tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHCYQbZKcBIxweH8mifHOxcpto8VPmf6W+nOBKgRWhsiZYPVF2
	koNYkOKhU3CrwMk2nWwqA00sps2rWUYfZiCKWADltxlBrLY4qrBzw2WB6ubveWTewvQ=
X-Gm-Gg: AY/fxX4rha3Y7IAP5nDkLh6Tn96fySihcpBFYKg5H58RnMT8Ghw0t8vj9gbg6UkxIU5
	aFT1VabNM3yU+ymOe4wLKp2byf9it0X9U83Epesl9hs1kRY3DQxwPdlOOqkOgfHswT8sTZRVNr5
	NfMmeeytGgwoawte3jFrWVjKfwBhRkX0ut3/NppgXdFCvfhMQZHPhdJ24qC434qOqjd3H0awUqO
	eZGyCS2U/GeFiWdrDRKoj3bJQSaoI9WLZ83tbqJlW3BFMQvVfNRoZVb21qpjPaP7WhqxLIOGRfe
	Eu4jzKrq8p9TVOBp5mQIrSHGNoCDE5Wk/BtbA+Fa2m55vYBQ96OG08dWsIkZJWKcArt80WNYRAx
	DqqQ/RDrcpW5mDWQ54VxKILSOOQglaf5b1u637HlLtofNZuFoGrNin0rO3cfe8oF9t14v9j6xqG
	XVzuZ0vYjcx3K29iqF
X-Google-Smtp-Source: AGHT+IHi6fS0MK2Kosi15XiBw2e95XkRVwWYbIeQ5N6L4qMRxWQV+A5hUru6upLl+PEiAB1wfKiYMw==
X-Received: by 2002:a05:6000:220b:b0:430:fbce:f382 with SMTP id ffacd0b85a97d-4324e4d04d4mr60068477f8f.25.1767623977366;
        Mon, 05 Jan 2026 06:39:37 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1afbfsm102065572f8f.9.2026.01.05.06.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:39:36 -0800 (PST)
Date: Mon, 5 Jan 2026 17:39:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 2/4] staging: fbtft: ssd1351: send gamma table via
 fbtft_write_buf_dc()
Message-ID: <aVvNJV93mprLcZwy@stanley.mountain>
References: <20260104110638.532615-1-sun.jian.kdev@gmail.com>
 <20260104110638.532615-3-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104110638.532615-3-sun.jian.kdev@gmail.com>

On Sun, Jan 04, 2026 at 07:06:36PM +0800, Sun Jian wrote:
> Clang reports a large stack frame in set_gamma() (-Wframe-larger-than=1024)
> due to the large write_reg() call emitting 63 gamma bytes via varargs.
> 
> Send the command byte (0xB8) and the gamma payload using
> fbtft_write_buf_dc() to avoid the varargs/NUMARGS stack blow-up.
> 
> No functional change intended.
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  drivers/staging/fbtft/fb_ssd1351.c | 35 +++++++++++++-----------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
> index 6736b09b2f45..b4ab2c81e528 100644
> --- a/drivers/staging/fbtft/fb_ssd1351.c
> +++ b/drivers/staging/fbtft/fb_ssd1351.c
> @@ -119,43 +119,38 @@ static int set_var(struct fbtft_par *par)
>   */
>  static int set_gamma(struct fbtft_par *par, u32 *curves)
>  {
> -	unsigned long tmp[GAMMA_NUM * GAMMA_LEN];
> +	u8 data[GAMMA_LEN];

Ugh...  GAMMA_NUM is 1 so this is an annoying calculation.  So what
this does is it changes the type from unsigned long to u8 and renames
the variable.  I am fine with renaming the variable it's unrelated and
makes the review harder.

> +	u8 cmd = 0xB8;
>  	int i, acc = 0;
> +	int ret;
>  
> -	for (i = 0; i < 63; i++) {
> +	for (i = 0; i < GAMMA_LEN; i++) {

GAMMA_LEN is 63.  So this looks like a change, but it's an unrelated
cleanup.

>  		if (i > 0 && curves[i] < 2) {
>  			dev_err(par->info->device,
>  				"Illegal value in Grayscale Lookup Table at index %d : %d. Must be greater than 1\n",
>  				i, curves[i]);
>  			return -EINVAL;
>  		}
> +

This is an unrelated white space change.

>  		acc += curves[i];
> -		tmp[i] = acc;
> +
>  		if (acc > 180) {
>  			dev_err(par->info->device,
>  				"Illegal value(s) in Grayscale Lookup Table. At index=%d : %d, the accumulated value has exceeded 180\n",
>  				i, acc);
>  			return -EINVAL;
>  		}
> +
> +		data[i] = acc;

Here we move the acc assignment after the sanity check, but it's just
an unrelated cleanup.

>  	}
>  
> -	write_reg(par, 0xB8,
> -		  tmp[0],  tmp[1],  tmp[2],  tmp[3],
> -		  tmp[4],  tmp[5],  tmp[6],  tmp[7],
> -		  tmp[8],  tmp[9],  tmp[10], tmp[11],
> -		  tmp[12], tmp[13], tmp[14], tmp[15],
> -		  tmp[16], tmp[17], tmp[18], tmp[19],
> -		  tmp[20], tmp[21], tmp[22], tmp[23],
> -		  tmp[24], tmp[25], tmp[26], tmp[27],
> -		  tmp[28], tmp[29], tmp[30], tmp[31],
> -		  tmp[32], tmp[33], tmp[34], tmp[35],
> -		  tmp[36], tmp[37], tmp[38], tmp[39],
> -		  tmp[40], tmp[41], tmp[42], tmp[43],
> -		  tmp[44], tmp[45], tmp[46], tmp[47],
> -		  tmp[48], tmp[49], tmp[50], tmp[51],
> -		  tmp[52], tmp[53], tmp[54], tmp[55],
> -		  tmp[56], tmp[57], tmp[58], tmp[59],
> -		  tmp[60], tmp[61], tmp[62]);
> +	ret = fbtft_write_buf_dc(par, &cmd, 1, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = fbtft_write_buf_dc(par, data, sizeof(data), 1);
> +	if (ret < 0)
> +		return ret;

These are good changes.  Just change the type from unsigned long to u8
and use fbtft_write_buf_dc() instead of write_reg().  Then do the other
changes in a separate patch.

Same for the other patches.

regards,
dan carpenter

>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 
