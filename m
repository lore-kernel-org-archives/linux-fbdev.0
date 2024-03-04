Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142736B02
	for <linux-fbdev@vger.kernel.org>; Mon,  4 Mar 2024 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548806; cv=none; b=hZeFOiGLGEgZ/cKW9J4RgcPhA+HxzNnxz5bPHsDnlMinHN+BkkOf2c863Ojclf+WthCKnFSCSLCjjouZJYWwQNb5oipUjGmtcaSJe+koh7NyR1yPEtVBA1Y5Xtecu/5KRpqCJ6VU9Ls+w0vcy+p5T3tIMliK2ECs52S2POKyZpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548806; c=relaxed/simple;
	bh=1QpDL7otKaLVRfvpxBnWM75rS6/RsB/zuNBPtPTxMoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcqEgf/Z5jsJodfVhiJtWLxPyre2mkKUFq1j9uAlm0GnVoD+NPFx9j2MKuw/TSYJOsscHI+cKGo0eSBh6tKPzmDfWD/ypcyDIMmkWiPAYDdEsXZ0y/FYhtPgAe1uyLetFBDGrJGKlv8cx4R3qPogi4zwJFazJxsqDigYxuCjEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CrAEHXon; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CrAEHXon"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d311081954so47643031fa.2
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Mar 2024 02:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709548803; x=1710153603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W9/tP/ZbC0JsITFItqvv/KxYTeSI+hdxPkuzSwYAtNM=;
        b=CrAEHXonv9u/E+bmwuo6b+6G16H7UbnRbH3VPQOm0Yoo5jziLuaPcvADIlkreP59RZ
         Z/PdWhv4bJAvZ6gQ0N8q+uKk/Nd6acnLc/7gCLHnX7rS2gP5Sm0Ti3OCAu9bJ7JtWnG6
         D4E6HNb5PbVOhJ7wqG27heDjr89ec8t4iHe+ZWaqlQ4IEdXTmhsHxR0Y4YqsIda73VI4
         YUzqLU0YAaUZlAI5DfSqAW8LpOWuTCHOVp+YNYi3AlvNnSGiE4a4YrZLIGQaRMAKTMyH
         6qtqEKNPnqY8RKexSRiUtFw39K99ELr88SBEgm4GaNU9tdIngYpEiPRoJLq2Dk5dmu47
         d7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709548803; x=1710153603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9/tP/ZbC0JsITFItqvv/KxYTeSI+hdxPkuzSwYAtNM=;
        b=Gm/FXtauEB2Gu650OAkxQYoDkfYjG8vw/oCa1RC0aauvWKT8f2ueJ5WOzspdgmoZUI
         +9jzqefsIW8EjQahd38iz6DGxuw/WkKtFji+m+AiMObvedGgDYilJvDjwbf7z6rxuTQ1
         MykDE98/STyEn/UbAZmAzIk07UxnLj7MH2WOOL8rmuwAqGCMbjryjMx4XzIQRhLrPbrh
         Yh/SUD57/hMHnydawwNv9UrLkdPCt1zAjEkrxmRJqVA++RhQFop/t3Kr9S7EzF+ykwYD
         l0lew/HpbVGMS4TDKrgyBhEW+VDDY7ALjWkaqglMjXSwpe4ou28HxVozbouAlnpKkbCh
         SBSA==
X-Forwarded-Encrypted: i=1; AJvYcCUsjsLBfra6fzNyYDrVtGwRxzo1lRgWSHCiTDXdLIrdamHUccrFybbJ24PtlH1caOTU70reYY4mWo1uEoQSLhTqOhZ01xYIYArcUbU=
X-Gm-Message-State: AOJu0Yz5qaq1AkVtDH1EPnwLDcde3AEWD9bEZSC0HeSFVNMiOIkFg6ob
	ex3cdyKLk1tHeu2zhQJ1g9f4h1qeQjD4MV8VUod/qrczoqVhob4iDUqRWcQCymI=
X-Google-Smtp-Source: AGHT+IHy2hD7I8n57uZ/ZLTPk4mOw39Pr9Mxe+/s9Lm4AJxmZpTlPtP8zpuXOrVna1EzdyQwmIaOcA==
X-Received: by 2002:a2e:3801:0:b0:2d2:a9f8:c436 with SMTP id f1-20020a2e3801000000b002d2a9f8c436mr4984250lja.53.1709548802698;
        Mon, 04 Mar 2024 02:40:02 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id hg14-20020a05600c538e00b0041228b2e179sm14216843wmb.39.2024.03.04.02.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:40:02 -0800 (PST)
Date: Mon, 4 Mar 2024 10:40:00 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] backlight: gpio: Simplify with dev_err_probe()
Message-ID: <20240304104000.GA102563@aspen.lan>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
 <20240304-backlight-probe-v1-1-e5f57d0df6e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-backlight-probe-v1-1-e5f57d0df6e6@linaro.org>

On Mon, Mar 04, 2024 at 11:11:38AM +0100, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/video/backlight/gpio_backlight.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index d28c30b2a35d..9f960f853b6e 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -64,13 +64,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	def_value = device_property_read_bool(dev, "default-on");
>
>  	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
> -	if (IS_ERR(gbl->gpiod)) {
> -		ret = PTR_ERR(gbl->gpiod);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev,
> -				"Error: The gpios parameter is missing or invalid.\n");
> -		return ret;
> -	}
> +	if (IS_ERR(gbl->gpiod))
> +		return dev_err_probe(dev, PTR_ERR(gbl->gpiod),
> +				     "Error: The gpios parameter is missing or invalid.\n");

The "Error: " should be removed from the string. dev_err_probe() already prints
that.


Daniel.
