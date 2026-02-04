Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B523B95F8
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198931; cv=none; b=bPxFNd03w9YaQUPvD0VjmmsDHESl+O7+75+9KPa/YWe2wD9y2Ow8oZ1BZiLRlb1KZoYRvybttea8QcF2E7acI+GizWY8utevnwl4G6X6sWLebu8TGOmVOBw/YUaGN1UBbjwW3YaSvf/24MMlMkyTHWVp5BTB+XZHva6qgHBilJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198931; c=relaxed/simple;
	bh=fDc9+RnTuNqnqK2DLJw2MgkTQPt1U2igsoiMD6lUu2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFmb6SUZ8aMel4zwm5kwDjmg1U8Sctn6duwrG+0G41jWhuOyhQfhMgnpclaM+MjxhEAUCHnkttAfbzHptXvLm2rxDABPMKvi/7QTMSFzmQdkWrT9dwNa/NzlU0f3ZP+KkoRwDvWPCo4VXoGm8wQo9nnh8OO1p5+5/TqtcuAHC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=glgbkgof; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glgbkgof"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-482f2599980so38388605e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 01:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770198930; x=1770803730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XzUjtBBrjfJBhBDao8Y/buom6ruqtjiudppkV5j4hu4=;
        b=glgbkgofbI7qInVxzI2G4p6D7xwoBdKDZ5TjFI4Y9e2wf7+Quwknk0amcexyLDaTRo
         JlczXuLGX3BBEdINyNNkum6VRz4TklTxWUStm0Ta7xPFGUXg1Y7x44lFZPS3+P/yuuuV
         8RMZeGrPw6bRFmcwXRC5KgKAkEbJpUWbCDmqq5TEb1GtsAuYb//K725imvxU5axrulDx
         KVXdrgmSDFwugeqq0m68bf4VIHIzkQzqZsvw06XL3bVFWAZWODVtxUwpcFdlCYppokWs
         gOAcr6GhhB9YlGh4rRrBD9RsVbWRopj69R/BuZmDZbMLz7VwHaIAz9shl7ukgm+2C7Dm
         KJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770198930; x=1770803730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzUjtBBrjfJBhBDao8Y/buom6ruqtjiudppkV5j4hu4=;
        b=QHiwVfyKhXa/DZnkxwHm+BFZ2zR9EKvjM8JinZKVng+q3NZ6zubRpQj7mv1vI43k3j
         f7a8MwSxJEjfSn70mNMrXoVxpxTVoyb8ruEWa1LTCGevoNi6gkotC3XSAssuFWihQuVD
         oi4SjffEx0L0o8jAyHc6DnonOPwSZOG2yq97NTZS/uLi8NfZxAGPCk9LG+QQ0IMrEEtb
         7GVaWzABx/knAaBK3c7VMChDJ+SNYJ2rh9tK25/tLgK3shj0aLzUnLIg1UuWhIO9zk4x
         GaDqPP094RDa20+oeXJnruj6qZIi61UNPNF359s+Cr7NqqNfrIXE6ZxSt9NB/pUPe2g6
         g/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhaIn5rEMAQMQQSSEi7oY5VRKqFuidFsn9DLHlK347X1kQNc6lzzIMKN5icJZBv+LGZ0VeUBXPNEWJ3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQ30F2hf4eLvqvHy0QpogMr096Eb+guLZhuS7zITdytykB2lv
	ZnWUF8fMFRdCOFPwH/gekOwbRG6z0VRwpe1QcqH1VyffIl4/Yv5Dcpz9N+aj4PAdjYA=
X-Gm-Gg: AZuq6aLBqOdlogh8oCnEyQ0ahTLBEeAiZ+ozQUSXXZWJ+aez73Zs2aorOaYwz+B8V3Z
	j/6h+1Zb0L/txkTCcNFNy0c15OGq+iiwhBj0c/ZIIqqHF9kkbseFMq6LNjw8I6Qa+L5WYTw7Rwn
	tVfoxoVbLhhF8NnZzgUXMJKJwPigMpIgXESmtW015NBxb/s0BoVJ8A1JGSMrtWgxKruJlIhv95V
	MFxwQt9ssWp5/YZ9+JMfiwu1i3t1tSPTnSJ6Bf3Bg9kqd2ALpHuu3588P9tb3CcWsPvouTjtUtP
	6Zj7z1wTsa4zprc5iNaIPDd2UPQgw/XOxYoX8VkeDTidSpZ4VVWye4Bdau3cZtP4iHC+NdguiIJ
	RMQt+tEHErOnZuCAqyCqaSLyX+jCjx+SsYS/9z8Ou7SAzofcLaYAmP+DkoWww3qu/RTZd27R12H
	HK6rfkXfbn3aXoIH/A
X-Received: by 2002:a05:600c:358d:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-4830e93ec05mr37014135e9.6.1770198929624;
        Wed, 04 Feb 2026 01:55:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e3a486sm5477520f8f.16.2026.02.04.01.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:55:29 -0800 (PST)
Date: Wed, 4 Feb 2026 12:55:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] staging: sm750fb: convert pr_* to dev_* logging in
 sm750_hw.c
Message-ID: <aYMXjuXKIPHVADeD@stanley.mountain>
References: <20260203230758.3056-1-iprintercanon@gmail.com>
 <20260203230758.3056-4-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203230758.3056-4-iprintercanon@gmail.com>

On Tue, Feb 03, 2026 at 11:07:58PM +0000, Artem Lytkin wrote:
> Convert pr_info/pr_err calls to dev_info/dev_err in hw_sm750_map()
> and hw_sm750_inithw() where struct pci_dev *pdev is available as
> a function parameter. Functions without direct device pointer access
> are left unchanged to avoid unnecessary signature changes.
> 
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_hw.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
> index ce46f240c..60f9f7135 100644
> --- a/drivers/staging/sm750fb/sm750_hw.c
> +++ b/drivers/staging/sm750fb/sm750_hw.c
> @@ -34,7 +34,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
>  	sm750_dev->vidreg_start = pci_resource_start(pdev, 1);
>  	sm750_dev->vidreg_size = SZ_2M;
>  
> -	pr_info("mmio phyAddr = %lx\n", sm750_dev->vidreg_start);
> +	dev_info(&pdev->dev, "mmio phyAddr = %lx\n", sm750_dev->vidreg_start);
>  

Same.

regards,
dan carpenter

