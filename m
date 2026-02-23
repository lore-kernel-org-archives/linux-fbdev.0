Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C353834A765;
	Mon, 23 Feb 2026 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857510; cv=none; b=S5Wr+9KGCo6oaCD3CE85DO8X0s4+4d3+0Sdlv2L4oiHp2wcFrAB4w2eTvFMJ2V67FbuPN/uacVZMJBC9aayJZQOoMhCC8stOsQCJ+d5BNjhT0nQ67qdqI5Huho8Zt9sHj/SSk37W2y3JvVn+YDD8Vmh+flPE52TExnOZijHLmwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857510; c=relaxed/simple;
	bh=fLM72wLZK4elHl13l4dGIUdFQyhFlTDlFSWNfvZu/A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6qACboYzY0nz5GuwxkU00UShA0DduX7BFULqvQCKr+TlaptR/V25HqGUs/Vruy5RsGOrdJXEWz9UhuzupZFzIfU0G0oOW6XeNaIrW4Nw364uIe8Y0503aXRyjphA7GlCjOXeGv+yHMGJNKxuLVrG5ykfyr6SZY7UzZ8hF2S9aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iJnDGGv9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iJnDGGv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A19C116C6;
	Mon, 23 Feb 2026 14:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771857510;
	bh=fLM72wLZK4elHl13l4dGIUdFQyhFlTDlFSWNfvZu/A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJnDGGv9+aHmIwNVq/+T7dLGRDOL7Iaxa0iz4GlkNpMSRgfAcXG+c2xWTKHufhixv
	 kqlw4IDzH/zul+syOYdmbKqiTyKfGtepGCoWxb+jaWT/6gifMxfQLv+yHLhBNHOfaj
	 NrORvrq1WAQyrcB2PpvdsiN6MmdNMdfyokZQyNQE=
Date: Mon, 23 Feb 2026 15:36:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] staging: sm750fb: clean up logging
Message-ID: <2026022356-valley-anemia-aeaf@gregkh>
References: <20260207153703.2049-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207153703.2049-1-iprintercanon@gmail.com>

On Sat, Feb 07, 2026 at 03:37:00PM +0000, Artem Lytkin wrote:
> This series cleans up the logging in the sm750fb driver.
> 
> Changes since v3:
>   - Dropped the strcat and strncmp patches as requested by Greg KH
>   - Consistently removed all pr_info/pr_debug/pr_warn diagnostic prints
>     in one patch (previously some fb_find_mode prints were kept)
>   - Split dev_err conversions into two patches: one for sm750.c
>     and one for sm750_hw.c
> 
> Patch 1 removes all pr_info/pr_debug/pr_warn diagnostic prints
> from both sm750.c and sm750_hw.c. These include address dumps,
> debug variable prints, fb_find_mode result logging, and CH7301
> DVI chip status messages.
> 
> Patches 2-3 convert the remaining pr_err() calls to dev_err()
> for proper device context.
> 
> Artem Lytkin (3):
>   staging: sm750fb: remove debug and diagnostic prints
>   staging: sm750fb: convert logging to device-based in sm750.c
>   staging: sm750fb: convert logging to device-based in sm750_hw.c
> 
>  drivers/staging/sm750fb/sm750.c    | 88 +++---------------------------
>  drivers/staging/sm750fb/sm750_hw.c | 26 ++-------
>  2 files changed, 14 insertions(+), 100 deletions(-)
> 
> -- 
> 2.43.0
> 
> 

Does not apply to 7.0-rc1 :(
