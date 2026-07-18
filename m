Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077235B62C;
	Sat, 18 Jul 2026 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784356343; cv=none; b=Az65qiILUZnKb6FYIwjFvqQoBbTULN+m8Tmh4ko1vWMcQ1b+Y0bwzeL2kgG+HKBdnNgYlM1EFzTD6sFrJivNnk1WCXLYyoz80iezcqZH0BEk2HI7/xF17tmnJK003Eqvg+g1M9fmFuj00OpwiCohPSBFZstu76jlyP8TNYCAjRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784356343; c=relaxed/simple;
	bh=Im2Yf9B8OaageFHL0JxiK1QFFNipQv7vux9iPsQYp7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hs/4e+/EPVR5jvC8PvJbjXP1dCEcb6DmCjk7gzFOPQ1C/wt+f9lpZeS7lHLQX/yfv0ei5aDPGyuZrsZYW7cfbra9bus30E7lvO7PXUsdlvcT2+BhtZUkFYQ2HbX9dGQk8RYZzN5HZV0pP+ZnQbsD+C1qaUkykwQ9yn1ie7qGOUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cxey0Vtn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cxey0Vtn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F101E1F000E9;
	Sat, 18 Jul 2026 06:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784356341;
	bh=NrPUAhwbfkjMaSatZXfXLRB1QEGM+S+xRTaSlGMCCVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cxey0Vtn1+/zHJsHWGdpdl5UJ+ap76/sI30t83Ox1oaqsYEurCO0+tOjApwgJvb07
	 oE9MLK1vWpQBt1XoFH0n4YlfGs0BbkID56UmBkk/wJ3IJ69fX6YCEP6kl5d7AO8B6p
	 ah1LscVeRoEZ6mZWP+P6vBsw1DGsjMPZEKq0Jme4=
Date: Sat, 18 Jul 2026 08:31:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nils Lehnen <nils.lehnen@proton.me>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] staging: sm750fb: remove dead VALIDATION_CHIP code
Message-ID: <2026071837-ferocity-sixtyfold-7a4e@gregkh>
References: <20260718062027.5850-1-nils.lehnen@proton.me>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718062027.5850-1-nils.lehnen@proton.me>

On Sat, Jul 18, 2026 at 06:20:56AM +0000, Nils Lehnen wrote:
> VALIDATION_CHIP is defined nowhere in the tree, yet fourteen
> preprocessor conditionals in the sm750fb DDK files still test it.
> Patch 1 resolves all of them (dead branches dropped, always-true
> branches kept), as the driver TODO asks under "remove unused code";
> patch 2 cleans up the indentation and blank lines the removal leaves
> behind.
> 
> Verification, both patches: the disassembly of all ten sm750fb object
> files (objdump -d, x86, CONFIG_FB_SM750=m) is bit-identical across the
> series. Compile-tested only; no SM750 hardware available.
> 
> All English text in this series (cover letter, commit messages, code
> comments) was translated from a German draft with the assistance of
> Claude Fable 5.
> 
> v2: resend of v1 -- patch 1/2 of v1 arrived with an empty subject due
> to a local send mishap; no code changes.
> v1: https://lore.kernel.org/r/20260718055132.441-1-nils.lehnen@proton.me

Please wait a day or so between new versions, gives people a chance to
review what you sent and you to make changes based on it.

thanks,

greg k-h
