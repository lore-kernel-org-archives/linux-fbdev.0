Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A805210197
	for <linux-fbdev@vger.kernel.org>; Thu, 30 May 2024 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717051212; cv=none; b=rLxSyCUo0tjEUzDm5v+2Gw0nBYXOSpjN4/Z4tvh97Y/ViHMt6z1EC4y6aT9eg+Lf9aooERO2V5weuPUhEQYKcdiaJbgsszsMEiqOPwwhVCMuXSVkrmBdFqxgsDI6SGavJtHT0C7GCwLzcklE2LRy8KGs7S1Hs0V4xUaJRXMf4TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717051212; c=relaxed/simple;
	bh=ylScWtRnNsvzxfLN7SlSXfogkUEyR/tv1L2cL+EG+QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuqYVZQOAFF20zS+ZqHLii8u0DE4bpS5M5nrRHQaeYMaFyEjK7nATe8J1dCgb1HiNz5rCnzC5fHmXc4FlspmBT1U9oOVDmjBOL2GvtSAHj52hp/5vu8MiyjIS4JacxoMnKtXXvQ5d8CS3M14H7kO1MlRUM1l1oxfVruNFHsLUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jdItoEE8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdItoEE8"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5755fafa5a7so510867a12.1
        for <linux-fbdev@vger.kernel.org>; Wed, 29 May 2024 23:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717051209; x=1717656009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hbYS8lpXExj7GV7sixwHtaV70JUaIYUrLKDua6V9Rwg=;
        b=jdItoEE8ukXj3bDxNj0BLRK+V5SxlP/UMUv4C7f4inSddLFjxjXJ3CUpH2Xj7S1y1A
         dmLygG6qgGwSDVDnVZPLUi6n0B+7CuCWRhsykN1AfxDXYyEnHamAtth6/VpwOgiEbGIg
         3trUkj4k2Isgp6xs12aSZo4hBZhXPgdGHhGGTnHj/4hPMqMv8NdmTZs32xSeSoeaf50a
         pM2ujgMul60x2hc4ljghwV/Og4YTnUDJAvbd/uGLIwPXW05lWgoezCD2l6ftyP/CGToD
         58sie2vvhDcav9Mz2JPpgy2D/v5aTaCuC8HWKkXmwe+XyvUtGw7CCO5tNo8nUruouqQO
         72PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717051209; x=1717656009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbYS8lpXExj7GV7sixwHtaV70JUaIYUrLKDua6V9Rwg=;
        b=CMPbt3FXmbflz4zK1uDPkK7TkqDXH1xmdDq3yyg48Utj/5Y660mU/4Pa3icPR1klZl
         lbR9Dp5ZjsXV2INcYLZzECpxE3IRYCvqFn/RKZFMWNXeYMK+ao43Cg1LSwx3PBRZL+Kj
         GFXIwHXIq40egqdpIO92X7fwDPGoHKMph33LALvc9EZ7FYkU3ET9Dt3bLsbShTMbVMYR
         J2lB8K498Boe5Nui3AETb3+CSKqBqDx29CZGv4kKa2nM+1u3kmTI0prEJbi/hqE00s1/
         Flccj/RA4Etdaj6UeJBeYv7OELkIH0vuV3LXwnXVA8/IErFjnG+PkeVfwgMJQpimi6za
         ZyAA==
X-Forwarded-Encrypted: i=1; AJvYcCVDIJ0npyS2Md2qLAXl6PGBYQqVyDSjnCFLXKnGEpBcXQ6jgtP0R4qg/b2DRmNIbmU6c4Xw60n9K2qcOroJPtRY178O14SD4djcUjk=
X-Gm-Message-State: AOJu0YyaiYGskK5nifJrwBIvTIMZ5HvRispBv22jsf+qveJh2eQrxFt6
	7qi56V4NKhxHNj8vuQHxO+VaA2CtdYLr3PfHO1HuPGGFIFi/ZgsdcWVGO95eX2A=
X-Google-Smtp-Source: AGHT+IE6/VTwKZTsEcVkjHDXiwR4jbhWUjQNX+Zpjmyoqeke5OVHzCiHycLfInR8VWcYgsER/P3wXg==
X-Received: by 2002:a50:9316:0:b0:579:c2fe:886 with SMTP id 4fb4d7f45d1cf-57a177b15b9mr645619a12.14.1717051209214;
        Wed, 29 May 2024 23:40:09 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d69b49basm4770207a12.88.2024.05.29.23.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 23:40:08 -0700 (PDT)
Date: Thu, 30 May 2024 09:40:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Lad Prabhakar <prabhakar.csengg@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Rob Herring <robh+dt@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	coresight@lists.linaro.org, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
	linux-media@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 7/9] staging: media: atmel: use
 for_each_endpoint_of_node()
Message-ID: <f0f1b989-2166-44ad-ba70-caf56a4d93c4@moroto.mountain>
References: <87le3soy08.wl-kuninori.morimoto.gx@renesas.com>
 <87bk4ooxya.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk4ooxya.wl-kuninori.morimoto.gx@renesas.com>

On Thu, May 30, 2024 at 02:06:22AM +0000, Kuninori Morimoto wrote:
> We already have for_each_endpoint_of_node(), don't use
> of_graph_get_next_endpoint() directly. Replace it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  .../staging/media/deprecated/atmel/atmel-sama5d2-isc.c    | 8 ++------
>  .../staging/media/deprecated/atmel/atmel-sama7g5-isc.c    | 8 ++------
>  2 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/media/deprecated/atmel/atmel-sama5d2-isc.c b/drivers/staging/media/deprecated/atmel/atmel-sama5d2-isc.c
> index 31b2b48085c59..3b28a232418a9 100644
> --- a/drivers/staging/media/deprecated/atmel/atmel-sama5d2-isc.c
> +++ b/drivers/staging/media/deprecated/atmel/atmel-sama5d2-isc.c
> @@ -333,20 +333,16 @@ static const u32 isc_sama5d2_gamma_table[][GAMMA_ENTRIES] = {
>  static int isc_parse_dt(struct device *dev, struct isc_device *isc)
>  {
>  	struct device_node *np = dev->of_node;
> -	struct device_node *epn = NULL;
> +	struct device_node *epn;
>  	struct isc_subdev_entity *subdev_entity;
>  	unsigned int flags;
>  	int ret;
>  
>  	INIT_LIST_HEAD(&isc->subdev_entities);
>  
> -	while (1) {
> +	for_each_endpoint_of_node(np, epn) {
>  		struct v4l2_fwnode_endpoint v4l2_epn = { .bus_type = 0 };
>  
> -		epn = of_graph_get_next_endpoint(np, epn);
> -		if (!epn)
> -			return 0;
> -
>  		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(epn),
>  						 &v4l2_epn);
>  		if (ret) {

This introduces a Smatch warning because now "ret" is uninitialized if
the for_each_endpoint_of_node() list is empty.  Is that something which
is possible?

I've been meaning to make a list of loops which always iterate at least
one time.  for_each_cpu() etc.

regards,
dan carpenter

