Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78252286A8;
	Fri, 19 Jul 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721384279; cv=none; b=P07iSlGhJ+G24dElbjjqAvMggRM0aforQC+f/RVSkRNhbC8xs2f3cwbAQX8kqkA2May1P3BwKzyJ4cy3EhNQi0n3itOyMTEY1tcN1nNWLryTJiZ8X8RXb0g9APPdAmiyezp9VysfBB9pOxPUwyZErngen0lwlc0BYL89Tq9jLIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721384279; c=relaxed/simple;
	bh=ukiKUcHxw6E5rNaEVwCvS99WA1kcaSLZF5/03q4C2lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nC7ZQilBsjjzJtoZgkfzcvlJ2dEAgVqK72OdslcVJYM7fGPYtBjMQG11lIblQ5unyn37pxUZTpHGpk1eUeAkmkQwsDJ7aDlWZ07Q3NPC5KcCb2XmaBUNeoNEjRsfVsK8zOSn7ANLERG9oU1qAq4kM9DxUWLwCiCju5yuOQeaaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcNXBgzn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcNXBgzn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721384277; x=1752920277;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ukiKUcHxw6E5rNaEVwCvS99WA1kcaSLZF5/03q4C2lw=;
  b=TcNXBgznMNPMIZWkNAbKaC1Kc/KfSkKApfEIS0Aow2aaJymWj/M3lJT9
   2WwcmRqji2xo9Ag7Ch0BrzAkZRB/DlDGuyklOGEHnVltlfKuwy9H3YRjl
   UafVW2cbGzXO6zOOugOOUHnVOzHDUtKqPCVCY9MB8n9514g2bV4+E9QmV
   I49tSmh86VQ7laXcd/exOjdPDD7P5VzYl947BJDR+lIWlVBmcjReJD7md
   ScrRSrT8QqxDydySXa+tzt789j0Xk2p2rgXPJN1hRNEYVaM9+lJUc3awt
   ASoTAEMyEH3cdrz4Q6ZIV4vr4uFQWcX3aWjx00/1H4JPbXitlJSepaF7U
   g==;
X-CSE-ConnectionGUID: KRFjwSp5RteC4HHubD7ceg==
X-CSE-MsgGUID: DgXLaOn2QkSzQi1hEN0mwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="19125257"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="19125257"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 03:17:56 -0700
X-CSE-ConnectionGUID: 9saA8r7wQFWiWAUmTXoXsQ==
X-CSE-MsgGUID: pAkOsJ74REG3vMffOwQXqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="74282171"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 03:17:52 -0700
Date: Fri, 19 Jul 2024 13:18:06 +0300
From: Imre Deak <imre.deak@intel.com>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/panic: Add drm_panic_is_enabled()
Message-ID: <Zpo9Xv6wLevidsNa@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-2-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240717090102.968152-2-jfalempe@redhat.com>

Hi,

On Wed, Jul 17, 2024 at 10:48:39AM +0200, Jocelyn Falempe wrote:
> It allows to check if the drm device supports drm_panic.
> Prepare the work to have better integration with fbcon and vtconsole.
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  drivers/gpu/drm/drm_panic.c | 20 ++++++++++++++++++++
>  include/drm/drm_panic.h     |  2 ++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 948aed00595e..d9a25c2d0a65 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -703,6 +703,26 @@ static void debugfs_register_plane(struct drm_plane *plane, int index)
>  static void debugfs_register_plane(struct drm_plane *plane, int index) {}
>  #endif /* CONFIG_DRM_PANIC_DEBUG */
>  
> +/**
> + * drm_panic_is_enabled
> + * @dev: the drm device that may supports drm_panic
> + *
> + * returns true if the drm device supports drm_panic
> + */
> +bool drm_panic_is_enabled(struct drm_device *dev)
> +{
> +	struct drm_plane *plane;
> +
> +	if (!dev->mode_config.num_total_plane)
> +		return false;
> +
> +	drm_for_each_plane(plane, dev)
> +		if (plane->helper_private && plane->helper_private->get_scanout_buffer)
> +			return true;
> +	return false;
> +}
> +EXPORT_SYMBOL(drm_panic_is_enabled);
> +
>  /**
>   * drm_panic_register() - Initialize DRM panic for a device
>   * @dev: the drm device on which the panic screen will be displayed.
> diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
> index 73bb3f3d9ed9..c3a358dc3e27 100644
> --- a/include/drm/drm_panic.h
> +++ b/include/drm/drm_panic.h
> @@ -148,11 +148,13 @@ struct drm_scanout_buffer {
>  
>  #ifdef CONFIG_DRM_PANIC
>  
> +bool drm_panic_is_enabled(struct drm_device *dev);
>  void drm_panic_register(struct drm_device *dev);
>  void drm_panic_unregister(struct drm_device *dev);
>  
>  #else
>  
> +bool drm_panic_is_enabled(struct drm_device *dev) {return false; }

This was moved to drivers/gpu/drm/drm_crtc_internal.h in the applied
version and I can't find that version on the mailing list; imo this kind
of change requires a resend.

Also, the above breaks CONFIG_DRM_PANIC=n builds:

In file included from drivers/gpu/drm/drm_atomic_uapi.c:43:
drivers/gpu/drm/drm_crtc_internal.h:322:6: error: no previous prototype for ‘drm_panic_is_enabled’ [-Werror=missing-prototypes]
  322 | bool drm_panic_is_enabled(struct drm_device *dev) {return false; }

Stubs like the above must be an inline function.

>  static inline void drm_panic_register(struct drm_device *dev) {}
>  static inline void drm_panic_unregister(struct drm_device *dev) {}
>  
> -- 
> 2.45.2
> 
