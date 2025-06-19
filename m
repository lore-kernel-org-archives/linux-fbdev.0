Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A37128B4F2;
	Thu, 19 Jun 2025 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341178; cv=none; b=rSn/7DtcAFXB7Lotoq4P8HIq+2crgCj13UIxPX5uOXRckKVbtmdsvDZFLJTcaCb6APIICElekmu7a1n5Zz7iDlvt9REy46ps1oiCi3nlakX1UzNS43LgTdGZ41zN7xYKq5pVWxWpmPNm1lqyQWj6Fonb5nFysB3DAcfpzcbB+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341178; c=relaxed/simple;
	bh=iJ6ZtPygsp8IufeVSuSqjaMqxRwGKNUtW+CxFhaNVzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeGdNGTLlk0jHCfMYJJ8QpBlGO7Uaj9l+MOstzzL7Z/WB2+WWZhDU92G59O2L6ZR2nX/74tqDgD8BD3VcYdg74MYdQ1oaUZ5W3s/Q+XekaaSATUVR/nkkOL/eVdfPDjDq8E4s0pUlSy5ym+Ra3k46LBeFr8r7/aKV71tQ3XIbzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ACbmFvYZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ACbmFvYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76556C4CEF2;
	Thu, 19 Jun 2025 13:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750341176;
	bh=iJ6ZtPygsp8IufeVSuSqjaMqxRwGKNUtW+CxFhaNVzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ACbmFvYZWMbc+R9QA10fqT0qHnFLfzhB+kTbu4IcvhIydPGFZOHOnZypC3DQ/bZhQ
	 ukdNlHj0Jo4RejsJ5zuYMTLUYFxo+bL5bJXIrsRBseLtNSr5UKHRT9tc90G6KrEQmQ
	 CnH1Z7LZb5tCzgmPdzA6enE0TUkJHXE0f/9mZrqk=
Date: Thu, 19 Jun 2025 15:52:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kisub Choe <kisub.choe.0x1@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: rename 'proc_setBLANK'
Message-ID: <2025061933-dispersal-employer-0e12@gregkh>
References: <20250618141555.5434-1-kisub.choe.0x1@gmail.com>
 <2025061817-jacket-nacho-50d6@gregkh>
 <aFQMrXRzui58krqA@zinc>
 <2025061927-pushpin-scholar-a898@gregkh>
 <aFQVZIXoS43iu0o5@zinc>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFQVZIXoS43iu0o5@zinc>

On Thu, Jun 19, 2025 at 10:49:24PM +0900, Kisub Choe wrote:
> On Thu, Jun 19, 2025 at 03:24:26PM +0200, Greg KH wrote:
> > On Thu, Jun 19, 2025 at 10:12:13PM +0900, Kisub Choe wrote:
> > > On Wed, Jun 18, 2025 at 04:26:10PM +0200, Greg KH wrote:
> > > > On Wed, Jun 18, 2025 at 11:15:55PM +0900, Kisub Choe wrote:
> > > > > Rename 'proc_setBLANK' to 'proc_setBLANK' to
> > > > 
> > > > That doesn't rename anything :(
> > > Rename 'proc_setBLANK' to 'proc_set_blank' to
> > > > 
> > > > 
> > > > 
> > > > > conform with kernel style guidelines as reported by checkpatch.pl
> > > > > 
> > > > > CHECK: Avoid CamelCase: <proc_setBLANK>
> > > > > 
> > > > > Signed-off-by: Kisub Choe <kisub.choe.0x1@gmail.com>
> > > > > ---
> > > > >  drivers/staging/sm750fb/sm750.c | 4 ++--
> > > > >  drivers/staging/sm750fb/sm750.h | 2 +-
> > > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> > > > > index 1d929aca399c..bb2ade6030c2 100644
> > > > > --- a/drivers/staging/sm750fb/sm750.c
> > > > > +++ b/drivers/staging/sm750fb/sm750.c
> > > > > @@ -577,7 +577,7 @@ static int lynxfb_ops_blank(int blank, struct fb_info *info)
> > > > >  	pr_debug("blank = %d.\n", blank);
> > > > >  	par = info->par;
> > > > >  	output = &par->output;
> > > > > -	return output->proc_setBLANK(output, blank);
> > > > > +	return output->proc_set_blank(output, blank);
> > > > >  }
> > > > >  
> > > > >  static int sm750fb_set_drv(struct lynxfb_par *par)
> > > > > @@ -605,7 +605,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
> > > > >  	crtc->ypanstep = 1;
> > > > >  	crtc->ywrapstep = 0;
> > > > >  
> > > > > -	output->proc_setBLANK = (sm750_dev->revid == SM750LE_REVISION_ID) ?
> > > > > +	output->proc_set_blank = (sm750_dev->revid == SM750LE_REVISION_ID) ?
> > > > >  				 hw_sm750le_set_blank : hw_sm750_set_blank;
> > > > 
> > > > Why do we even need this function pointer?  Why not just do the check
> > > > above when it is called instead of this indirection?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Dear Greg,
> > > 
> > > Here is the updated patch with revised commit message. No code changes.
> > 
> > Please read the documentation for how to send an updated patch (hint, it
> > needs to be a new version).
> > 
> > Also, see my comments above about what you should do here instead of
> > just renaming the variable.  Please make that change which will remove
> > the variable entirely.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Thank you for feedback.
> 
> I was wondering if you could share additional feedback regarding
> pros and cons calling a function directly based on the condition instead of the
> current implementation?

I'll leave that as an exercise for the reader to complete :)

have fun!

greg k-h
