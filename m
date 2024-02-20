Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170576A8A5
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438335; cv=none; b=qOoH108iYuMpbYEtaZ2yzdaaQyFW8P5Ifxhomu39OeKo0Ygd9uDOLs2d4Lc3ToCJsH5dlOFV1ecgodDxte42O1GPMPdK62Kil01N9Rc5/M2QD26TrUk/3ETNzG7UAkzGNRj5YOZWOhHfMRGkNlFh3u+n6urrUO7yyiS6zbD53u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438335; c=relaxed/simple;
	bh=ZUd/4SIGCstdqfJUTd63+Gsgaaki8fxiSzh0mr3PVCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gsqh7jNJASbfBfyeXQ/RVY3XS91FLVee9/WwAssW0ygbCLbk86Wni21ZVE1DRWTn3xso+tlzTquLL3XEMbEsL9GCbuXHv0BTgUa1QJGa96nTZl3RjMv6B4EqxTK0b6vQ8qkVV8v5my+IUdyoa9x+DOF8dq2c9nAytWGtNDOZYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jwGeAk+R; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwGeAk+R"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d61d51dd1so761156f8f.3
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708438332; x=1709043132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VlCI9F854lrsWDUIN6PG7zZ3hJeSzAbz00+8LmilWc8=;
        b=jwGeAk+R6VThW+JUlY4uPM1hbUFeOFHIh7TvNpyFy8lqUbVkMmMSUZO+mies2RHt8S
         DMQIo0B7bwaXIxYNYV66GyXKgq6tKRjMSAt87kA/IstD/uW8sxlz3I/+D8GRstrYaHap
         ReGFQhe+o49yE8gcedT1MZIovD2u7U9aODQZ60x3OS+B13BTcBm+g1G+C0N7+GYvbwv9
         909FFIGpJJptV230JtxKxaLcWuhLSLlUowxFIjvv9YD71qcp3ipAF1dNqaxOPBsK2GC4
         VUmKNrSNddMrBuKNX9UIZtPTajQFSz6X0AzdrTNo2XCQgplAJ2frDxP0OyEW9uHAJA9q
         wc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708438332; x=1709043132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlCI9F854lrsWDUIN6PG7zZ3hJeSzAbz00+8LmilWc8=;
        b=COK3YYXAvaYEHny/iIaGU31NX6O44HzHFu7VqAVAVzIVAPxHKke5Q2YZXFxWT6elQd
         S775TpKVoB87WO0mKlN2FmJUnYcictUA+gt3fVwEfc9KpLUd55gV6y219Tc5gRBvWzWE
         j5yQAFdgUHcPs85KZaxiixOSLnWdbUJRDoCTSUiNFX6P0DKDP4ltCwJ2TuilxIWd92Dy
         58CdfQz0ncyhlc+HXpZmoCSgobN/J3i7U7GUKEKDT80A+KB6Ds4wZ6/GUuqVNQCd9wC2
         iXSLdPolYbUgz0chqEPNIuBkG/iW5XSoFQ8HKkg636rTSEjjWPEdtki1iPZvO+XGAnhA
         5zjA==
X-Forwarded-Encrypted: i=1; AJvYcCWFqmH7hHUYcXz4g3xepmSxShbZm6ocIjtCrmwjr4Jp9IaQdJDn2hWoHjJqKve+XifnQZ6tn2ayfmLOJdsA83pCDrT33pTn+tjkDw0=
X-Gm-Message-State: AOJu0Yy9XwEJ0W9AIv/GJueI7AlHJDKZ+6kDHXAVi26hBZOJOf73OOfD
	afu1Q6Ml1ZgHxxxu1LxQmiruqGa1nnbrlT3lHBwOYVKpl26xzBLuQ5+XEXu2Kfk=
X-Google-Smtp-Source: AGHT+IHoWaPYXgMjU6PeB2yk8TgKT2tZQUeUz9ykPdB+ZXJLtJWkH3ETMuOSkIOY4HbiE/fpQppbBg==
X-Received: by 2002:adf:ec44:0:b0:33d:3ceb:5308 with SMTP id w4-20020adfec44000000b0033d3ceb5308mr4607368wrn.42.1708438332431;
        Tue, 20 Feb 2024 06:12:12 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bq5-20020a5d5a05000000b0033d60ab6bc8sm4662665wrb.50.2024.02.20.06.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 06:12:12 -0800 (PST)
Date: Tue, 20 Feb 2024 14:12:10 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"G.Shark Jeong" <gshark.jeong@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maximilian Weigand <mweigand@mweigand.net>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8974-hammerhead: Hook up backlight
Message-ID: <20240220141210.GG6716@aspen.lan>
References: <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
 <20240220-lm3630a-fixups-v1-4-9ca62f7e4a33@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-lm3630a-fixups-v1-4-9ca62f7e4a33@z3ntu.xyz>

On Tue, Feb 20, 2024 at 12:11:22AM +0100, Luca Weiss wrote:
> Connect the panel with the backlight nodes so that the backlight can be
> turned off when the display is blanked.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
> index 4aaae8537a3f..8eaa5b162815 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
> @@ -182,7 +182,7 @@ &blsp2_i2c5 {
>  	status = "okay";
>  	clock-frequency = <355000>;
>
> -	led-controller@38 {
> +	backlight: led-controller@38 {

Again... a minor nit regarding existing problems but this node doesn't
follow the generic naming recommendations:
https://devicetree-specification.readthedocs.io/en/stable/devicetree-basics.html#generic-names-recommendation


Daniel.
