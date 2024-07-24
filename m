Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63B315B10B
	for <linux-fbdev@vger.kernel.org>; Wed, 24 Jul 2024 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837797; cv=none; b=rOY7vqh2IFidvBMpJ9SGTF/tId0zrTzWEBcPWpsEVlbLthBf2Z8Y3nUZwVg+tOIoaLqC8hRyu3MZh6Rch8Ch0vyJOhE7TRWsE2XZIRgWDPnIwL4gyIMt6dGaO0aYGK//Ek47ikkPSUMmmBy8ds8wKf67Nhn7peznIdVarRl4VlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837797; c=relaxed/simple;
	bh=y7Zu/VsvUJKkKsJYtAY7jVUswzsmYdNVgKKzorX/Y3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFbz8KvSmsYRkpY4GuUhcXOy7yNhYOioTJEIBNsoVog+FFFIDS/WHkesg1rwg9NUB99jjUzvSIxX7mmIpdp/mVt5FNV0rOh2HV+k+MPjNQWcH/SdkPBlbVJAIgNVPivJh2ZEczDkOVNOyIC+JyWQAuymW18mcbc1bsnQerBINoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HXEydHHf; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXEydHHf"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3daf0e73a62so2511787b6e.0
        for <linux-fbdev@vger.kernel.org>; Wed, 24 Jul 2024 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721837795; x=1722442595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKtTi6J8HEB5OCpZPgPDE9GsqwJqSTtYQpQ+3Zz5BCQ=;
        b=HXEydHHf5hAja8lNwp7WB+4JsNxlT/2EtrwZeo43CxK61FqL9sHk+RyW/CarJ6EI0/
         pM7yPIIVJdaiVhowJZehJYQsSynGdgek6Sw/injmH7loXyrpsy+VGbbAR0rhLyjrM7Jz
         xz+ZtyF1jTOz8hL5n39JeZKE1fJJqILKK8P2dXxzmIUK8p/pjEGDH8h2j3mtmOuEHgGD
         rmE+969VOZo17qO/kyZGTMcE817bluOC7zaSZ6bgHpqeK4RIIpSAHDKZ3EX+Koj8x9up
         Iw8+t5+oE/ftjhzVIzuS1qfjmuJjIHXawCGXErdb07guX8g58dOGridu+J7zqtavHK4C
         QqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721837795; x=1722442595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKtTi6J8HEB5OCpZPgPDE9GsqwJqSTtYQpQ+3Zz5BCQ=;
        b=aElXC1Lqqb4QYzEqrEGkfPFv7G1z6ljcVpTgCxypSFbeAVOctDphkANRYj1skIy7MV
         /2ZyIC9IrhYaaSSd9Mh2P7TNwrlJ90CiEeeG36Mc18s7C9m2tCjc7q30eFj2t1he9TZE
         VvyEIZkE/d5O8BvM6/U4804ucb9M25GqSJBhL3vpkAtucxp98Y/XLC717rO93uoSQNuy
         XT7MoA2kMmRBoV5sXqEK8tvePFS1+J0+9Iv+OAjh5vF3g7Q5MI3GMt7tguExB7tzL8yI
         2R4gZ/YMhVm4LHrAEBvNdT61wpz6wfrofqFQ7QCz/3vWCJKhJwcI/vviDoJwVZrLQ0g0
         7u8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZnhwSMjnvJcu0cQRc65odgoqpkuogiH6PwqPXqCNBg+zR4Wqpr3eHuBN+0qObcmxer3kxWs9IoG0zBy9Vm3/SZ0on8P7wo6qpb/E=
X-Gm-Message-State: AOJu0Ywz9fJJQSoCuikbRgqQtPxclgsZ+rDI6Q0QXzbAr8mi1Js/ziK1
	NquGaqzyL9NK/wqtU2IUNBh33lCPuFDHzGl6gdUHHT/Nulww+dDqmVAek7R3NF8=
X-Google-Smtp-Source: AGHT+IGL4mtwKdB32MSZ63+5s36lNy2nWouLYk/6/hosNV4rfjK0ChpvX+4v525bHV4bv4C5KpXHyg==
X-Received: by 2002:a05:6808:2002:b0:3d6:71d4:e90d with SMTP id 5614622812f47-3db110cb758mr36565b6e.50.1721837794749;
        Wed, 24 Jul 2024 09:16:34 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:c022:78f5:6e53:c844])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dae0990123sm2442748b6e.30.2024.07.24.09.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:16:34 -0700 (PDT)
