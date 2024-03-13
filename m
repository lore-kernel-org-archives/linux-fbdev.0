Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F8B2E822
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327204; cv=none; b=erAqFWgNrKvyCIWStCbVbmY5DveO7d8rnPwGBQks9ahJx25TGKXAHU20Rq1Xw+9liVpVS0qH5+jLfjTl3DyzZKge3yZoJPvL2cmV3cPVNuQRvdlZOjGCLQCo7FUUShnxQdX7ieQ3QiSbHQZSCk5HwoA1++gcpAY4FODAgS5/byo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327204; c=relaxed/simple;
	bh=NeHCxeTpk973W213lTTQgD3AN+9uz6Ld4+6CVfc+fWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFRkyA5084w3oK2n9glDJcioQTEDWf5pfdry87gAXkRuEM1X1oVWJtyWutPVtslB3lcFwSarykqztO8ycAdqTq/CGDJWx5QKptTvCCB5n7MZgJSVdFaKySEIKnRiOzxMJYoiAS6ApEewzzX6p0wW/cusJKkMMMEZDH+0e5Xxk7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66F481007
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 03:53:57 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 531F83F73F
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 03:53:20 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:53:13 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de, javierm@redhat.com,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 22/43] drm/arm/komeda: Use fbdev-dma
Message-ID: <ZfGFmTp__hsQhox5@e110455-lin.cambridge.arm.com>
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-23-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312154834.26178-23-tzimmermann@suse.de>

On Tue, Mar 12, 2024 at 04:45:17PM +0100, Thomas Zimmermann wrote:
> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by komeda. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu


> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> index cc57ea4e13ae6..ffdeec3b3f2ea 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -9,7 +9,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> -#include <drm/drm_fbdev_generic.h>
> +#include <drm/drm_fbdev_dma.h>
>  #include <drm/drm_module.h>
>  #include <drm/drm_of.h>
>  #include "komeda_dev.h"
> @@ -80,7 +80,7 @@ static int komeda_platform_probe(struct platform_device *pdev)
>  	}
>  
>  	dev_set_drvdata(dev, mdrv);
> -	drm_fbdev_generic_setup(&mdrv->kms->base, 32);
> +	drm_fbdev_dma_setup(&mdrv->kms->base, 32);
>  
>  	return 0;
>  
> -- 
> 2.44.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
