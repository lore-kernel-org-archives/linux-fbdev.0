Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197F13C3E7
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185667; cv=none; b=ESLuqGNtWPUK5Gyk/C0QpDnhld468iwoGECInlKV/6O2+9EtmcGhRzbSEiB6Z/pZLTXEOalN06py49erGXScIZlzjYtAtF7PfrnY+KlsP9UxWxHDozM9xn7eGT2M+f4P8myWL4q5QtJeiCwOvrM+HNzcXkx8yF75S4oYY+zvOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185667; c=relaxed/simple;
	bh=6hy9MHFehUy/zuX4NYpy8UxQhRHJAuB0rX2A35+Fa/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3Cmyz5Nqe2rbdP6TNx+CVemwgYPa2Kc+WSCPrW5Ip7AC6p1+o8O850Laj+NNw6O5jElnBnqQ0/jwhY6hgBD6+hFdWDY+ENlSHDrjpmLiHgUbhsCiFj+4WKWjFg27BvT95iyl4sV7FdPB8LnlDsuzMN5srVFVZtYp1/9fj+G3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rlAA7S3N; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rlAA7S3N"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d6c1e238so3755316e87.2
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 05:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185664; x=1713790464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6hy9MHFehUy/zuX4NYpy8UxQhRHJAuB0rX2A35+Fa/0=;
        b=rlAA7S3N3Vgt/FjbnrDGQI0IeUDXdQYkzdF405wlU3tAIj54eneHEXybGcCxRdCd/0
         PO7101V2peiftQ72u0hX0t0SDBYoRh++JFuGSApL3qd4AHxe+5VUx8tHphtWis/s5+Me
         KVYPXEAiIee8ZVV/IleXpCOrh5yOOzyWqDXGBNNHhOdUeBJ9zgx0OhbGD87pLLd4hVW2
         wNtVr+eXSBwYxf5VeTJMxreANDr+1DBgg69VebxyjrWZn5n3HpmmOKmgCdd7S6VPw0Wp
         u3SwcM1su1ldiwQ2mzpUsTZxFDAQ9SfuTK+sG9z8xKMl93Slmm4eBt2nCrPrRePhVNjs
         Fgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185664; x=1713790464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hy9MHFehUy/zuX4NYpy8UxQhRHJAuB0rX2A35+Fa/0=;
        b=o7/+ulGEeNmO9gCJ5Ldb872tBZIUqPjEfq8Tt7FDugsozmhgDnT4NewCzKZ/u8i99g
         bx7YN7AP6gNFye1H3x4ajEiSZlUFEhXwhXGM4G63SmqxEMkKWC3McaDYqvhOVpReo6Ee
         cDhieBdXTr1ahSEskgtWtAtQI0YvbOX2+pfWqeAGHiX1k8sM4vw1qS7gCp+D1vUjKsMN
         ksMs6UeRPZa9nsvVi0kDyRlgAfIIedUVgX6h3KoA40SPUECNX4hwrte8VPcC1Hnughrf
         snD2HlFu4YaZQk3YygOYsp/ILG8OIQrRtz3kB+ksWm/S2D9Mf2mXAsrJF84cQEhiAqM1
         20/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIclG6F/kNSO/8tqlP0Kz0DGNRFhs5RAQ7XVHHfaeCkDKKyUMDS0j5eAovaM0HkKBbi+jcXdAmc3RJPlEu3heHDAe/5MUzZFV/KeU=
X-Gm-Message-State: AOJu0Yzr6Qb1TI+S3E8a7lW7fKpoc4+/SBOgQGYqVTH0TBMJJ4xh+leW
	hCetQRKDCjkxAC3rjhH+gQMFmTRGJkFsJHWEv0BQuemqlIGz+q2qP4iQaJMICjQ=
X-Google-Smtp-Source: AGHT+IHWAIlGaPkDWCdPgAXfWq/+MLUcSYotiH9LGBzmKnQ4SFxdrNrzwncOrZpKE9P8st08sqCGFg==
X-Received: by 2002:a2e:7a16:0:b0:2d2:4637:63f with SMTP id v22-20020a2e7a16000000b002d24637063fmr5787093ljc.45.1713185663909;
        Mon, 15 Apr 2024 05:54:23 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b004181ed7c033sm9730638wmq.24.2024.04.15.05.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:54:23 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:54:21 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexander Shiyan <shc_work@mail.ru>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 10/18] backlight: lms501kf03: Constify lcd_ops
Message-ID: <20240415125421.GJ222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-10-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-10-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:36:08PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' is not modified by core backlight code, so it can be
> made const for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
