Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A12E2EE9
	for <linux-fbdev@vger.kernel.org>; Tue, 15 Jul 2025 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585662; cv=none; b=f+rTVjDdC48jb0+F3qbZU84VgLmwXIsJUyKwRf0nyLYoSGtWOO1wafWsEBV3WViMlU6Dakybn8MJnXKqBkNdIH/IHOoiNLAxms/v7IAkv6f1CfKGg/rQ9SZHU8AV2to/vZKA1mgTmVDw7LVkD/FbIg2Ppq6gMlWKuNb6x5UYT8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585662; c=relaxed/simple;
	bh=iTD6QvZiqKeEPSTRArjSPKCxmJgkIkYH4P8NnK2Uek4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQLJ9bsvLp4+fTcfNwN0Pw7ookI8Dc1ZaWnGVlltzeX8YfSyQFLPsy9HGJTGrX7+dw7UEiTo90pbZzY+RNI+ydyII/rBSflzUSLjXG/zi04Qb9j6l0m4wWb8fpJvZMhq9HUqZsRir3gs7ORZim0SeMEoHwn6WBxapYrNz0YFQPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Sj4CpYCY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Sj4CpYCY"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so50052185e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 15 Jul 2025 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752585658; x=1753190458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2aER99iRVzHm/yjHj1djxkk2abTrxMFAl8DKmvxNC7E=;
        b=Sj4CpYCYKMArSE2WNKe9VIHCoVVMPqgl+zSny72jjlwcJ7WPNEdhyECom2scQi6bTR
         qWlhHb65A5VB1IvIDyb+GpZm/LprNY1x9DyiZ5RUXF7o1NY7Ca+q8jzKK03vug6NbEnX
         RNUZbTiKsLlVvdOkedS8gdjR3Bs99uSANjo2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585658; x=1753190458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aER99iRVzHm/yjHj1djxkk2abTrxMFAl8DKmvxNC7E=;
        b=Sb/4sIchVK2YPk4AB5pO73dLd+uk3VsR1iIfKWXNbuB50Szcw9SyVk1W1FanyH8Op9
         5h20sHY8IHPurGj9qnOO7i90tN89wtZ5zTozbb34cnXxoQ4Ic0oEkK2UByRvUxg7hD18
         19Gr3OTZza73hiA8KcXKeH0K+emrkJwDOB0WrYw9MzF3qW1iP+yFv/NEdX2CsePHJC0b
         BTiMFyC6fevH8YqG+x2pIa/dz69ybpOjU5n2Nef+SWtHKHJCNvy+T73jxYtXdz5p1Z5w
         rjB0SOyjwmQBxK1Y754LpriDyJEWgu+znwRiK9FLcMnDl6ZRixzpUkcrxpUUDoNBCQO7
         sXaw==
X-Forwarded-Encrypted: i=1; AJvYcCUBOGgGnOzKT/TCHshfY16IHcssJZYOERvv6RN8OHvOT7TKRbstgDPvUm57V9h4CHDJBBajr++1iFacbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVwptFSzO72N+2STCjwi5D/p5mUAJI81dL0v+zU5RYql+Zlute
	XQ4Bs/gPwIMGpgwypinGglx8IDd1a/iNk8NKyrSJ6PhiEHttpV637i4BZdHiUNMtgWA=
X-Gm-Gg: ASbGncvWVjnmTVXYgDpluSIRK0CkVLB8ghqs4MfQLrWImbUNK0kyI/wVkVAzx86V6N3
	vOS5a9tdHcpA1lzjESPT6eiHI01jj3ZCwCXAaQrRrwDj3DwZu/euywMgWmWFEtzSuA+zTqLRpcW
	BbjxRYENFXtgbaNiTVJjj72+myS1A2o++pDuTfRRrzHifCqHXaKpoDEHicbN0dI+Ar1HTO3QOZh
	Quj8uzLGKb7sTuZtqu4fg5RzELwjcnfDuM1HT9kpYLX/n36fAwEX3PlxKAZAxZymUaXaB536gmY
	sJo6tdZWkM61vG6UkBWnd3AsMwXTcn8t+UG3X6vuyfHgJQnrqVM8p2zwsZYDW4ddz8xnYx5jFzQ
	wwyUWAEf+2FXBSnULacMCjIzuC7B7LK7WWg==
X-Google-Smtp-Source: AGHT+IGinrr6VlQ7VPBCrVc59xWEOcpuzjncDgPBrTWdeNMpcUJW8rPWbAvhsIGRi9zIwLALwbGYCg==
X-Received: by 2002:a5d:64e4:0:b0:3ab:27f9:e4f with SMTP id ffacd0b85a97d-3b5f2e1b872mr13361758f8f.35.1752585657761;
        Tue, 15 Jul 2025 06:20:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562b54b439sm3676615e9.16.2025.07.15.06.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:20:57 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:20:55 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com,
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com,
	deller@gmx.de, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
	fnkl.kernel@gmail.com, j@jannau.net, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, sven@kernel.org,
	alyssa@rosenzweig.io, neal@gompa.dev,
	support.opensource@diasemi.com, duje.mihanovic@skole.hr,
	dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 05/15] fbcon: Add necessary include statements and
 forward declarations
Message-ID: <aHZVt86l-sXKQpMI@phenom.ffwll.local>
References: <20250715122643.137027-1-tzimmermann@suse.de>
 <20250715122643.137027-6-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715122643.137027-6-tzimmermann@suse.de>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Tue, Jul 15, 2025 at 02:24:42PM +0200, Thomas Zimmermann wrote:
> Make the header self contained for including.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

> ---
>  include/linux/fbcon.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
> index 2382dec6d6ab..81f0e698acbf 100644
> --- a/include/linux/fbcon.h
> +++ b/include/linux/fbcon.h
> @@ -1,6 +1,13 @@
>  #ifndef _LINUX_FBCON_H
>  #define _LINUX_FBCON_H
>  
> +#include <linux/compiler_types.h>
> +
> +struct fb_blit_caps;
> +struct fb_info;
> +struct fb_var_screeninfo;
> +struct fb_videomode;
> +
>  #ifdef CONFIG_FRAMEBUFFER_CONSOLE
>  void __init fb_console_init(void);
>  void __exit fb_console_exit(void);
> -- 
> 2.50.0
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
