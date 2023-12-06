Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+6XzOmu"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD1FDC
	for <linux-fbdev@vger.kernel.org>; Wed,  6 Dec 2023 03:26:48 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so354133f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 06 Dec 2023 03:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701862007; x=1702466807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EvSC8sFJC144TRBvtM3+ZPdJXLrfbSly1D5iu6epzXY=;
        b=B+6XzOmuiPR/HvuuAXP9A5ABo8ZaDwQ+BUroHE+ijr/0ePnKp1rUTJTwZDdh/iR17m
         9ZepE0bnbo4ZsBmfrN4AgJlVhMUGWzu9lt7CdFA7SQ1buLJag1UMCyPlGBv+thGppHGX
         7AsNu+Mu/OIwu8RSmGaxd7u+ePlK98uBzNOOyPZJQV1RJUN1iaHBl3j/0ns0xElsk7Et
         dQRgdsoiHBTyxEMCq9AyxysAAf9aZjhEyMzCbPKZRoRa/7GycXgEs0cNrJz7YXxqPbYg
         BaWMRZ6q7OiqtbLHG2+UbDEbLlMNuPU9BXNv7FRmOjU3JzwN3RBSuSk8y72Wh3XUYwAg
         A8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701862007; x=1702466807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvSC8sFJC144TRBvtM3+ZPdJXLrfbSly1D5iu6epzXY=;
        b=D1my5f3FvGu4DlC/1jrsMaPG5UFILI19nhG0adesnx83gn3JR7BugEXeKaP1oHfgPv
         lSDmfiDUeJiVIrzmuYMNuAEgW2wkLyuygBOelUSAdfnMvy1rIiHuNVGDzURiaz7KAxvn
         va8B0BXNph8tnF+V4SfBPRO9deuXvXypq/M6BVQuR5kZWd0Z6otqZJTRa6pzOUqbqD22
         X2n+ltC2n1uobyfAUtl2lcBV+aUNACSvPvlVzhFPvaFEd6W26IwTsiPbuFv8qQtPXMoU
         hmwyypcTwQ555E3XuUODaw3l2EEPxyJ6/HdNsPz6xzCU3lckl+GHmUeZDmxKN4kSzZgc
         yPuw==
X-Gm-Message-State: AOJu0YybT1Oer/N5XQxFkfVQmBU6Elogo06eySzPF82UCMp0RJAavwEz
	j1w+3DJnTDcb4cLyd67h1GfMmw==
X-Google-Smtp-Source: AGHT+IGLGNtV6sQTUXUZq/T4TEJqUVUvZaN893Vu0zQMRSW6n3M3Mtf8yrqGuZC/2DvnctBaVxiZuA==
X-Received: by 2002:adf:e644:0:b0:333:73e:632b with SMTP id b4-20020adfe644000000b00333073e632bmr435543wrn.31.1701862007313;
        Wed, 06 Dec 2023 03:26:47 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id c1-20020adfa301000000b003333a216682sm11483046wrb.97.2023.12.06.03.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:26:46 -0800 (PST)
Date: Wed, 6 Dec 2023 11:26:45 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: ili922x: fix W=1 kernel-doc warnings
Message-ID: <20231206112645.GA81045@aspen.lan>
References: <20231205225638.32563-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205225638.32563-1-rdunlap@infradead.org>

On Tue, Dec 05, 2023 at 02:56:38PM -0800, Randy Dunlap wrote:
> Fix kernel-doc warnings found when using "W=1".
>
> ili922x.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> ili922x.c:85: warning: missing initial short description on line:
>  * START_BYTE(id, rs, rw)
> ili922x.c:91: warning: contents before sections
> ili922x.c:118: warning: expecting prototype for CHECK_FREQ_REG(spi_device s, spi_transfer x)(). Prototype was for CHECK_FREQ_REG() instead
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/backlight/ili922x.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff -- a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
> --- a/drivers/video/backlight/ili922x.c
> +++ b/drivers/video/backlight/ili922x.c
> @@ -82,13 +82,12 @@
>  #define START_RW_READ		1
>
>  /**
> - * START_BYTE(id, rs, rw)
> - *
> - * Set the start byte according to the required operation.
> + * START_BYTE() - Set the start byte according to the required operation.
>   * The start byte is defined as:
>   *   ----------------------------------
>   *  | 0 | 1 | 1 | 1 | 0 | ID | RS | RW |
>   *   ----------------------------------

I'm not sure we want "The start byte is defined as" in the brief
description. Needs a blank line between the brief and full description
(or hoist the argument descriptions up to match the idiomatic
form for a kernel-doc comment in the docs if you prefer).

> + *
>   * @id: display's id as set by the manufacturer
>   * @rs: operation type bit, one of:
>   *	  - START_RS_INDEX	set the index register
> @@ -101,14 +100,14 @@
>  	(0x70 | (((id) & 0x01) << 2) | (((rs) & 0x01) << 1) | ((rw) & 0x01))
>
>  /**
> - * CHECK_FREQ_REG(spi_device s, spi_transfer x) - Check the frequency
> + * CHECK_FREQ_REG() - Check the frequency
>   *	for the SPI transfer.

Likewise I think there is no need for "According to the datasheet..." to be
included in the brief description.


Daniel.


>                             According to the datasheet, the controller
>   *	accept higher frequency for the GRAM transfer, but it requires
>   *	lower frequency when the registers are read/written.
>   *	The macro sets the frequency in the spi_transfer structure if
>   *	the frequency exceeds the maximum value.
>   * @s: pointer to an SPI device
> - * @x: pointer to the read/write buffer pair
> + * @x: pointer to the &spi_transfer read/write buffer pair
>   */
>  #define CHECK_FREQ_REG(s, x)	\
>  	do {			\
