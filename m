Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A287246760;
	Thu, 19 Jun 2025 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340971; cv=none; b=SpEIQ48hoVFQN9jZM2e0a53p0COBVSTPQg9IKaa8t37oMVCo5zuJYE17vRCZ7ESPaFjchguNkBbk975s92rHJtIEpCXac7nwTKMUB93VAhQ1vuU4pS5UNh/udWei8xOadX7Q/7uNqw5RlSrkoGiWsAtfbJxuXwuo156rKhk72xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340971; c=relaxed/simple;
	bh=vHMy8lfA0RvTgRqwgI8565ZKT2Th82SQ44ADnJE2z5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLgcowCkuJ9UFtLDFYd1cSPbERvyoXryBMNsxjoh5QiRsIzK7r61+53h156gNklRJIH1yNsyc4j/oSamaIvoeWq/bFVSmnkE6T1zUu9VeB3HLm9VAf6dALUivCI2PuQ7xayoT5icK9WlAg50WSwSkhggiTnz5d8kMBtOm0zZXe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIQXvTHX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIQXvTHX"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso612675b3a.3;
        Thu, 19 Jun 2025 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750340970; x=1750945770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWaDkoPD+uSM9zWkt35EXFyWvonB0R9vMQAYIH1I094=;
        b=HIQXvTHXU4MinC0ewPfDiBPlt9NxJ0N9gLLgFSCPpQbhhJSsewu6rmalzQ+QlyZbjq
         w5QcP71Z4AW7j7OU910F8ENHa+NqnFJjG+ZIyfLImqCWQhgmkvL4ByzN7KX7+BlC5kSy
         VEVv+XvlmFrchjbJhsVPyUx3fUv5tvPwbMmrtO10+pvCpmtAELB3ytA3LDktC417kXzD
         fgVSYlgsAiVWT2aBr77C25qJLrJ9tgmgnbtf2+IytArtMdIwgJTtQf+lbe5vByy9VF4u
         KNYpg3Ds72l4nakQVXGniIslbM4IxImXhKvA1xg+xUuJ8FnwNI+Cxafk+xgXmSq2Vt4e
         cM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750340970; x=1750945770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWaDkoPD+uSM9zWkt35EXFyWvonB0R9vMQAYIH1I094=;
        b=Xk6idt3tTDx9ftG9onXl1GsRMPSLOKo14wyA4CEmyQDYtFNh5O54c6MN78V34GhdGV
         t73dpTnkG/Kb4yrx5AfI1RkYc6JUmADrt7OdcXYL6JCSaJ2LN9OVm6SDHR/YKk1ZhkZF
         b16RATrAdVJmArwVkBsEUuTeOFKLnf26knaxL0Jl0Jf2m3FWq/bM1Xt48ZfSK1maY07n
         HICEvPdjDAGHJ8nnPuRX6c9cDvIZ78BJu7M2W9y6Fn2+k9SV9Z2JRHN091HmeBEwHXnJ
         xIXTrwvwj0iymgMvq1BQIWIv1pNAEbphsvSdW07fIdVG9hayKL6lb/deRcMGYqScXa6s
         c4cg==
X-Forwarded-Encrypted: i=1; AJvYcCUb2QPlFgPl0UTfLaAemzjyVS7iGdc5gUkQJih0osS/uGMJykAKGC8OgwXgFvZ5HqOw7goStGGuLyRKsQ==@vger.kernel.org, AJvYcCXu+Pzqf9Hkck81TuOqFUaSabjykirrt9VNdgVC9dnSXiw44ps0UycSvu5tklAuU0LlCWHxAeZ0qj8neePS@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHm09tFjUa1sYppFgemaevY/0cyCQKU2Q9BeG6iWJNE3V7+Yc
	zaPEy1alb2URAPIS3llHFpd3dFBabHfle6pcz7FCc4wYEC2YtE+3TKaG
X-Gm-Gg: ASbGncvK6DnXZOzRsarWaImVGc8UD/nQDeEn6f6DdVKkEPGWBX/ip23jLUknSZG8uO+
	sqPu56Jrch7VMOnvshqYVtZpSyC1bDnbcc/Qzu63KKeeg12wU65uSQ0rNUU6phRwpI372C+bu9x
	JBe3uq904erm1Tf5nAK9bg4r6cYDeC3BW4hiyimu2ENISasxM01vlvyFx7TgHnFnga4E75woGqv
	nocNFv0okQXqUEiVPag0yO8Ek6GGy34VA6JpntgwsK3Z1qErntoeO5YXE5E0R5ZXQro4E8SZ5B6
	sqgmcI5Cjg3jaRCKl+A9UZbGQRS3cNn2oRyAgAF75VNK3Nrz5oCfPn1Yhw==
