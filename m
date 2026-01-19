Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3333635B12B
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Jan 2026 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833745; cv=none; b=B9lCPYHzU3fAdt66cSfXbJkNr7VhZFkqxd1hutXujqThvZO5geMDLQs9mJH+lIxftTvljfGN6qacBz9TNG3mGeaVQ/dYxCPFfeh3Z/qT7hfGGAOdWB6o/1zcirZEHoJ4lEUtFeZAuqBzPQ2FajHODZjzp0jtRxL47RWp4FdrkUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833745; c=relaxed/simple;
	bh=afV6H9ksp+j0F3QSTrjV2ykIVls2yG3qd1BHRd1y/fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQLfDduhR9lIxwAby0Xuv1Cr6ie7I/sXVJa4VyiIBR4CUcFiOgIVVSSJT7urLPWowOOJiBm6iKc4u+l5ktsg6F+BC+2VeBh5RHn/paXVZRcSU6PZrJWbGdMr230yMieluR15accgdcGLsrrOD0QcA3Bge0Z5s0GeejL1wRy/aNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=h7vBvgXn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="h7vBvgXn"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43246af170aso2527745f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Jan 2026 06:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768833741; x=1769438541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TvnwX7iYJXUTTPGbmFJMfKYn4PnTqwC1sbs2t7QZU9Q=;
        b=h7vBvgXnClc4BISfxuNlt/S6fnTXIcyoqCxSMnQadnq/q0XIR5mABcC56zzpZ6YS+s
         u77KdT29rZ21vHPgHTg03OyyQqttj8M+8l8zsDUo2RBRFBMhfV2NV53YjNtmm4lzQSH4
         2Q1Acw+CjFMJvLxO0X1Kz/kXRfOhqY1L9llLWvQH7j+j3YUucT0uFGCymcSYZzagXsVp
         kKPLPHzHo3cik2E3tnFdce9+TKZBxT1N6CjGhZKwHqXvuB8wV3oPR2jYOG3jPMEFWIZh
         N+qyP6uObHWfzV5/ZpWxhVy13yKmxsu6ExZpYkA7rLoEjv64gzGmdpLMmHX1H04E52eI
         oU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768833741; x=1769438541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvnwX7iYJXUTTPGbmFJMfKYn4PnTqwC1sbs2t7QZU9Q=;
        b=mPXaBUTTOHISqjeAsnRnJO10gApvaODl4WjalxJPfshenR1d3KjDvGx8V42BNqeFGT
         KLoEe0NmvLakpuVQShXMKBGPURGCCipX8EFH+WPvOfnriIb/sl/Iy4e+czUwFUJNnqLt
         CSc2ogTheH2b5NS8MmrN2Yxoj0vVjR51NXOPaIYRbVcnWsJu6qrsko+RN522vWRHod1Z
         VNZiqqsKDcY6eqDielWawM0BMFWwKhkSCyGQ8YO9g/D47/S93vc00g9k/SLxk9g81hkZ
         sgArf80vQzOI1S3XydyAR08ajrOey+WDyFPEybQbR2soAsXuJnrzUjxMHFHLP2OjsCfH
         n0HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuzlAi0vZDnYZX9N2dpM6ERTLUIoN/47QP4/kmlYjxWuVDCdTGWtsil60v4sZU/8s6puT0Ng4EfdjwcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2W9ehceCxtbUEtrNw9xKQKyjvfccW6UVDe3P7kSPGnH/e8tJ
	0g+HpVLJSu0+eRKamTiUjc+wYA1L/t0vGFPNY8biGyW+qXAlyg25ntZ92ZdqrlUzVm4=
X-Gm-Gg: AZuq6aINwpFFCd2oOV0afUM+qf6JhH2OcfAftYH+wwd2Gtv+60Ju8bVzf3lHCVlmGSW
	t7fWnxVsrXa+GDxZgwfWg/gW6+10RPrekRkZ6CJfXmfUXia7jsagB+Zlf00ZOhfkMzXCPo0Lj4J
	o3LHpHk6guSjUzmT62qX/HUrXqjZaJ8mUbUpJMpFhmn9lt6m0iCqCppjWpatMo8HnXNui3AKGaa
	hHOEEGa/RJnvyQd/jWz0QA8ErzWktVL23Tjypm0Bq6+8T11KKpuwdwfNH0gViV6BEd6rxVafEGv
	mlIB+HpkA/ARhHCNSPtBROCWbnQn/XRVI2LCNGDzIIzChM7hPUVbkYBdOVMOuZpLeoRDqjR9D3W
	Tl1LFFoB9UFRe1RRNz+BfxVWfbdURWyGpVXtur9Gz9efUD/jcd6iCsNg2nwdcCfDW8s8Ly7hCPf
	TxN3Viv7JDl9FkkzHO2h9L9RT+VqU0rQejDgtkfpyMxGNd8yNNtAwIrZuah9gfqIIZI5SkNe2K3
	MBjsnznoFIBLWR6uYZzU8BgBLmCHlw0fuiZoIyWLFVRdRzbToIBB2rvvUg3G9SKmapapdImkdDD
	6NamFZ0=
X-Received: by 2002:a05:6000:4203:b0:432:d9ef:3bef with SMTP id ffacd0b85a97d-4356953f7d4mr17422902f8f.2.1768833741613;
        Mon, 19 Jan 2026 06:42:21 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699271dfsm22939388f8f.15.2026.01.19.06.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 06:42:21 -0800 (PST)
Date: Mon, 19 Jan 2026 14:42:19 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: tessolveupstream@gmail.com
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: backlight: gpio-backlight: allow
 multiple GPIOs
Message-ID: <aW5CywUjbr6eCPI_@aspen.lan>
References: <20260105085120.230862-1-tessolveupstream@gmail.com>
 <20260105085120.230862-2-tessolveupstream@gmail.com>
 <aVuKdAyXfWLs-WJI@aspen.lan>
 <c182df66-8503-49cf-8d1d-7da17214b843@gmail.com>
 <aWe7_hFpmO0E2sJe@aspen.lan>
 <95a49665-f379-48a7-a2b5-d288cdfdc0a8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95a49665-f379-48a7-a2b5-d288cdfdc0a8@gmail.com>

On Sun, Jan 18, 2026 at 10:18:32PM +0530, tessolveupstream@gmail.com wrote:
> On 14-01-2026 21:23, Daniel Thompson wrote:
> > On Tue, Jan 13, 2026 at 10:15:53AM +0530, tessolveupstream@gmail.com wrote:
> diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> index 1483ce4a3480..82698519daff 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> @@ -16,9 +16,11 @@ properties:
>      const: gpio-backlight
>
>    gpios:
> -    description: The gpio that is used for enabling/disabling the backlight.
> +    description: |
> +      The gpio that is used for enabling/disabling the backlight.
> +      Multiple GPIOs can be specified for panels that require several
> +      enable signals.
>      minItems: 1
> -    maxItems: 2
>
>    default-on:
>      description: enable the backlight at boot.
>
> Does this approach work for you?

I think so... but I'd rather just review a v2 patch than this kind of
meta-patch.


Daniel.
