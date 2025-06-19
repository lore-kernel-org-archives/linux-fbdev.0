Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926C1AF0B5;
	Thu, 19 Jun 2025 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342944; cv=none; b=CaOE+L0X6679WqXg8XIkoi0glhRGj0GhK7Ob/N8aJFXYGqvaNPeFUzkAjq4nClkrrDvqsd4fhuP6wHk9p+M6oDqLOX5cfFiO5y5iLx+zx45p4uC21D0tC18Gy1um+U3X3fGDj7FOMk2/BiNvSCIOi/dZsPuMdRNCRRIaEMgM068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342944; c=relaxed/simple;
	bh=1odOdgCePaE7YQFe7cT7R8bcM+k0j7YI88YHcqbu7S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1w2y4j4wDBEebK4U1GISWDUaiCt4skjFSqTQMrr82Ts3bQM+MMr14YCR1v2spiEocpp76tJX1l3zUURZDab0t5IO36Fxjfu8AeC2ITFR4vbPDYQPF8LOvJigKdG915vWGjTyTZzWK50Phr/0HUIvGUnhYNSQVlndb8eoGrvWPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NU3iBe5C; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NU3iBe5C"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23602481460so7739235ad.0;
        Thu, 19 Jun 2025 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750342942; x=1750947742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tzx/vk5AUTsaeIAmj6weO5EnX/lq5FtjMMGzRyfVOMI=;
        b=NU3iBe5C6K32I4mnfuuIug7LG+VjjzGzIUHA9qax7QbOH1Du1VTZO/WbzCIO8Jmd+t
         Sv0wbRBF9Z0l6sauGqnUPOciIW5TFsJMLPvcZjQ7ZFzEi+iSFbgcYBXB3hk98ukQRpsK
         tqYlQLdVf8efUpch2Ylzht7lnMNwYiKYQEqXoh9sKJvw7yJZ4qwufsQcdY0nX2cIvy/4
         4HeE18Za9YPYPyfqh1lyj+hp4AX6VZSjTjBvzu5Kf3b3ahbfuW3zrdCnrZ0oc9eBmowR
         IGgjb2jXSjOZemCY1hQTuKBjFHaagr3MOxi1iOVmDXpBqKSBri/WtPegyrxEdFf72ohV
         8mWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750342942; x=1750947742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tzx/vk5AUTsaeIAmj6weO5EnX/lq5FtjMMGzRyfVOMI=;
        b=GF/Q30dVHBIV5lqq8Az4sddN9mr8IoiqkW1QiCgTCC5rrz5Nu0Q1N8Z5MRDVDgX1cE
         i9t3J3B+Ii8udgPRXHDuuYs3+wzsy60j9Oofs2wspw4HbhE3EH6hGRsuvXISTuQUx92V
         zmfXmDyactmAIQV/4xQohaLTzaC8ngBcruyzi1K/6y8wDEfy1I8vWmO0EavmIv4Tei2q
         N/R1uHr0bfosCnnCfeLKQDpDO54pXEbHW/qrtyUUPoJEMU5Rrcml3Uy4jWg9J1AUt53b
         jKVeX/xtibNiW0nbzyg5ratkE3zubZn5CfKy9vXsrsYJbDBrUu1OnMRtqq2z2iD8qVBY
         1nIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8iBx6XlH+37iiGZXs8rGOSdRbE5u/D78fFx5Iqmqr2pNYGc4B0JXXs6e9pcKf2GpLmMQNy4sUrRey0g==@vger.kernel.org, AJvYcCVZuvkiGNe7IH86Iw10Akz2L1u5iCKQ676oGwU0tf2MZimxrFHh/B6kTYIjh0NXrggITt15Fepaz+kRVAHY@vger.kernel.org
X-Gm-Message-State: AOJu0YzE75aWakm8moGCWC6LljUWvwVgQ51NjZIKU5sQyeDKfqRi6AKB
	njjhIEP2/T130tSPOW3KANs1mtdBXCkI1+lSZ3IBBnpkO+4XEz/GA8PH
X-Gm-Gg: ASbGncs5sYBV31vhrKTnC8baDwX66DTx6F13usxtinrmYpFnyMw0Lo2GfWayIiZQ9E/
	9YUqRE+ghniGVSdq0OTwoWseLddAyx+zBKeA7+WLUeHzW0PCeRX71G1oxQR6EsX8dU3+72n7wFO
	ZW+ZGeK5+Y3Bm3VEQ+sJ7k542kJelz86D6vcowfrIaAmUSoTUbIoP8445j2HyiRkgE3WGNL0R5E
	7cYOC6hClkXTnJtUETeZW8mKqmqxmZN0vjWt+TvuZU7mh26lShCGh26CZDVx8mSVN10We+tDyUB
	ZS26l/JqnBzd/Juya+H+GJ+HCna4/W00yQnK+Mdudlcklplh8oUdeDGDdbiCAshtnhrWptTs
