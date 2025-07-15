Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2C1F1537;
	Tue, 15 Jul 2025 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622984; cv=none; b=uLzJSyB/MF4bsXSc9t+yVzYuXRGhNXElM4V9TXrFvVHdMa0e65YwxsJvh6YhBSYVOeppKiviukG4/w45PoDtw4/27v+2V1lO4k2XzK0qwNPvzjO+UMPYljvEvDlxlj2WR7zn3Tu3AaKP2jOHB6Jra+9PHtim7fE/Bt5tidYR4to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622984; c=relaxed/simple;
	bh=oIkUYfDgAMBmComyQL46QfRRvvbeCNaERG0b0OclZGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdxQSV5v3EimKMw2RvW4s2OmCbKN1CG+XmS/QKs+3rjh8t67XUNIEnyioc8BCqv8eQkNUO18HCUk/g9vMnf0QdDSpchbxpH60Rf78tyYImfKYJzadpLG5g2/DlBqK7g9+JOr9l7fLZ4aJXGCbeP3Te028XtN8P3591myOwMR1sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzkvdF8/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzkvdF8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D22C4CEE3;
	Tue, 15 Jul 2025 23:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752622984;
	bh=oIkUYfDgAMBmComyQL46QfRRvvbeCNaERG0b0OclZGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzkvdF8/yTgHzxS4GWWzOX3MNf4yT/HYcZnvr8glkE4W0Pxmu1lz7A2uYcEN+XzuW
	 nOVolShmJUUj28oA7KzqfIQmVGgOHB1uSA956PstXl9/dP6eBxTYNrd5zbcDNUCaky
	 mcMRxKlylObJc+6tQ8djX6o71Mw8eSltMXt00dopXLGeGeRZwZwA+15HQq6/KQ31iE
	 HelbunvlA9M9ptdjzLuuVQ+MxVeZbnaucqNQa/LJLrG87dvcuKUp6VCBAhGgcgLnCx
	 pzn3lOi3QgJC46OAhOkiOWujzQ0zWjhRR9bZaJNiECosEvyiX5jUrsjf9lSgiPRbIx
	 jhLz6kvar9zZQ==
Received: by venus (Postfix, from userid 1000)
	id 6D31F180F0F; Wed, 16 Jul 2025 01:43:02 +0200 (CEST)
Date: Wed, 16 Jul 2025 01:43:02 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, 
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, deller@gmx.de, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, 
	fnkl.kernel@gmail.com, j@jannau.net, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	sven@kernel.org, alyssa@rosenzweig.io, neal@gompa.dev, 
	support.opensource@diasemi.com, duje.mihanovic@skole.hr, dri-devel@lists.freedesktop.org, 
	asahi@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 02/15] drm/panel: panel-samsung-s6e63m0: Include
 <linux/of.h>
Message-ID: <67hurwpxz4c2ropgbq3q6umybr2fgucgtbdu4qc6y3qk3uypc4@3xkijgin5ydl>
References: <20250715122643.137027-1-tzimmermann@suse.de>
 <20250715122643.137027-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715122643.137027-3-tzimmermann@suse.de>

Hi,

On Tue, Jul 15, 2025 at 02:24:39PM +0200, Thomas Zimmermann wrote:
> Include <linux/of.h> to declare device_property_read_u32(). Avoids
> dependency on backlight header to include it.

device_property_*() is from <linux/property.h>, which is already
included in the following line...

Greetings,

-- Sebastian

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> index ea241c89593b..930948cb615f 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> @@ -16,6 +16,7 @@
>  #include <linux/export.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/media-bus-format.h>
> -- 
> 2.50.0
> 
