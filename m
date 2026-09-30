Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F013D0BEC;
	Wed, 30 Sep 2026 06:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749963; cv=pass; b=nGaoPSSDQ5nWix1V0G4Au4tns/ORRJDDbpHIIQA+SqDgIckJcAtX4QnkzBCkkmCFbhzfGap3QJ5yLV3laGkHxKRs+stOjWGPi0yFkoc4Yi8OUg8xgG1aiQdAh5Kd8wma0pzAl2Or6YIj1DD/etLTCF8q14fz7x/Oe7M4aTWlfbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749963; c=relaxed/simple;
	bh=fraJiAsIooHaKwkP4MQRGKPRqp8rVGzl961dSNpIISc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOfhuxS/J6VrRZLC4HqVx0iBvRIEEXNv1GlcigPfvKA9TWsacVuj/phFjWbMycexQboRJxFG6/iUvlGNFyK44I3SGVCgnxao/OC7GPVMENFfq6rIYTKqxk56sfNWDzVoG74nsKv2VXHU728VjZwII+heBIPNFDRqOM0SbJZtqv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=wZdrdCl9; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=Pgv2S4p/; arc=pass smtp.client-ip=185.56.87.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="wZdrdCl9";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="Pgv2S4p/"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-5kj8.prod.antispam.mailspamprotection.com; s=arckey; t=1790749958;
	 b=MK21rD5nxDaCzsQXyuxIagyCVLQuGeILxCuOfpSMGRfG5fZj+jJdnHM7YoAWAzGRuBPIQ4FHf+
	  4hxX+Pp49vXhtPyq/eQz3HbcHtACHNVdyTWIOeTap6iFK2GeXd3dvnXddjVfLx5pdMhEw1t6zQ
	  75qZ1XzlN9s70xVcvBa5gtObJfxTq3pvws175a71rk96mrIOFlTzMALeSdVlphlmC6t7Cr9270
	  H9c9BhpACKCF2lpfCVphiDyLfUGB9eIofYcZdTj5aYUWo8nnrB35cykcGIaTGNiyZ0FPNat6AX
	  BFPN08vLar+cm3EECzmehKhBu8MHFNWZJAEQdehPHumKXw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-5kj8.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-5kj8.prod.antispam.mailspamprotection.com; s=arckey; t=1790749958;
	bh=fraJiAsIooHaKwkP4MQRGKPRqp8rVGzl961dSNpIISc=;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	  Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
	b=t8SLfBlc99MNfOMV1MPTjqq6TnRlksUNL9GP7IZBJ9seCQ/u8rO2PnsS1V0InUdazrq7ANhOkx
	  LEXsdqwWn3RxwYZ2itPUDdJgnAceNYmpow/Y6qrTFCGePww6uCaciToT8WAPY6OUNgMUTi35N2
	  v7yF3gkTcC27x99cy1LkssWWWLg85HB8RuwBUG4gm62Cv8Cs4YEM6bbWsoAHOiKdDZLmihx9ff
	  Fzcu3QtExgvQiShyF33zZKA0zWNv+isegwZL2SKNb5LHwqUJRNgb/IjlB4mGvxbIchpKV1klop
	  OZjl/GX5VLaEbOTRKekYdzn/g21/ZSoegw52rwG2I6yvkw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
	:From:Date:Reply-To:List-Unsubscribe;
	bh=vfBHxdNa1POFeFP8vaAw0Rs93HzFAT2Fl4oprPlHcmU=; b=wZdrdCl9a6UBsuIN4JrKRgkp/P
	9jFDb1QvEpzsxjKu8ZwIU/+QK1l8T6eZ6BqkGed1ZVlySiOaX4BmYZ830eYHR90fD7FEJ19sT4DOj
	gOBgLR/R486A+xOHWmEJuu9M0fKFxRT+RliiqrwT4eSY22RSspBSoaqd7T1qB/vsKCsg=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-5kj8.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBnrc-00000000CpG-33Wt;
	Wed, 30 Sep 2026 06:32:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=vfBHxdNa1POFeFP8vaAw0Rs93HzFAT2Fl4oprPlHcmU=; b=Pgv2S4p/yJ6Z9oAD8eGWvUm+vf
	ZdkiWqv78PPj6IHYCFLP8ZPHdUyP2P2I1IXxDBasT2hdQoxVelScvSKS4NkwfwzGxMTMSbS52WKtR
	lpco7utODND+XeZXKvlSdU1tvANzL8K7ty/sg2n2TuP+MCq7BZr3r+YLKMyRf5qfWaJY=;
