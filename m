Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5AE14F9E9
	for <linux-fbdev@vger.kernel.org>; Fri, 12 Apr 2024 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948620; cv=none; b=drQ0IfwEq9vvIFUVbfz95cndGLvTuCU2YYbfYId9owXYIZixRuF3k9GY/93U8IEF7is6gCIqoB/SpFRI2xH1cZbw4QEibR4bOdXjAcQCppzXhFr5H3fSf0cluB9YiWNxY60W3G4e9a5nfY7ZsziYYJUEoKrVDREdWrb0T247t4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948620; c=relaxed/simple;
	bh=6g9XhBGjy70BDzvLkZAGHtJoeYxS5XtLt0x8Yh43ilQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdURlpWTEiiZuCKXIhTPdIB+GBj05nCW/vrMgW+c7ZAUluXkCjMtyfHRiopaMD0i3XkBzf4+/u1L6OEt5LeL6nUuSOmu8B9VKtCCTpW68WjOyoY9Xrg7d1PFfRzM9hdrNXYvynDHZ7kp22gFDp7blPxF7eJFdoBp6C98K6ihUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TYYdscFp; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TYYdscFp"
Received: from pendragon.ideasonboard.com (85-76-16-252-nat.elisa-mobile.fi [85.76.16.252])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0831FA12;
	Fri, 12 Apr 2024 21:02:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712948573;
	bh=6g9XhBGjy70BDzvLkZAGHtJoeYxS5XtLt0x8Yh43ilQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TYYdscFpu7/f3LnYDyFlGz5JyIBCNIP0uljw9ZxKLy/zX+BLkGClUv+SgUX+7Lumy
	 xdkFayltMVlv02fyUxegYqVjTJR2brY8Er3ol7EDFEWi1cyykk3Fk97TIUu8qVGgbe
	 r4dlGm4uRdx3NQdYv1ESxJD0/EdASToUvJoaCvuI=
Date: Fri, 12 Apr 2024 22:03:10 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, deller@gmx.de, airlied@gmail.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2 30/43] drm/renesas/shmobile: Use fbdev-dma
Message-ID: <20240412185856.GM31122@pendragon.ideasonboard.com>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-31-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410130557.31572-31-tzimmermann@suse.de>

Hi Thomas,

Thank you for the patch.

On Wed, Apr 10, 2024 at 03:02:26PM +0200, Thomas Zimmermann wrote:
> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by shmobile. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> index e83c3e52251de..890cc2f6408d6 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> @@ -19,7 +19,7 @@
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_fbdev_generic.h>
> +#include <drm/drm_fbdev_dma.h>
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_modeset_helper.h>
>  #include <drm/drm_module.h>
> @@ -250,7 +250,7 @@ static int shmob_drm_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_modeset_cleanup;
>  
> -	drm_fbdev_generic_setup(ddev, 16);
> +	drm_fbdev_dma_setup(ddev, 16);
>  
>  	return 0;
>  

-- 
Regards,

Laurent Pinchart
