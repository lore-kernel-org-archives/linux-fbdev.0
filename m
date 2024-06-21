Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8350884D13
	for <linux-fbdev@vger.kernel.org>; Fri, 21 Jun 2024 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966485; cv=none; b=hgzMrUkFIqXdx0LrJdKemajM5wLuRC4yXOKJ5dXsaqiFs0DGFmDwnE+zaply9sGcF8JsFKcPOs7ZDMJf6h5u1stlT7c10EJsYzexoc7yc4Cfbd5p3Z7PZ1w5qswQgpb7QskPpllKWnmEPhBhkKk63dooMCz+BFYySoScN+wczUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966485; c=relaxed/simple;
	bh=OlI8WG42tfYxEvg2uxEiUxZl/W5sVijloq/FzS1zkcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EC4FJQU6hFPHlot2hEWKLkYBULkh7JQGtCBiVZAazn9PhMPaQhLDAx95Yn1rznBL4+wLRbz4MztYM9MPhilibR5cTUQ46ONzu7GBvI79rX7nvto/50YVHszxFiZ7LbSSWzfcZWHiQYK4dxO6R4p74+AmMLWvmSrR/kVJ6eau7Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I0ESq37Q; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0ESq37Q"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cc9b887f1so2188964e87.3
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Jun 2024 03:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718966481; x=1719571281; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OlI8WG42tfYxEvg2uxEiUxZl/W5sVijloq/FzS1zkcs=;
        b=I0ESq37Q88e+G4WwCjfJi/0wd65IzaHnzhmksZ5FrpRZh7j2hjy7zbHCFOKuUa8lQW
         nuACXkXuZPq0gUuQjHoXMtPOgWAB0n7UhJqKpoXO4A3abvIFgusWSNa31aVAxPCdtr2U
         1nAg7IJukpWFp0y/02K6is1G0GMRE0xPzB/JjjZOodJbt0QWSxRg7hwys19oN0qku18W
         eFd6NKd1t3Yl3h4ZLyKGIXLFtWYxZZ8ItSi4Adae8qMh1J4vojnPQSmjcQRvDJ7oq5G7
         mZ4y0y8pA+aE4TXxg5s1V6NElj9ZLTeJe04jNQxyqMmWIwiTx6TzFHs64aUYRaAjuqNr
         k4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718966481; x=1719571281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlI8WG42tfYxEvg2uxEiUxZl/W5sVijloq/FzS1zkcs=;
        b=iT1X9PByvukJ1MeoF8eezutJsibu+Dv79O35XOGvKNbAG5SzYix/VbTJ/Igt+DIDhc
         TLXGPUlSVMr0YTy12zmaWiI4m6eXOndfDA3TR4pDMVZJuo5n1s+/U3tmTMOo4Dbp2HB2
         /qsjp+1pTZEt2Zncl4lTRGf0juSfCR8OMdI/258rNtTWoyQcsOx2+7YVls/4fk4KD7c2
         l/NntVu4rCvjaoMno23VSiLlcKdFbx4jpYc8ARp716+cTwESPZWUv8O10mKAcIWVNLXQ
         l7oj7crL/NCz7YWlGnyfXpdWvwA0VfmCR+4jTdoFFY1iPjedwXCCnlxANvMK/7MM8XU5
         n4KA==
X-Forwarded-Encrypted: i=1; AJvYcCW0KwYnC9ZvdvKtuO+WArKfgkFHl2/y3GukVZBAv4zaEz44QBP+nV0pTwiF0AJabedMG/bX0udZLRuFDmHyvuhrWkpmFd7dBBHl3W4=
X-Gm-Message-State: AOJu0Yyb2l/k4+1nNMrbgJhlNO/iOUNdpnx9gd4FOFxeKrvZORab7q1J
	x/ZY77EIj1gQF+EOmOkKLzlFZnjumHs9RGNJV6r6IViKzHui9/dixkCjaPJTqKw=
X-Google-Smtp-Source: AGHT+IEKqEanpP2Gb1L+htVVw75Q/jC9n63JsCue/e1Dww3+6vlxu4NwaXLBc2+Zx1U7PXEmAvMzvg==
X-Received: by 2002:ac2:505a:0:b0:52c:c156:15c5 with SMTP id 2adb3069b0e04-52ccaa65800mr5359611e87.41.1718966481379;
        Fri, 21 Jun 2024 03:41:21 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248179d8e0sm23456835e9.3.2024.06.21.03.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 03:41:20 -0700 (PDT)
Date: Fri, 21 Jun 2024 11:41:19 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, Jianhua Lu <lujianhua000@gmail.com>,
	Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-ID: <20240621104119.GA285771@aspen.lan>
References: <20240619193558.2543645-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240619193558.2543645-2-u.kleine-koenig@baylibre.com>

On Wed, Jun 19, 2024 at 09:35:57PM +0200, Uwe Kleine-König wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
>
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
>
> While add it, also remove commas after the sentinel entries.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
