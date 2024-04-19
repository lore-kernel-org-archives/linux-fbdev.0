Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58A2651B6
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520114; cv=none; b=nAf7OxBcqTf5UyDyp05I8Gk2m+gS5CpuZQVLJyPpuVqhCegFeHLcOe55oCddNs+WnhbekICP4ve3v6lvKyaJ+X/163J1rJs53hdT67rdTwnnV56t7nOfRJw4YNZH+KlvV0Giv3gJ1eJipJoYOOlIITVasSWImASSVGaekQWZ0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520114; c=relaxed/simple;
	bh=acg674xB0Aec4Rx63OEgs3Tkk0KAIgbgErRLJLmMd4c=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=RZ8nDh4S4mcfP1SqS40MIFQVZiNqX1VpYEC3UySK/FpZuINkWvC3wCm7yf7ylH36xLucnRxTBmWAuNV3ATvusyOcLyGBjPMbvyNU838+90lgCEvMiEgnINq7JbykOduTi8DQj1c/wS7NmTEr61VvqXMMPGrazwFIgG8HdBtzDe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=FuQ8aaWH; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FuQ8aaWH"
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 77A0A55;
	Fri, 19 Apr 2024 11:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713520056;
	bh=acg674xB0Aec4Rx63OEgs3Tkk0KAIgbgErRLJLmMd4c=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=FuQ8aaWHrBkFckFTrhFiuuMEctpKwcHNG/9v5a/4OMlu/mgl/e1F3gkPLGF1UdO0E
	 MggH3ZD5l1pI501Se+vRbe5kzhqE6mv5AMSh/QzrupevJvfuXC4Hyx9yov3+SUoivt
	 wvHJKHIK4Y7TthdubazF+Bs1cmusBk28rd6yq3rg=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240419083331.7761-29-tzimmermann@suse.de>
References: <20240419083331.7761-1-tzimmermann@suse.de> <20240419083331.7761-29-tzimmermann@suse.de>
Subject: Re: [PATCH v3 28/43] drm/renesas/rcar-du: Use fbdev-dma
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de, javierm@redhat.com
Date: Fri, 19 Apr 2024 10:48:21 +0100
Message-ID: <171352010146.2468918.15747857643350071357@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Thomas Zimmermann (2024-04-19 09:29:21)
> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by rcar-du. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

As I'm on Cc, I'm fine with this too.


Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c b/drivers/gpu/=
drm/renesas/rcar-du/rcar_du_drv.c
> index dee530e4c8b27..fb719d9aff10d 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
> @@ -20,7 +20,7 @@
> =20
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_fbdev_generic.h>
> +#include <drm/drm_fbdev_dma.h>
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_managed.h>
>  #include <drm/drm_probe_helper.h>
> @@ -716,7 +716,7 @@ static int rcar_du_probe(struct platform_device *pdev)
> =20
>         drm_info(&rcdu->ddev, "Device %s probed\n", dev_name(&pdev->dev));
> =20
> -       drm_fbdev_generic_setup(&rcdu->ddev, 32);
> +       drm_fbdev_dma_setup(&rcdu->ddev, 32);
> =20
>         return 0;
> =20
> --=20
> 2.44.0
>
