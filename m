Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697283D8104
	for <linux-fbdev@vger.kernel.org>; Fri, 26 Jun 2026 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456497; cv=none; b=KtedWIE+C/Hn6Add4UU/TMeum0O8Z3ko+YL6DtqP8BSNiOJ89HVTT85gzMah2/Cum3o4kRepAsPEpIqIzCNvSoWdLWmqMt5lTtTGf3te86unHhCWjdDNWmNnuSw1AKlKVGkP1FL+vOcZHzeTMpYyZXIgSR/aRLeQiN0+7Ft/Rfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456497; c=relaxed/simple;
	bh=piuMXamwFeb2ty8Py4xAcFtdGIavuUxn7rU5cnWtoPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1y44HHTQGQCv1xceMFSLLk/lcdVmMGm7OQ/9tjCUXTaFx4qWqzfHNeZ7HKJ9qfj3Oacgt4FUUCZaUoHpwS7Kzayzi2NHnPutnySPDUAvk5MT7I4iSw1JKHpAkiOLwJEXQ0EXplgVJJfV3b+AvVNmmSu2i7InCsp4CKY4C5TnGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rvGA7NH0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvGA7NH0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4924593f45dso7628295e9.1
        for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 23:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782456493; x=1783061293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N0cksKNHvZ81428H3lVKSOV4A7mJ0/dw00DfAdSSuw=;
        b=rvGA7NH0gGqh2GN3utS10bLKcyq6MpKq9xr4fn7zMD5PboGse+svuU8M/vaJ5jpit3
         45Cg8YgpJKIGB52GMmd5ZznCQC/hKc5ieYyxyvrcZpRtjBUzks7fL0YJHSErmYG3Y48t
         E+VKPGzmyetIPttbVIfo8AG7V+uezBcBmlFiJrnm8ZRb82OLu+COc68dO0bQhZjHOXkN
         hwv0b2VMisxwn6w9L0cbJn6eTgKAN10CeChBHk7I8JVxUwFKnCe4vMZ4bTdKQFbr+0EB
         JPxhAo8I/40R+V1jrkroc6jACSWHOnue1/eRQGowtNF23b2NVutmDBUj5/HWVCg0DyhK
         lpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782456493; x=1783061293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9N0cksKNHvZ81428H3lVKSOV4A7mJ0/dw00DfAdSSuw=;
        b=OQESel1/416gb3vq3Fbh1LBo8kbgw4df1g0SsVv50W7Phku9eEJoYrAW727Blk0I2r
         UB9Kl0v3AsB5ky3LK7O4YGVmT/jm3h5Kh6edfZIcf7I6ZibYGmB5ylAF2b5peib8PCEF
         4Ak75012+0/CaOMnCroQLtG+r4LqTOBztDwWgefNsjdD/CtF885r9wQs425CLZ6u7n3f
         +rvdJLEuKx/55LuOa0476c7M1Co2P1u5Utn30p6NIHzLtWoS6jVKscE8TqAEpX9Mzr2C
         X1LT32g6nubrG8fgHJa/NG2noakjckY6A+ITWd9S+jOH5Bncddwp0z9l6imTfm9pJuZh
         mF+w==
X-Forwarded-Encrypted: i=1; AFNElJ/v/9VR0jO4dy41qPbGS53zpmq8f5wVzfgatgZYoZoDtvbJiFlRBTJeq3p4QPIASvbRgRp0eKnwlBsevg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZUoB4VVhHQWBwBb9PlCl0zezBbPbz+pr1b8j5ZYKxenz99BA
	b4DX8Dl7GgYt7uSsVokaPjuzAwUK6Ke4lVertSe0jygrJnTBmNFL4PL7V9SrSb8h
