Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914AB2E6114
	for <linux-fbdev@vger.kernel.org>; Fri, 22 Aug 2025 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847590; cv=none; b=FEulJ8KTzekujOEpC9W7IPvRD9DWKquvqH4AmweyTJaNgiFTa8syln2X8YE1WXwiKfhg1G7Py/OFWSK5hWuURpwjQnWHxXSMiQSmDipREHo4iPro32pFT0tbu+tkq0a+ofv1LOoEPLC1NmmuiMMcJTjz9XRaBdvu8mrr306gFBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847590; c=relaxed/simple;
	bh=0cIVGZsKog3LpWjaV7XG6J5KkdzzL27b/J6vLZIoci4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmhazsAKqIThtxIpFqzvW2/hvFjnFyPSYuWiPC2TiwA4hBgzJrMZ9hctgT3DNoH5K3P14sL2Z7zAhRY/d5GVSOpmONyn/8OSMbdahQjDDNVN0E/kTlaQ87o/IKv4g9Hz3OJGlwjEEuU+guhWkqocVeMS5ym/V8ytGrfywMxjIqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=zNVQzzFn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="zNVQzzFn"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b065d58so14688415e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 22 Aug 2025 00:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755847587; x=1756452387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lK3kj6aT+uG8TNpObwIxTe+g6r92LKlTq+gjwtDBVRk=;
        b=zNVQzzFnw6Ir2uWiC0VDKKumRfmUWCmeEV31QGKcZ2nzBt4CI97D5zdXjcrOEHjS0h
         xZ5yZWK9gnuuNPd9PEZnUUIOmLC2Cd0dVUKsXitGDOU0lNvynkUexFOGtCqQ/vp/lxgI
         HbJZvVDtCaK08BhzMB9rjzNbbgGrbAQoHarWOfCMLk4JiZS7sxhxcApcag6oUH3r4HZd
         etubO1LL0MaWgki/QT5hQ6EPCP26zR1TW/tBrwLXBEfcnJrhr+UbT912a4ITqoNKLGHf
         eGfp+KVlD9n5veE5OCs3CS23rYqicCrXT4TGgTN+ki5KCoQnhM1/r6/DbYRyXNxyM9D0
         axsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755847587; x=1756452387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lK3kj6aT+uG8TNpObwIxTe+g6r92LKlTq+gjwtDBVRk=;
        b=a3hITQTXBo2SO/V8CkbEN3TksxL9CRX0AoDVXAX/yuNNUQ/kcKBcQX4vw3xCrWVRKK
         KZOwo7x988UTVBoARv6LnfcqmvaaLy5b6glLfv6r1u5bzgH8kzy3NcLefzc+sdqa+0P/
         ctHFaNRS3hMV8TKsOTfOhxyi0hoZSDr1dIBe6MZcoZzHSN2xzDevkpZ3RkIeB0Es0sBw
         96HznPOJlIJnTuht2DdNYIyLqPzSH4sHPZiMo3wzvObsiMDCGnGNFUltFdCAZfz3ymXz
         A2NXfS8D1RU/jGsVeQ8HVMjX1Cg+SWVaVdhhFlMsIzKzZ2MEu9QUySYXjFmovKBRfQwb
         Vsxg==
X-Forwarded-Encrypted: i=1; AJvYcCWzkMgT4xy/zjRMEsUkjXDATzTAGPVUfD+ylnCsZIK/+D01l8J7rVbCESzBaDIz9zmaTOf4QfmDzz7udw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+LUQOsfCJ29WgMCnAYWIeBKFl+59y5LRnhrkNNGInEDR18zR
	gWchx0uuqN2d6Kt+3f4Kz19oditVFcFuWBco9Lu7dhNWzO94vWfmb83+z2HLLHfDkn8=
X-Gm-Gg: ASbGnct8ivYiT9lWAQN26Dnru/eYOdmEOsnVkcmSEpMC0u+i84dbBzs8SxI4Azc9AMR
	9uZOPx0d/7TWxwApBb8qXBOh7+YRqJXAUdG26TNuGt4HfS8dP7+zmZ/m8ELCZKZuJnHWhIL2R1u
	Cb4Exvky92mW/uV5NhoYRhY+ln/QombTelovLQ4lQ5FxxE4w7F1yDcutIcKu72M4GBMO3xW0FTJ
	223w4e+1+Of++PcmYuyzj8AVVsTVbuQkicqbkw+O6jiPgSMmJVowcmVf1mMv6fE/26uHOTInbcj
	XIkW46O+uA4ZkJYgAwL0iExevPg/kJMegIBRmA5OVpiq8H66dtksRD0DXi+CpDGZ55/4xPAsA4I
	T9DaFUPsMQpLMwTComQQ3xPPM4V3aj0ndrNccWm6reYJgVuuUsMATXls3mBgpl2OShyzcme6wio
	xjHCJSug==
X-Google-Smtp-Source: AGHT+IHDuHRP55niLwTskQO1m/b/5ctH5UZu5kjoy3BiQ8RvkZmMD4Fr6kF/PognPgs2X/R938TpUw==
X-Received: by 2002:a05:600c:1c28:b0:459:d780:3604 with SMTP id 5b1f17b1804b1-45b51798fb1mr14095255e9.3.1755847586840;
        Fri, 22 Aug 2025 00:26:26 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50e2f0adsm25076255e9.13.2025.08.22.00.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 00:26:26 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:26:24 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: maudspierings@gocontroll.com
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: backlight: Add max25014 bindings
Message-ID: <aKgboFjwjtZsanWb@aspen.lan>
References: <20250819-max25014-v2-0-5fd7aeb141ea@gocontroll.com>
 <20250819-max25014-v2-1-5fd7aeb141ea@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-max25014-v2-1-5fd7aeb141ea@gocontroll.com>

On Tue, Aug 19, 2025 at 12:58:59PM +0200, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
>
> The Maxim MAX25014 is a 4-channel automotive grade backlight driver IC
> with intgrated boost controller.
>
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
>  .../bindings/leds/backlight/maxim,max25014.yaml    | 79 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 84 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/maxim,max25014.yaml b/Documentation/devicetree/bindings/leds/backlight/maxim,max25014.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..30b591152fa31d5e43243cac44c72028b05b5f8a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/maxim,max25014.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/maxim,max25014.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim max25014 backlight controller
> +
> +maintainers:
> +  - Maud Spierings <maudspierings@gocontroll.com>
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max25014
> +
> +  reg:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

Is the interrupt useful for anything?

AFAIK its perfectly OK for DT bindings to describe hardware features the
driver does not use... but is the driver missing out on error reporting
(for example) by not using this interrupt for anything?


Daniel.
