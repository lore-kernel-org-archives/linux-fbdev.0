Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4CB1F4C83
	for <linux-fbdev@vger.kernel.org>; Fri, 28 Feb 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764408; cv=none; b=pEQLuOjFpFl49TIxeiKFL2SdcrJxNC9iiTxrQwIMihL8OijX91c7ElhcqenE3UFpY/Wi5LRSwAHi+V6RGLkfx8WVOdBvFWV8QXYY6Cr/ld90k/LP/Q8vlAZddNmqm9d2j/ODYQluHNekcQOlJgIm0HpXKMnh4l4FPFeZUVrNefk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764408; c=relaxed/simple;
	bh=nhR/P/6U5t/QZbBIPrPO7uVnSy5xVoKPhPv0X5+5HOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUPpIHtl4e1/0MWhbDoJQnPtHrI4ZtHB7eSQPxUv328s4Xm40CEfVzPshxlLBw8hfyFjw4cZHCXyMOvhzdYBH7Cymkj6xMal++8gj0AdC9XQC/041Axb2siIBCbDT8huXRKw39IbYKP8QZomwzbUjbTJKAdFpP2t3gnsz5z1Nz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hnHJQX6s; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnHJQX6s"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab78e6edb99so323410666b.2
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Feb 2025 09:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740764405; x=1741369205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=riQXDN9QZs6LxV8yAa+6lbOT9fE5uen2D3eotym0+Xk=;
        b=hnHJQX6sKwS1OP7pPdj4gNeTa7A6yZ5rwZ3mzfBqffAi7HTH7hDTozBSK+GYD6LgY0
         cTNOWAKS5cWueAKE9Wp5Vx3Pz19C5/ZCtOHsHV4Dbp87uK5pgH+9YjC/ejwzHte4IefW
         0Y0kK0CaFx8WOw0LI3d/WEXmwNoR4yG9j9GgZX8S9VdK0puUlP4wZMoNEDN5qhEU1e7P
         Oak99K053ONZEM3JCJMS4XkE0pVaI9N5z0OA/qFKJGTP0Qa899jQcKNNP+hJn3N1fFGI
         S18BQNejkEbMjSr5WMe70K7DfSk2bN/rbJPHiOIlWxfDbEwyfAl8pkQpzBifaMNNKyhc
         oJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740764405; x=1741369205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riQXDN9QZs6LxV8yAa+6lbOT9fE5uen2D3eotym0+Xk=;
        b=da3jwaH2A2tI+gPgylKVg+aBx8Wi1ns+iZawjHYUXsTf/F07qgwh8H7CrTTDi5Rj6m
         hgAea39me3ueG64qIsxwsp1SQ0mAKvwmpZypMu8YQr/C2fRsOiXxvlqW7E3PkzYTQl1H
         ftUCbni8e/CyTAK5pE81kr84CCZRKGuO+/6xEMtXZZN8AZyQG3XeX1lq6hjmT2tbv8NT
         QkVgqA8XGlWAkH1or5Qd2vFoHv9B/W+tbqte+w+ryH/4fdOcVAvUXneYUppb+DyVfUYv
         taUBQmJtq38QNZHkVRzxWfw6csd/74qBw6cVZs1Axioo47Ore6pBaBbvKYQwUJ0uEsWc
         jqOg==
X-Gm-Message-State: AOJu0Yxi2V4SpEu0DQAq8W/Eo72rVVstn4VbqQS6fDwzniAhANo5wWNH
	EkDQC/9xavoTIOesK98OTCiET8REKk7WZ1K41yzCg/3KHBAv0GqzuC6q0tfAZqw=
X-Gm-Gg: ASbGnctz+XEPtXfe4FqXnI3KcqPQLqS76FBzNbJEnMpAE3ZUBPdEtMr8MdH4SdAfDm/
	SMD2UUZWb9KK+04aFB33uPWCsOX1S8PAs8j7lvpricpw+sJMn7nr7p/FYFf89DczVMZpVf7pecX
	VNYK44retTOLJI7YSJo+Bxt/ijBZJlTS1LW/AGU+QgsxLtyirCdOSDnDrVemOZdQaLCmpTk+H9d
	92N/8ajED5hgAqFmTVw8dZ7OALra6rddhXnUzWQS2TY1gbnH2lfPH5xlI4swu3NzCyR/ZmuyNEK
	sCGpUZ+nD4eknvx7JRKNqbm8fa3btFg=
X-Google-Smtp-Source: AGHT+IH9J6JKqMSthgE9WEHmeCIetbaaQ9ZpNXV3XeAC+1XH1Fo46T2ivFKqFX77iByopRqjkr30Kg==
X-Received: by 2002:a17:907:3e0b:b0:aa6:832b:8d76 with SMTP id a640c23a62f3a-abf25d95298mr449951666b.12.1740764404831;
        Fri, 28 Feb 2025 09:40:04 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c6ee4b3sm316011766b.112.2025.02.28.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:40:04 -0800 (PST)
Date: Fri, 28 Feb 2025 20:40:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: sm750fb: Fix CamelCase variable naming
Message-ID: <ba45d980-c6b1-482a-8bfd-457a92d3e24b@stanley.mountain>
References: <20250228162359.14029-1-lima.gabriel.luz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228162359.14029-1-lima.gabriel.luz@gmail.com>

On Fri, Feb 28, 2025 at 01:23:54PM -0300, Gabriel Lima Luz wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> CHECK: Avoid CamelCase
> 
> Signed-off-by: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_power.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
> index 63c9e8b6ffb3..33e852fe6949 100644
> --- a/drivers/staging/sm750fb/ddk750_power.h
> +++ b/drivers/staging/sm750fb/ddk750_power.h
> @@ -3,10 +3,10 @@
>  #define DDK750_POWER_H__
>  
>  enum dpms {
> -	crtDPMS_ON = 0x0,
> -	crtDPMS_STANDBY = 0x1,
> -	crtDPMS_SUSPEND = 0x2,
> -	crtDPMS_OFF = 0x3,
> +	crt_DPMS_ON = 0x0,
> +	crt_DPMS_STANDBY = 0x1,
> +	crt_DPMS_SUSPEND = 0x2,
> +	crt_DPMS_OFF = 0x3,
>  };
>  

It seems these are not used.  Just delete them.

regards,
dan carpenter

