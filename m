Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB911A7251;
	Thu,  3 Oct 2024 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972333; cv=none; b=QIXdHnjRBfWBLMMeR+CMjU+MWQ8H1C1JeTuo4NxZsFcC35g86md7zxNd13H6d4/X56FBM/f91jsb/IRa1tz3+QYrR3m5X2eINUXIGUi5ulBn5uO7cywtj3RvmNCB+5hmtESr6Mv42vTOOT8jzUB5hRPsEvSC3kPuM++KU3HN8Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972333; c=relaxed/simple;
	bh=hINcHOlb+ofr37ZEVAMaCAl6SnmDYT2fhvrMzIgLFls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0CBydsUgbXqpX4/PktSpZ2VuHt2iNK9OM7oX42YSS05s1rxaKUsWVyG/P2Mm/1micR0Jc6maW5mA43Uu36a/k1VR3lCUcTjC+xfxbbIqB0U3VCEgFMXEnH7pZ+bPGCCKGuk4V4xxxpPbi93COHZlVbXJccsxrNPlZi3C3y5eqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rgDhKPeH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rgDhKPeH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8VFCquFTBw+dL27Xzp2OsRt1sPML0xALYJmjaiCuhhM=; b=rgDhKPeH+AO/mHrnadgpPMChEr
	qQiB3fiHqtd5YaWhpzNzu6hjJqUwD9Ck4b3xCFp7D8aONfJ8lfADuxAZw0KQax9/R77a+6Qq8i1Rr
	/6B2yiaVaf8RZP546dJMdV/GU+2jlsn/W5lir1iWF1PheSD94LUld124qIubeluUpfU99iCcU1lZI
	+pVeHtdBWhBKg+as6Q8K87E/6jmNfLavpzGVFfHNMd3fEFLgFIt9MhnKrNYvJXIsuMakVGmuXU1DA
	U0qV/IKJpTInhYlaBVipC+66DUyLlWQ6WimTiE3WcLJZV74NCmcl95imnUSOcsjJTTYXlQgFwjPiO
	+q3lYlQA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58586)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1swOXK-0000eB-1Y;
	Thu, 03 Oct 2024 17:18:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1swOXH-0000FO-21;
	Thu, 03 Oct 2024 17:18:39 +0100
Date: Thu, 3 Oct 2024 17:18:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: clingfei <clf700383@gmail.com>
Cc: deller@gmx.de, shc_work@mail.ru, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: clps711x-fb: unregister fb when clps711x_fb_probe
 register failed
Message-ID: <Zv7D3yPdfLVpEESu@shell.armlinux.org.uk>
References: <20241003161236.3527733-1-clf700383@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003161236.3527733-1-clf700383@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 04, 2024 at 12:12:36AM +0800, clingfei wrote:
> When register_framebuffer failed, it jumps out_fb_dealloc_cmap without
> calling unregister_framebuffer, which may cause potential memory leak.

This looks completely wrong. If register_framebuffer() fails, then the
work that register_framebuffer() does internally should be cleaned up
and unregister_framebuffer() should not be necessary.

The code looks correct as-is to me, so there's no need to patch it.
If there is a memory leak, that'll be in register_framebuffer() itself.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
