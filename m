Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB8B12BF18
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Feb 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999211; cv=none; b=qyJ4wtYsfsrcBjGFsGlm6ZRtxxXeYtmjQl9MdcQ34ibKr5/rslx34rP/l09N448gZGVWjGtapRiOHh0/CMoQKqyIkCmpr7IaGvHTRFD2hwYlaaukM3JGiCVT504ZKXtuDnv8rUDP+K3YEuC9p5wVey6PyO0UlE7FwPMbb7Seu2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999211; c=relaxed/simple;
	bh=ztKOJXZUQlmom6xQKGWtUiTuW3B1WQBrh5Kjye/DMFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0Ym2OPUzbPWrLRzcKp6EatF7D34Qs55thj9VAFaNM4PsDC3nB+118xwZYpkIYKI2+uEa978mw3NKWsQdf7Lks1jQJKRtLJUPIdt9JPoH3Uz04KMRFf/RK+GYdvHfliVlIqGGPcpFmgwbLQ0oAarJyDPvsgdrE1Z7tN7vJYj2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nEUn0ccd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nEUn0ccd"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33cf6266c76so483471f8f.1
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Feb 2024 04:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707999208; x=1708604008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ztKOJXZUQlmom6xQKGWtUiTuW3B1WQBrh5Kjye/DMFE=;
        b=nEUn0ccdqhB9A168PeeBvFIyn4yTU0Jzgaw8sq9Ps9/yNU7HPY7I0vq1N0M7phHVif
         Ooc6mJvwnR0ORt+LROrJt8MJNHK/bffEQTptI3GQIyMxTYpnB1UpJEgmPDqET5/T3VrM
         REDgR+tB3oN4Ha9pTZrV/J7m8xY+N1riD7sUfIvSToVS/ysyAVVA1DAj6SWSMtn+bBLC
         LYBZm4RFZh00nz9HCsY7nf6aMUNLJzMvAvnT9+/7AaZ6KtR/iK7w3vFC5EXNpQS9KvLl
         YXdo189Iw10t1aR+PF+5XANpDVaJk0TXBYtslSguBDSWhCOfK9QiQ+vHHLQRRgzKxmkr
         CsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707999208; x=1708604008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztKOJXZUQlmom6xQKGWtUiTuW3B1WQBrh5Kjye/DMFE=;
        b=dXCsL9Hck0jTMg5xjkCORYw1D7q0n7wF/C+4oqr3DmPBk1E6nJ8UXb0stsiFizQgQr
         7j9tAX/QT131j5w2wtXo/Lo//IBp0IjguGuBHNp2J3ZqVml7+rdW5G6R/Xc7rUoRMerW
         DEgEJDkSIhP6eqpjWmGgOVaWwtiyG2WnlcEoo7vPAk3Qu/TwmOpSPFmaa771qvDe3RGT
         WguitwK87BdzPOBcERGTBppuCs6zL4xTBDaWpbbNESUKyfYFqjTk8HF2ZG6xrzdLE9fe
         haAI6z3n5tRGqi9ZF7Px23mZ6eTZp2kWuRkoU3uYTgvEDC9vEHF9JSL0QPeSamv5xfst
         +uqA==
X-Forwarded-Encrypted: i=1; AJvYcCXF6Jy8bjtQYSnFOr0M1XY/oXUDI0Ptc431dzyS6X8YLsL/fp8GPbu/9jID0pq0o+rLLdE5S0LSIVeyK54yRfJRXgA+R2P0LLLpoTU=
X-Gm-Message-State: AOJu0Yz4tpLqbEyaTqTkyvX/5/5DOZebdVg4HJFufLCBqdEUmLk8rK6j
	OtUKhdjFOr1wCysFEmWjvz5dmOJHqIpv2m9vp9gehNsmf71KW9e6m5s4QCCLiXY=
X-Google-Smtp-Source: AGHT+IG3P5/6JWNhRAZMxDeU3U+UujVMo6057seoNpz5jKX5VhBBtJ3zIzJ42dclINgr2k0ttUEtXg==
X-Received: by 2002:adf:f489:0:b0:33b:49db:c719 with SMTP id l9-20020adff489000000b0033b49dbc719mr1501651wro.39.1707999208004;
        Thu, 15 Feb 2024 04:13:28 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id z3-20020a5d6543000000b0033b583ba5e0sm1591192wrv.92.2024.02.15.04.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:13:27 -0800 (PST)
Date: Thu, 15 Feb 2024 12:13:26 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de, javierm@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 00/10] backlight: Replace struct fb_info in interfaces
Message-ID: <20240215121326.GL9758@aspen.lan>
References: <20240212162645.5661-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212162645.5661-1-tzimmermann@suse.de>

On Mon, Feb 12, 2024 at 05:16:33PM +0100, Thomas Zimmermann wrote:
> Backlight drivers implement struct backlight_ops.check_fb, which
> uses struct fb_info in its interface. Replace the callback with one
> the does not use fb_info.
>
> In DRM, we have several drivers that implement backlight support. By
> including <linux/backlight.h> these drivers depend on <linux/fb.h>.
> At the same time, fbdev is deprecated for new drivers and likely to
> be replaced on many systems.
>
> This patchset is part of a larger effort to implement the backlight
> code without depending on fbdev.
>
> Patch 1 makes the backlight core match backlight and framebuffer
> devices via struct fb_info.bl_dev. Patches 2 to 9 then go through
> drivers and remove unnecessary implementations of check_fb. Finally,
> patch 10 replaces the check_fb hook with controls_device, which
> uses the framebuffer's Linux device instead of the framebuffer.

I won't reply individually but I also took a look at the patches for
the combo devices and it all looked good to me from a backlight
point of view.

However I don't want to drop Reviewed-by: on them since it risks those
bit being mistaken for an ack and merged ahead of the patch 1...


Daniel.
