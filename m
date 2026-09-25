Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088304E56EE;
	Fri, 25 Sep 2026 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364744; cv=pass; b=iYPI6ZXkjCA7oC1k4O0KT25oLLHtx5iuclWDymeCBCOhlfE0STSg61945WTDgq4MOXHv4NEVZGACdHP3lFHikgQb8s7+h/SpDpQnKMWtgcKW24Nl6ApDohSwkJxgW9PbiW14sKo0tY9//NMmcEtd06hj6+BRRY2C5F+Qj+ksc64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364744; c=relaxed/simple;
	bh=oN779mH9tBNwuA7d/NdNWDGQm450ycX3DX6zJkalp1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+WyovUshpti76kqem51Id6a+vXUpJO5dcRQCHsyWnM1yQ3ffX5mhEm1fPV7uSDkjyfFDrtFTNdeIRz8/xIoR2xwSLoP+k4XLWFJbcnWClnx6ocmzb2DtuRPfhBXMMWfAFjSSsd1CAE0NkEt1zZEV01in2zslzGSo7umYJk6M3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=kbVeRKSs; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=QJx4pD3h; arc=pass smtp.client-ip=185.56.87.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="kbVeRKSs";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="QJx4pD3h"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-0jng.prod.antispam.mailspamprotection.com; s=arckey; t=1790364740;
	 b=kjRpZW/WFtWpZ+0aj4bt/aQq0IesDfymlyH+Ef7HVZ3gfjM1S0SS3deN4VyqsU6323pqGUklMs
	  t6FcFvI0yL7TS7pCCWU+1awBJrJO/lj/gq1f3q32KlckM1kSlsKL9zFm7JUBQdGgeVM/aBSaw3
	  LkYJrbk0fu6B3FDQ/qH/6Z9T3TNWovcxmV/jMhryg/sJZxZGIFyKcXPMzB0Wt/l+KeVS44PoGQ
	  +CZfsz95V2ctdNgMAaH+NPt0NknpL4sL3vWzKGKcPsrW6czOR8UMCDM+B7aPyCqPWd/CxyyRrr
	  Hi1BOjy0yK7xj72PZVygjEZUp3MpH1s8Ugsv2epUqPmznw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-0jng.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-0jng.prod.antispam.mailspamprotection.com; s=arckey; t=1790364740;
	bh=oN779mH9tBNwuA7d/NdNWDGQm450ycX3DX6zJkalp1I=;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	  Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
	b=c4T9Ri6sn99kF5GOxqBkeHpl8ga3rN80Nu949eOkPLZRU2dYc9BiHwpapMfXr9PnpXZem8TNNw
	  MB/UcJ4BMtdeFAz2ONqygYcoaqf+ls2eRbEtg3ZENKvwmNgoDmzG5MECMlmepcdNMZ7wncAqMq
	  sYJRobp8Q7xPfCJJGsVhpV4jHRa8V04w0Q+i5uZolJwISpS2Grv7lTzpC8JFw72MCEE2kAqePj
	  jCgXMC9G21OcY+nlQZCrPQ0RFxpIDjotoKt6qIoYcJ0P81JWFAKPXW7QvIae4pg3ApRRJT6cFD
	  Fx3Tnze4M8SUFypU2/Xnj9vo1LsNVnPP9IAG4KoSEGYkKg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
	:From:Date:Reply-To:List-Unsubscribe;
	bh=yvE3X9fHZurwYk916e+LX2mNqDb/QFApCbGFkhBpWsI=; b=kbVeRKSsQUbxRDo25OJk568kQc
	oUxR5bNUdTicg065wQzXCXsn+Gxw6pSf/kyjPyE0dmfaqUVGhgRlg2GPFzCb+Igi1W7QSdZM8+2wz
	sM3N70IHQ+MMQtwGwNGn9nMgxubRbqc+xu1V5WVPL1WNBiuyMQmPOTaSVKZfbBU/zrNM=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-0jng.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xABeT-00000006ZRw-0o9K;
	Fri, 25 Sep 2026 19:32:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=yvE3X9fHZurwYk916e+LX2mNqDb/QFApCbGFkhBpWsI=; b=QJx4pD3h5WMfaRo9W0EvTF6goY
	BapWrz5179rvyOrHL6dOengJgj79GvD7dKfyewvov+Nugo+OfX96ypdaC3dlJTBXc+fIntYohkNaQ
	yqV/99qP3sCHq4vcZKBQ2bzgfS+dcQ0cKhD4RQb9qDIAOqhvvJWwEYmxQVBxzaNbHnMk=;
Received: from [79.45.60.29] (port=62784 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xABeI-00000000BOp-0kv1;
	Fri, 25 Sep 2026 19:31:58 +0000
Date: Fri, 25 Sep 2026 21:31:56 +0200
From: Francesco Valla <francesco@valla.it>
To: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, 
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Boot logo supplied by the device tree
Message-ID: <arbLHvCBqxG7zcf_@bywater>
References: <20260923201035.51007-1-maximpedraza@gmail.com>
 <64e273d4-2660-437d-8871-e2bfa3c377c9@suse.de>
 <CAEUXW=G2a=Qz-9P_2+EFe-GiW4WqdOjtSCxoO4P15u_J48nP9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUXW=G2a=Qz-9P_2+EFe-GiW4WqdOjtSCxoO4P15u_J48nP9g@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: da2b712f03778543fbd6975a29cb1846
X-AntiAbuse: ID - da2b712f03778543fbd6975a29cb1846
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xABeT-00000006ZRw-0o9K-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-0jng.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Màxim,

On Fri, Sep 25, 2026 at 10:48:31AM +0200, Màxim Pedraza Padilla wrote:
> Hi Thomas,
> 
> > the whole Linux logo on the console is somewhat gimmicky and IMHO should
> > not be further extended. Also fbdev as a whole has realistically run its
> > course. We fix bugs and occasionally clean up the code, but it is
> > questionable whether new feature make much sense. Even more so as the
> > drivers your system uses appear to be DRM ones.
> 
> They are, it is tilcdc. Understood, I will drop the fbdev side, which
> also settles your comment on patch 1.
> 
> > There is a proposal for a DRM splash screen at [1]. It retrieves the
> > device vendor's logo from the firmware and displays it at the given
> > coordinates. IMHO you should start with this series and add DT support
> > there.
> 
> Agreed. I have been following Francesco's series since Sam pointed me
> at it, and it is where the DRM follow-up I mentioned in the cover letter
> belongs, rather than in a client of my own.
> 
> A device tree source fits next to the BGRT one. The BGRT is the firmware
> handing the kernel an image and where to put it, and a DT system has no
> such table. The BMP loaded as firmware only helps if the file is built
> into the kernel, or if a filesystem is already there when the display
> comes up. With U-Boot's Falcon mode, the device tree is the only thing
> that reaches the kernel.
> 
> So the plan would be a node under /chosen carrying a BMP, either in the
> node itself or in a reserved memory region the bootloader loaded it
> into, with the placement properties from this series. The region is the
> same memremap() the BGRT source already does, only with the address
> coming from the device tree.
> 
> Rotation too: the client skips a BGRT image with the orientation bits
> set today, and it could turn it instead. I will ask Rob separately how
> he wants the image described, since that is what the binding hinges on.
> 
> Francesco, is a v4 on the way? Would you take a DT source as patches on
> top of your series, or would you rather I wait until it lands?
> 

v4 is planned but has been preempted by other activities - I am not able
to give you an ETA at the moment. If you have capacity, feel free to
take over.

> Max
> 

Regards,
Francesco

