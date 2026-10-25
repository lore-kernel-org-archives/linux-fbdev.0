Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792936731;
	b=XXwwx+FHYMge7gIeNzfcwD5yZL3ggwtXIUOtYe6gAheilPHhQhrn4DHj71XkJUtMX7vw
	 jLxMSjy+lRYWiludiKr89UAGEy9zQW2jPkOeyJ6Vhcz0JD4218r8AprrTVMZ4e/ILEXWw
	 hsjIZXTp9mz9uFcMXQ5tiNGDoxlgPIeT6xYWb/U/+eumxOPfT0AueqyKSgiRhtQ0+8m8J
	 o5c2+7v5PDqtQ76rYfp6EUjV3SgI7Up0cQ7YZGUuHMxux4RAP98VGmyZidHzd5fZLMzTz
	 dXoNDBIdzXI/Gnvo7jjP1P04B/RcbA/Ezggxg+jx9VZt0YjW8Tk+Zv+rKSkjxJ1zTSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792936731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=so8lfUIk2kpbn92EQdY+sr4PHE6OnQZjUslmbfm4DwQ=;
	b=HtFzCiMBKqD2Jj/B2vro+uMmsgoeGh27jiaq9HEHLSxsnOxGpJjpPO2y2oPfAo/KTuxp
	 gi66t2Vn+YeQrJ39lAyMHtpLiaiWVgfh+maZQcU4wY1GS6e3vBrx6bWINS/pjJQstLlYD
	 sWOdlRmahFlHoXAuskPrmR1UZ9IlSayQWImcO0qfxaN6+9hVq2nIEljPqkQ8VfXfrrfyw
	 ohZgXaYb/p6SAEvfMFRRYdrW+9hguVUdKQ3HdI0dnMEhmFiO1p6irtfkmhj0bxxWUNtDA
	 UttJvTLkQmLWfQtXs32YhpJp8qNgMBnd1EBGHsojrMgcV670l0bpT/lS3eLnHcDSM4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="roEio4p/";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80F606A321
	for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 13:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B80F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=roEio4p/
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso17045735e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792936730; x=1793541530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=so8lfUIk2kpbn92EQdY+sr4PHE6OnQZjUslmbfm4DwQ=;
        b=roEio4p/SNDt1lLBBpyDRgA+J7X49aiBxo0+pbSw7SD3P7aDyAJjyw9GQ7VCwqZ8hm
         Bo9H0wgpNLrpfWBiYcNqRGKCVBaILlPji8KqTZHY943o52QEEomGAyNNuM/8i2gZs8xg
         Pd0I7l+B7ZBxgxyhNBrUqcI17JBeHr+nl/d2pRPIIsudVuJ3p55qCIjw6G07CPmDSU1X
         lMRum9TYcZA4bBO4ulSXWbkneSrKu33N9VJwSxBW3pQuiHODrfMvDoEohcEKnyXfzbLq
         3C8iNZQHi8EXAc3CYSlYqqZAjDfZ6s1C7Y2Wt5JConmNy/qvMXicIe+6tJuYhcTD3LAp
         C+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792936730; x=1793541530;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=so8lfUIk2kpbn92EQdY+sr4PHE6OnQZjUslmbfm4DwQ=;
        b=O6juSmdfjG3yJvMVEIcCtflZUDVWZcbKpqN+QoSs0KLOOExUH1hNop16b2rqj8JETi
         pNqtL6q96K7Z+82R0LM3aw9eji8Gnr0k8cVLcR9EO5nDBx0tTSAgDcEx94yqsm4DFdDE
         ZWMwVuC4zsayy/TK/jTbX3yfuw43sg16DWc2d+/iXpsqvLh/sFIgLJ9kRQPhf+rAzbNU
         NwLB40k2B9V19dgLqGI0TUS0BlGvd5e0IIY/3wJYNEzyBApU3cygdMsxm1j0X1ZncncN
         Kklc47SdNUIlbbdGKUltAueXk9Aw+ubed/2OZD3WEeeWh6GdhOW4fYjD3tsqfYl1LKC7
         XQVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzi+evPCspxLEyalxrYCA5o7eEnWRVRT88CpP13Qk5+jkXsJBFzuPAKbX/VgqHRjvfWUlytbMflILskPQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJapaulhkFAmd4IUbXrSMN47KgPkeSxsZrXTi3U3WH92DM6DBLp
	kjbo1OA22exl6Odm/PmqFMNyqYxnHCfkWuroauv8bww9U68E/xdGWPee
