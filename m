Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E5860DFA
	for <linux-fbdev@vger.kernel.org>; Fri,  5 Jul 2024 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169177; cv=none; b=uWBurNCMcvaT64JY67zd0OmAwZ6U5UzB70q2Upooc+b9W+HAXB26NuGjbE4IrqL0zw/ySln4q0PdeWlqBwc2u+7pkkUghIZNCgWdsS8NAmaHFXpdNFCWDwn4A47wWhSdHS+3ZrwiHVxWBXvHBMxoVKh6ndVfVhPkT23uQEZJAeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169177; c=relaxed/simple;
	bh=rtrv43YpYECPvPw2sbM6bFO8Srxd3kG9PqB9jlbBqHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnEoHRaqkKAsL78tZnMEMuCL+Ahcr0LEQiynG1ihlaTW0qzzlH6CmrR6KxwWQMhc7uKFEYTitrJTsTvFT9J7SNQp5WtVeq2XxxHBFKbNn/akILen163B1SmUWUHYgf13KEg4X/PQ2kNEf9icdKZceGmoSvXsW34wYJMlKT22m2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UQ8l0moI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQ8l0moI"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so8621345e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 05 Jul 2024 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720169174; x=1720773974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vqe4KnkOYZvhw0LoLhK32nqj8NEoWKv+/VqzK0jL6Vs=;
        b=UQ8l0moIW7bfcefnk4yrnk/culRaO6W1Vg8lwk+KlfO/ytpnYXkuB8hlRQUozMlmEt
         SIygPZaB4jSDZM3LTUyCV9+RNut0MnGlA5+kJAoT1HKxWpe+boacTY0oRt7d3/VgveJ8
         BJV21kWOBSL+1oaGInIV8GhAhoBiooLuTpkzGD+Pae2Kf7wov8zH/C25a9ga2wdyvCRx
         BdEETEA+9/RCJwiw6qX5ztrsaxRhpzs9yIlMDI5ki3BBcSR4GJCbWIMsnZLTBkB5plDK
         QGWepYbh65PjaYdXZ6IeTTcaOAJOeHDU+NCpuQxFLrZZSCSrDAmrMta4Vob9mvGCHZ8g
         ebOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720169174; x=1720773974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vqe4KnkOYZvhw0LoLhK32nqj8NEoWKv+/VqzK0jL6Vs=;
        b=ejddr6m12YlWhx7HMcAuYwT+RbFqpze1MLTDkVx33UQMugudPQOsmdfrIlH2G16YeW
         MHsVcYAC8yPpQg4lfl4AZEL03WeKHm7BP4cNxznFo3ni91CBNijJwjAAIA8I9kmN7I1Q
         d7fye4gaA/0PokMSiJ/pY+veLrrpqzofOIy7sdobOUVEWjAlizzX0RLo5XqxYLkBbPzu
         +K50CZWHPi8fMiKKFLVNnbwn4M7GeeUx9wvjwiiNLYQgEHJ0curWg+VhNt4muTsYz9vj
         14cdYeUY/Uue1UeeMOJrRzeFljorVjYvHNcpDO1ZCRgylA7HSLfoD5oC5ZY9ZPwS5hFM
         8htw==
X-Forwarded-Encrypted: i=1; AJvYcCXb0fBHYAOyXd8KcvF8CfQOK0wRckvLUXAof6O2QXsK4viNz+4Y/i/NvhK4LZCSEhGjm8lu5C3X7Qu1PTMxWS20Xk3cGjiPAD0wCDg=
X-Gm-Message-State: AOJu0Ywh2AHwSyZ2e+/c1QueU//M4KlVVML4CZ4A0cF+V0lry/MbBGJW
	2bPbjWNr3ucN5TeLEfL0eK6zzOismFDyatTRWVx2Qj8wAPnsWdT1w3dpqbfSnuQ=
X-Google-Smtp-Source: AGHT+IHLaWHMsrIEkAGvMoO52ZSCdECYDkbf6R9gSoFbVCf+dsJ9hk2JLjnNeb/U+Qrngj9X8+Z9Iw==
X-Received: by 2002:a05:600c:4f01:b0:425:6290:b11b with SMTP id 5b1f17b1804b1-4264b197124mr33304105e9.18.1720169174264;
        Fri, 05 Jul 2024 01:46:14 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a25181asm53763085e9.30.2024.07.05.01.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 01:46:13 -0700 (PDT)
Date: Fri, 5 Jul 2024 09:46:12 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: l4f00242t03: Add check for spi_setup
Message-ID: <20240705084612.GA110803@aspen.lan>
References: <20240705083834.3006465-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705083834.3006465-1-nichen@iscas.ac.cn>

On Fri, Jul 05, 2024 at 04:38:34PM +0800, Chen Ni wrote:
> Add check for the return value of spi_setup() and return the error
> if it fails in order to catch the error.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/video/backlight/l4f00242t03.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
> index dd0874f8c7ff..a4e27adee8ac 100644
> --- a/drivers/video/backlight/l4f00242t03.c
> +++ b/drivers/video/backlight/l4f00242t03.c
> @@ -166,6 +166,7 @@ static const struct lcd_ops l4f_ops = {
>  static int l4f00242t03_probe(struct spi_device *spi)
>  {
>  	struct l4f00242t03_priv *priv;
> +	int ret;
>
>  	priv = devm_kzalloc(&spi->dev, sizeof(struct l4f00242t03_priv),
>  				GFP_KERNEL);
> @@ -174,7 +175,9 @@ static int l4f00242t03_probe(struct spi_device *spi)
>
>  	spi_set_drvdata(spi, priv);
>  	spi->bits_per_word = 9;
> -	spi_setup(spi);
> +	ret = spi_setup(spi);
> +	if (ret < 0)
> +		return ret;

Good change but please add a dev_err_probe() here to match the other
error paths in this function.


Daniel.
