Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F624BBFD;
	Wed,  8 Jul 2026 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512064; cv=none; b=fN0yf0umFWmwwS+Jznq/CsxY3Mqq2U3vBvUFp6rZT5nNlx7nkZnk/FzRn14iefofgHEDG12MlCeboX8a6nDiGbPRee72DzK8LP/lXtb2HBImmUhFDUXfUaoMYodshopFXnv7LNw9gXNk8mbSFzQTHx6qi0y2FStBfzAJqCP1Fgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512064; c=relaxed/simple;
	bh=Jtyz5mdtM3RdujAuDQH9BG+O8ipXDm6TjpRPi1dkua8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnNY1o0L91njgRE29T4W8e9w2iowUJzONGeX9O9aNPkt6wiMV32KZ0WhNwoSTOBd1lO3zsKrYwCt+nxzCJFP0H0p5UKNVyjPmfNJMlYmI5/oAvknIa1qD1MgR/G/rUI3Ugj+OzZtaqT6/0P/Lns8XX92AnKoR6pvuQTXy1Itx4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ygwpvJPm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ygwpvJPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8981F000E9;
	Wed,  8 Jul 2026 12:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783512062;
	bh=9p863L7he4lt5AW5SKjC2DMMvuDWQSHTHf5Po/24QRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ygwpvJPmgyQYEPywd1eG2GuHjo3Z2x9SpG70XgkkgLYg8lDse9UQvsIi4JqcuPWOF
	 /AhYaRxyPqB2tAOTl+T6Ev7fRfXo2SyoqRMNQiSSGeF95yIX9+TOih/VF88hvubKpp
	 /5BtsqQ74kZtNhqhtDxIoEXb2zYtCCvK9QJjEqB8=
Date: Wed, 8 Jul 2026 13:59:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Andr=E9?= Moreira <andrem.33333@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] staging: sm750fb: Remove unused variable
 'setAllEngOff'
Message-ID: <2026070828-arrange-degrading-a2ed@gregkh>
References: <2026070710-exact-unveiling-e321@gregkh>
 <20260708060307.12237-1-andrem.33333@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708060307.12237-1-andrem.33333@gmail.com>

On Wed, Jul 08, 2026 at 03:03:07AM -0300, André Moreira wrote:
> The variable 'setAllEngOff' within the 'init_status' struct is only
> set to zero during setup but its value is never read anywhere else
> in the driver. Remove it entirely to clean up the code.
> 
> Signed-off-by: André Moreira <andrem.33333@gmail.com>
> ---
> v6:
>   - Change patch approach from renaming CamelCase to entirely removing
>     the unused 'setAllEngOff' variable, based on Greg KH's feedback.

This doesn't apply to my tree at all.  Can you rebase against the
staging-testing branch and resend?

thanks,

greg k-h
