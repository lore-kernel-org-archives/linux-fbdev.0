Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADBD4D8A1;
	Wed, 21 Aug 2024 01:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724203987; cv=none; b=eTkduTvGlA4jnpweGJBDUrWiJoE8qrwCMnc2FaWMo1gYzcBv7n9ddE2YIgjbImGIIgR3c+YFhftzLr6te60d+Ixn81fBTd8PAZ16P18yy+4z1XzY5WJA0cJVZjEpflOTl1VNeA4jX1hmgi7bLCLo1+DdQbKlgMwM7U+55yhwtHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724203987; c=relaxed/simple;
	bh=KLi0TnpDkBTzJ09B1HMXgbn4QuzoAiWgsTpWahuX7iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAoeKKZ3s0A4toaHHlXasv5T4LdRcG+KubafBXROBd+dchmssStkzA74j2tEOoEPSTS8/CXeRqkuypCHkgclJtuo92I5etPFWaVO0RDMF+huiEJsKozpCvLwXT9HdyahtcvYcxVE04ps4vHJXC5k6FHv+a7kLxhVfSf9ziCh9fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgC8ygV1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgC8ygV1"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-710ece280b6so4682675b3a.2;
        Tue, 20 Aug 2024 18:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724203985; x=1724808785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ftd1IDF8uP3S8XVIxFMU0f4TBPiPOQnJZcwvztab0TI=;
        b=VgC8ygV1wUPJ1SdtKaivkvPRaIbFaKeU71pmEiNAfsw3IvBJnQdMAiyYoEJCotRhAA
         bDtGictx64AwxDBcrI/1VlkfE/hgEMOnniG/nC3wiGGIDAQ9qNz0ujVHbHSJecuvKth4
         7ktcHV5UOxW9HMq0r3rpC4hPAKX31NTYGWibDOJJwHT4DeMYopyfNBXCQl35IC2i+uFu
         KDGENGYqy5s1NXzfI0FWM73L1A8VRZaQpBRGMDDkhe1esiADZpbFkw0EiNkwruDM9AGz
         mMFVWafteLgwH/4/K3f1n4exVceOCycYAue7r71WC5gwLrig/r50lQcEfDVGBj6IdwR1
         KppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724203985; x=1724808785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ftd1IDF8uP3S8XVIxFMU0f4TBPiPOQnJZcwvztab0TI=;
        b=WBqKggJjR2+7MLe8n1Vd7HFplTTTVTf3cwdhnLr+2P1JukMkzespAKKXTyzF4cpNyg
         Q3/q95R2zvP3U2Q8w4K+a6zXoo/C8vn78EloHZtc/k/YCrvKFke+ltsC9yM97Y00kXKZ
         BBhLLcNi7nKLf4CPE0lL5DRyWeplcvhGfWFFbisykp5hCAJ6A4dxiY0KOuye/2jpO52z
         lTHevTm88/I4xZRiaYeAMLDJVMFPh+nVF1e1QHyxFZqENeJStukdAqL+jepkYS9mBDhs
         sWz+dBHOSMlN+J8dqocZr3o4DYB4Q6nvQELezZyiqGG/FwfOXdT92sE8iXyR0nO9wCo8
         YE5g==
X-Forwarded-Encrypted: i=1; AJvYcCU2yPJjDnlmBVPGf43AbJKb70TL+FUPZw9oEIdt+XYMkFmFb8e6aBzxjPe5xHTTbdAQOsVvuMRJxqGmOdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTC76mtxGGvyq6xE2D5uEYYiOiKikoNSCME5hk1Kr88dA3Zvn6
	lY6ry9Yq1KOLPdWnrw1Ht/dIwxAQpFrA5rKqUXlXCCz8RF6QGw13
X-Google-Smtp-Source: AGHT+IGgq8Bs1TaJCeHCZ10a7+TD9emDRmGLEWIF2iln3CIQrIJw0tE0RlKdDODRSGOnPKl4rDw6HA==
X-Received: by 2002:a05:6a00:10c1:b0:713:e70e:f7ea with SMTP id d2e1a72fcca58-71423484c49mr982638b3a.7.1724203985277;
        Tue, 20 Aug 2024 18:33:05 -0700 (PDT)
Received: from localhost.localdomain ([117.189.239.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af18621sm8844478b3a.153.2024.08.20.18.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 18:33:04 -0700 (PDT)
Date: Wed, 21 Aug 2024 09:32:57 +0800
From: Jianhua Lu <lujianhua000@gmail.com>
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, lee@kernel.org,
	daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Subject: Re: [PATCH -next] backlight: ktz8866: fix module autoloading
Message-ID: <ZsVDyadlVGR2NrHA@localhost.localdomain>
References: <20240820121628.42321-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820121628.42321-1-liaochen4@huawei.com>

On Tue, Aug 20, 2024 at 12:16:28PM +0000, Liao Chen wrote:
> diff --git a/drivers/video/backlight/ktz8866.c b/drivers/video/backlight/ktz8866.c
> index 2e508741c0af..351c2b4d63ed 100644
> --- a/drivers/video/backlight/ktz8866.c
> +++ b/drivers/video/backlight/ktz8866.c
> @@ -190,6 +190,7 @@ static const struct of_device_id ktz8866_match_table[] = {
>  	},
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, ktz8866_match_table);
>  
>  static struct i2c_driver ktz8866_driver = {
>  	.driver = {
> -- 
> 2.34.1
> 

Reviewed-by: Jianhua Lu <lujianhua000@gmail.com>
