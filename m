Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683153168E9
	for <linux-fbdev@vger.kernel.org>; Mon,  5 Jan 2026 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606908; cv=none; b=fO0ZTW9K8QN3Pc4r5R8Ag4iqYllNADCgXpAxvVC124RnATtForw0d4bauvi9+SAPzUayrlugDJUQwAUumr2fdcxQPf80ZOCZQqciW1/51nJPacdg7g7+RN//E5Rkr2b7eWpIz/yB+/z+s2WcYEZI9QUUJkGBw5jnLY6eqSgmJNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606908; c=relaxed/simple;
	bh=6HoC5B1ekt0sL7loIBZy8fGIO8xpT7YLxuo/MRO5H70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoSZ+fW2yaTVa2Y5yKNkr6+bo1LjcmkdK1RfVU3JVd2MiGwTf9OIwZVaBbKGI9HRZLMv09e+C+Z837m+CD3vNryYkcD+qu6FDWUIZiYa6ZrOx5W41DDH+9gp0amMwR0jz2UWlXldiwVnM9ikg5wroSWiYfh+Qy4yvWCf5m7jCUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=akG68zoo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="akG68zoo"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so109975825e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 05 Jan 2026 01:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767606903; x=1768211703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8EEV3Yajgow2Le02Xox/uVz7KgADcHkRJO8r3JoHZTc=;
        b=akG68zoozxjQ3b0JhmiR3iSEikMHAgtq4KK/Lc/49V0Zr0cF5q/S2NYqsCsBPSwo7O
         9iPiVTJQs6iI6eMzlEOvFlpvMD3XK6uYjpaSvBpq+eOTZ3UlDK/W2hzQkTQvksIDeA+L
         p4Wals4wzn1GfbLz/mU9gvBGvikPFfAvyl6pEeaxvns40WtJxkXYxoN3ACQy1VVm/MVn
         TzTYQygnhWGKHKLyvfqw0ACySBwqmx/Cs3Fr10/dSSdbX1m0YjCdWouqPEzF0W3Sb/Nl
         qBSR9V3jMUnAYM/I+ZvNK4Hx0igLZXTJYjtHJ+ad9dN2jd3/1rbjKGq0mUSoCC9g/+kA
         TM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767606903; x=1768211703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EEV3Yajgow2Le02Xox/uVz7KgADcHkRJO8r3JoHZTc=;
        b=wDugOHpho8iY/8vDYtLi3LqSEGwnSstqIO++rAuRlD60doYu9KFCEbxh1dm1NNSSv4
         FyZlSLCEeZSFLcyECM5FIP7IVZhPSBu+S05RPk1IG6f6O58pc4one+oV8MU4V2aElmXp
         r4wG20rPGEioIzUXGKglgXJQAgwmH4xbbRT2/d6HiIcmQlSiNsCO3Uu/JZYK36/Xrgb4
         D/y9Oui/+pN/yZaEl3HYHZR2s4elkOxexs7BSOFkBTF7uGB+fz2jj9wgIRHnlkXEQhGv
         UqLFOKpy/1frFAMO0zH4DmBmYfiJuhOQ5TopgcI2gJYx0nI+1pHAZbHpEjRTsjnqtofd
         SX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyvGcqO5NhoQXK6jVNyy17R8NsMK905X0jlB6bJDRC8Z5pkFDa+IJbSeHgsvLl2V38o8Eom0KaLE4tfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQA2RpbmgsQX9JjWiwiQ0aWXs71eW5sfqLukTT/z/uD1i2IdT
	yRBlZ2HFJvvVDDrGNQLPlvWvwuqLV/qFKij/CRaQ0U9X6geS+oGfGhSX5NAvFeQJwto=
X-Gm-Gg: AY/fxX6/Ctl/PSlmSj1jP/7cepWAeEfhd5zUTkJCUO9hM0dqm/237o+3etRsS3bJgDY
	e/hAuKH5k9gTxZv/xxL+mPqPCAlHoljzIbVfGBVMfMf8ESk1beKk+Hync1QUo1/EaImLZowTBSG
	rJTlbGpk6bBGIoGFn3MYvIg3iCc2jyMvN5ffNGvqs0gwIyhzn4nhbRTL6Q7AFvxXOOVjVvVpebP
	xjylTFHAACIK31z/VL2Smrf27Qh/sRHKtxIqUqiuhbY+8ttIsr8OQzoHWUNlYNfO1ffqNThXNtz
	tyuih+5vaYInW9zwElo+RLFs8NDeD0zImU4xmclEPF/PUuvma/2JfMF4X1MmBY2Ol2Jm92Dxig6
	hsh8XySqE1h4tv/ulc1mK+sooRgDug3CHYs2q/y+azB7HM/3k4nae+7M6zMGofwI/VJFikC/GCp
	vfbyu3DVmfU2fDSjIqpC7jPUwVWeoN5NKo/Iwr2ttSajulpWYtz04AU5cnrgsObWz220wB2ZjW6
	KhB/dgkcsh2/ctkhPLtBp9t1tRSkAq431KuM9H71Tquw4+SBqSqKPo14Z0c00VbtGmutDVY
X-Google-Smtp-Source: AGHT+IEDntn78ZAZ+9BLk0OP0TDSrFfpGHytu7a8eXwL+wuSz/sJ8bMiyLl9n++coQm1Y605Eud1ag==
X-Received: by 2002:a05:600c:4446:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47d1956f896mr636890455e9.16.1767606903267;
        Mon, 05 Jan 2026 01:55:03 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6be5e2eesm55247805e9.5.2026.01.05.01.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:55:02 -0800 (PST)
Date: Mon, 5 Jan 2026 09:55:00 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Sudarshan Shetty <tessolveupstream@gmail.com>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: backlight: gpio-backlight: allow
 multiple GPIOs
Message-ID: <aVuKdAyXfWLs-WJI@aspen.lan>
References: <20260105085120.230862-1-tessolveupstream@gmail.com>
 <20260105085120.230862-2-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105085120.230862-2-tessolveupstream@gmail.com>

On Mon, Jan 05, 2026 at 02:21:19PM +0530, Sudarshan Shetty wrote:
> Update the gpio-backlight binding to support configurations that require
> more than one GPIO for enabling/disabling the backlight.
>
> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> ---
>  .../bindings/leds/backlight/gpio-backlight.yaml      | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> index 584030b6b0b9..1483ce4a3480 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> @@ -17,7 +17,8 @@ properties:
>
>    gpios:
>      description: The gpio that is used for enabling/disabling the backlight.
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

Why 2?


Daniel.
