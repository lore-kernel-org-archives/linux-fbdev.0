Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB1248F69
	for <linux-fbdev@vger.kernel.org>; Mon, 27 Oct 2025 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552945; cv=none; b=EbVx8Rq/lyKStEYD/w0yxsunEfK3TccT71N4/R4FZBkoIFbRIQZkvOV4V/8+bbnLQuvJd7ovjfAzhrgceFpq9aHtEZuzzYrlTlN7n45x6CAI/X0wDYcBLJgYCWfVgCrlQsfPc6/e9Uy9aqu51OYFcDGqKhs3oKrRpxNwedeCPJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552945; c=relaxed/simple;
	bh=WwKDAtuQ20D01jVdtRfvMGKLaalNFcjLEA1dkVK4nu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCllkPvNn9VxjCYurr54khYDFnkDdcaX4X04AhL1d42RE8eLFwVnLYeRatuI7A0qORsVMl8Ftp36kMTbWgQjReSFLborCesO+3jz0lOPXihti8B+56wz88ii12NvKT7gsxwOW7hH+J3lGPmpv4XktmnE40xBeKlndrPUESMrYf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wYafJsDS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYafJsDS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so25722705e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 27 Oct 2025 01:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761552942; x=1762157742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VCBeTLhApGGiqkKyRfbUgLkYILC1Vq+3fS3KeJIjhg=;
        b=wYafJsDSV92CJvQavoZNvekebvfzD9WTLdm2D7FuRY3r6li+BWhqpWFUvKWO4aVCCt
         3/1zfmRM86NWta6cMcxa+9R0+DUNPdmhTYSnFZksSmfYyUVbWUjK61dORA2Y5HlhWCa7
         je/gtyM2BdcfffIsi7pIsb6pYwjpI2Pi8OBfW8PJA4XUCErqxome+PR8xPLi/NSbQkVm
         vl9zizyAmBT0J1PrY2+4j1QE4XYlMehsvp2V+x0eVYU8m2AuwYY1JKwTKzjXLBZ+YcO8
         d+WIV2wQM8M6hG9ZgGDE/j8vHDsX1DDFK90jSzYymsKZ9oUPqM0gerpOtYUOkbE/fay4
         HDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761552942; x=1762157742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VCBeTLhApGGiqkKyRfbUgLkYILC1Vq+3fS3KeJIjhg=;
        b=lRAXSPhVyn515MHvCEHMz7sLUeAXBuLi69IlqQMLtR2PVBy/JcFJfccPoH2IO/JMLJ
         hrHPfeXXx/ToKuaiF1JXaZy7Z6C3SPClk05/0wUEdUjiYpCBNr0uncq6uB23DnOWnRd4
         SuQWJxip/X+t6ww3hxK3+xxGrEy7Noz3xpziD87aaf6Pz0o/EdHvCXjVj5sKMb8z5JHu
         ewPqsxk7zcr6nXvhLFi64Tm2cCmdChNGd7/nXllbI4QaNvDtyXyM0B+UTtruA3hfHBRu
         mYxy4yj22/voTJ+90cXvCG9/yFyztBQo6j65i0+G8aJJIvDiV9ck5nkQm74oIxkVMiYk
         qBzA==
X-Forwarded-Encrypted: i=1; AJvYcCUvMkhZXDLW9D/Dl1mEnYhs5DJkrs7obHQDZG/hn8MWPmyq7FVKxofDkyKClZTbIMGWw7UY5pPZAzbRqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJlCD66uLOuCI/b4lwxEBpO4bBrK9URzM70iQORz2uwebAkSge
	rlVJp1/TbzRhpMCLgSpp8hogdYae50nsmVZSsUyhZrEa1FBBwWMCE44kBm7zfRLMNJ4=
X-Gm-Gg: ASbGncttS8GrOZ5ylQTo6tqgbThEi4jMfMoxtduDi/bRsESYxNCTyyGBZJ2mUhn7FlQ
	CLMbdmRLpRC6cjB0QFxT62jXrr7jp5EjcdNqpFM5xpERWuME25v719DqDoKZAguthNy/4mg52nq
	X6YquKYynN6vlqDwshCrb3cM+MCNts0SNjZu/ohNlM/dNh+/9313puftFsL6ZlXJ0ZBQD7ihX2f
	krr6xsFhh5TtZ+yRbud8iz79vlw1Iv7B/EWY8+tW1iFpGzS4GCWz4K8LeWL/QapLQRYwmI0vc6K
	+k+KFj0QRT8xs0HKbV5LGwzoxXY7bRXKtLCFGJhHU1cuRCTFDyt/gBTGlrHqP9thSLDEIvLJWfQ
	atCQWL6N+mD5VsMAzXvC9HIt3ksLo8vY3AIh93Kp9f780gFkfrGZa+yxQFqVb7L69RGESsIeYGE
	AciUSZx8R2miq2wLxN
X-Google-Smtp-Source: AGHT+IGIWZ+lmA7GDak4870XTiv3Yj8BU4Bmg1GQHYPOkEGe2jc+lTeJlZIP+IYjxTa6CteNWBl2Dw==
X-Received: by 2002:a05:600c:548a:b0:471:ff3:7514 with SMTP id 5b1f17b1804b1-47117877736mr281675505e9.12.1761552942082;
        Mon, 27 Oct 2025 01:15:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475dd4a36easm122063665e9.10.2025.10.27.01.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:15:41 -0700 (PDT)
Date: Mon, 27 Oct 2025 11:15:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
Cc: sudip.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode0 an array of const
 pointers
Message-ID: <aP8qKZkEA0FUkaYC@stanley.mountain>
References: <20251026233432.1707-1-cristiandelgobbo87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026233432.1707-1-cristiandelgobbo87@gmail.com>

On Mon, Oct 27, 2025 at 12:34:32AM +0100, Cristian Del Gobbo wrote:
> Change g_fbmode0 from 'static const char *' to 'static const char * const'
> so that both the array and its elements are const. This addresses a
> checkpatch warning and matches intended usage.
> 
> No functional change intended.
> 
> Signed-off-by: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 3659af7e519d..ceb89ee99ce0 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -33,7 +33,7 @@
>  static int g_hwcursor = 1;
>  static int g_noaccel;
>  static int g_nomtrr;
> -static const char *g_fbmode[] = {NULL, NULL};
> +static const char * const g_fbmode[] = {NULL, NULL};

This breaks the build.  Please, at least try compiling your patches.

regards,
dan carpenter


