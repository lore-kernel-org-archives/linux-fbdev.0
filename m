Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DA628A2C1
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Feb 2025 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739482368; cv=none; b=AEJedtI9y73h/kThj2l9/1Ob6TfLk7PRP/XZPmQgHdiwCOFYL/fKCSkYUjUY2ohx5NxbrCsS0COc9bBVnzNiFh69qL2X6hQCi/+G4+tdfLHksVs/p87/79Us+8LAHMFUG5z0V7ZVneMFb//2CDVBUWRKax3IpNtmIgdMSwEjOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739482368; c=relaxed/simple;
	bh=fHyM7qs+fM0V9XKBYiBwjzIu4xyYyLnJ9YjK5FgeIzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCwufau35Hnw+e2NNnXIxMdWuHj0AJxP+FNpB4jw34Jcd+ECEFDNU5kC8/Dtk28jyjKoFe+wQUwa3aX8HEb21DsI2kzNK1OTBFmlhjYj810ayNV85ASKQIc8P/yNFsLazet5iXgS3PW8ybkytypASXL1G6wN+3NJqxReSrxuOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=LmNghaiK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="LmNghaiK"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43690d4605dso9260135e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 13 Feb 2025 13:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1739482364; x=1740087164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E9Cksr5sI5tujPp8b/uuWc+Q85liEnv8iPKnjQVPTio=;
        b=LmNghaiK1ByYmv8Fagl6cYWSyFuxlYjmSuyH/Q42VCWsZcW67qQXnrfFz0e+KIcPZH
         /DpsMsWbJx8LKFdO9f0u+Ag0PiAQ99Fy3lhL1VGyd0kVt9bKGX606ie4tnbVR7VfXvyh
         TRhF1P2z+XS6xB1+E4IhnQsg3S+zDWennsTUg5vvkWTgefY4VblWI1F7exIFsPTgJw5m
         Ar9aVJiqg7psbUdGQCl9D1zdDtqeZeqLzuWFBdcE6VWAgKs4tMAZ7yUx6v6LVhJ8PcPP
         PAEPygZv8TCDUehoJfYKph3+hXwNHyKBefUF2jwXNhDUDoCwpgx12vfDjoNUKBQwBP6L
         3Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739482364; x=1740087164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9Cksr5sI5tujPp8b/uuWc+Q85liEnv8iPKnjQVPTio=;
        b=D/Cc2KCLp/FrLlqsBvXPx1/MYls/hao34/huNn4AEnONLgKLByOpI07F7vrrtDPNiv
         uD0y/JdBfIXpu2vELEBzbwzK9OZZJoSiAjL44+0Ky/Uf9zrcurQU3rwlyLXRZ8JBY6x+
         i9cf46WvZKSTnpsZmbF4FnRtwaxFCJwoD1SxTwn17C+zhOK9JWNMZ9qR27CB1U07DMS9
         rfPAVyD6QSHjfqYNU+lfK3GqjrBg+IUEgF8d3hZmXrYzChyIjiH39SCWAnZ0K393iaze
         rlISzoOlwoapLtleS3qutb0WgxMkJFjoXyo/pnDZz5trwizfU/XdSAoDuZc0iaesVNEy
         dQZA==
X-Forwarded-Encrypted: i=1; AJvYcCXXu9fgExhnrtGBIr/c/omtVzkLPGEvpGtFmIj4CDgf7fg5ejDVlcWILKU6g9WKpJC88ibJJu6jpngg3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc6XxvxmyQT9w+Aog1jsG+nWBDgd2cH9I4uR+s0g6XeWdmfRKd
	IZsSDKybu6+woCnl0BX0SJGvacjNVMn5TAAgiLd5fsEafdogiHWGO7V9TmmpW4U=
X-Gm-Gg: ASbGnctjP0yWoj97Xr8bVvDywSO7iE6PrhQ+aQQtu62tiW708eTIqDNk0bGww6yibJW
	gXpoxBLueRHhkdmnQ2zxzfKRbtENAknxR7onKJxsFRDWGTgJpLCfN8br7TVNm2h1vyO23sLOs1E
	anFBzK4NNNTUUtCTjaBT7hWxLgV7oq9EpRd/j63lLmtfCt9ebsrqairWjncjmHx8BPgv1SkT/5M
	H3MJOPJVUx3ZesCvW2sYDUuTk4nU1Hl9vuumF2/ksn/MKXhD7Jh6Z2dB8ooiQxRQbnpZFhF5o9x
	wYuS4QTMl3ahWV3Q7dr40/muGfNI9IQOaT+hjaTyIUogKhFbA86aZrE5AVG+aqVBC9t+vAOdrg=
	=
X-Google-Smtp-Source: AGHT+IHeCTtwq1iNXSF1fUZIaS/4CGI5trwsdX8zzJ/YF5He2ktcc89iauHD10dC77CQia9erjfZIA==
X-Received: by 2002:a05:600c:46cc:b0:439:31e0:d9a2 with SMTP id 5b1f17b1804b1-43960169738mr60413745e9.3.1739482364316;
        Thu, 13 Feb 2025 13:32:44 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7d2sm59583405e9.25.2025.02.13.13.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:32:43 -0800 (PST)
Date: Thu, 13 Feb 2025 21:32:41 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: mfd: Document TI LM3533 MFD
Message-ID: <Z65k-fi78DnKVN1K@aspen.lan>
References: <20250212075845.11338-1-clamor95@gmail.com>
 <20250212075845.11338-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212075845.11338-2-clamor95@gmail.com>

On Wed, Feb 12, 2025 at 09:58:41AM +0200, Svyatoslav Ryhel wrote:
> Add bindings for the LM3533 - a complete power source for
> backlight, keypad, and indicator LEDs in smartphone handsets.
> The high-voltage inductive boost converter provides the
> power for two series LED strings display backlight and keypad
> functions.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/mfd/ti,lm3533.yaml    | 221 ++++++++++++++++++
>  include/dt-bindings/mfd/lm3533.h              |  19 ++
>  2 files changed, 240 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
>  create mode 100644 include/dt-bindings/mfd/lm3533.h
>
> diff --git a/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml b/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
> new file mode 100644
> index 000000000000..d0307e5894f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
> @@ -0,0 +1,221 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,lm3533.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI LM3533 Complete Lighting Power Solution
> +
> +description: |
> +  The LM3533 is a complete power source for backlight,
> +  keypad, and indicator LEDs in smartphone handsets. The
> +  high-voltage inductive boost converter provides the
> +  power for two series LED strings display backlight and
> +  keypad functions.
> +  https://www.ti.com/product/LM3533
> +
> +maintainers:
> +  - Johan Hovold <jhovold@gmail.com>

This looks like it has been copied from the lm3533 driver. Did Johan
agree to this?


Daniel.
