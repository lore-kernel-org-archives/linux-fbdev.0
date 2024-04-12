Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9714EC60
	for <linux-fbdev@vger.kernel.org>; Fri, 12 Apr 2024 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948652; cv=none; b=TLmLCU2FetFeYAISyvTS7Uhcm3bC/EUfskBDYjHwXAEgKej9Ww1CopvuYT/iS/2wrnZyTkFAapjUX3MeZhFSwgFrLqi8pA5DKcGeFr/TjseCrenfQCqSjM9nWxAcdWxMd/ZTuz39jkSJlSV+1AIcbZtWC0WB7LwlbFRmLwrYMIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948652; c=relaxed/simple;
	bh=zdkIDE+9ajHMVys+kPtc1f5OSjUsx0ARovuYB12ViKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGfapQ3FrUnlgcnvcKDpsTTH4Vjs4VkZi8AYi6tLaSIouyAEtHEWgw6nMe2HI1QWZwTUC8X5rRTN9IkGX8sbmG0Gzcf0bC+dYLkGsYSHeCAsouwRf3Tia5praejdzznGhQxf7RgNYtG+ny7Oss6bVAjwj7qe7BdtCAPIVscvB9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=F2rzDpux; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="F2rzDpux"
Received: from pendragon.ideasonboard.com (85-76-16-252-nat.elisa-mobile.fi [85.76.16.252])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DF9A0A12;
	Fri, 12 Apr 2024 21:03:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712948605;
	bh=zdkIDE+9ajHMVys+kPtc1f5OSjUsx0ARovuYB12ViKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2rzDpux40nnQ1TNrwgJKN6ocHDZ1bXi5cUYcY9s5Eh9mw3dJnZN2wyGvCz9GLB4b
	 cge79O+uj7t+TFfYD7dvnaTl94Kf2HDuxxbqBDO5MpPHdNH45/4e2w2DmFxmCzwXEJ
	 zrHOlokTsFQjVQO+Thc0VPoPaktoselU/KZizP3g=
Date: Fri, 12 Apr 2024 22:03:57 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, deller@gmx.de, airlied@gmail.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 28/43] drm/renesas/rcar-du: Use fbdev-dma
Message-ID: <20240412190357.GN31122@pendragon.ideasonboard.com>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-29-tzimmermann@suse.de>
 <20240412185724.GL31122@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240412185724.GL31122@pendragon.ideasonboard.com>

On Fri, Apr 12, 2024 at 09:57:27PM +0300, Laurent Pinchart wrote:
> Hi Thomas,
> 
> Thank you for the patch.
> 
> On Wed, Apr 10, 2024 at 03:02:24PM +0200, Thomas Zimmermann wrote:
> > Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> > damage handling, which is required by rcar-du. Avoids the overhead of
> > fbdev-generic's additional shadow buffering. No functional changes.
> > 
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I meant

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> On a side note, I noticed that drm_fbdev_generic_client_funcs and
> drm_fbdev_dma_client_funcs point to functions that are identical. Would
> there be a way to avoid the code duplication ?
> 
> > ---
> >  drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
> > index dee530e4c8b27..fb719d9aff10d 100644
> > --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
> > +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
> > @@ -20,7 +20,7 @@
> >  
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_drv.h>
> > -#include <drm/drm_fbdev_generic.h>
> > +#include <drm/drm_fbdev_dma.h>
> >  #include <drm/drm_gem_dma_helper.h>
> >  #include <drm/drm_managed.h>
> >  #include <drm/drm_probe_helper.h>
> > @@ -716,7 +716,7 @@ static int rcar_du_probe(struct platform_device *pdev)
> >  
> >  	drm_info(&rcdu->ddev, "Device %s probed\n", dev_name(&pdev->dev));
> >  
> > -	drm_fbdev_generic_setup(&rcdu->ddev, 32);
> > +	drm_fbdev_dma_setup(&rcdu->ddev, 32);
> >  
> >  	return 0;
> >  

-- 
Regards,

Laurent Pinchart
