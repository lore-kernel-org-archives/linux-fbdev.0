Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A6F3DBA1
	for <linux-fbdev@vger.kernel.org>; Fri, 15 Dec 2023 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+q8FDOv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c68c1990dso9285775e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 15 Dec 2023 08:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702656665; x=1703261465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oiYfNucyGrJK9+Fismuk7ieCgUCyCPw4k2hNnP6Ge6o=;
        b=Q+q8FDOvOPYDVmfBOa3BqjkZ0Cz1nJjJTIQwB9Z70mqq2un9Gt6kn7RqUiABy2aup7
         4xEDTOigPSXcND5uQMTV5NyHPcLm1McJMdLwOKLKFP8wAGZedWSrau7m7X4w3JXmrMyh
         NvEDTlRtOFAIdJ2E1YzhXsOFOrsPiTaJTcXvdQfZ5b03JgkTnuMXvbQVcjBa6L4mg/zy
         nTZlJk24wBE0DLgtTTOOv4+uvhRoHfsKwfsSQUYquLSoErniUVPp/1Mz76Dgm08XLQ4I
         K5tAOUXty6S83pI5/ikqp8gcDzUQEHQi6JSoVJTe7a5xbWLQvBxxiFr+a9yTZMKp7FDe
         8lRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702656665; x=1703261465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiYfNucyGrJK9+Fismuk7ieCgUCyCPw4k2hNnP6Ge6o=;
        b=kdXE9nwf9tlEBEYzgCzALs+jN4xgqFGxkd9ynSRvkxKlcB6/w0gtXpL79A2PCykEfP
         JT1JAzKiZp6dzPG+uCeGw9iL7DY/lbKauyvAwSOcRDxNObEQn82XrSiTRWdPpwemHZPC
         aCBdmZJaUsqjYIixtCq6NRR7Nd5Mo9jv4T0QA5DFxFBZ+kcV5OHmI9TyOfIpGJtuR73w
         jWSUng0we3YmAbsFo6leKJnjoKYEiVhVwcZ1BkLI0ugOKMn1To+D/Sv05r7D1q1Nnlfo
         EJyNC4KHPAY1t9Jj5LxJlglQELwUWEF3uEHyy3RXqRDe8j2WZMKSi66l59bIWWGQCUyJ
         0BLA==
X-Gm-Message-State: AOJu0YzhbT++4UvOIHMVIIHj3QC+ExpezeevycE4JWLr1oc1wczt6vsV
	HqwauhgZjhoAX8hkyj3uB0lGZKAPTdedZilAZUZPVw==
X-Google-Smtp-Source: AGHT+IE9/QpVqN2I8/3tKtSs5UIywuHjtuZECShg0SZTo046hup40+fbNNexXXT5wkPSCrngxFK7eg==
X-Received: by 2002:a1c:6a07:0:b0:40b:5e21:c5ec with SMTP id f7-20020a1c6a07000000b0040b5e21c5ecmr4187384wmc.186.1702656664783;
        Fri, 15 Dec 2023 08:11:04 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00405c7591b09sm29759819wmo.35.2023.12.15.08.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:11:04 -0800 (PST)
Date: Fri, 15 Dec 2023 16:11:02 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 1/2] backlight: mp3309c: Make use of device properties
Message-ID: <20231215161102.GA662726@aspen.lan>
References: <20231214195158.1335727-1-andriy.shevchenko@linux.intel.com>
 <20231214195158.1335727-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214195158.1335727-2-andriy.shevchenko@linux.intel.com>

On Thu, Dec 14, 2023 at 09:51:13PM +0200, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>
> Add mod_devicetable.h include.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/video/backlight/mp3309c.c | 38 ++++++++++++-------------------
>  1 file changed, 15 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
> index 34d71259fac1..d9b08f191999 100644
> --- a/drivers/video/backlight/mp3309c.c
> +++ b/drivers/video/backlight/mp3309c.c
> @@ -15,6 +15,8 @@
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
>  #include <linux/pwm.h>
>  #include <linux/regmap.h>
>
> @@ -202,15 +204,12 @@ static const struct backlight_ops mp3309c_bl_ops = {
>  static int pm3309c_parse_dt_node(struct mp3309c_chip *chip,

Pretty minor... but I wonder if it should be renamed:
mp3309c_parse_fwnode().


Daniel.
