Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869893914ED;
	Tue,  7 Jul 2026 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415598; cv=none; b=LbceigZ0bL5+F9U/qceJS2ep0Qzs9GtKry6KiWtBJj7zmb0pq6XDGyxGxHGsAy3JFgNAen5KqEdBXsW+DQC4eDIE3MYjggtAR4NpXoc15mf7UXYkUMtZ/Q6550upC0ddiclNaNJb3pvDXO0QlXdqy9YnYIEeQHg+Gzu12bGkIVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415598; c=relaxed/simple;
	bh=wyOdB9KbOxmtWx3A7FEKhU4nEKKqXjuWLFR2iciPMTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms6iFo5RcluC9mXdFG5RSKuo5Nd0xtDH3wK/+x4WVuOdY9UOQaoipxscVva1ovTPMdE2VeoORD3poFBXI2FxJbYS3H1MgiZkjr+kbFyzdhh7roFCaUnWEnre85dcJ9LpmUWxU+JpSCLnNRTNb68Msv/WNqWjXqs/vVg24ydxVLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MDSmu+Ps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MDSmu+Ps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC7D1F000E9;
	Tue,  7 Jul 2026 09:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783415597;
	bh=6smUS6s6HWwUwjxx51MxkZYCbfe6mmOxZoJeGBmIFPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MDSmu+PsXxeAlxDjrodZV54Ve4T+o6oVP3qPZEiJnwa/P/QOWMIrE61/4Z6Bv3ZSi
	 XAVuu+AcexML8Pu0bSXXQSyYBytI1LpmmOkekT+Ond2IT+Hhg6FCu8oYs43uEykH/L
	 yn9wEmEOB7tAUotPhMc6m2xd2AFmyPBpqF5sprws=
Date: Tue, 7 Jul 2026 11:13:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Noah Adkins <noahcadkins@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	"open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
	"open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: sm750fb: convert camelCase parameters to
 snake_case
Message-ID: <2026070710-amusing-gecko-a39f@gregkh>
References: <20260615012837.90113-2-noahcadkins@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615012837.90113-2-noahcadkins@gmail.com>

On Sun, Jun 14, 2026 at 09:28:38PM -0400, Noah Adkins wrote:
> Convert the camelCase parameters in the 2D acceleration helper
> prototypes to snake_case to conform to the kernel coding style
> and to make them consistent with the parameter names in the
> corresponding implementations.

But they don't seem to match up with what the .c file says, right?  Why
not?

For example:

>  int sm750_hw_copyarea(struct lynx_accel *accel,
> -		      unsigned int sBase, unsigned int sPitch,
> +		      unsigned int source_base, unsigned int source_pitch,
>  		      unsigned int sx, unsigned int sy,
> -		      unsigned int dBase, unsigned int dPitch,
> +		      unsigned int d_base, unsigned int d_pitch,

"d_base" is "dest_base" in the .c file.

Same for some other variables.

thanks,

greg k-h
