Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC16A35F
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438273; cv=none; b=J59Q0ELsycWunqKvj4welERbxoKwXKptO5Zj+0AorGxOjEJ71rxppwEn2XwsDUfavR8fTegeLdhftlFld7M8faOeLN5hUN/MWmLoW0yWnFOaRirl81uB2oxyFWbcLGHeyWK6Z/kEzq0mEJ1B5lFBR5UdzbGYcLa4FGZxl0weUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438273; c=relaxed/simple;
	bh=DoDTpH52fG/xa9JYP7JIk5GojpXoFXs7XhgACpgYZoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRkY3sbqatEOJsY7Mqn1H4BJayedxGUShYLjFt411Gr3QAZF1hggdVQu2wAliIwPvd8v/zp2utkGFIf30Bjda38XZgIjxX3hiWKCt7NtICWX8sahn0ivG0hRrYZ81J910LXMmRASCZRpN/VF0qaTbKesoAA/vBMyrWQHTeIkqII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MtOuoA8j; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtOuoA8j"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4127188dd5cso1887875e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 06:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708438270; x=1709043070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WYAwDAwFgnqBG7CxkptbcyQsBM6DtwJYIQlGTNsuuGE=;
        b=MtOuoA8jvtt49h63j6TQEYV+ueHDmktflInByjI7pu3IOcfGUKQplLp8T/QtsPz8lH
         93NBfXIHBNwA6PaQYgeUzROW8Z4Iq/dOsEkO5kDwapdIFD320Gk1gpoaT+85uOe9upQv
         p35drCVWTw2J2i1oNkX0falGJwuwhqPVcNeNHdcK4o/VkeEC2m2OKy8XpMrhQ7MLvRy+
         e6W4wZKLtgpi2P5rWmGfJ4judLgOejxTmPTikyZxgAkjORzaZASBtvf7K98ghmFeox6W
         TfmV6QcI6+SuhcO6twx7WQJ54aKkRKljPbrcvpYHXNF4pAJBnkM8oM38hcEsjbQR5eC7
         C3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708438270; x=1709043070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYAwDAwFgnqBG7CxkptbcyQsBM6DtwJYIQlGTNsuuGE=;
        b=Nhe8idrtVDD2eC8YpTTBEoheTR8ISkx3eWAHnTphI4GNtIsgYj83BTjRdcqGEqlu5B
         GEa500qKZK9O7e5eMtI+b0VmRp8/l1GxAO1NNkP6CrePhOy6uMt5Jjo/3zFg8U12PVVs
         rXkyJ6eWu34s03/2Q0GuDNrmbtNLWalHedtCc2CVF/xJTtWTsOe2Jq4ykeExhLUKdOp9
         JozyW6s3HOb12qasPbrHDneN3MJGs8GcQkYoG6lQRTJY+e4L99AMPY8aTArVQXLmv25t
         fb+lhgeoxu5DorItmciHC1jPBJe4j8oC9e6K674Tnq0XXjDyFssaJ/4okWoCTA4NqLei
         hc5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+t46q1H0Tztkk8Jertlf07WbyGDReoj5pfpKdPrsEPMpeuOhkmOf8b/TFjBQO5oH6YBtE3x1DmQmldyGtYnGm5a0JQD6qo5TvumA=
X-Gm-Message-State: AOJu0Yzys4Pl9uXSr7DT+b15b8ntAPEy3+gJvqz6Qha6kuCKTe6OGk8T
	CTfXs3v+zI+yF1yeFtZBdhB5XsxeHcbVi3dZiXSMcOzXrVx8Q4ywDYo5tEb6YO4=
X-Google-Smtp-Source: AGHT+IH7G6/8AbTda6e+b8uSaQ+ucRuJkJiJ61GD7iDnIPSep0vXQt5/dU86gOTGDRGrdA5ym28B4Q==
X-Received: by 2002:a05:600c:4fc4:b0:412:913:5484 with SMTP id o4-20020a05600c4fc400b0041209135484mr10836802wmq.11.1708438269747;
        Tue, 20 Feb 2024 06:11:09 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bp1-20020a5d5a81000000b0033d38cbe385sm9829129wrb.6.2024.02.20.06.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 06:11:09 -0800 (PST)
Date: Tue, 20 Feb 2024 14:11:07 +0000
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
Subject: Re: [PATCH 3/4] backlight: lm3630a: Use backlight_get_brightness
 helper in update_status
Message-ID: <20240220141107.GF6716@aspen.lan>
References: <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
 <20240220-lm3630a-fixups-v1-3-9ca62f7e4a33@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-lm3630a-fixups-v1-3-9ca62f7e4a33@z3ntu.xyz>

On Tue, Feb 20, 2024 at 12:11:21AM +0100, Luca Weiss wrote:
> As per documentation "drivers are expected to use this function in their
> update_status() operation to get the brightness value.".
>
> With this we can also drop the manual backlight_is_blank() handling
> since backlight_get_brightness() is already handling this correctly.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

However...

> ---
>  	/* disable sleep */
> @@ -201,9 +202,9 @@ static int lm3630a_bank_a_update_status(struct backlight_device *bl)
>  		goto out_i2c_err;
>  	usleep_range(1000, 2000);
>  	/* minimum brightness is 0x04 */
> -	ret = lm3630a_write(pchip, REG_BRT_A, bl->props.brightness);
> +	ret = lm3630a_write(pchip, REG_BRT_A, brightness);

... then handling of the minimum brightness looks weird in this driver.

The range of the backlight is 0..max_brightness. Sadly the drivers
are inconsistant regarding whether zero means off or just minimum,
however three certainly isn't supposed to mean off! In other words the
offsetting should be handled by driver rather than hoping userspace has
some magic LM3630A mode.

You didn't introduce this so this patch still has my R-b ...


Daniel.
