Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7436EAAE
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780052421; cv=none; b=V2aarw+HybQX4qmTPprS3Yl9HosAKCY3sDnyGQ15+NZc9TM+dwqupCGfhIzNQcw52iVlLc7jb/uj4xSvmLaNfG9BvdYeWDx5G6GN+BlEsJmBl6Ga0wInN+n+qQJp69aEom3fM3cN3xGXkglxZhRJayMh/BMfsSgqvaW+79u1i8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780052421; c=relaxed/simple;
	bh=6hUd2Dp3mbUUsH0uJSobaZD75vru4SnrNxnw5Brg8sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5rnjOjvs8Zc3rxJ9YgGA+vnK9AkEc4aQ1LAR/GfzfFYWH6cEu123IRaiD9Ue5x06B8fIuig3ivPelhOrhF6zsty7mc40vmVlGPlJP24kABRpBl4AipuNWI/+ZD+WgWDtJm+NKQU9rUu5H0HzWT+RaHDOlX7dxCjna1Eg+Q+/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=EBTl19xW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="EBTl19xW"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so87858615e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780052417; x=1780657217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=18we3XaF38yQ3wAMs5IOP6Gxb6jY92eB45OuWFEEzvE=;
        b=EBTl19xWHiPWCO7Nczi0mwTNG6EQHjljhLEWvLhlgFCHXAGByJCxzkfO1ZY2HoVauu
         DHjoLRpG30HBnJjGsufGCVx7ovs09PcOQAmjy2inMDQf6eSetlZV2Wc/z7pqWOAOID6M
         XESmr+oqX2g32vSRhprYdCAliIEucCsN4RTemaK4l8icZcWDHpQgjcvlYjynJtLRL5vL
         8zmuIxUMy5uvcsatLW1qQaW6ydbP7winGOMB1M+7P2hL06SzRPkOLX7aDugyB9RTwQd7
         2I3kBTAb+lod36BoDU7xXXSN3LiM+KvFekOYgljs+DSvVqQP+xB6VdNevjAQhMgK8zkA
         TNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780052417; x=1780657217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18we3XaF38yQ3wAMs5IOP6Gxb6jY92eB45OuWFEEzvE=;
        b=CRCYskfjAs1x3lBAuaz5nI43kBwKCVoWTpKgHDPHGX265+gvML5Qxv0Blq4mNkbtBV
         8ADGnrlPhksNHmvI71zBMAFPWHx+QicDHHKnJUp0Ks4b9cSL8ADNzmBoPvCKVnEytFDt
         TRD+EM83ThP42pSG5PIi16lyo1sDaOHmE73BHBozCOyK+lgw7uPGx9VbKlfD6Ms4gUpg
         d/n3gnOxm6oD+SvqiidyjoDe8ZSsNgUmImersfMmyKz9yxII4YXmiY8OpZ+POv3V3Pzr
         QbYg06lEEgAtOLHsJrmEYOD67tW1RdGH3TKLq6IEhJlXJL5uE4ZpWDx2mN3cvNQDMrFQ
         Yk+g==
X-Forwarded-Encrypted: i=1; AFNElJ+JlfivxDYEW6BVTARnS6LQ9UeSFP77r4DvnDxn3v0TxZxtmyvbkSK/6fCeEP0IAeWnehncKjWO4w9BDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Z37WFsgcDItf24RdgwVYaeGDiYPT2pTukoo7weYxZLK2Wskf
	usxu71luDri2b+QiCegv9UpHibKS0n8UNP6SyuM1LAWVTFfmISLEL7bhVNv5J9alyKU=
X-Gm-Gg: Acq92OFQ98bRmNaou06BNi7lthtnITzDyeXWE2tKmD3Qq0JCbfdApgmyjRR/VIJrQd6
	91sovb3XpwVj88XkbQR1f+qsV012oGNQRBYzShRE9RGxCcVAz29C/XuM2DSWwvyER8/H8ziiKoT
	WAntNB6mhNVwWwWv34PvqgUIJD7vizu0clReCrKuOr6KI6Nn0YL9qpn0kiYMjyJPue5gvTLDQZG
	D13OygmjUTp0j1Qj/mtP2K4+SzQGHMm+kAlfFw6qq0BKho894SVKVDoyHhlPVX2uy5i+w7jIret
	+cvjDL3Ap3b0sXwA+iVqfY0DRmJLcBW2VMG2npkNDKzs58VLmU+7JFP/xvv28effSkx8KZdpFe1
	IIIH8HC3kDO5AUoLbMltDJ3KRxb3bQprtB/90y/bdyxhNBbVBd3e3A1sA25Mjt+qSSepqamnzFP
	nIts8TMTU5xWwMH2ZHELbRjIvHqy0P9Of3SIxa7c8v77SdXKF86caiR/mvSYebChOZtfzyE2WRE
	EBnqocrAFMPNGMDt4i6dlCa/DLRA+fYrYPyhz5Bq75hbzEOs8V0maBmIKDcg1mMCtG8tZZJ5NDV
	KU8qfRxK1I6MMchZqxF2lX+XC5wEKQ==
X-Received: by 2002:a05:600c:630f:b0:490:845d:652d with SMTP id 5b1f17b1804b1-4909c0ba3dbmr44464495e9.15.1780052415386;
        Fri, 29 May 2026 04:00:15 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6975e2sm49548585e9.6.2026.05.29.04.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 04:00:15 -0700 (PDT)
Date: Fri, 29 May 2026 12:00:12 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 2/6] mfd: lm3533: Convert to use OF bindings
Message-ID: <ahlxvGRVFDFrTUN3@aspen.lan>
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528135123.103745-3-clamor95@gmail.com>

On Thu, May 28, 2026 at 04:51:19PM +0300, Svyatoslav Ryhel wrote:
> Since there are no users of this driver via platform data, remove the
> platform data support and switch to using Device Tree bindings.
> Additionally, optimize functions used only by platform data.

The last sentence is a little vague and makes us have to hunt for the
changes in a relatively large patch. If it is referring to the change to
common up the init and update code then it's would better to say that
explicitly!

> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/iio/light/lm3533-als.c      |  95 ++++------
>  drivers/leds/leds-lm3533.c          |  51 ++++--
>  drivers/mfd/lm3533-core.c           | 268 ++++++++++------------------
>  drivers/video/backlight/lm3533_bl.c |  52 ++++--
>  include/linux/mfd/lm3533.h          |  51 +-----

Just one comment for backlight, below:

> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
> index babfd3ceec86..42da652df58d 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
> @@ -295,13 +293,20 @@ static int lm3533_bl_probe(struct platform_device *pdev)
>  	bl->cb.id = lm3533_bl_get_ctrlbank_id(bl);
>  	bl->cb.dev = NULL;			/* until registered */
>
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-%d",
> +			      pdev->name, pdev->id);
> +	if (!name)
> +		return -ENOMEM;
> +
>  	memset(&props, 0, sizeof(props));
>  	props.type = BACKLIGHT_RAW;
>  	props.max_brightness = LM3533_BL_MAX_BRIGHTNESS;
> -	props.brightness = pdata->default_brightness;

Given the big changes to the driver is there any chance of putting a
good value in props.scale (BACKLIGHT_SCALE_LINEAR or
BACKLIGHT_SCALE_NON_LINEAR)?

If the difference between 50% and 100% *looks* like 50% then the scale is
non-linear (since humn perception of brightness is not linear).


Daniel.
