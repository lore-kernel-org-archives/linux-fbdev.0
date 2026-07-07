Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C41938E8D4;
	Tue,  7 Jul 2026 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415256; cv=none; b=s72pTa8uz/Ctw9YuIZFQNlmj+e5smyfIfnkZKEcsQ3IJabq4sPpBHZrhr2RL8h2JU/On3u8Qf43hCTVtQ+PwLBZTy1UPsJLHh8RLlLMrgYsrYEs9Mw6Rj7EDrCiPXw0dq+QSueCmL1MRCfD5j1EQ1Brh8u0ZIVzygj+F+0n8KkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415256; c=relaxed/simple;
	bh=VRKXzMiJnCjs+kM4Bl9tSS0BvqJoFasPagT16rvf07A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKMP7wsDrS3MgywZZbA8mymN2eaNhtSbtQqcqVfet6Ln4o6SVtMGzjYWPaNRAn3MOaY8JjG4QUvuBiildkOn76onocshU/358qPeQCHQO9MRS7QrJD9sBNXuTNEHtekCxevXknPuCJMLdNr4dmmh98zPj2xv+WKLEbM7w21s+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hzg+u+5N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hzg+u+5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4FC1F000E9;
	Tue,  7 Jul 2026 09:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783415255;
	bh=k1Cz6vVUec2enh3HL+AaMWdxDzS8uMOrt47z4n1/R3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hzg+u+5Nhx5y+b0LhxEDTOf5mgTESPkTSk8rPXN1DkDMzlxej5M/asz/uaPvUyi2V
	 ZE10Wd/XDdFQo/HBN1rSvtFZcB9LZu8w+6kBZh5Llh4VRD5p1ILA66J/4/fD9h49u1
	 f13PaXqqWgoeC/m5meATXt0PHJALejpr08++o2ys=
Date: Tue, 7 Jul 2026 11:07:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: eamanu@riseup.net
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] staging: sm750fb: fix CamelCase variables name in
 sm750
Message-ID: <2026070732-shawl-effects-c4c9@gregkh>
References: <20260526131631.1237672-1-eamanu@riseup.net>
 <2026052623-cause-region-02e3@gregkh>
 <b69100263ea16141b31a7dc240ccdc91@riseup.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b69100263ea16141b31a7dc240ccdc91@riseup.net>

On Tue, May 26, 2026 at 08:30:56PM +0000, eamanu@riseup.net wrote:
> Hi,
> 
> thanks for your reply
> 
> On 2026-05-26 13:20, Greg KH wrote:
> > On Tue, May 26, 2026 at 10:16:31AM -0300, Emmanuel Arias wrote:
> >> Replace CamelCase variable name with snake_case:
> >> - pvReg -> pv_reg
> > 
> > Why are you keeping the "pv_"?  What does that mean?
> 
> Sorry, I'm trying to start contributing in the kernel. I run
> 
>   scripts/checkpatch.pl --file drivers/staging/sm750fb/*.c 
> 
> And the output was:
> 
> drivers/staging/sm750fb/sm750.c
> -------------------------------
> WARNING: static const char * array should probably be static const char
> * const
> #36: FILE: drivers/staging/sm750fb/sm750.c:36:
> +static const char *g_fbmode[] = {NULL, NULL};
> 
> CHECK: Avoid CamelCase: <pvReg>
> #758: FILE: drivers/staging/sm750fb/sm750.c:758:
> +       crtc->cursor.mmio = sm750_dev->pvReg +
> 
> CHECK: Avoid CamelCase: <setAllEngOff>
> #863: FILE: drivers/staging/sm750fb/sm750.c:863:
> +       sm750_dev->init_parm.setAllEngOff = 0;
> 
> total: 0 errors, 1 warnings, 2 checks, 1171 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or
> --fix-inplace.
> 
> So I tried to change pvReg for pv_reg and the same for setAllEngOff.
> 
> > 
> >> - setAllEngOff -> set_all_eng_off
> >> 
> >> Reported-by: kernel test robot <lkp@intel.com>
> > 
> > The test robot told you to make this change?
> 
> As I understand the test robot failed because:
> 
> 
>    drivers/staging/sm750fb/sm750_hw.c: In function 'hw_sm750_map':
> >> drivers/staging/sm750fb/sm750_hw.c:43:13: error: 'struct sm750_dev' has no member named 'pvReg'; did you mean 'pv_reg'?
>      sm750_dev->pvReg =
>                 ^~~~~
>                 pv_reg
> 
> > 
> >> Closes: https://lore.kernel.org/oe-kbuild-all/202605171049.KbaBnrJV-lkp@intel.com/
> >> Signed-off-by: Emmanuel Arias <eamanu@riseup.net>
> >> ---
> >>  drivers/staging/sm750fb/sm750.c    |  6 +++---
> >>  drivers/staging/sm750fb/sm750.h    |  4 ++--
> >>  drivers/staging/sm750fb/sm750_hw.c | 12 ++++++------
> >>  3 files changed, 11 insertions(+), 11 deletions(-)
> > 
> > What changed from v1?
> 
> So, in this v2 I added sm750_hw.c.
> 
> Please let me know if I misunderstood the workflow

The workflow is good, but you changed the name without thinking about
why checkpatch was telling you the current name was bad, and so you need
to pick a correct name for it instead.

Look on the mailing list archives for the many times people have
attempted to do this same thing recently for why this name change is not
the correct one.

thanks,

greg k-h
