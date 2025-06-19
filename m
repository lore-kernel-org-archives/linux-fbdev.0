Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833C725C706;
	Thu, 19 Jun 2025 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339469; cv=none; b=YNi0uIdHr1qt7BCB3Ls08IX2JDIm6rccYr0oYknrJlOUzA5yE/bMZjHIYTaVnUW3zQ4ClLPwe0Q3QlBTiHcjmWTRSSs4r7zrgHrwfrg2IZCe+BZN1+asCLx4QmmYQcdAq9lpV/AtwXTX0qBnYM+euXShFm5GfmtMNeYCgwAhd8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339469; c=relaxed/simple;
	bh=7Z0NVx6HuroPTKxZ/uY5Zr2GD5nqEz+D8bJSTlgruM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7RRoaUq7hjSSkmFJ4Nlkhvd2jsen1AgjVWneRFJsi3C0fb8y8SNRPLZLaNqixI11qb0xNdmYm1uu7skgY+zVVnh4YIF4WGkaxkkrYAb87Mo9CmLmGdpSzQ23XDruRb5ICyTUKylb+eCZfcwudZfvfrZXskEZTYS7WzGR45Zk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qs66MUey; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qs66MUey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857BFC4CEEA;
	Thu, 19 Jun 2025 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750339469;
	bh=7Z0NVx6HuroPTKxZ/uY5Zr2GD5nqEz+D8bJSTlgruM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qs66MUeypU2TaVeNpdtZMNZcLRdlJ/oEiARWV3kzJMB5PAauGHR4NuBOZYvA2Mg2l
	 2F5H4xduFMlvhCAVYac2iyZZeg8oOGITs5lgzlS1KNk+9tEJ5gm8B8QkPWMjwzsMRa
	 3dgE9dkDFqFq3iH0kmZ9157MlIA8YIjEvJe1IBN4=
Date: Thu, 19 Jun 2025 15:24:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kisub Choe <kisub.choe.0x1@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: rename 'proc_setBLANK'
Message-ID: <2025061927-pushpin-scholar-a898@gregkh>
References: <20250618141555.5434-1-kisub.choe.0x1@gmail.com>
 <2025061817-jacket-nacho-50d6@gregkh>
 <aFQMrXRzui58krqA@zinc>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFQMrXRzui58krqA@zinc>

On Thu, Jun 19, 2025 at 10:12:13PM +0900, Kisub Choe wrote:
> On Wed, Jun 18, 2025 at 04:26:10PM +0200, Greg KH wrote:
> > On Wed, Jun 18, 2025 at 11:15:55PM +0900, Kisub Choe wrote:
> > > Rename 'proc_setBLANK' to 'proc_setBLANK' to
> > 
> > That doesn't rename anything :(
> Rename 'proc_setBLANK' to 'proc_set_blank' to
> > 
> > 
> > 
> > > conform with kernel style guidelines as reported by checkpatch.pl
> > > 
> > > CHECK: Avoid CamelCase: <proc_setBLANK>
> > > 
> > > Signed-off-by: Kisub Choe <kisub.choe.0x1@gmail.com>
> > > ---
> > >  drivers/staging/sm750fb/sm750.c | 4 ++--
> > >  drivers/staging/sm750fb/sm750.h | 2 +-
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> > > index 1d929aca399c..bb2ade6030c2 100644
> > > --- a/drivers/staging/sm750fb/sm750.c
> > > +++ b/drivers/staging/sm750fb/sm750.c
> > > @@ -577,7 +577,7 @@ static int lynxfb_ops_blank(int blank, struct fb_info *info)
> > >  	pr_debug("blank = %d.\n", blank);
> > >  	par = info->par;
> > >  	output = &par->output;
> > > -	return output->proc_setBLANK(output, blank);
> > > +	return output->proc_set_blank(output, blank);
> > >  }
> > >  
> > >  static int sm750fb_set_drv(struct lynxfb_par *par)
> > > @@ -605,7 +605,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
> > >  	crtc->ypanstep = 1;
> > >  	crtc->ywrapstep = 0;
> > >  
> > > -	output->proc_setBLANK = (sm750_dev->revid == SM750LE_REVISION_ID) ?
> > > +	output->proc_set_blank = (sm750_dev->revid == SM750LE_REVISION_ID) ?
> > >  				 hw_sm750le_set_blank : hw_sm750_set_blank;
> > 
> > Why do we even need this function pointer?  Why not just do the check
> > above when it is called instead of this indirection?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Dear Greg,
> 
> Here is the updated patch with revised commit message. No code changes.

Please read the documentation for how to send an updated patch (hint, it
needs to be a new version).

Also, see my comments above about what you should do here instead of
just renaming the variable.  Please make that change which will remove
the variable entirely.

thanks,

greg k-h
