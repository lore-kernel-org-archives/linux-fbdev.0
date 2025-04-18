Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D4F2222D9;
	Fri, 18 Apr 2025 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744978174; cv=none; b=G91cK3KaU5WBJotOjEkKLoclfeY6UZ+asUdXOBBaHe+/KwQOFRgAAmmblKOtF/5v54Bf9pISvFDI0xEy2fBbAf44Hp85XLpqxWlEm7jfGnRQTM1+ByOuJMkgIlHicpN8sn5Klt7QY/9NcY6iu7kaZfgW4fDy4eKAmuxAdDcM2Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744978174; c=relaxed/simple;
	bh=UrZtd00JOI1ZqzOWgiF1K2vX5+1n0VOFfrtStcupqxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWRQtauXDnB35sKk+x4ePPwNLD2vKPretEJz8UZ6Thp2qGqQ/cY7tdeOK3Vwakz2bYC47nxgNn7+LS+Zk5zP/QwSR6uhydX77z0UoOeFfevc5xkFcw7d8e8SSChrZ/tELni6c+mZTeI25E6XvnvVrsIu6lTNMiBbcbQP9344KeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=reI93Lih; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="reI93Lih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA0DC4CEE2;
	Fri, 18 Apr 2025 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744978173;
	bh=UrZtd00JOI1ZqzOWgiF1K2vX5+1n0VOFfrtStcupqxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=reI93LihKsTQTtHII8ebpccBTnuBcvSleL9DSWAaD2wFPgWGPrm+nLPpFzNGqEhId
	 Ypl8spBNnUYbCfFsGXzQc8unbf14FcerQgqvRKKsfhwmlXVvULY2+H3mJ4KHZICrRd
	 APSJbDKWR1SV1JdaWA6ku4KMgOrj7iVX13XEhuXA=
Date: Fri, 18 Apr 2025 14:09:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ruben Wauters <rubenru09@aol.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] staging: sm750fb: rename gDviCtrlChipName
Message-ID: <2025041801-reassign-wager-ea18@gregkh>
References: <20250417190302.13811-1-rubenru09@aol.com>
 <20250417190302.13811-3-rubenru09@aol.com>
 <2025041803-clutter-harmonica-7047@gregkh>
 <6a47dc48a803b6a07a7fcd33eec8df9e60e86144.camel@aol.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a47dc48a803b6a07a7fcd33eec8df9e60e86144.camel@aol.com>

On Fri, Apr 18, 2025 at 12:45:28PM +0100, Ruben Wauters wrote:
> On Fri, 2025-04-18 at 12:36 +0200, Greg Kroah-Hartman wrote:
> > On Thu, Apr 17, 2025 at 08:02:50PM +0100, Ruben Wauters wrote:
> > > Renames gDviCtrlChipName to dvi_controller_chip_name
> > > This fixes checkpatch.pl's camel case check.
> > > 
> > > Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> > > 
> > > ---
> > > 
> > > I changed the name to dvi_controller_chip_name as I
> > > believe it is somewhat more descriptive than
> > > g_dvi_ctrl_chip_name. If the second one is wanted instead
> > > please let me know and I will change it
> > > ---
> > >  drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/sm750fb/ddk750_sii164.c
> > > b/drivers/staging/sm750fb/ddk750_sii164.c
> > > index dd7811b18bf6..d4309e0d807f 100644
> > > --- a/drivers/staging/sm750fb/ddk750_sii164.c
> > > +++ b/drivers/staging/sm750fb/ddk750_sii164.c
> > > @@ -14,7 +14,7 @@
> > >  
> > >  #ifdef SII164_FULL_FUNCTIONS
> > 
> > This is never defined, so instead of papering over variable names
> > that
> > are crazy, why not just remove all of the code in the blocks for this
> > define entirely?
> 
> Given the amount of code that is never used and the time went into
> writing this, it does make me wonder whether this code *should* be used
> instead of being removed. I don't know exactly how it would be
> integrated however, removal as of now might be the easiest option, but
> I'm not entirely sure whether it would be the best option in terms of
> functionality.

Just remove it, odds are it was written a long time ago for other
hardware.  If someone needs it in the future, the git history has it
there for their use.

thanks,

greg k-h