X-Gm-Gg: AfdE7cmG+9+g/2jqoxD3x47BEzqf7q9H9Q3uxQ5kKNAVWf+QxrFVzaFU9IwBppsoREl
	zknwlbPHL7JoG+2Imrn6rSxXrFU4wc8ml+rslR5AixIQaNh213ARb5SYspsVTCwa0Njs2iN++Ly
	+VY0qo6uSTHMvj+lksOeys5p0y2udUOMGQZhgfufuZzHPrppYJVR0P2y05+74I+INeApUevFuQk
	If8qTNdcpfwjS3/5qN7QZKr3GAMU9QCfvKRskJ9eq627KVCwBNE9SmlgeR/j1wuyHzyAOQG9VrF
	h7MELjVzH33xiESmuszqCXsN/2Ysyl4aby+1A3Z8M7AlwT4BQb/JM7Px6lnF70NQbLTzOAxyfc3
	rQ6CiHBgGup/LBj5mYzlzeaMZEfelvW0LoJx3AV85dYFo2+Uk2SXoRJEWG4onVXH0KaRT0uBY81
	iEOi+BsUH5GgkmDGjvtslGVM+G9CTzTnGShpJZcNXWGAVoLLq3bg==
X-Received: by 2002:a05:600c:3143:b0:492:4cce:53e2 with SMTP id 5b1f17b1804b1-4926683b1a2mr69365785e9.3.1782456492535;
        Thu, 25 Jun 2026 23:48:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690a1a85sm93653035e9.15.2026.06.25.23.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:48:12 -0700 (PDT)
Date: Fri, 26 Jun 2026 07:48:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: suryasaimadhu <suryasaimadhu369@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix unaligned access and buffer size
 when startbyte is used
Message-ID: <20260626074810.433c4006@pumpkin>
In-Reply-To: <20260625103041.281190-1-suryasaimadhu369@gmail.com>
References: <20260625103041.281190-1-suryasaimadhu369@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 18:30:41 +0800
suryasaimadhu <suryasaimadhu369@gmail.com> wrote:

> When par->startbyte is non-zero, buf is advanced by one byte creating
> an unaligned pointer for 16-bit types (u16, __be16). Dereferencing this
> unaligned pointer can cause a kernel panic on strict-alignment
> architectures.
> 
> Fix by using put_unaligned() instead of direct pointer dereference.
> 
> Also fix incorrect buffer size calculation in fbtft_write_buf_dc() call:
>   len * (sizeof(data_type) + offset)  /* wrong: multiplies offset by len */
>   len * sizeof(data_type) + offset    /* correct: one startbyte +
>                                          len items */

That should probably be a separate patch.

> 
> Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 2169f8d1d..cfcf4d7e7 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -4,6 +4,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/spi/spi.h>
>  #include "fbtft.h"
> +#include <linux/unaligned.h>
>  
>  /*****************************************************************************
>   *
> @@ -40,7 +41,7 @@ void func(struct fbtft_par *par, int len, ...)                                \

I'd consider changing that to:
	func(struct fbtft_par *par, int len, u8 cmd, ...)
and probably reducing len by one.

It makes it more obvious that the first parameter is mandatory and the ... is
associated data.

	David

>  		offset = 1;                                                   \
>  	}                                                                     \
>  									      \
> -	*buf = modifier((data_type)va_arg(args, unsigned int));               \
> +	put_unaligned(modifier((data_type)va_arg(args, unsigned int)), buf);  \
>  	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset,   \
>  				 0);                                          \
>  	if (ret < 0)							      \
> @@ -52,11 +53,13 @@ void func(struct fbtft_par *par, int len, ...)                                \
>  									      \
>  	if (len) {                                                            \
>  		i = len;                                                      \
> -		while (i--)						      \
> -			*buf++ = modifier((data_type)va_arg(args,             \
> -							    unsigned int));   \
> +		while (i--) {                                                 \
> +			put_unaligned(modifier((data_type)va_arg(args,        \
> +					       unsigned int)), buf);          \
> +			buf++;                                                \
> +		}                                                             \
>  		fbtft_write_buf_dc(par, par->buf,			      \
> -				   len * (sizeof(data_type) + offset), 1);    \
> +				   len * sizeof(data_type) + offset, 1);      \
>  	}                                                                     \
>  out:									      \
>  	va_end(args);                                                         \