Date: Wed, 24 Jul 2024 11:16:32 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-media@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Steve Longerbeam <slongerbeam@gmail.com>,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 2/2] media: imx: vdic: Introduce mem2mem VDI
 deinterlacer driver
Message-ID: <5aab2235-76cd-4fa6-8957-aed35e83a95e@suswa.mountain>
References: <20240724002044.112544-1-marex@denx.de>
 <20240724002044.112544-2-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724002044.112544-2-marex@denx.de>

On Wed, Jul 24, 2024 at 02:19:38AM +0200, Marek Vasut wrote:
> diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
> index be54dca11465d..a841fdb4c2394 100644
> --- a/drivers/staging/media/imx/imx-media-dev.c
> +++ b/drivers/staging/media/imx/imx-media-dev.c
> @@ -57,7 +57,52 @@ static int imx6_media_probe_complete(struct v4l2_async_notifier *notifier)
>  		goto unlock;
>  	}
>  
> +	imxmd->m2m_vdic[0] = imx_media_mem2mem_vdic_init(imxmd, 0);
> +	if (IS_ERR(imxmd->m2m_vdic[0])) {
> +		ret = PTR_ERR(imxmd->m2m_vdic[0]);
> +		imxmd->m2m_vdic[0] = NULL;
> +		goto unlock;
> +	}
> +
> +	/* MX6S/DL has one IPUv3, init second VDI only on MX6Q/QP */
> +	if (imxmd->ipu[1]) {
> +		imxmd->m2m_vdic[1] = imx_media_mem2mem_vdic_init(imxmd, 1);
> +		if (IS_ERR(imxmd->m2m_vdic[1])) {
> +			ret = PTR_ERR(imxmd->m2m_vdic[1]);
> +			imxmd->m2m_vdic[1] = NULL;
> +			goto uninit_vdi0;
> +		}
> +	}
> +
>  	ret = imx_media_csc_scaler_device_register(imxmd->m2m_vdev);
> +	if (ret)
> +		goto uninit_vdi1;
> +
> +	ret = imx_media_mem2mem_vdic_register(imxmd->m2m_vdic[0]);
> +	if (ret)
> +		goto unreg_csc;
> +
> +	/* MX6S/DL has one IPUv3, init second VDI only on MX6Q/QP */
> +	if (imxmd->ipu[1]) {
> +		ret = imx_media_mem2mem_vdic_register(imxmd->m2m_vdic[1]);
> +		if (ret)
> +			goto unreg_vdic;
> +	}
> +
> +	mutex_unlock(&imxmd->mutex);
> +	return ret;

Since it looks like you're going to do another version of this, could
you change this to return 0;

> +
> +unreg_vdic:
> +	imx_media_mem2mem_vdic_unregister(imxmd->m2m_vdic[0]);
> +	imxmd->m2m_vdic[0] = NULL;
> +unreg_csc:
> +	imx_media_csc_scaler_device_unregister(imxmd->m2m_vdev);
> +	imxmd->m2m_vdev = NULL;
> +uninit_vdi1:
> +	if (imxmd->ipu[1])
> +		imx_media_mem2mem_vdic_uninit(imxmd->m2m_vdic[1]);
> +uninit_vdi0:
> +	imx_media_mem2mem_vdic_uninit(imxmd->m2m_vdic[0]);
>  unlock:
>  	mutex_unlock(&imxmd->mutex);
>  	return ret;

[ snip ]

> +static int ipu_mem2mem_vdic_querycap(struct file *file, void *priv,
> +				     struct v4l2_capability *cap)
> +{
> +	strscpy(cap->driver, "imx-m2m-vdic", sizeof(cap->driver));
> +	strscpy(cap->card, "imx-m2m-vdic", sizeof(cap->card));
> +	strscpy(cap->bus_info, "platform:imx-m2m-vdic", sizeof(cap->bus_info));

These days strscpy() is a magic function where the third parameter is
optional.

	strscpy(cap->driver, "imx-m2m-vdic");
	strscpy(cap->card, "imx-m2m-vdic");
	strscpy(cap->bus_info, "platform:imx-m2m-vdic");

Shazaaam!  Magic!

> +	cap->device_caps = V4L2_CAP_VIDEO_M2M | V4L2_CAP_STREAMING;
> +	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
> +
> +	return 0;
> +}

regards,
dan carpenter

