Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8148C8060C
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525379; cv=none; b=pJsJTOMu6wxv25XpjfO0Q9TjIsP5MqA3O+iNB8+H+S8pu7tgg0Os9NmnUmqxPBLFfro+uSrLaPGIccjZrY1yPsdPfuOMZ6+HMLQXPRkWVdrQSmh1mJa4JAOe1aTXFmlHMAc72zHKvJ17mSzYKamtPXL/prJw3t9SZuFzdyr6lRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525379; c=relaxed/simple;
	bh=grKm/2J6jIM4KK7Si4oFqiL6awWeyiiCJE+GsmPyCkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMG0vRJOgM3RMKCOKgyDQ9doZwHHiTgOagjHm2yzLlBwyGV85WWKV0TH7+Oc/RiMnY7lyJC5f+8+0eiyI/TRit/2qV9puz8Q70oOGs8lq/O9DqbOyGbER39HO2eHR7TfV2OSwNFzQ3tSfcu6u6yGMu5F280yoULZ7+AlwWO9afk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qTcH+okm; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTcH+okm"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-344047ac7e4so1838798f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 04:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713525376; x=1714130176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJd9Cm2U697LnBlhHhSEj5YlaO4Yzmz+HEeo9KmF9JU=;
        b=qTcH+okmNS24VZcre1N0NdobWTfz0QYhWyYYwbF63tyCPf7o+tyRXhmV/9Auz1MXbi
         W9I/IEaoQhASgRyD2EQQWz0QT+aaIhrKSJoR92cbvURZtiEz2Z9QPq6/xl3XIzbmYJ6b
         eYGxAIj4v5q9HURtlYGABf7JNEKkwimIgxy5ByI05MjWtEAbl72+jTMK8zNourMPPH5p
         SxPPDFJXTghhes/1cL4kkkLD1PkPR3werliMVUSPtc6u5eh+sZ2UD1jhgdgMxOD+Ept4
         940a3Czjgqulfd+QTfVMyew8VjFAphYjbhGr82Y0TP06SRdEyCD5c8euAPD1OzlM07tE
         O0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713525376; x=1714130176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJd9Cm2U697LnBlhHhSEj5YlaO4Yzmz+HEeo9KmF9JU=;
        b=SrnShbjx0qrAidGAIlrBiFPuFOyF/ESxWu1rRAjhKm8pzZDARJuG/QpXqTrLKmFyWc
         260bMyQR/t7roAvtatCIbPfSK2BSha6QDrj06sp+Qnk+E391yV14THHzd7DYNsPTy8kE
         Np9dwhp08O3/hgbilv8hjN/lmb3wll26Qw6v+CgThBlnlYLRj7dMyS1U2liklm54uAT0
         AprCvi/TrQcsEe6vZds0wT3Gg/JF2crg8N0GIhZc242CqYZpVzm2BTJ0CSKk8bmzPsz+
         gUShgGlYOnkTrQWWInNcxcTpQGDvlg/iiX7CZg2sl0I5R2to81f2PltsedLkUtvvWeMW
         fKag==
X-Forwarded-Encrypted: i=1; AJvYcCV4Piq1qb5lSF+zdQA3oJkbe3irf+SzuAQunACuYJULFZI9nzOjggakLDYTAJavpNf0QUB9kbQofYr5JvA5EGvjfJh7ZCsF+3pxxpI=
X-Gm-Message-State: AOJu0YxQJBHYzYX0ILNSZNdZh+zIjwcUFem5CbWIU3mwBc5qjAAG6Zqs
	qY5FNo4FJX2060CU4oaDa3VHi/TFitZWIIORw/naBr4h7elANbu2hYvwWcvm+Ie69Ol1CjHug7z
	ZNLI=
X-Google-Smtp-Source: AGHT+IE1a4qRWYhPeu0QdfH0dU1eOD7zKO7WosHykWSQF41QV8m8arLjW2fak04Hrze4DKigl/GWSA==
X-Received: by 2002:adf:f447:0:b0:343:d23a:c977 with SMTP id f7-20020adff447000000b00343d23ac977mr4117664wrp.1.1713525375627;
        Fri, 19 Apr 2024 04:16:15 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600001cb00b0034a21842accsm3473127wrx.86.2024.04.19.04.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:16:15 -0700 (PDT)
Date: Fri, 19 Apr 2024 12:16:13 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH][next] drivers: video: Simplify device_node cleanup using
 __free
Message-ID: <20240419111613.GA12884@aspen.lan>
References: <20240418194302.1466-1-shresthprasad7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418194302.1466-1-shresthprasad7@gmail.com>

^^^

Please fix the subject line to be "backlight: <driver>: ...". I came
very close to deleting this patch without reading it ;-) .


On Fri, Apr 19, 2024 at 01:13:02AM +0530, Shresth Prasad wrote:
> diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
> index eb18c6eb0ff0..3c5d8125080c 100644
> --- a/drivers/video/backlight/sky81452-backlight.c
> +++ b/drivers/video/backlight/sky81452-backlight.c
> @@ -182,7 +182,7 @@ static const struct attribute_group sky81452_bl_attr_group = {
>  static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
>  							struct device *dev)
>  {
> -	struct device_node *np = of_node_get(dev->of_node);
> +	struct device_node *np __free(device_node) = of_node_get(dev->of_node);


Do we need to get dev->of_node at all? The device, which we are
borrowing, already owns a reference to the node so I don't see
any point in this function taking an extra one.

So why not simply make this:

	struct device_node *np = dev->of_node;


Daniel.