X-Gm-Gg: AYBFou368++vZD9EiPJSUfaCfcnhYKfcaQpLlHMStE4SsDJEf/X0b/X1Nkbwtbhs2SQ
	1eGzl7dlwneQgybDQnVIF68brja5t66doaOMrdjwVZOUKOZzf0y2FZvWKKAyskbaDAdkCqJFtx4
	CWtJDVqvDUrsC5HJFaXcoUOTTJLS4OR42DJMKwwSVy2lJ/CDvDvNITQd9YDJFX7HNBiS3NmpE0M
	Ti2a/tSGs0t4hcvPqNut3L9J7MbZLGZg9sdlHLv7FvDYkDW2pD/adXC6Xunvuv1D8Td7LYHLMQ9
	ePLDstoHfj1xq1PjxIlVFzCv4HmnlLs8QWFdBMbRDllUf/Dzw1yd29prsKIsVZlbAws7sJEuY2h
	OKyZyjp+D8yybMVKQpKRDHywQdjzew6TCuGnlFgbgpdU3JVXAU9E+ceC/t+uA8r0KkkURnDoAZF
	2CpVshFncfktqq0JY3LQZyH902LR/hW3MjBbO7//COcoFoP+IouyagVgYr1tfSl503FFO9Jioiv
	JGf+fSzI9YqYZjMvDCn99o4BrSfpNDc9xmDRUzRkMAYwREmjsyV76ZVdwAN2cGJUbZTGXheqg==
X-Received: by 2002:a05:600c:1391:b0:4a1:fc0a:8b75 with SMTP id 5b1f17b1804b1-4a35ac9f430mr75846955e9.24.1792936729550;
        Sun, 25 Oct 2026 06:58:49 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a09434esm123575575e9.0.2026.10.25.06.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 06:58:48 -0700 (PDT)
Date: Sun, 25 Oct 2026 16:58:44 +0300
From: Dan Carpenter <error27@gmail.com>
To: Haasham Khan <haasham93@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: remove unnecessary goto
Message-ID: <at4LFOUt-XGzBAgS@stanley.mountain>
References: <20261025130258.10747-1-haasham93@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025130258.10747-1-haasham93@gmail.com>

On Sun, Oct 25, 2026 at 01:02:58PM +0000, Haasham Khan wrote:
> The error path in hw_sm750_crtc_set_mode() jumps to a label that
> immediately returns ret. Return directly and remove the unnecessary
> label.
> 
> Signed-off-by: Haasham Khan <haasham93@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_hw.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
> index c4358d3e5091..22f93277e91b 100644
> --- a/drivers/staging/sm750fb/sm750_hw.c
> +++ b/drivers/staging/sm750fb/sm750_hw.c
> @@ -272,7 +272,7 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
>  	ret = ddk750_set_mode_timing(&modparm, clock);
>  	if (ret) {
>  		dev_err(&sm750_dev->pdev->dev, "Set mode timing failed\n");
> -		goto exit;
> +		return ret;
>  	}
>  
>  	if (crtc->channel != sm750_secondary) {
> @@ -332,7 +332,6 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
>  		poke32(CRT_DISPLAY_CTRL, reg);
>  	}
>  
> -exit:
>  	return ret;

Change this to "return 0;"

regards,
dan carpenter