Received: from [87.14.44.235] (port=64939 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBnrT-000000007V4-2h2L;
	Wed, 30 Sep 2026 06:32:15 +0000
Date: Wed, 30 Sep 2026 08:32:13 +0200
From: Francesco Valla <francesco@valla.it>
To: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, 
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Boot logo supplied by the device tree
Message-ID: <aryqYhHqFk3cXh9d@bywater>
References: <20260923201035.51007-1-maximpedraza@gmail.com>
 <64e273d4-2660-437d-8871-e2bfa3c377c9@suse.de>
 <CAEUXW=G2a=Qz-9P_2+EFe-GiW4WqdOjtSCxoO4P15u_J48nP9g@mail.gmail.com>
 <arbLHvCBqxG7zcf_@bywater>
 <CAEUXW=ELS1OCyDdy5Gx41g8twU5B8112gMct9uFqhdGVveRKMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUXW=ELS1OCyDdy5Gx41g8twU5B8112gMct9uFqhdGVveRKMw@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: a227565a0f53b66e258310df8122d8bb
X-AntiAbuse: ID - a227565a0f53b66e258310df8122d8bb
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xBnrc-00000000CpG-33Wt-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-5kj8.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Màxim,

On Tue, Sep 29, 2026 at 01:46:36PM +0200, Màxim Pedraza Padilla wrote:
> Hi Francesco,
> 
> > v4 is planned but has been preempted by other activities - I am not able
> > to give you an ETA at the moment. If you have capacity, feel free to
> > take over.
> 
> Thanks, I appreciate it. Since it is your series, I would like to run
> past you what I would change before taking it on.
> 
> The v4 would still be an RFC, based on drm-misc-next. Your patches keep
> your authorship, with any fix to them folded in and noted in the commit
> message.
> 
> Fixes to what is in v3:
> 
>   - the BGRT symbols exported, as in your patch for Mario, but with
>     EXPORT_SYMBOL_GPL;
>   - drm_splash_init_client() indexes modeset_mask by the number of
>     modesets added in the first loop and by the number walked in the
>     second, so an output without a mode ahead of a connected one gets
>     the buffer instead;
>   - for a tiled group, the first loop dereferences tiled->buffer before
>     any buffer exists, and the width and height look swapped;
>   - if the BMP firmware never arrives, the callback returns without
>     waking the render thread, which is left in TASK_UNINTERRUPTIBLE for
>     good;
>   - the 24 bit blitters read each pixel as an unaligned u32, one byte
>     past the image when the rows have no padding;
>   - the image cleanup always calls memunmap(), which will need to know
>     where the image came from once there is a third source;
>   - the spaces in DRM_CLIENT_DEFAULT, in a patch of its own.
>

I suggest you also take at look at the review sashiko did for the V3
[1], as it contains some good suggestions (some of them are already
present in your list).

> The modeset, tiling and render thread ones come from reading the code,
> so I will reproduce them in qemu first. Tiling I cannot test at all.
>

I did not test tiling as well - I think it's a mode limited to some
Intel cards?

> Additions:
> 
>   - a device tree image source: a node under /chosen with the BMP either
>     in the node itself (dtc's /incbin/) or in a reserved memory region,
>     mapped with the same memremap() as the BGRT;

A reserved memory region is (probably) a better idea, to allow change
the splash without recompiling the devicetree.

A possible usecase would be:

 - bootloader reads the BMP image from a dedicated partition and loads
   it to the reserved memory (very much like the BGRT path);
 - splash client parses the devicetree, finds the memory region and
   loads the image from there;
 - userspace updates the dedicated partition with a different image.

>   - placement from that node, a position with -1 centring an axis plus
>     an offset, instead of always centring;
>   - rotation, for the DT image and for BGRT images with the orientation
>     bits set, which are skipped today;
>   - the background colour coming from the same place as the image: the
>     DT node can carry its own, splash_color goes with splash_bmp, and
>     the Kconfig colour stays the default for everything else, BGRT
>     included.
> 
> The sources would be tried in the order DT, BGRT, BMP firmware, and
> then just the colour. A DT node is only there if someone put it there
> for that board, so it seemed right to let it win.
> 
> Does that match what you had in mind? And how would you like to appear
> in MAINTAINERS, as a maintainer next to me or as a reviewer?
> 

Yes, please, either as a co-maintainer or as a reviewer, as you see fit.

> If you are happy with it, I'll take you up on your offer.
>

Thank you for continuing the effort on this - I still believe it's
useful, but currently is not fitting inside my schedule.

> Màxim
> 

Regards,
Francesco


[1] https://sashiko.dev/#/patchset/20260510-drm_client_splash-v3-0-a9aee9f0b2fc%40valla.it

> El vie, 25 sept 2026 a las 21:32, Francesco Valla
> (<francesco@valla.it>) escribió:
> >
> > Hi Màxim,
> >
> > On Fri, Sep 25, 2026 at 10:48:31AM +0200, Màxim Pedraza Padilla wrote:
> > > Hi Thomas,
> > >
> > > > the whole Linux logo on the console is somewhat gimmicky and IMHO should
> > > > not be further extended. Also fbdev as a whole has realistically run its
> > > > course. We fix bugs and occasionally clean up the code, but it is
> > > > questionable whether new feature make much sense. Even more so as the
> > > > drivers your system uses appear to be DRM ones.
> > >
> > > They are, it is tilcdc. Understood, I will drop the fbdev side, which
> > > also settles your comment on patch 1.
> > >
> > > > There is a proposal for a DRM splash screen at [1]. It retrieves the
> > > > device vendor's logo from the firmware and displays it at the given
> > > > coordinates. IMHO you should start with this series and add DT support
> > > > there.
> > >
> > > Agreed. I have been following Francesco's series since Sam pointed me
> > > at it, and it is where the DRM follow-up I mentioned in the cover letter
> > > belongs, rather than in a client of my own.
> > >
> > > A device tree source fits next to the BGRT one. The BGRT is the firmware
> > > handing the kernel an image and where to put it, and a DT system has no
> > > such table. The BMP loaded as firmware only helps if the file is built
> > > into the kernel, or if a filesystem is already there when the display
> > > comes up. With U-Boot's Falcon mode, the device tree is the only thing
> > > that reaches the kernel.
> > >
> > > So the plan would be a node under /chosen carrying a BMP, either in the
> > > node itself or in a reserved memory region the bootloader loaded it
> > > into, with the placement properties from this series. The region is the
> > > same memremap() the BGRT source already does, only with the address
> > > coming from the device tree.
> > >
> > > Rotation too: the client skips a BGRT image with the orientation bits
> > > set today, and it could turn it instead. I will ask Rob separately how
> > > he wants the image described, since that is what the binding hinges on.
> > >
> > > Francesco, is a v4 on the way? Would you take a DT source as patches on
> > > top of your series, or would you rather I wait until it lands?
> > >
> >
> > v4 is planned but has been preempted by other activities - I am not able
> > to give you an ETA at the moment. If you have capacity, feel free to
> > take over.
> >
> > > Max
> > >
> >
> > Regards,
> > Francesco
> >
