Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB634C806
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634600; cv=none; b=d4RIin4TS7cLkUhfnt2COBy93DBWVCQ/TE4wfp9Sw8oqtixxOsc3M/Gfz51aHflf37ofstyjyG0Vw16W/kV5Mod/elCzxVKTk2Os0eZrxI25/a+KawWsuiZhZqVPfS6lUVg+ylZIbg+FpThh8FvkMe9yNZlsi+KEPKaCsMbUrzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634600; c=relaxed/simple;
	bh=KJYwgD8a5x3dFWij9qo8R0F8k3yUFjNN+Nah1NIDZs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFUjPvP7D2zL2+oM+Cj4xwH/Jfd9H56cKLFg0QQJbUvyPGCfk0GfpQajHHfKBNRryj4fXnS2B1O4M0KC3idrssHUGVLEQ+/fN4CD7e2sM6kO4l5nFoZt9HicE/7GZO4uJIOfuNh//OPYZQErlJIqsbGA+YsGBJjeumbWf2b5wIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P1LDAQ81; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1LDAQ81"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48371119eacso83987065e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 06:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772634598; x=1773239398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vItL+rwbobOFxMZ3mkQBXQUgxfP7hCn2bqDZg0FE4Wk=;
        b=P1LDAQ81wRy8avPtpPkyhzGeniAeVj27+q9zMERlesInexfwhnOXlz8r1Ts7NX6ic6
         nPEliBBgdhcQv4M2nUEOMvJ/F0l3BvW2QFwI2gLFYj/s6zvsoVcQLdVPtzr4OxjZCzjE
         AjVj2OYyMjvgjk1QNRWD7pxqI1wbltpKObV4m0HPJb/D/g3zFuWfc07x63a8WTEYfG/s
         DdT4dTBZR6SojFi1Glo12IXIxSSef6aAtiQ1Vb8Q5yn8xHmK6WLo5TNBn6RaCuPSA6xr
         /4cu+3E1LJOvHT3v4T+ivCUjBeWFdcBUCbCLWGqdwwQUE4GSWIepssEDjK31Oix6UhD0
         euGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772634598; x=1773239398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vItL+rwbobOFxMZ3mkQBXQUgxfP7hCn2bqDZg0FE4Wk=;
        b=ZfC8Ya0hdqCP81cCs+ceK9hQ+jVUxkFu1JBw+XODvWA8slGPWcE66S8/Se5Mf0hSyF
         jylClGODYFLJMNFuB8Fu0r1d+xuoPAvLFFyq9Loco5xwUxrp5a0u90alxlFzuEgnmitE
         vngusmxDfL5s5ejw0PgyvLkI4OgYiR7eIfn3nB9DR8hRtSj/gsjrHLa8n80YKZiRKC8x
         qf6Y+5wGBlAXB8IoFl0gzcIg74c/gqJo8yIEPgMRDlRxrpCVQEiq96YbX9rHAKAiBCwG
         zg7f/wkDV9fS7lspjssj2jRS1ph1FrTgNwYzOr8PQIC5gMOe8/VQLMYtN/WmDv2ImXNm
         HZzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn/l6xYQ2mpYfwR4XEoad3mYONjv1xEpA5mRMbo99JqFpurwffDnBUyhryJMQOnqqdt9Q1HboIqsMxVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgt514nZXoHnVri8bg0+fLOSZa62z19KngOofu0MeGGhcPfOmN
	qUEhat0zAmhq/LO3x5sRLj5pqapf5KB/f24PF8cKLqmmNSPZhj78Qnp35a4u2Ncfr7sYaqpm7+H
	Gmsos
X-Gm-Gg: ATEYQzyEqPJEmcMRGBY2RzdTaqdrDPYDBjIJMSkuPaTg5MWU2ztUuK12SuyQeM4+nFW
	nf+yGakPj9w4VDDJHh343/O2XNaQtmT6KC2d0W/q+Hq3dICsJQIx8lO/23PN1g+vLdblEvpHOr6
	Df3Pu8Gr0N6a2wEULq2OHQegstMBxXJ7Ac75ad80Mc0w3sPfJEn18Zfxef2mMppXDRhBLiWOYEq
	mko+sqBtl6k2xtf3TMaftsAuWeqSKUMvY9bVI+QrhN9DyH4mIvpPROJSvmDaY2MlatQZssEBfbs
	jIoB5TZkcfzL7Lp1qbJJ4h+RYLz0ZJ90VsfHYfkd+EUX117meKzrFYxbRtKd12YvdmbR06eDYK2
	4PklmYFjL68+RpgUsDmBsEfq3LHlA55TtcOlNRSb2Ms8yL7wEuXPZBAWsdHZlOWJx+P491sZa20
	gQoZ2HcOXQUje8d+6EpYRpetvRa62i
X-Received: by 2002:a05:600c:1f13:b0:480:4a90:1afe with SMTP id 5b1f17b1804b1-485198bab53mr33785625e9.34.1772634597557;
        Wed, 04 Mar 2026 06:29:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485188914ddsm68911555e9.12.2026.03.04.06.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:29:57 -0800 (PST)
Date: Wed, 4 Mar 2026 17:29:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Soham Kute <officialsohamkute@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] staging: sm750fb: sw_i2c_write_byte: return
 -ETIMEDOUT on timeout
Message-ID: <aahB4trbBPTc9B97@stanley.mountain>
References: <aaVT1mSeKrSSlrha@stanley.mountain>
 <20260304084545.156170-1-officialsohamkute@gmail.com>
 <20260304084545.156170-6-officialsohamkute@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304084545.156170-6-officialsohamkute@gmail.com>

On Wed, Mar 04, 2026 at 02:15:44PM +0530, Soham Kute wrote:
> Return -ETIMEDOUT instead of -1 when the I2C byte write times out.
> The callers check for non-zero return value and treat it as failure.
> 

"The callers either ignore errors or treat all non-zero returns as
failure and return -1."

> Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_swi2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
> index 0ef8d4ff2ef9..a17f758dda6c 100644
> --- a/drivers/staging/sm750fb/ddk750_swi2c.c
> +++ b/drivers/staging/sm750fb/ddk750_swi2c.c
> @@ -294,7 +294,7 @@ static long sw_i2c_write_byte(unsigned char data)


Need to update the comments at the start of the function as well.

   234  /*
   235   *  This function writes one byte to the slave device
   236   *
   237   *  Parameters:
   238   *      data    - Data to be write to the slave device
   239   *
   240   *  Return Value:
   241   *       0   - Success
   242   *      -1   - Fail to write byte
                ^^^^^^^^^^^^^^^^^^^^^^^^^
   243   */
   244  static long sw_i2c_write_byte(unsigned char data)

>  	if (i < 0xff)
>  		return 0;
>  	else
> -		return -1;
> +		return -ETIMEDOUT;

I don't think -ETIMEDOUT is the correct error code.  Maybe -EIO or
-EINVAL.

regards,
dan carpenter

