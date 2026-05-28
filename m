Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B903A7833
	for <linux-fbdev@vger.kernel.org>; Thu, 28 May 2026 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977686; cv=none; b=a9dWGAAaBmMNHpax+pDR8Y+OSUuu8Dg6zma474sMnuzPwB2h68vYBDhanmsha+ZQnGTmyx8KsJpfCCND80KjGsFWWKpdrrypeoGGvjf8cqopiFFtuW1i/O+F+NFQOUW/VMuhLajzinLYjRH37ITsBuJ5Z7MBwjwR6E5d2KrdcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977686; c=relaxed/simple;
	bh=rdPGG8pktzYfsd4W8n81NxemFwnNGSn28UK5dAbJa5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqogBRfhnH775TX+GMCTNt+aD0sIZDAv3utjpax96rtH6iC5bg7bY03Cu/d6Q07KsIfcJ3D8pbQ6BDwdnng0C4Y75g2LuyeQuTt6x3hjmk3qoASw2ve8Esedvby9rnLGeaI/bnaRKDqaGws2MwhWqXfDDek0uX7jdtdI5hO38O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQn/JS3T; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQn/JS3T"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45eedcbbb48so293592f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 28 May 2026 07:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779977683; x=1780582483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t5ZWNU2/v1WVVM5yKXhZz4uBk/9oPZrNGdrmkhMBSCs=;
        b=qQn/JS3THjBWSZVSuL5DUZvRxEkAmon2bi8cjHbqptw9161hpod1WBFMCnG2QwQS3Y
         piMPKQpacW/2o3uTvy6z77KANvfnfIePqZVP8THfQo3h5wsicCIHCDgRMJz3mlh5wxqN
         2jtzaveZxR6MyvuoXC+sjrNOxFIkJc/Bzp1MGeZjesfFaXfDZSWuDj1fpDV13rxmlr4z
         UCqHjYu6TYKHm7qvqfcuh632DgM3RdfeXrFHyQ8swJZt1qitwOVP8J3ZhvRZxCLf5q+a
         tk4qD0//LnAEbvAnefRBkGh3XZ5c6yYAKkJZySJYPVzcSxin7qcaNMOKdUTpvJ4BU2f1
         3udA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779977683; x=1780582483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5ZWNU2/v1WVVM5yKXhZz4uBk/9oPZrNGdrmkhMBSCs=;
        b=k1kFkkMh1eNEy7tc2HzKqPUMTl6AazROe4XizpOf1+eh7aQaUBINbctr2pW3Tmcb7I
         FVUbPwoEMZjeqEhalut/gaSscpZS1hEwjYiAeeXwYK+b2tIINagO2vIwQs+4dLDSkKKh
         vYN0HSceR/AJ9v/+CwZ1ylLpLJ0Jo8lm1/iiElkjIRj6VBRR86jnTwZXW6RRbB1NmrHO
         rOBmVnf1g4FoTD9R4xzr6FccKNSdGaCCzQwWhVnDimq4zx+l+fqQRbDV1I1PmfjWqGua
         nMnR+TiMzPfOowOE7GmaZbscuyyhGd/OLdnlFBqER4UxkCaWg+acjHp/hElYG+O8Pc8X
         pBoA==
X-Forwarded-Encrypted: i=1; AFNElJ/0vuR3MnnC5Q21tBpXl5Q/sHojVTLKGMKLIXl0ueNLI+0E3Fs8rJ9lj2lIecZ7yN8f7s+xkuXkFQsy0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX5o3X9sFWg0Wx/oCfKJN9lnGlNu3RxEhEJiDk0uga4qPBNmgz
	yFavxhh4UKbI1zRbT2TIQ9VjSY9hmF8wiAwTTjJQVS91pxvCvk17NMnL
X-Gm-Gg: Acq92OF5AC2u6Xzcj4L64um88vTNuuQruCO0C8Rt8+YTko4zWfacw7paDrmjRwddH9p
	IV0nIB66uUBS982EgsiDsHesSQjHSnT7BUD7dBaaxxbGIEUtdxEZBCUXfWrfJsWJpKguz5Ux0qK
	TQFc8vkErTq0Q8ruhndni1bAJHkpG7hGVscXwKgugrZLCMV0CJ5s5KixayXLn3Q7BrzpLM3yKLQ
	2g+VNe/ECye8qjngwIVojKZDXAZcveniGgD6s3CVPSKH/IU0V05ogYLFL7QeJlVmVHI33f+KWY5
	isvNl4TthdauBG+qnq7B5dFszZQ1cUCj9vMY/UqdtPbCIGHzArwhBTL3GjQdjJK5VtAZchTOcq/
	+YEykK2cSI9dQeGCxyv24ogidv+FIfTjwqrY1w5cApuqiNv29VFS0IgXIY9W8RpYRF6JcZ4jxDL
	EOBS79uNHOEtWIj5NW7xjzoUDS3cvKO0v6rw==
X-Received: by 2002:a05:6000:29d7:b0:452:bc74:b129 with SMTP id ffacd0b85a97d-45eeceda8bcmr1325768f8f.16.1779977682661;
        Thu, 28 May 2026 07:14:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eeceb5b5dsm2333753f8f.28.2026.05.28.07.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:14:41 -0700 (PDT)
Date: Thu, 28 May 2026 17:14:38 +0300
From: Dan Carpenter <error27@gmail.com>
To: Onish Sharma <neharora23587@gmail.com>
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: rename setAllEngOff
Message-ID: <ahhNzvLUTIZ3qq6L@stanley.mountain>
References: <20260528133627.10850-1-neharora23587@gmail.com>
 <20260528133627.10850-2-neharora23587@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528133627.10850-2-neharora23587@gmail.com>

On Thu, May 28, 2026 at 07:06:27PM +0530, Onish Sharma wrote:
> Rename setAllEngOff to set_all_eng_off to comply with kernel coding style
> and improve readability.
> 
> Signed-off-by: Onish Sharma <neharora23587@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  drivers/staging/sm750fb/sm750.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 8f01b3c63fe8..716a8935f58d 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -848,7 +848,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
>  	sm750_dev->init_parm.mem_clk = 0;
>  	sm750_dev->init_parm.master_clk = 0;
>  	sm750_dev->init_parm.power_mode = 0;
> -	sm750_dev->init_parm.setAllEngOff = 0;
> +	sm750_dev->init_parm.set_all_eng_off = 0;
>  	sm750_dev->init_parm.reset_memory = 1;
>  
>  	/* defaultly turn g_hwcursor on for both view */
> diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
> index 0492b1afbb11..e8885133da2e 100644
> --- a/drivers/staging/sm750fb/sm750.h
> +++ b/drivers/staging/sm750fb/sm750.h
> @@ -44,7 +44,7 @@ struct init_status {
>  	ushort chip_clk;
>  	ushort mem_clk;
>  	ushort master_clk;
> -	ushort setAllEngOff;
> +	ushort set_all_eng_off;
>  	ushort reset_memory;
>  };

There are no users?  Why not just delete it.

regards,
dan carpenter

