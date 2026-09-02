Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272B289E13;
	Wed,  2 Sep 2026 05:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328730; cv=none; b=Qxa+QG+IOquPEnSfDCwiglE/0vIK7f17k//KgzytHi5eShzVxHDLlLqIZoNVmBNcp9u+lasvWD2Egt9DD0keRHiPwXExB6B9zOCKPvYAm7FofOtRJ7U0rxlV8IvU3PH5IoNMqcWqwMGAFjDYjLN8NhDFH3tKyAjxN7loGbbDXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328730; c=relaxed/simple;
	bh=Nk2TGIcv9yI7FiOWkuWIFdjitR9ZVHS+PbSVS5wBM5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIOTokEAzq3vQJ2jBPyLVd+f2mR7gMScKMBEUq54VWoDGreJN8pNEbE3u3ckJtYK4+7GrCUT0aM2HngT9yopCSIEBi0NIwvZMH0y6RI8ip3ZNru9ErIkeqoewPv2D28FVyUI+v2hzXX3KbD327CR5HNkbyd916zNbD92R6yyfmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uzb/2fCt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uzb/2fCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49A61F000E9;
	Wed,  2 Sep 2026 05:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788328729;
	bh=sTbax0D6dEo7/4ksum2O2WOquO8eB2u4AH6Op/kUQT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uzb/2fCtFJVlfE0iogpJbnq1AUZ4sfUHwB3+2PzRdqzengFtn9MnX4mPTw1AprQzp
	 oaiVAaP4JKL+4Kr7Ygd9dQvzbRrp3igdP2t4JE9rCKlUBfmDLCWIaqKGHap8qlZpuk
	 DVeOs303FJPmhKk22kef08otgQm89C2RjH/uCRGg=
Date: Wed, 2 Sep 2026 07:58:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Anshika Jain <anshikajain196872@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, sashiko-bot@kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: fix len<=0 buffer overflow in
 define_fbtft_write_reg()
Message-ID: <2026090225-counting-headroom-4efc@gregkh>
References: <20260902045026.7442-1-anshikajain196872@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902045026.7442-1-anshikajain196872@gmail.com>

On Wed, Sep 02, 2026 at 10:20:26AM +0530, Anshika Jain wrote:
> If len is 0 or negative when a define_fbtft_write_reg()-generated
> function is called, len-- underflows to -1, causing the subsequent
> while (i--) loop to run approximately 2^31 times and write far past
> the end of buf.
> 
> This is a latent bug: nothing in the current code prevents two
> adjacent negative values in an init_sequence from producing len=0,
> and there is no guarantee future or out-of-tree panel definitions
> won't do so.
> 
> Add an early return for len <= 0, matching the existing guard already
> present in the sibling function fbtft_write_reg8_bus9().
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260830161529.14500-1-anshikajain196872@gmail.com?part=1
> 
> Signed-off-by: Anshika Jain <anshikajain196872@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 3 +++
>  1 file changed, 3 insertions(+)

Did you forget an assisted-by: tag that helped you write this patch and
changelog?

thanks,

greg k-h
