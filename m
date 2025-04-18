Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F541204C26;
	Fri, 18 Apr 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744972443; cv=none; b=B3sgyo8nxlhLirdqsHPbVV9gY1W40hwXy7F4TADJa5TxyfUZis7JUfeezTzLDpQmJSEYlG/ssFbqFI8ORSx18mrRnoJBWc1apCM57KV3GIza6pmoE8C3Sdiuwzm4iHSzCsEtWrwysLlwYgZhzqyvayzFvtQjGuIwTJNNlFt7SYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744972443; c=relaxed/simple;
	bh=vw8bJB61CiRtKIfQ9TiC017QXdCK0sfEXWxyk/l1gUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfMSC43d9HggXNeVXBmQuslCulkAxqIx4YHAaitiG40fHxgTGArMsU0M6tLx9YtCkZsv+WGU7s+xxTxdH++g7IRMw+TvfE03/nuf0mOnK8cD1m7hkfev0Gz3vc4QLVbZZzu0KoxVR2KPRQxi8H0oePXwvgHcyB0xaPmRgiAPCLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h1cjH1dj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h1cjH1dj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2246FC4CEE2;
	Fri, 18 Apr 2025 10:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744972442;
	bh=vw8bJB61CiRtKIfQ9TiC017QXdCK0sfEXWxyk/l1gUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1cjH1dj6ASU6TKCPMEOg9kqVr3SZrvVLCOAIFiht6pcIgGxyh11L8KGJz6sUsRtj
	 ZlHXlJXZR4VpqtQQxaNBjnQ+wnsOAM8+hPsLbAeZhbp75Z60KEhtxxjH/RT9FPQuJc
	 4goe7xrnsURfpbQq4UUZNh/pm4Ag7dVhvmPVppTs=
Date: Fri, 18 Apr 2025 12:33:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ruben Wauters <rubenru09@aol.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] staging: sm250fb: remove USE_HW_I2C check
Message-ID: <2025041836-debug-unstopped-9a88@gregkh>
References: <20250417190302.13811-1-rubenru09@aol.com>
 <20250417190302.13811-2-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417190302.13811-2-rubenru09@aol.com>

On Thu, Apr 17, 2025 at 08:02:49PM +0100, Ruben Wauters wrote:
> Removes the USE_HW_I2C check and function defines in
> ddk750_sii164.c.
> 
> The software equivalents were never used due to
> USE_HW_I2C being defined just before the ifdef, meaning
> the hardware versions were always used.
> 
> The define names were also triggering checkpatch.pl's
> camel case check.
> 
> Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> 
> ---
> 
> I am somewhat unsure whether this is the way to go or
> the correct way would be to add an option/opportunity for
> the software version to be used. Currently the hardware
> version is always used, but I am unsure if there ever even
> would be a case where you would want to use the software
> version over the hardware version.

Then the code can be added back, not an issue.

But you forgot this same check in
drivers/staging/sm750fb/ddk750_hwi2c.c, right?

Also, what about removing the sm750_sw_i2c_write_reg() and other
functions that are now never referenced?  Can you add that to this patch
series?  A single series that just removes the use of USE_HW_I2C and the
now unneeded functions would be best, as it's not really a "coding
style" fix, but rather a code cleanup thing, right?

thanks,

greg k-h
