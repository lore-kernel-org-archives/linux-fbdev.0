Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B07C09D
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Feb 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869743; cv=none; b=VUPEi2dTWCi18x47j8yGrapwFiLNQa+J7nszVS3uPNkJncbdjXEuLE5MCn3th+VGjAommaqfsISuC1IA0tDzsHbEwO2cfZIcn/V/ZNlBjPjw3ma2yQMxzw8NmIJeuOc+zKBXY+pf+3+Oh+iwD5QNOQ7gdbC/rn4Dw7/DclZcVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869743; c=relaxed/simple;
	bh=hfTBL9aDECTY+ZjU8pGAAtn2SIcowOf+C1vhc3Y984M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DReyRG1nJTiFwkjo0JJ3IjlYJkIICupSFOTEduBpinLuD3hxI3zv/7XwxJbGKyCII/BvxiTuGdmwdT0ntGNF48tFQkjzwjeCk47zmU+M4rTN2BuIgVUZvzQb+7ErdemuyD+lL9IdCwTbgwaHN20/cJo/7+Se5Lf6fvDwWxrBQlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=idMvPh9s; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idMvPh9s"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5111e5e4e2bso3032310e87.3
        for <linux-fbdev@vger.kernel.org>; Fri, 02 Feb 2024 02:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706869739; x=1707474539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hfTBL9aDECTY+ZjU8pGAAtn2SIcowOf+C1vhc3Y984M=;
        b=idMvPh9sfm0o/YVxqLFUvOiO/yvhDdqJOULxiQl4lum83pgQWjS8Vkzzesmy9qT+dA
         hemPJ0diAr7HHfX1z0dFHvMdzT6hYJZglveRqWzQexfctK7DK1UrteolXddg3Rb583Nd
         XizzmehHA4mX9zJkSLuWAtnkBGFM/OEZo9YDNBE7XEqyr+m2iezBJg3Z3FgOYz663jG0
         Fwk4OvvJA1debG4q3xrA8KYgeC6ISIFpfvXvFZN7QkWPpzJ6wh8cpPoH8an+IDDw7uPW
         Q32HWVNJQKGkva0U9jc7prsrbZB3WKIacNfH3SIXGesEY29AZiu/c16BnGhYyvz7pbTg
         8TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869739; x=1707474539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfTBL9aDECTY+ZjU8pGAAtn2SIcowOf+C1vhc3Y984M=;
        b=qgLcnKMBKlpJWVl4oxxx0uhN6CjHar/iL32RJ+LPKiUILBjxPyM5e+tkwZ2vZWq0Ca
         keCpvqSTnnTNEGZu2wCzJdbtq8X22OLd5OgwnJpDaKVYsKlpS5ds5hj1ALSe0cZtQaYd
         jvIp6NgaqjHT2EhtMynYgwvwBzmS6ccpdCXGLQrC+aDRSnjP2TetxTCKHe4eGQWUiW+P
         sHAbIzujrRbjsHUTibejuYhU3bivseoL2HM7lIN8bxLi9hSoyBDUUafS3YbfQBUBapMn
         N++qU60KmfqxqXNJ9QBfOgW20i1S/4xvc9XTHSvkzlFZZHxAe/Xnh4v4i8y7kY/ETDnA
         O9Aw==
X-Gm-Message-State: AOJu0YyL21AD+JJA5zsrRT8H0JMib+VcJ/GIAHlnGASepX/Z8F7T4OWL
	8EHu0ty1XO2qva0fOPEdD8Oy2Njo1n424NP+Ne2WtifADr6epM+Dnpks3VlqM9A=
X-Google-Smtp-Source: AGHT+IEBsmADrZtTDuAXy91jZj5Ipy9Q00moOwM0OK42zDksQ9zXaQvSN6W2TFULGA37a76clD5gEA==
X-Received: by 2002:a19:f702:0:b0:511:19b1:95b6 with SMTP id z2-20020a19f702000000b0051119b195b6mr3184454lfe.63.1706869739372;
        Fri, 02 Feb 2024 02:28:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWL2xY+EdYZof303ODkqaHz/8jXKXGb/Tt/J3CM9reDHXICB6snDxVlDDNw8QXdd0Vceq/cgmSOIYqOwyhKO60vFa6h+WZVWzEFiNQDAgbRwFkxasbdAcWkEVYkrM2Vb/GBCHXvVfjiRUb9O19ROcxGbQbXe5ijmbUBQE73b8Hd5puAX8UL+6X/M8n2JnVHgu9FmMZzF2g/ihXzmEnBZDVpNyj1p7HHrzkhtNg/QAJS342/7lPVUV2nfEQQLuub7Q==
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0040ebf340759sm2202718wmq.21.2024.02.02.02.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:28:58 -0800 (PST)
Date: Fri, 2 Feb 2024 10:28:57 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 2/3] backlight: mp3309c: use dev_err_probe() instead
 of dev_err()
Message-ID: <20240202102857.GC373571@aspen.lan>
References: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
 <20240201151537.367218-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201151537.367218-3-andriy.shevchenko@linux.intel.com>

On Thu, Feb 01, 2024 at 05:14:14PM +0200, Andy Shevchenko wrote:
> Replace dev_err() with dev_err_probe().
>
> This helps in simplifing code and standardizing the error output.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
