Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E5C18787A;
	Mon, 16 Mar 2026 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773649019; cv=none; b=cxzCJ4RO7JsEwa6NAywPAOJyot7L4wD77iXx/9SKlih21qMN8blIllCLcdJwaTYCuwrFlNhIu3m36oVuehZmWEtU+Aqw5hdc/Mr5jKK3xHFens874JUhPomecW5fGY8XSIG7WNJD1r0E1C1kE65ZLzkzezFklpDmHcpljNXTGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773649019; c=relaxed/simple;
	bh=AjbpXI/kQSTfr5RWg4hjFERFZ+0Aejn2Fq2EyqDEX94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwKSjghe6Og1ANHcEYCj1cjeiL/prVP51Nabrf7zbDs+IAIfNfByp+oeIEKnVwrUIttUp9It7pRXf0bBsYJ/aqAQ22phpYgcX+/h1T2pGue6gk4DQp8rehXipWlx+kNg+bk40eJA/BlCUIiDrBkMNSpZ+Ily1/+1A97kLlwdZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=swQIPaZ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="swQIPaZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD2FC19421;
	Mon, 16 Mar 2026 08:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773649018;
	bh=AjbpXI/kQSTfr5RWg4hjFERFZ+0Aejn2Fq2EyqDEX94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=swQIPaZ8tP05TlYR7yWCdEmPpZONO9b9mSsj7GcGZx6FWHbe90VzjThxjk3/9EoyS
	 qmdjmOnA3SUCiG1r0AI7HIgqVNxlwKlTgS8zNTBWjn0xXBe5R5UfYvxhWakm9GoMrV
	 FRssgwZwBxVrLUaS6Gsw7kqKzQIlXGinpkW4aoqI=
Date: Mon, 16 Mar 2026 09:16:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: OaroraEtimis <oaroraetimis@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: sm750fb: Replace busy-wait loop with
 udelay()
Message-ID: <2026031644-astronaut-unable-ac49@gregkh>
References: <20260315232042.231620-1-OaroraEtimis@gmail.com>
 <2026031626-semisoft-attic-8b37@gregkh>
 <495a2eb6-619e-4ad8-b550-678f7334819e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <495a2eb6-619e-4ad8-b550-678f7334819e@gmail.com>

On Mon, Mar 16, 2026 at 03:42:04PM +0800, OaroraEtimis wrote:
> Hi Greg,
> 
> Thanks for the review. Sorry for dropping the historical comment in v2. My
> only goal was to fix the -Wunused-but-set-variable warning and prevent the
> loop from being optimized away by the compiler.
> 
> I will definitely restore the comment.
> 
> 
> On Mon, Mar 16, 2026 at 14:11, Greg KH wrote:
> 
> > How is "2" the same as this busy loop?
> 
> It was a rough estimation. A 600-iteration empty loop on older CPUs
> (~500MHz) took about 2 to 3 microseconds.
> 
> 
> > And why not fix this properly, as the comment states?
> 
> The comment suggests writing to VGA ports (0x3ce/0x3cf) to force a delay. I
> didn't implement this because I don't have the specific hardware or
> datasheets to test it.
> 
> I was afraid that introducing direct VGA I/O just to fix a compiler warning
> might cause unexpected hardware regressions *or compatibility issues across
> different platforms.*
> 
> Given that I can't test hardware I/O, how would you prefer I handle this in
> v3?

Don't do any logical change that testing without hardware can not be
verified (i.e. whitespace changes).

> 1. Keep the original loop but add cpu_relax() inside to prevent compiler
> optimization. (Safest for the hardware)

Are you sure?  Can you sleep at that point in time?  What does the
performance of the device then look like?

> 2. Use udelay(2) (or ndelay) and restore the historical comment.
> 3. Migrate the driver to the standard i2c-algo-bit framework (a much heavier
> refactoring).

Number 3 is the best way.

good luck!

greg k-h