X-Google-Smtp-Source: AGHT+IHxAiL7hf1jJVl22RrIcO1EAkXCMjUFL/8ZXNEEdM6cf4zD/pd8rrtTHN3+4EbISj7/GDjPPQ==
X-Received: by 2002:a17:902:f683:b0:234:c8f6:1b11 with SMTP id d9443c01a7336-2366b144efemr374948105ad.44.1750342942435;
        Thu, 19 Jun 2025 07:22:22 -0700 (PDT)
Received: from rpi4b8g ([182.216.63.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca379sm120067605ad.210.2025.06.19.07.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:22:21 -0700 (PDT)
Date: Thu, 19 Jun 2025 23:22:17 +0900
From: Kisub Choe <kisub.choe.0x1@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kisub Choe <kisub.choe.0x1@gmail.com>, sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: rename 'proc_setBLANK'
Message-ID: <aFQdGZFdtMAgTGpA@rpi4b8g>
References: <20250618141555.5434-1-kisub.choe.0x1@gmail.com>
 <2025061817-jacket-nacho-50d6@gregkh>
 <aFQMrXRzui58krqA@zinc>
 <2025061927-pushpin-scholar-a898@gregkh>
 <aFQVZIXoS43iu0o5@zinc>
 <2025061933-dispersal-employer-0e12@gregkh>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025061933-dispersal-employer-0e12@gregkh>

On Thu, Jun 19, 2025 at 03:52:53PM +0200, Greg KH wrote:
> On Thu, Jun 19, 2025 at 10:49:24PM +0900, Kisub Choe wrote:
> > On Thu, Jun 19, 2025 at 03:24:26PM +0200, Greg KH wrote:
> > > On Thu, Jun 19, 2025 at 10:12:13PM +0900, Kisub Choe wrote:
> > > > On Wed, Jun 18, 2025 at 04:26:10PM +0200, Greg KH wrote:
> > > > > On Wed, Jun 18, 2025 at 11:15:55PM +0900, Kisub Choe wrote:
> > > > > > Rename 'proc_setBLANK' to 'proc_setBLANK' to
> > > > > 
> > > > > That doesn't rename anything :(
> > > > Rename 'proc_setBLANK' to 'proc_set_blank' to
> > > > > 
> > > > > 
> > > > > 
> > > > > > conform with kernel style guidelines as reported by checkpatch.pl
> > > > > > 
> > > > > > CHECK: Avoid CamelCase: <proc_setBLANK>
> > > > > > 
> > > > > > Signed-off-by: Kisub Choe <kisub.choe.0x1@gmail.com>
> > > > > > ---
> > > > > >  drivers/staging/sm750fb/sm750.c | 4 ++--
> > > > > >  drivers/staging/sm750fb/sm750.h | 2 +-
> > > > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> > > > > > index 1d929aca399c..bb2ade6030c2 100644
> > > > > > --- a/drivers/staging/sm750fb/sm750.c
> > > > > > +++ b/drivers/staging/sm750fb/sm750.c
> > > > > > @@ -577,7 +577,7 @@ static int lynxfb_ops_blank(int blank, struct fb_info *info)
> > > > > >  	pr_debug("blank = %d.\n", blank);
> > > > > >  	par = info->par;
> > > > > >  	output = &par->output;
> > > > > > -	return output->proc_setBLANK(output, blank);
> > > > > > +	return output->proc_set_blank(output, blank);
> > > > > >  }
> > > > > >  
> > > > > >  static int sm750fb_set_drv(struct lynxfb_par *par)
> > > > > > @@ -605,7 +605,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
> > > > > >  	crtc->ypanstep = 1;
> > > > > >  	crtc->ywrapstep = 0;
> > > > > >  
> > > > > > -	output->proc_setBLANK = (sm750_dev->revid == SM750LE_REVISION_ID) ?
> > > > > > +	output->proc_set_blank = (sm750_dev->revid == SM750LE_REVISION_ID) ?
> > > > > >  				 hw_sm750le_set_blank : hw_sm750_set_blank;
> > > > > 
> > > > > Why do we even need this function pointer?  Why not just do the check
> > > > > above when it is called instead of this indirection?
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > 
> > > > Dear Greg,
> > > > 
> > > > Here is the updated patch with revised commit message. No code changes.
> > > 
> > > Please read the documentation for how to send an updated patch (hint, it
> > > needs to be a new version).
> > > 
> > > Also, see my comments above about what you should do here instead of
> > > just renaming the variable.  Please make that change which will remove
> > > the variable entirely.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Thank you for feedback.
> > 
> > I was wondering if you could share additional feedback regarding
> > pros and cons calling a function directly based on the condition instead of the
> > current implementation?
> 
> I'll leave that as an exercise for the reader to complete :)
> 
> have fun!
> 
> greg k-h

Thank you!
Let me try to make changes and update.

Regards,
Kisub Choe.
