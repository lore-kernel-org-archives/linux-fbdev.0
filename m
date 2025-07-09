Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBEF275867
	for <linux-fbdev@vger.kernel.org>; Wed,  9 Jul 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067761; cv=none; b=DQAnJ1RJKDwnSDmymsPpgJyEJNoDHxVqThVwu72cHVOk+ogH4Hk3CnFvZKGf5ZwhdmVveu7Jcz9fI83KJYnMECos5plLPARg0a6scQe8pEBaCO+SukXwcXWBye4N1AYpQxWuuHPV8Pw1rbkS2I5xMuIlxQxrQJBnx+ZxeaJDUDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067761; c=relaxed/simple;
	bh=cW0Bq0o459dhcBjaPtQi1e/bhTjUMZUuCnFStM23xFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=io0pIMA0Ng8V5/81tIYB1S+ZdbxsO//LF0t+ropvvFJsIznCit4SixLfsxzHBTXjb11Ewk7kpLGlgX2+pKnSFlF4hMg/voAGudOqewwA7giupMtqiC2MtiU7EcyubYPsMdxwknKDkxVwt8GzUKnR7bZE+YQFcSyqwfZWlmW09CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=DV+Bi0PA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DV+Bi0PA"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a54690d369so5519782f8f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Jul 2025 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752067758; x=1752672558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7ChNGg4ytvrkyPdwTVY+tgK9qtOn9MNMSkgYieKFrs=;
        b=DV+Bi0PANZDTly+wA2dTvU4G2iVVvc19EV8vRR7cAUlM8MSojOxm5E3PN/HPe9iGDh
         5KoneP/IXUzWy4Llti5vGXRE+9BV4rtgLdGdcyOZ4rGF97lPnN2exJs2FTekCniT/PMc
         43np5jRw7w9lU7JA8erZWM8CEqU1+1n1ChrVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067758; x=1752672558;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7ChNGg4ytvrkyPdwTVY+tgK9qtOn9MNMSkgYieKFrs=;
        b=tGPfg+ZNgfwIlur7Spf/3XtKKqVk97eSq7JFFEVQ3NtxNuB+CtHtZxudw6sidHEmro
         E3kTt3g8m8JWdvm6+Nzi6hN9lHHL6LTpGgKwc7ja3zyXP5QrYwukFH8GKchbC4bMvC9o
         nTm1rwuMtG4KAf2YsyKTcnMFnFuOubZLBrVQjSeCiBQjKNub6D2RX+R0n8Adlu9+dh9U
         5ehlFR/aa/uaFBJHLEKSX19Lak7Bcw//PAhT8SPvhcsSsLf+cGmMDyU6gvEtMceaEyQe
         E/q7nMl4Un/gmCfhVjG6blAWs3UPQ2ir/3AIce5dHnWDmHJcENn6oaskF9W9XrPG4FEX
         OGCA==
X-Forwarded-Encrypted: i=1; AJvYcCXu0nAPZF/SUaA09MYvF4Sl5jLzHNd/RgtVM3yBjE3vJtgpyC/Tsaxq266fTz9p34Tatov3OPHVEKbFxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr6tEHJWTezNRjMZDwvSPUxa3lafRa1NxVufS3GIuydnBqloAk
	Sz2waS2Seg2enwnVYVCRpUqc8nMEFHXkpfCM2qK/F2K4edUo95rDtBdpt8tgp3Ux/H8=
X-Gm-Gg: ASbGnctxu9sPlzavIGAPLm7qCXpTm2BsLrstVpy4DV30lgXbskeIlwWRLb3fBLNWHUa
	asY+Qubl3eT3S5+CHkkZqq1NyJ6WREL0/9mpREKLtA4RYf+L4uIIsBo3Ij5Nzy0xc+yWNq+87GP
	aj6RMcrLhw+e2YyBXBVysrAmKQRWGrWFnZpNQAqEWnqCqCv/VtfszmHu8/xFKJAdFCB25BIy+2p
	62XRiL8VSTi/ftk+02aRoQjD7rOjb2+m5UvmRctnneOFVY+svO3yferGYmxwBBmQ3zF6kcprb1G
	t5zQWvFaOQ23PudF9P42f42MoKEcsBFD5tt2N0WxFu0mwwCcPYOTaF+ok9Cx9dr1AZrv0xMMkA=
	=
X-Google-Smtp-Source: AGHT+IFar//XMLNwcASIfuk7qcZqw3/wXyQn3J1+S0W4CZBJrV82FSt+WnK9/ttO97p5WJTa6+FvZA==
X-Received: by 2002:a5d:5c84:0:b0:3a5:1c0d:85e8 with SMTP id ffacd0b85a97d-3b5e44e3c24mr2126864f8f.22.1752067758459;
        Wed, 09 Jul 2025 06:29:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030ba29sm15624007f8f.2.2025.07.09.06.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 06:29:18 -0700 (PDT)
Date: Wed, 9 Jul 2025 15:29:16 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: oushixiong1025@163.com
Cc: Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH] fbcon: Fix outdated registered_fb reference in comment
Message-ID: <aG5urDySjLCCj86J@phenom.ffwll.local>
Mail-Followup-To: oushixiong1025@163.com, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
References: <20250709103438.572309-1-oushixiong1025@163.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709103438.572309-1-oushixiong1025@163.com>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Wed, Jul 09, 2025 at 06:34:38PM +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> The variable was renamed to fbcon_registered_fb, but this comment was
> not updated along with the change. Correct it to avoid confusion.
> 
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>

I've added the right Fixes: line and merged this to drm-misc-next, thanks
for your patch.
-Sima

> ---
>  drivers/video/fbdev/core/fbcon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 25684f5d6523..d8eab4859fd4 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -953,13 +953,13 @@ static const char *fbcon_startup(void)
>  	int rows, cols;
>  
>  	/*
> -	 *  If num_registered_fb is zero, this is a call for the dummy part.
> +	 *  If fbcon_num_registered_fb is zero, this is a call for the dummy part.
>  	 *  The frame buffer devices weren't initialized yet.
>  	 */
>  	if (!fbcon_num_registered_fb || info_idx == -1)
>  		return display_desc;
>  	/*
> -	 * Instead of blindly using registered_fb[0], we use info_idx, set by
> +	 * Instead of blindly using fbcon_registered_fb[0], we use info_idx, set by
>  	 * fbcon_fb_registered();
>  	 */
>  	info = fbcon_registered_fb[info_idx];
> -- 
> 2.25.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