X-Google-Smtp-Source: AGHT+IFwhI6f+rDnPbqksOiWdj6ftTdebu5QnmBHRMDK0BCTl0IMR+BYGJa9ss9I1NOdNDhtVR9WIQ==
X-Received: by 2002:a05:6a00:21c3:b0:748:68dd:ecc8 with SMTP id d2e1a72fcca58-7489cfea237mr26170827b3a.22.1750340969731;
        Thu, 19 Jun 2025 06:49:29 -0700 (PDT)
Received: from zinc ([182.216.63.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748ef5890easm3377949b3a.92.2025.06.19.06.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 06:49:29 -0700 (PDT)
Date: Thu, 19 Jun 2025 22:49:24 +0900
From: Kisub Choe <kisub.choe.0x1@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kisub Choe <kisub.choe.0x1@gmail.com>, sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: rename 'proc_setBLANK'
Message-ID: <aFQVZIXoS43iu0o5@zinc>
References: <20250618141555.5434-1-kisub.choe.0x1@gmail.com>
 <2025061817-jacket-nacho-50d6@gregkh>
 <aFQMrXRzui58krqA@zinc>
 <2025061927-pushpin-scholar-a898@gregkh>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025061927-pushpin-scholar-a898@gregkh>

On Thu, Jun 19, 2025 at 03:24:26PM +0200, Greg KH wrote:
> On Thu, Jun 19, 2025 at 10:12:13PM +0900, Kisub Choe wrote:
> > On Wed, Jun 18, 2025 at 04:26:10PM +0200, Greg KH wrote:
> > > On Wed, Jun 18, 2025 at 11:15:55PM +0900, Kisub Choe wrote:
> > > > Rename 'proc_setBLANK' to 'proc_setBLANK' to
> > > 
> > > That doesn't rename anything :(
> > Rename 'proc_setBLANK' to 'proc_set_blank' to
> > > 
> > > 
> > > 
> > > > conform with kernel style guidelines as reported by checkpatch.pl
> > > > 
> > > > CHECK: Avoid CamelCase: <proc_setBLANK>
> > > > 
> > > > Signed-off-by: Kisub Choe <kisub.choe.0x1@gmail.com>
> > > > ---
> > > >  drivers/staging/sm750fb/sm750.c | 4 ++--
> > > >  drivers/staging/sm750fb/sm750.h | 2 +-
> > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> > > > index 1d929aca399c..bb2ade6030c2 100644
> > > > --- a/drivers/staging/sm750fb/sm750.c
> > > > +++ b/drivers/staging/sm750fb/sm750.c
> > > > @@ -577,7 +577,7 @@ static int lynxfb_ops_blank(int blank, struct fb_info *info)
> > > >  	pr_debug("blank = %d.\n", blank);
> > > >  	par = info->par;
> > > >  	output = &par->output;
> > > > -	return output->proc_setBLANK(output, blank);
> > > > +	return output->proc_set_blank(output, blank);
> > > >  }
> > > >  
> > > >  static int sm750fb_set_drv(struct lynxfb_par *par)
> > > > @@ -605,7 +605,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
> > > >  	crtc->ypanstep = 1;
> > > >  	crtc->ywrapstep = 0;
> > > >  
> > > > -	output->proc_setBLANK = (sm750_dev->revid == SM750LE_REVISION_ID) ?
> > > > +	output->proc_set_blank = (sm750_dev->revid == SM750LE_REVISION_ID) ?
> > > >  				 hw_sm750le_set_blank : hw_sm750_set_blank;
> > > 
> > > Why do we even need this function pointer?  Why not just do the check
> > > above when it is called instead of this indirection?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Dear Greg,
> > 
> > Here is the updated patch with revised commit message. No code changes.
> 
> Please read the documentation for how to send an updated patch (hint, it
> needs to be a new version).
> 
> Also, see my comments above about what you should do here instead of
> just renaming the variable.  Please make that change which will remove
> the variable entirely.
> 
> thanks,
> 
> greg k-h

Thank you for feedback.

I was wondering if you could share additional feedback regarding
pros and cons calling a function directly based on the condition instead of the
current implementation?

Regards,
Kisub Choe.
