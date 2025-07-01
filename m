Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC972AE97
	for <linux-fbdev@vger.kernel.org>; Tue,  1 Jul 2025 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379185; cv=none; b=JZ+AXarH6WU2WAA754cWXBf6AQEpkrlisugC2qv+t53VGtn69/B4lDhRVItisMoQmtyGoB0mMELsWwivKt7u4eALEwFcwII4Sg5SHcbJ60FB34bC9SvXTJACB13sO+5tNX7jXGaFw+yRDbh9a4S8iJhYrH63BxYlHYRdp2ZlXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379185; c=relaxed/simple;
	bh=cKrEiugH0xvIcKtzSeFU/00qwTU7Zi40z85pYKEb35g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHcMSJzznvAwKm6PCP/wfd4r0i74c9pCq1jpXOq7Ic1m1tVnakPR4Q9Lht/rZ5IAfOn1T6/BW+9xkOvxk5aAusd5qR2clCEEI59hbT/mUkXcUT7KUQjMg7uvk2MQaTkr9OUcqJTZ7NjpOrbZviL+ffhU+07tJFNYj7oIxmNuYf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HIk+z3yM; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HIk+z3yM"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso2463144fac.2
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Jul 2025 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751379183; x=1751983983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DgIRXBrUhqUfMA4ZY1lMetlJzjnZyUiR+RgRBjwesGE=;
        b=HIk+z3yM8yuaaYSQpLUqXjPELAyly4P3XZBjLUJsx688dzZX/ywIzulWOvE79493VK
         9VFx5WtaggDMoR0+Qed0Vx5cvq4YFHxN29PE4SoQq8C5h2Pi41BnpJcZ3suISftofxxD
         OJzoavpageZ6mDvN+S5vr2VBjl9oKxKrxCyHWBw1eogEcSeW1Sdt9nskUwUj/37oYo9M
         rSPkhpKcn5DO/M/uZ0pe0VSBZkS0AbbmhbFWgKSxYiduUi5J7JK318g0CRVOkZVfDm0L
         DwhlV0K2LNWY4JRiIvz4mElyjgQ8q114TdQlB+EzS38djihbKDCVTvNIG9QTf9I04QOR
         A1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379183; x=1751983983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgIRXBrUhqUfMA4ZY1lMetlJzjnZyUiR+RgRBjwesGE=;
        b=u+GpPyOjqtQszusaKVP+Sj8utAKKJYpDrRaP5B5KGb1qkEb4jQEO6jAzS61x/zmeEU
         zx/TqrYJi34tgyhYPJ/BIWHkgj2iA1hGe3Mc4E5VQz8dADWgJFfk0cuUFvBxMty3e7e8
         8yyYCWEARvxvAnik/MqN6DMPD1WKST0PXNDLLpCiPM0nFwCU+eIFVkyes/hB5NKadsW4
         CONbUmg9BEBeqGnh9sseGtaTRCRVdAz7DuG8Daj9ohWLuEy54BUZNc2qEdtvj6uJ9SHJ
         ZmNUta9vARw4z7melEbcnJF4M3QyoczAItNm7z2mbg7VWII56y2DJszFXtpvQKHuD2Mu
         +Ryg==
X-Forwarded-Encrypted: i=1; AJvYcCUWwUNv3ploOuAq3pCL3CzwFE04F3W/1TpclRPfUx6CQRKisKeUmhOLvhB1izRzkCWProq/ByBH22tKlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzucWJpqCobccwlP6fLpnQHXwXlNLHuur6SoXPWYCgxMSUQpEJB
	3UcOkbiWKdy6CHO44Dba9H5NwbaudszF0rAFOd6/6g/Jry19Rg3Urmt1FdwF8yKw3Ak=
X-Gm-Gg: ASbGncu72nvoKTdBM9DNsMTqew7TknXdOfZViUUA3gr8LiJuum4RFEFCiJ5cnT0X582
	+ta4k8ZNEBRiEF2QL/44WuLN7F+25gpV+d9/gyh3w3q+RY8DxGpBT1AFztGoO7mRJAv42OZHpjC
	+EFR/wfQuan30bsgBMSCSEXbSxQxTWEHjRdh4B87NX04v8OpChuyooEOn9fe+Jak3V78bxPDHpj
	9JsiGsaWbACn8UU8EqBx0nultjmD4bgQqPT2fyntI3F4elFSLhcJsIYB+lPlm+PIJWGILT+Ye67
	XhMpSFjFg5TwRLNYKZEy9oPgj6j2wO/Rdwgq7UYjWuzy939PSEzf4hKjDhlph4FYwI9Xfw==
X-Google-Smtp-Source: AGHT+IF8222q5H+Su9S8AoNHUZyIRZzavZDR6dz1AwLsejbGTN9lIlZ82z0uy9mz2H1nkV0KHwWknw==
X-Received: by 2002:a05:6870:a99b:b0:2e4:4617:f6e1 with SMTP id 586e51a60fabf-2efed451a35mr13168004fac.2.1751379183127;
        Tue, 01 Jul 2025 07:13:03 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:8ebc:82eb:65f7:565e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50b1ffdsm3274257fac.26.2025.07.01.07.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:13:01 -0700 (PDT)
Date: Tue, 1 Jul 2025 17:13:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, lorenzo.stoakes@oracle.com,
	tzimmermann@suse.de, riyandhiman14@gmail.com, willy@infradead.org,
	notro@tronnes.org, thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Revert "staging: fbtft: fix potential memory leak
 in fbtft_framebuffer_alloc()"
Message-ID: <2e1d692c-5f16-4042-9ae9-423e3991834e@suswa.mountain>
References: <cover.1751361715.git.abdun.nihaal@gmail.com>
 <a689f32d6c56d6c5c6ba8e2faa0305b5e92d9897.1751361715.git.abdun.nihaal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a689f32d6c56d6c5c6ba8e2faa0305b5e92d9897.1751361715.git.abdun.nihaal@gmail.com>

On Tue, Jul 01, 2025 at 03:10:22PM +0530, Abdun Nihaal wrote:
> This reverts commit eb2cb7dab60f ("staging: fbtft: fix potential memory
> leak in fbtft_framebuffer_alloc()").
> 
> An updated patch has been added as commit 505bffe21233 ("staging:
> fbtft: fix potential memory leak in fbtft_framebuffer_alloc()"),
> and so reverting the old patch.
> 
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> ---

This is the wrong approach.  The original patch was fine.  Just
write the next patches on top of that.

regards,
dan carpenter

