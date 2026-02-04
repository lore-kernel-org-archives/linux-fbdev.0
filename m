Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ABC3B8BC1
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198706; cv=none; b=ttqpdRrdNdKSIu6cTgcHUTghtO0OXqqic0MQyBgohT4phlpD7kbx+dHLvZvzBatggowlwDO3XuLuj0iWHFi6Vd6oOmR24Z3tqWZ/tyZ8xFT5f0HAQc5cCAgfmsTf3egleVDXw/8jMYyyQApjnMc2XjuDLRhXm/EN5GU8W2HUhHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198706; c=relaxed/simple;
	bh=ezthpWKnElCR0TA+hKS8v39gnjtVM/93Fiq5mpvui68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1vG9BmrZQaYej7dWES1Rks0Y8+641Tzr4w/1jojZC3pkrElcAIJz8XJNeWV1yYXCxo14ApXw2Dxw6VUlcXpFpOlLipM3IgpZU+qxQYEtmkgDB1QdE3Y39HLU9uMAF331JKwMLzIgkwupXnFSU4IehXHQBmp4E41cMNn7APt2K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RzcXywoR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzcXywoR"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43284ed32a0so3593350f8f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 01:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770198704; x=1770803504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+pphTL/bI4DAfxN8hx2U5FFoYBqSIHv0mUwG+qB2tM=;
        b=RzcXywoRCciFoYw1FYsLuEdau9zufsRTnGBHUuRSLPfmYeoZmKPHBp2Hsn56ACHBDI
         +yZRF63hcJzhdbmO/0VXYLFKCYGBrds5C//ZmahZjD6i57Pjm0lk3hQGyhrY3Q9pJlPs
         UeR0JH1tUufQEHgF8soV9n5H4KYPLiTUi/d4N9DWLmhQfrn2WPXJArp/qI3oum5VCXCP
         usuQQbXKybm/EGV+EzXfgM4SR5zQ6nu+3wPBpn13Es6wF+3Y30ZTulDAdCTEXYQLF0Ag
         I3/uZNdFAJ3QlsHmw69y0eYcxzmZ2AMnVIBkkcnsezZGem5sa9aAxtLp0iZgeCGC88Q9
         lHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770198704; x=1770803504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+pphTL/bI4DAfxN8hx2U5FFoYBqSIHv0mUwG+qB2tM=;
        b=XT9s+szZcr1H3WafWXZpJAfKjHJvYcVy5SRL0RjyjjNdxG8YgTVAF6CeY9XYRvzYWS
         iB/nHcnDlKp/FM1tmFdCK9SMstoWK/fL86KKvOV+1LtBBcdtTzCAf0XaExDJf00h5AQ4
         1KeUfqKsln/3max13LQ3anPZ42/dobxDwbGcTl+WtLSiWEP3j0vhtQSDPG4zkW1O7TIX
         YjORJM5/GIW+jUMsig1FWFiHzSKnspkHyJiMI/0Ax89oX25NLtbmi7JujWzpH/wYOcfx
         q7s0ER8r0NUyJlWRoKq7I0L0CDLj/0gw5jvINjLGUKcDgQKoLln7zMUT9G64DqGyFKLH
         lwYg==
X-Forwarded-Encrypted: i=1; AJvYcCW1PcslIUmsyk8WTO7vO1J4J6mxvF+XVMoLZuJS/ceqDgkO7XIT4Qnapmz6wGmFKafhoIjSQbDUfUhLZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKBRMjDLYEVKeb9RQcFiYaxCmW4QWTylpKtrKFFLDQN8/J/ZFv
	5VsQ9ZDyn1tCpau9bC36iftOiFAFPByMR5HdksjAypNJg1Ggg2achwcbFbj4AbpbB5U=
X-Gm-Gg: AZuq6aIwy8/DAdyq6WZ2EAUlbTvQzB+F4Me2AM2ISYqmeBSRuhGgOtMjujyoL4UHCSw
	YPyjNuUXdW0dY4200JSIenRHnAS9vypxTsXn45tFHiHD/fz5XFJdaTxLvG3Ak1H+8c9IByfKyhm
	G/H3T+ddDV9uauWvP42VNSnBM45hxB0+ejgf0dmNGntJn+aI9oChmOMHbJ1jjopOkpE8I2Cf93L
	hrw2ZDHFQ+QFaRcpzV8Fvao3hRT3ixX9zhACxlHzWufxR9iuX/EKK4b0xuCOOUmLqbnS0SOLzre
	u8N9YYVMhXUgKj6U4sAWmc1cJDsIHEc5JirGCQZ+fS3F0K/e6BMeTAwpwQRcLkYoUJ/fSlEtGgk
	hsUWyQDRAHMRrvN8WnJq7V++pbbw8lEFIsiKmP3ZnICFuUifjVkJpcXBDkKTOZQ52CdtJL2r+zc
	EFojwYofsAIgpHBlgN
X-Received: by 2002:a05:6000:4284:b0:435:9223:c625 with SMTP id ffacd0b85a97d-43617e465b0mr3425732f8f.28.1770198704522;
        Wed, 04 Feb 2026 01:51:44 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436180659b8sm4734092f8f.43.2026.02.04.01.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:51:44 -0800 (PST)
Date: Wed, 4 Feb 2026 12:51:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] staging: sm750fb: replace strcat() with memcpy() in
 lynxfb_setup()
Message-ID: <aYMWrfvxLALsy8-l@stanley.mountain>
References: <20260203230758.3056-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203230758.3056-1-iprintercanon@gmail.com>

On Tue, Feb 03, 2026 at 11:07:55PM +0000, Artem Lytkin wrote:
> Replace deprecated strcat() with memcpy() in option parsing. The
> destination buffer is allocated with kzalloc (zero-filled) and the
> write position is tracked via pointer, making the null-terminator
> scan in strcat() redundant and potentially unsafe.
> 
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index fecd7457e..4c6e84c03 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -1163,7 +1163,7 @@ static int __init lynxfb_setup(char *options)
>  		} else if (!strncmp(opt, "dual", strlen("dual"))) {
>  			g_dualview = 1;
>  		} else {
> -			strcat(tmp, opt);
> +			memcpy(tmp, opt, strlen(opt));

This has exactly the same security issues as the original code.

regards,
dan carpenter

>  			tmp += strlen(opt);
>  			if (options)
>  				*tmp++ = ':';
> -- 
> 2.43.0
> 
