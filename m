Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A221019B
	for <linux-fbdev@vger.kernel.org>; Thu, 30 May 2024 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717051063; cv=none; b=AcF5C4vAEudYhSKR/aj6eA7RyjisGWUH37Gf9Og3p1lvASQIkZQHTTza1RgtdLkjp01AK8Srl2fHtzc8MiBoaCkhReM+0O3+U5Vk12dZC7wj13fBKAtMQG2nJoTyyidodyS7yqP0v3OOiNTrSqFO0c7/SoOEUBW6Jy4mTMAr5/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717051063; c=relaxed/simple;
	bh=XiJPjIhtnRRi9k4YOJ1yFXpTdkcwoF0URO6vqm11YzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1hPahu91XZFzys38b1NXw+UMns/qk1X/P2c3bAlrvI34oJ/YF4MChwxMWznpDrrM3peolnCN3q9r9qcyX7SsScTNhcaLAaDE94PNLTKIx1Y8+kr/tpiMkwLp97TF08hxEJzGwxVfJ5OjCPdFhkxhsbcHIHLqQE/hQncFU56Yq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IA2M/gXk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IA2M/gXk"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a033c2ec2so420532a12.2
        for <linux-fbdev@vger.kernel.org>; Wed, 29 May 2024 23:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717051059; x=1717655859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kPh8VLFqGiI+tH1uAPQnmuZ7TXsqcVMc+OlD3shtzK0=;
        b=IA2M/gXkfAn5A2Og5sppkKe45IzgLvdzcFnt75iI+0R67t5lLTAwLnaE1CS7aHc/aT
         2WeflGsKx4fwbRcLvJybs8w4tPOq4o8Ugl8bqzHRplw7zDe/6LA2ofrPjDDGYIczyN5K
         IJk9n1qeeEzwCGy8IDSLvQoHvDg59kSmxWMHtWJnWWE884OWHN/VUnbfHcwpsfZms8M2
         siArbLwxEP6KTve08HgylwttIrX9GlqZSHp6KlnhN7z986e54v+vTfBH0n6NGWs7ptLr
         BOHY0wtEW41paq2zGm7uFUsKSg+lKW4RmfkP0KKa9XE7VPzWE/798iBeRoOe/v9P8PC1
         R1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717051059; x=1717655859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPh8VLFqGiI+tH1uAPQnmuZ7TXsqcVMc+OlD3shtzK0=;
        b=uqyeRwyF07aHxRdXRjkaNSTJVsZ2wL1j+uEU/bYp/I08oaO3wBKgG6XKMxhSbTUZr8
         nPizUBWRJNWtdOUu+MGNn0G2PhakDvczM6o+iHFR3OF74XGsFwW751Ahemn17UbSKb8x
         S8KLRlmuZrphgTJdUz2ejC8rrbub3Z93JyfC+md4GfXL0pA2+c81czxaLVtkwjCLZp8Z
         1Zc0AXtC4rNYnCGx6Fvn4rNGyOIIumkT1rB5cpcvbmMTdqMdccyWSz03CPlXRXxR9UyQ
         DvEfvUsJwm/famYoC/Fq9WU1qVPxpeR2AI+VaO1FMFiCTfAsZ8f1Hm1ML1UqEISNQcjp
         dPvg==
X-Forwarded-Encrypted: i=1; AJvYcCUNKDkOlAss0b4eWAbOBbnv15YY45xQrOsFG2+yj8QIcpc9lDgmerNhLOyYDIC3lM6klRrCpH9Bi3ZsJ3JfH0RlvhDiM2d4fzJllEw=
X-Gm-Message-State: AOJu0YyM0KEJ+TUUb6TWxHhphHgpfTU3giURD9wLs7scqsma5Xz/WKz/
	+EoG+404d3ETyIb0MI2jp1fVu4l2NWgbZelA2fqW8+eB8tkQZBSnD8wNcOqfpT4=
X-Google-Smtp-Source: AGHT+IG58ojdsX4BmxtP/Bpc7KHEVVJgxF4twZVOBR7WGhJA36YAA2YN/IutMaNtxo384yPdBxYKtw==
X-Received: by 2002:a17:906:6a1b:b0:a65:ab25:24da with SMTP id a640c23a62f3a-a65e8e4c925mr88419866b.22.1717051058980;
        Wed, 29 May 2024 23:37:38 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc5150fsm785325266b.102.2024.05.29.23.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 23:37:38 -0700 (PDT)
Date: Thu, 30 May 2024 09:37:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Lad Prabhakar <prabhakar.csengg@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>,
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
Subject: Re: [PATCH v3 4/9] media: platform: microchip: use
 for_each_endpoint_of_node()
Message-ID: <330e0f46-567a-460c-ad88-1f6acb2c2fe4@moroto.mountain>
References: <87le3soy08.wl-kuninori.morimoto.gx@renesas.com>
 <87fru0oxyq.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fru0oxyq.wl-kuninori.morimoto.gx@renesas.com>

On Thu, May 30, 2024 at 02:06:05AM +0000, Kuninori Morimoto wrote:
> diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
> index 5ac149cf3647f..60b6d922d764e 100644
> --- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
> +++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
> @@ -353,33 +353,29 @@ static const u32 isc_sama5d2_gamma_table[][GAMMA_ENTRIES] = {
>  static int isc_parse_dt(struct device *dev, struct isc_device *isc)
>  {
>  	struct device_node *np = dev->of_node;
> -	struct device_node *epn = NULL;
> +	struct device_node *epn;
>  	struct isc_subdev_entity *subdev_entity;
>  	unsigned int flags;
> -	int ret;
>  
>  	INIT_LIST_HEAD(&isc->subdev_entities);
>  
> -	while (1) {
> +	for_each_endpoint_of_node(np, epn) {
>  		struct v4l2_fwnode_endpoint v4l2_epn = { .bus_type = 0 };
> -
> -		epn = of_graph_get_next_endpoint(np, epn);
> -		if (!epn)
> -			return 0;
> +		int ret;
>  
>  		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(epn),
>  						 &v4l2_epn);
>  		if (ret) {
> -			ret = -EINVAL;
> +			of_node_put(epn);
>  			dev_err(dev, "Could not parse the endpoint\n");
> -			break;
> +			return -EINVAL;
>  		}
>  
>  		subdev_entity = devm_kzalloc(dev, sizeof(*subdev_entity),
>  					     GFP_KERNEL);
>  		if (!subdev_entity) {
> -			ret = -ENOMEM;
> -			break;
> +			of_node_put(epn);
> +			return -ENOMEM;
>  		}
>  		subdev_entity->epn = epn;

This code is an example of what Laurent was talking about.  We're taking
storing "subdev_entity->epn = epn" but then not incrementing the
refcount.  Perhaps it's not necessary?

The difference between this and _scoped() would be if we stored epn and
then returned.  I feel like that's less common.  We could detect that
sort of thing using static analysis if it turned out to be an issue.

regards,
dan carpenter

