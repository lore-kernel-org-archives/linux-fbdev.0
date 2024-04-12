Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C12423778
	for <linux-fbdev@vger.kernel.org>; Fri, 12 Apr 2024 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948258; cv=none; b=mz71JkewULeh+sqAaIPelHvi0GoSC+cQOkTIXwO3yAz6l4exNo1L6aXiYDvdxFuwjdxQ99oogg7B1s/sJ2ulkWsiKKPpGvJPAXe1coKruCwQ9L5f6BVAODGGK2eoK8R/hL/azBGtr6ekceMvwhMAYjLQHty/dNZ1fe9C7E4JerE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948258; c=relaxed/simple;
	bh=EQ6Lmy5pGSwuV/tq+q7lx5fLarfb7SpMCoGAnUzNdmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUd+6NBmwSmw0rFSzRWzG6ijVUPdnfZoX3By0VUltd3mzFVXwlX1vzqzzVrqPzun/IQbsZGReDgCmtQDeKPQwDu03Np8GOxv2SCBFw3psZ8Ilr/Wyw9C/XqVgSj8YLmR7peSa6evSBrHL9oxdEnt1KCmXGVxsp9JYNjvLYXi6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=heg5wQ1/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="heg5wQ1/"
Received: from pendragon.ideasonboard.com (85-76-16-252-nat.elisa-mobile.fi [85.76.16.252])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 276E99D5;
	Fri, 12 Apr 2024 20:56:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712948210;
	bh=EQ6Lmy5pGSwuV/tq+q7lx5fLarfb7SpMCoGAnUzNdmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=heg5wQ1/OiOxSF4jNQ+5JzQD8R+2hMo3gbGy9lxCC0u/klzDgBZOrGnyLajzoZUSI
	 B9zef6hH+nDHEGxBc0fKBKCekVJdQDIM5bZLWbr2ST6XQdeGWGW9uE4aCPFlhXwq5Y
	 IDY0aB6mBLXZA/DlumEmhGAqj9sGGOGwDG9XPGtA=
Date: Fri, 12 Apr 2024 21:57:24 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, deller@gmx.de, airlied@gmail.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 28/43] drm/renesas/rcar-du: Use fbdev-dma
Message-ID: <20240412185724.GL31122@pendragon.ideasonboard.com>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-29-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410130557.31572-29-tzimmermann@suse.de>

Hi Thomas,

Thank you for the patch.

On Wed, Apr 10, 2024 at 03:02:24PM +0200, Thomas Zimmermann wrote:
> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by rcar-du. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On a side note, I noticed that drm_fbdev_generic_client_funcs and
drm_fbdev_dma_client_funcs point to functions that are identical. Would
there be a way to avoid the code duplication ?

> ---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
> index dee530e4c8b27..fb719d9aff10d 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
> @@ -20,7 +20,7 @@
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_fbdev_generic.h>
> +#include <drm/drm_fbdev_dma.h>
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_managed.h>
>  #include <drm/drm_probe_helper.h>
> @@ -716,7 +716,7 @@ static int rcar_du_probe(struct platform_device *pdev)
>  
>  	drm_info(&rcdu->ddev, "Device %s probed\n", dev_name(&pdev->dev));
>  
> -	drm_fbdev_generic_setup(&rcdu->ddev, 32);
> +	drm_fbdev_dma_setup(&rcdu->ddev, 32);
>  
>  	return 0;
>  

-- 
Regards,

Laurent Pinchart
