Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36684136670
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Feb 2024 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709027239; cv=none; b=OBeaDZ3Ih1tcFNeLjhsI2yVycKP7mzk04g4H38RJAAiZVSTL/a7Z+gsw4ZnkufPkj0Uo+JQZ9Bv90qxQtnZT1+KHCUfY3pYQSHcU7ac3lNj4oJp/rFkd3vfBdSUI+EzLUhhEd6ufkQFJ+Y3kwYlgQGDfLPZGsjuNb8Khv4NOHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709027239; c=relaxed/simple;
	bh=MNowpMoLCLWMpjmmw3bZKPZ9u50KzyxiNPpNpawZ8+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIZyXnQFCCZiraQxgCHzzG6Lhy5PvNEYCNXn8vFM/jTOQHZbeb0R7e/LFAJ1qOTbtQ+VgQxObHYUd5xbboiu0rzW2B4pm6xO+7mN8K79reWSpf6Q8aTVO7QaHTEqWbbZ17y99aLBLb9rTA+OgMI6wLdAQcd84XBbHRD8fzibN70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=SUUjPR5v; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="SUUjPR5v"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id E17CC60432;
	Tue, 27 Feb 2024 09:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1709027236;
	bh=MNowpMoLCLWMpjmmw3bZKPZ9u50KzyxiNPpNpawZ8+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUUjPR5vjxe2udjm9tU5K1+r7QcCdRwl+bwI0dmAa0z3IMs1pmiwTBDWLVdL1ODkt
	 2r9k3Ab+BvzfE4hYHoH4riHPYgTpYb4RDx3yVzhILpt2s4SBvmeyVdToO8+EcexL6A
	 VxvTIEVaEp8taXlri0axQ9tHHavHXN3YXhNUaw5NEMsyiMwd/vBvz7Nj02CBL3xpXg
	 lAV7TRKoXAASK7t8MkoLlmRi3+SMOOshoRYu8O7u5OB1/t1zObthNmkoOk2x9QRmhm
	 DuaDFyKqaHuOiuVGStwX6xaDCzRKmN60RPAd799TXJbVHE9sAVN5s6V6hl8wvLED6D
	 Yydm53i6O+zFA==
Date: Tue, 27 Feb 2024 11:46:51 +0200
From: Tony Lindgren <tony@atomide.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 0/2] Fixes for omapdrm console
Message-ID: <20240227094651.GX5299@atomide.com>
References: <20240225064700.48035-1-tony@atomide.com>
 <43fc93f1-d602-47ae-98e5-ee6be4ea5192@ideasonboard.com>
 <42255362-4720-414e-b442-f98355e92968@ideasonboard.com>
 <ab0b8471-97a6-479a-88aa-9bb25e91fb8a@suse.de>
 <20240226112549.GU5299@atomide.com>
 <20240227070624.GB52537@atomide.com>
 <7d98a0cd-e6d5-460d-8b91-35fa340736dd@suse.de>
 <20240227080146.GW5299@atomide.com>
 <587d60ae-221b-4c02-9891-17dc608009d3@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <587d60ae-221b-4c02-9891-17dc608009d3@suse.de>

* Thomas Zimmermann <tzimmermann@suse.de> [240227 09:16]:
> I just realized the fb_deferred_io_mmap() is already exported. So please use
> it instead of duplicating the code in omapdrm.
> 
> [1] https://elixir.bootlin.com/linux/v6.7/source/drivers/video/fbdev/core/fb_defio.c#L237

Yeah I have now:

static int omap_fbdev_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
{
	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));

	return fb_deferred_io_mmap(info, vma);
}

> I also noticed that omapdrm does not yet select the correct Kconfig symbols.
> That can be fixed by
> 
>  1) creating Kconfig FB_DMAMEM_HELPERS_DEFERRED that are similar to their
> SYSMEM equivalent at [2]. The tokens should look like this
> 
> configFB_DMAMEM_HELPERS_DEFERRED  <https://elixir.bootlin.com/linux/latest/K/ident/CONFIG_FB_SYSMEM_HELPERS_DEFERRED>
> bool
> depends onFB_CORE  <https://elixir.bootlin.com/linux/latest/K/ident/CONFIG_FB_CORE>
> selectFB_DEFERRED_IO  <https://elixir.bootlin.com/linux/latest/K/ident/CONFIG_FB_DEFERRED_IO>
> selectFB_DMAMEM_HELPERS  <https://elixir.bootlin.com/linux/latest/K/ident/CONFIG_FB_SYSMEM_HELPERS>

OK

>   2) and selecting it instead of FB_DMAMEM_HELPERS under omapdrm's Kconfig
> symbol.

OK

Regards,

Tony

> [2] https://elixir.bootlin.com/linux/latest/source/drivers/video/fbdev/core/Kconfig#L147
