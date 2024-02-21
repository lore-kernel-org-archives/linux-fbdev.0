Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CBB3D566
	for <linux-fbdev@vger.kernel.org>; Wed, 21 Feb 2024 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510727; cv=none; b=aZjuN6shnM/uD+jMrgQJZ3IJ6OhaGacO7n4RWRSkCvlwOCTvdG3VfLOpNA0v8bd/6om4LxpNYm8hnlX3QWOg++5QyJm7wl/dK/VblapvUwyIaxpO1+oWkN52pCBnrrJlQ1HMfa2Ki+29GUEhoP/bBDk+iHBY6iKbe1uyUBCghNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510727; c=relaxed/simple;
	bh=Kz0el0TMjoNI2QnXHyxF2PvVpo76TlArIWhUIRqIk4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoqBlV3ouDHdb+bAGSBpdrjOaYwfNF/j7/5wHIZ65qdic7yLphrBce+nVDZ+q8ecA4pUwOLMw7tsZw2aHfebEayw00z17xOoCfrXLWWpj5k1jhZEjJC4wVmh1ob9pPwnDE7qB4OytO4km9rdli3I/AqyhgzmWcegiCe7dokEDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o2y6YKmm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2y6YKmm"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso7182849a12.2
        for <linux-fbdev@vger.kernel.org>; Wed, 21 Feb 2024 02:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708510723; x=1709115523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UOZWXYz0ax9PLPpkQLJdzcrN4l+8sAJvZhLzcXx8cHQ=;
        b=o2y6YKmmnee3ooMs6ptM6cHg9V0KN/AXqiVpLslvg/lw2+r+vjeluYeU4cH6KYI1Lt
         +WZrliqxDBTc9/2/C/FCfb99trkisJQLKaEvzzEDZzOQLbIkXtk0Jo6Y3FXOClKs4GAK
         zKUntUTjMXLhW5t1v1D3Gyv0Xf8uANa/fWHsrr7nZDfVBQIFHS2FdaRcXPplZ5IzB7RZ
         SVQTCORWEVB0EgzdN9j9l2nw80ncDVmvE4d2yCz4kDqyZfq6HMvYcepwNOKjvvSxYSNK
         vlIys6wOkgqevhhGeF7FM1J6iYyk0r5syowT0AxNU0rV2kOkvV5wc04JNybkmX+QiDti
         wAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708510723; x=1709115523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOZWXYz0ax9PLPpkQLJdzcrN4l+8sAJvZhLzcXx8cHQ=;
        b=YkxZEpZaQ19IjSkzqG18rKd5/T/kA3yqrqMxor+/veko7DBqIgx8dLY/9amwcaAsQT
         pnSpFu9L/S+hi8E28BZlVFxdtENbX2LvHj+AbTB2wEpu1ajJRminZ05HiJbzxttvXSsU
         SWg+pOjshTufbFQSyI+XeRvb9JIGjuKRKOqEh/4Ftt7R1q+OjYL7URlAC3Wd/KwKC8pu
         bTrFjqtbcyPDMEq8ezYUTnQrvGcdrf7eFMjr4EwGKdG0B33hYxcAkBsKajEE5dYVYkpS
         3zCDWAEMoH4sdQu3MW8Oy1tYMofqIOxeTjaQ7WdGQLgZFhZwRHSp419ySVdWcv11s2YI
         6uHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF+yQhe1sGeWsigzpVMbUxYLBPv+gk9vsg7mLsB9QmOFgNJYmY5X1/mxD1k6y2rE6byAC61IkUUOOf9N9c33UOJmfFc5UmLz0D48k=
X-Gm-Message-State: AOJu0YyrbKeb2LulF9i/Lfx9Dy0jhVxhvEMkZtoiCgvom1xeYearag1H
	bgymhi3Fx1kpvvVakHXk1XtCAPlyu2lUNYyj+VslQIg1QH8zWUgEncNM3K93TuZH/6chvrX8S3i
	h
X-Google-Smtp-Source: AGHT+IEeRDPAMZ7wla9T06jLLenh+NdcXBE8k3BklG5ivy4o/djY/xTj8ppS5RuIiGGOVuLlBqRm3g==
X-Received: by 2002:aa7:c58a:0:b0:564:b822:9204 with SMTP id g10-20020aa7c58a000000b00564b8229204mr3848417edq.17.1708510723630;
        Wed, 21 Feb 2024 02:18:43 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id s1-20020a056402164100b00563f918c76asm4454659edx.52.2024.02.21.02.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 02:18:43 -0800 (PST)
Date: Wed, 21 Feb 2024 13:18:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: sawara04.o@gmail.com
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: Fix "space prohibited before that close
 parenthesis ')'" error reported by checkpatch
Message-ID: <87f76339-3ace-4cbe-bdb9-266a86bf55eb@moroto.mountain>
References: <20240221095404.592464-1-sawara04.o@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221095404.592464-1-sawara04.o@gmail.com>

On Wed, Feb 21, 2024 at 06:54:04PM +0900, sawara04.o@gmail.com wrote:
> From: Kyoji Ogasawara <sawara04.o@gmail.com>
> 
> Since whitespace is prohibited before that close parenthesis ')' in a
> conditional statements, remove it and fix checkpatch.pl error "space prohibited before that
> close parenthesis ')'".
> 
> Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>

This breaks the build.  You could do a search for it.

https://lore.kernel.org/all/?q=define_fbtft_write_reg

regards,
dan carpenter

