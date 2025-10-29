Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D142F7AC0
	for <linux-fbdev@vger.kernel.org>; Wed, 29 Oct 2025 05:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761715794; cv=none; b=ohPABqaXv3QmH5TDWLHlBYhUPBQMZvT/G3TbC1WzKtt/bpar463H6isqI2Hyl/aelF4BoROKiZKJ4pVWw8SCcWPbLhpIgd+UQB7+ui84g+0+TAj7+Gc71krPhrILt7ERb8wwxSdwqLUjQe/hYd8VoDdN4RbXGHj0X+XgOJM5lVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761715794; c=relaxed/simple;
	bh=08/mzPYxSm/1nDpxNMmjbrtO5PkDhUO1zOysCCv/okI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO9b/nX8KjRje5OuLCYrPm9dD9aJZawPqYjgIEfAOMx2wLQX8p0/vPlFQg46GNdCIGJAggO+dOcIKQkiCU1YsSsLrojmV3W+Kz1hJoLAhBaDPSM/7ftKbtjNebTJIR4vohkd2cjgKZTb6qNUb5u1MO7kQ0adMvh/VJCBU5YLYvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rFQdn1y4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFQdn1y4"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4710683a644so5312515e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Oct 2025 22:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761715789; x=1762320589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pHaGH2NXIUYjcvzs9hO31NRTn0XjtT+KRdHL3PUBxU8=;
        b=rFQdn1y4g5Z1CkF1aKD8Y1A5sQ9H7frsuEwID6DGNdKuVJ4vH63j+v2GeB5ClCwK4Z
         nmX0u3AkNmsgQfP6YoZOEC+RPKrejDZBwOlWJi9AQ7JbkanngvBPtFA4o8AJ1ihj3hP1
         RkZM20fTfKEUCnT8zEH5r/Qb7OL0X9M9CtL6UsiZi/VAQgWrRMT5KqsPuwBx6NcA07Zi
         on9ERJ2a0o0l28BWwqfig9eT9oxVp/iEvnKZI3LSrlvWeiF5gvRkOssLcpS4xfGEtkl7
         sb/yHKlmAnb0cE+QvR7OidAsIv+arfms2ekr9yk3Aj/YbwSNH1g6pcU8bA1qlWYlcKgG
         XEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761715789; x=1762320589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHaGH2NXIUYjcvzs9hO31NRTn0XjtT+KRdHL3PUBxU8=;
        b=GR0aKyrQqu+b2BVcgv4U0ZZ4nu9+iQYvhhcnrBvr/AiD1UFnBqj2cZdk84AQhVR549
         uHx8U/PYiezhe4R99EhadmDGum43IFPKL7kb6+eR0I8flkk/nmgwm6dCOrPx55cOzOi/
         G1qnyzYmuo/FybuHET5Kk2BIt91il7c5EX90oGEZRb0C+cHu0aRc3qkZRFXaYMoZYxiG
         vCQfoTFDYlFEDHiUSCihsS/f0F0G0ZvnyFl/gwgw0IHO4Kmw1JDBTTN2n11Q0QKuCqHg
         krSSKr0yEdGsm0vDpM4LSSbvAtY2vrdT1pV5j5smLKwQnxaeICrH878XYrO+Advt+M0i
         GD4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxT5QbkO0nooFIAinARBWCfa6rVF9nhvN2ObPbQxuXWf/TuQHvNh+yXQacrgbmrg3CfD3jXseiX5V5MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJrWY9OClf/X0rIof5gz1DLu6OMs5ZiVMeaJnEXxWAymO/AdQz
	NkfCA/gYgz2YsgBNjkBWffcoLQ7NUIrF23TiZ1VfZpWc/XXI/cUEJ+J/kUu/Pj6XhtE=
X-Gm-Gg: ASbGncvnt0SHs1ieImf5rvcoTdc4ZKVFHIwCBePfF9yuxV8x+DmNvjpg9G8EzyswP6v
	TLGTJPn0vzHMUvLDz1pxeGli6h3UHqHcqIPW+ZjdBKvT7N6TgWW9nnRVPHxoivedhRV8fhrJWTc
	Mt1gxGRhgtoS6wOuGRxEgddV5RuAWo8PJo7AytKbohUIUcwiFimPKjjTgnz4ET3L5IZvSod4RYe
	KpcNct7FkUiw6/MF6RZG4JiCpxCg4s2gjCvflJOmomopwjbwpAW4TjvjllXO/AtMCUiXntcvEqN
	iPZAB8P4F8PSF3cRR9wPI9WSAhIZI5adRAN6QFvd/OFYnJNrpGhvVFCSn7hWbWnR+k3ZMLE0r9x
	H1d6PM+kWTYiZjkpzSaDuPin+GTDlKb1Y8HDRVsi2g3rNQclK3FT4XaeN1dIYyOELA+srBbzK0j
	6QujbsFZ0qrZg1BJb6
X-Google-Smtp-Source: AGHT+IHG2WznNN/Rizk/zJNzOf90BpJVy0QqUr8IDk1RCx9tIDyYps0DxYX9Z8QZNUQwV5GlDx1Ltw==
X-Received: by 2002:a05:600c:58d7:b0:46f:b42e:e363 with SMTP id 5b1f17b1804b1-477181c334emr32548945e9.20.1761715789186;
        Tue, 28 Oct 2025 22:29:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4771e3c878fsm28225995e9.17.2025.10.28.22.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 22:29:48 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:29:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
Cc: sudip.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: style fixes: align call and split
 chained assignment
Message-ID: <aQGmSIinidUQnHT4@stanley.mountain>
References: <20251029022123.5829-1-cristiandelgobbo87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029022123.5829-1-cristiandelgobbo87@gmail.com>

This patch was really confusing because I had no idea what I reported.
Just remove my reported by tag...

This is not a v2 patch, it's a whole new patch.  Don't call it a v2.

On Wed, Oct 29, 2025 at 03:21:23AM +0100, Cristian Del Gobbo wrote:
> - Drop previous change that made g_fbmode[] elements const (broke build).

But if it were a v2, this isn't the right way to send a v2.  In a v2 this
would go under the --- cut off line.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

> - Align the continued arguments of sm750_hw_cursor_set_size() with the
>   opening parenthesis.
> - Replace a chained assignment of red/green/blue with a temporary
>   variable to satisfy checkpatch and improve readability.

These are unrelated changes.  Do them as separate patches.

> 
> No functional change intended.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Signed-off-by: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>

Also run your patch through checkpatch.pl.

> ---
>  drivers/staging/sm750fb/sm750.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 3659af7e519d..94a99af4320e 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -121,8 +121,8 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
>  	sm750_hw_cursor_disable(cursor);
>  	if (fbcursor->set & FB_CUR_SETSIZE)
>  		sm750_hw_cursor_set_size(cursor,
> -					fbcursor->image.width,
> -					fbcursor->image.height);
> +					 fbcursor->image.width,
> +					 fbcursor->image.height);
>  
>  	if (fbcursor->set & FB_CUR_SETPOS)
>  		sm750_hw_cursor_set_pos(cursor,
> @@ -538,7 +538,11 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
>  	}
>  
>  	if (info->var.grayscale)
> -		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
> +		int y = (red * 77 + green * 151 + blue * 28) >> 8;

y is a strange variable name.  It has nothing to do with the y axis.

regards,
dan carpenter


