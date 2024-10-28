Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641E192B98
	for <linux-fbdev@vger.kernel.org>; Mon, 28 Oct 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112083; cv=none; b=PTcuG+0x00PTznmN3oOCVU0a5hqzKbSuX/ajSxnEDCIfQk+MGSTVbchLFmVeK2FKysGOy9l8c2MKsTaWoMpBBr5Ot5j6+cu9BW2GYXV90I4sni1hBmxkRMHnO1DHj7BGhEDtWwbmWnFU4mhhGNo6kGECE0Rpq3eVlQBICauNe9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112083; c=relaxed/simple;
	bh=5irGXhn86718cGnvmYCDIyA5mECyWc/a19n4ceUOvLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYS+eONajIHk9W+NTnMjCrjoWbnRaMeiYUb5maePkYmQyTs5HZQ2oawLW1Zp13eHuyY2kHOsPpWGJbqQ0iSpODeg6TGUCOBtg3tDI4kf5kieGPTd9f43jGbDl4LTkDVlzsQYeSAcfzUMdBp2BFr5mxZl92L2DZtPnwEMKvFeMfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=knc9Ntgt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="knc9Ntgt"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e8607c2aso4173967e87.3
        for <linux-fbdev@vger.kernel.org>; Mon, 28 Oct 2024 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730112079; x=1730716879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZIT+7wViTRtCbCkEjqqUgZ88WoHF9Xu9mW2Hw20sWw=;
        b=knc9Ntgt8/KPHEWWvruer0CJdjAw2TODYzk5nERzrfHWSeyfIdnDC0AMIGq0DFyB/a
         rmeX0aH5yi4z5rZ7ZmnU1Zn8mjZIITL0cA0xCIWlIEK857rNm7qBhLhXgEHukKbJMR6g
         0yxCxobTUcB0vSaPKeFqV/LOdDhGfehmVGDSz/FsHc4qp9uqbqNUkWskj3i5bLGScZbm
         nBRfl4q55HEjHQIcX2nG/XoF3C8u3jBrxOnemVDfbBMdsw4eJZdnktbwJ98LvINbFVzu
         s02l8OU5BArXo3awLgg16XQmYjHCqZmBJ2qbAJt1x6sotv04svpDmzYYqXu9Up4kf4A/
         ElgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730112079; x=1730716879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZIT+7wViTRtCbCkEjqqUgZ88WoHF9Xu9mW2Hw20sWw=;
        b=AOK2V7HuzfXad3/loZ6mnbaMRBHPbW7klj61prvay/dWWwxJ7IOgYAOF+gH3TZIvRg
         QmDWbosEyxSDhwsC7dnV8XiqSv+SnU602ZVWf1IQ9s+AUNZtFhmqiQaKKVEHmeqbo0t4
         wC6D7AG6aSocaLcFT8WJcMt7Nrigk9HCTBGMcpV45Rc+jdqTieAv7zCTTOUz2sIuj+zd
         OPo+5qloEdR71T0E+U7w9xHNav87QkajOyzHv0D6yevmzhoFeDYzZgacdYw2b5yJodqz
         PR+hf8o5gqAryrp32ImKbtjc41XJpWk1bH3K5b1FEc3WESUpmcwP37inEw9KdCJBhbYA
         nG1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWX5+3+/IzytFfTKqC54p9sPxvfJqBUvIaJ7LW7klk2gXeF1uWk3Jbu6M1vc6M24vIRovR3gZ2wyFefwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqzNxolozMMRZMZsUScHeMNOCCl6SBdGSucJbj8TF18shTE5Pi
	EzVxvME6gajPG7xASKN+WzgiokZ1edweOvhFUowy2vvLLXmmjNoqRa0IunovjGA=
X-Google-Smtp-Source: AGHT+IGacIyVLhHZd9j9VvJGOkzqOCuHA5kIm5Z7ZY+EO2eWEKnqJWz0dHf8Wy0AOggaYTiUjU1Fkw==
X-Received: by 2002:a05:6512:a8e:b0:53b:1625:bcf8 with SMTP id 2adb3069b0e04-53b348dac0cmr2859403e87.30.1730112078871;
        Mon, 28 Oct 2024 03:41:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1b0526sm1027418e87.180.2024.10.28.03.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:41:18 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:41:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video: sh7760fb: Fix a possible memory leak in
 sh7760fb_alloc_mem()
Message-ID: <ehzle6x534lfgxbcfisgpy3mmvggqlbh4zbrx2kl5sb2c3hnmn@biaxdd5cjcb4>
References: <20241026035634.467-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026035634.467-1-thunder.leizhen@huawei.com>

On Sat, Oct 26, 2024 at 11:56:34AM +0800, Zhen Lei wrote:
> When information such as info->screen_base is not ready, calling
> sh7760fb_free_mem() does not release memory correctly. Call
> dma_free_coherent() instead.
> 
> Fixes: 4a25e41831ee ("video: sh7760fb: SH7760/SH7763 LCDC framebuffer driver")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/video/fbdev/sh7760fb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
