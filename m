Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C2F14F137
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Apr 2024 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792345; cv=none; b=kXYIFHYDATJUt/nF3XfGms7gp2yBdi7IQpySKFO1FxzCYRzYk3KzSSJ5AeQTxMK80uI3lxunA7W275fMZXnmFMXJteYMTr0kSonSuxixIdBdiYVPu7EnCd3eu2mAD78H0KEVUbvD1+aIX28V1swbH8ROW7iiIML4Bm2M8zQ74BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792345; c=relaxed/simple;
	bh=p71XPOYccBTrK5vNtFphHMc7xrNQr0V9gF4p0adc0z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaqkxZzmzefcE9xH5ljKIEywPWDOaqi9yOUBxob78VQHe3aG+oUQhZPd5UiR5WfqfBEpDc7IPJGvUJeE/EooKwYYhedgtDsiXlmlzGNKFJvQ3zd6pUh5ej1eubJYfg2fbPzvzHRgZkkh3j4ZEyjDwfLVerKAsZAvwPU2zL180sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BsOYc8kK; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BsOYc8kK"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2dd041acff1so26597351fa.1
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Apr 2024 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713792342; x=1714397142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/kyPaZIZyrkWqjj0WFiDLbAxvb7aRYR+HuKJ6/NuUGw=;
        b=BsOYc8kKt4Q6uNuwgGExl66dXM2B7nHDi9znqKlCDM1xhyaY4GGq+rOS6yzCDIotqL
         ftlx2KiA30tjV22Ru1eKbG0OKrLeJtCm+kei7BUh/BG3oscuBDl/TRr706tHK0ZplkDj
         PRzKs31GOkjZ32RDjU8k4YaIfM/QGEqCkaQ3iUjY8eTsuPJ84m/eTzebnxB8mDvz4cH9
         m6ItnrkWIwxuVkprcKBqtFMFqzCHFyHfCmjaiT+h1lkMt8i27mLPVCQBLEi8qS+rbeuB
         S/1mL2ta1j+EhvrzY0yLQmLXWJmfJYPQkjdG49py3a/0wMBMUf0GRBEKl2OFsi7s1ABH
         Babw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792342; x=1714397142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kyPaZIZyrkWqjj0WFiDLbAxvb7aRYR+HuKJ6/NuUGw=;
        b=TN5ij4Cq+ciMsUHeuc764E5HBzenWHbb2Dc4/snS9+a7a21wwD71YZ11ZNyhbq6Ezh
         tHtANAyBxuIj1gJ6X9bMgEi31mmyugEi/SGGMV15n/GYtZ+QZU7kDCl67Ar19GkdTDC9
         jsE5D5O2PIiX8Sy+Slbwt9HK5nsumI2ek5zxh5NIjjZk85HniWQOdVyJ5lyG6OW/Qayg
         +MbBYFfJ4JCwL/9AIzMGPUQlmGr9113g4k0U48M4dtZck4Uhpf9sUZ4cvHQlmwXvxycR
         0A0CIcU0NsGZQV1LEWGTwhEwAK4ohFoWO0Wx83S2M3gzAp98gPqlq3S3f1bzldBZ611i
         pWaw==
X-Forwarded-Encrypted: i=1; AJvYcCXpBPYbJWTlsrWsPqQDl8S34NQmInxw6htJYAjCoBmWV6kkKWZ7m64JXljUHC6LH4oD6WrW4sm6C+Ad7nxBAkEHZHWXPWVM9usCFUo=
X-Gm-Message-State: AOJu0Yzzpzt2DRyLzx62jMHWe9YfRX1ucGYKRZmD+P1mUHcS4OWnf8N3
	hM5ud0UQzIEKnbhAglDEaO3HUkRbtt29BATEmGDKWsXHkiiKCxaJeLFM3lWYaD4=
X-Google-Smtp-Source: AGHT+IHWET/ZymKfhlPZrQHfC2dJ8JbIntynRS8qE8Jm7h5ARJyaDMzXxiK//kI7R+cm7SauaT3FVQ==
X-Received: by 2002:a2e:9d43:0:b0:2d4:6f33:2e59 with SMTP id y3-20020a2e9d43000000b002d46f332e59mr5822818ljj.30.1713792342161;
        Mon, 22 Apr 2024 06:25:42 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ef9-20020a05640228c900b00571bde3b0a4sm5246522edb.34.2024.04.22.06.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:25:41 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:25:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: A <ashokemailat@yahoo.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging:fbtft:fb_ili9320 Removed redundant Parentheses
Message-ID: <9baed766-a2d2-4b94-ae2b-d16ffbea3f67@moroto.mountain>
References: <452e4a2dcdc7020f75b84d787297a1d17a21ca81.camel.ref@yahoo.com>
 <452e4a2dcdc7020f75b84d787297a1d17a21ca81.camel@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452e4a2dcdc7020f75b84d787297a1d17a21ca81.camel@yahoo.com>

0) Fix your From address.

1) Look at how other people write subjects.
   git log --oneline drivers/staging/fbtft/fb_ili9320.c

On Fri, Apr 19, 2024 at 11:04:21AM -0700, A wrote:
> >From 51e98164e314a2d1d834d2a9baea21a9823650bb Mon Sep 17 00:00:00 2001
> From: Ashok Kumar <ashokemailat@yahoo.com>
> Date: Fri, 19 Apr 2024 10:32:48 -0700
> Subject: [PATCH] staging:fbtft:fb_ili9320 Removed redundant
>  Parentheses

2) This should not be part of the email.

> 
> Adhere to Linux kernel coding style.
> Reported by checkpatch
> 
> CHECK: Unnecessary parentheses around 'devcode != 0x0000'
> +       if ((devcode != 0x0000) && (devcode != 0x9320))
> 

3) Just leave this as-is.  Ignore checkpatch in this case.  Greg likes
   parens.

> Signed-off-by: Ashok Kumar <ashokemailat@yahoo.com>
> ---
>  drivers/staging/fbtft/fb_ili9320.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_ili9320.c
> b/drivers/staging/fbtft/fb_ili9320.c
> index 0be7c2d51548..409b54cc562e 100644
> --- a/drivers/staging/fbtft/fb_ili9320.c
> +++ b/drivers/staging/fbtft/fb_ili9320.c
> @@ -37,7 +37,7 @@ static int init_display(struct fbtft_par *par)
>  	devcode = read_devicecode(par);
>  	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par, "Device code:
> 0x%04X\n",

4) This patch is corrupt and will not apply.  Read the first two
paragraphs of Documentation/process/email-clients.rst.

regards,
dan carpenter


