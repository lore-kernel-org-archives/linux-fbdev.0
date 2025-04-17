Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A45324111D;
	Thu, 17 Apr 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912015; cv=none; b=ZaT7lqphI5gcbRceKFppC0en3P0IetApTtPeqtDOcZYUKUrhmSjAj4Aq7CgiiOMUoYxD/DVSNBu1InoFvnTFyTbk+OveExA49vf00XjoJeCC1BEVDOvOMrv2jXh1w9dhrLhOea7PPz1WMtw14w6xxTybIR3tFoouVy78+uQsG50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912015; c=relaxed/simple;
	bh=lfAIyq7sUVDvRco6w0Bs2SPY7/nE5Sle1eLod1lWlNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIH/djOJA06aDPzK25bSadNG2ZQyoTWUlYWw3ZgfPUavCY2r0jUozq2BlPB4+jM3M8Y5+7VFhep4izwyRV5DrqT3aKKoPg0+hwrYqm/mbkhiRriEefz3ydzaYBLGtWqJKNl0QerdNUWutqZViKlqA435Tbe3yxyRfHRXn10QUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sfYGK1d2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sfYGK1d2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72202C4CEE4;
	Thu, 17 Apr 2025 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744912014;
	bh=lfAIyq7sUVDvRco6w0Bs2SPY7/nE5Sle1eLod1lWlNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfYGK1d2/Ni9tU5h+d1g45a8zse6aEYq/PFbuGn32G3iq0ShVbLqHG9+iAEYqxwtu
	 MFMAT2pOzuZ2hS56oon49Zv2E6MeawUyUnIe43ynmSDNmh63L3SIrGQ6L9ybBCRX54
	 vivTXIUVO3PoS1vbeRxQl6qiRxn4au27lIZDM5x4=
Date: Thu, 17 Apr 2025 19:46:52 +0200
From: Greg Korah-Hartman <gregkh@linuxfoundation.org>
To: Ruben Wauters <rubenru09@aol.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix instances of camel case
Message-ID: <2025041741-uncoiled-glove-854d@gregkh>
References: <20250417153101.353645-1-rubenru09.ref@aol.com>
 <20250417153101.353645-1-rubenru09@aol.com>
 <2025041758-mounting-populace-458f@gregkh>
 <6ec1fa494ee823549fb97a48121cb28e37f1cc4d.camel@aol.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ec1fa494ee823549fb97a48121cb28e37f1cc4d.camel@aol.com>

On Thu, Apr 17, 2025 at 06:28:07PM +0100, Ruben Wauters wrote:
> On Thu, 2025-04-17 at 18:58 +0200, Greg Korah-Hartman wrote:
> > On Thu, Apr 17, 2025 at 04:27:47PM +0100, Ruben Wauters wrote:
> > > As per the kernel style guidelines, and as reported by
> > > checkpatch.pl,
> > > replaced instances of camel case with snake_case where appropriate
> > > and
> > > aligned names in the header with those in the c file.
> > > 
> > > Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> > > ---
> > >  drivers/staging/sm750fb/ddk750_sii164.c | 113 ++++++++++++--------
> > > ----
> > >  drivers/staging/sm750fb/ddk750_sii164.h |  26 +++---
> > >  2 files changed, 69 insertions(+), 70 deletions(-)
> > > 
> > > diff --git a/drivers/staging/sm750fb/ddk750_sii164.c
> > > b/drivers/staging/sm750fb/ddk750_sii164.c
> > > index 89700fc5dd2e..20c2f386220c 100644
> > > --- a/drivers/staging/sm750fb/ddk750_sii164.c
> > > +++ b/drivers/staging/sm750fb/ddk750_sii164.c
> > > @@ -12,11 +12,11 @@
> > >  #define USE_HW_I2C
> > >  
> > >  #ifdef USE_HW_I2C
> > > -    #define i2cWriteReg sm750_hw_i2c_write_reg
> > > -    #define i2cReadReg  sm750_hw_i2c_read_reg
> > > +    #define I2C_WRITE_REG sm750_hw_i2c_write_reg
> > > +    #define I2C_READ_REG  sm750_hw_i2c_read_reg
> > 
> > Close, but these are really a function name, not a macro, right?
> > 
> > And what sets this #define?  If it's always enabled, then unwrap this
> > indirection instead of keeping it around
> 
> Will take a look into it, if it turns out that this is in fact actually
> used/different, what would be the best way to name this? checkpatch.pl
> doesn't like the camelCase that's currently there.
> 
> > >  #else
> > > -    #define i2cWriteReg sm750_sw_i2c_write_reg
> > > -    #define i2cReadReg  sm750_sw_i2c_read_reg
> > > +    #define I2C_WRITE_REG sm750_sw_i2c_write_reg
> > > +    #define I2C_READ_REG  sm750_sw_i2c_read_reg
> > >  #endif
> > >  
> > >  /* SII164 Vendor and Device ID */
> > > @@ -25,7 +25,7 @@
> > >  
> > >  #ifdef SII164_FULL_FUNCTIONS
> > >  /* Name of the DVI Controller chip */
> > > -static char *gDviCtrlChipName = "Silicon Image SiI 164";
> > > +static char *dvi_controller_chip_name = "Silicon Image SiI 164";
> > 
> > This is a totally different thing.
> 
> It is, however I believe it is somewhat more descriptive, I suppose it
> doesn't really matter though and if it should be the same, just made
> snake_case, I can do that.
> > 
> > >  #endif
> > >  
> > >  /*
> > > @@ -37,14 +37,14 @@ static char *gDviCtrlChipName = "Silicon Image
> > > SiI 164";
> > >   */
> > >  unsigned short sii164_get_vendor_id(void)
> > >  {
> > > -	unsigned short vendorID;
> > > +	unsigned short vendor;
> > 
> > Why change this?
> 
> Again removing camelCase, kernel style guide says that shorter names
> are preferred (unless I misinterpreted that), I could make it vendor_id
> if that is preferred, I believe the same would be with device_id below
> it.
> 
> > This is a mix of lots of different changes, please break things up
> > into
> > "one logical change per patch"
> 
> Would it be best to split each rename (function or variable) into a
> separate patch? I do agree it is quite a lot and I was a little unsure
> when sending this one, but I also don't want to make a lot of different
> patches and spam your email with 100 patches at once.

Do "one logical thing at a time".  Think about what you would want to
see if you were the reviewer.  Sometimes yes, 100 patches is fine, but
really, make it in smaller chunks as odds are something is going to go
wrong with that many at once.

See all of the other patches on the list for examples, you have
thousands to learn from :)

good luck!

greg k-h
