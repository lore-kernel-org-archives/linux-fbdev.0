Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523432E62B7;
	Mon, 11 May 2026 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520446; cv=none; b=BcG2vwNndOO9oEtV1U/oMofLKqr4B/4MyUXqhhd404FWLtI6HKxccL+bEqykwKb0WZLp43O+id41Bd5bV0IbHsPd05qUywbKAUKco6ERPpVO686vaW0b91OfF4VfaVyatkOm4iynVgWLN8r91KEWDoZDrGTg3bVMYHW6pIdJ1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520446; c=relaxed/simple;
	bh=2L9KK+ZWLDyIXULS6w4ZoFWIXYgFx/hafimk4GWrCFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JN66P4CaSLnAemnnHIdsxq0Ia4O7GgwVJapogjxCIWoigaATT8qoyVQ0EmjWatxUHNEOrQ1Eyq3vzldlZKDyJI9fJWWS+HbmaA52PaXjjWSI6CL6iADRgsMTatKsbtvbQh1tMWadxMgYVkn+CUKDI0LsXAJvfR4n04899Hkenwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GoolCDnV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GoolCDnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8543BC2BCB0;
	Mon, 11 May 2026 17:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778520445;
	bh=2L9KK+ZWLDyIXULS6w4ZoFWIXYgFx/hafimk4GWrCFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GoolCDnVxve+p7I9GgHBcNS3xJ9Q57RaXL+iUTX717MaDsdYkxigvuxMIAsmFHOET
	 QZ1I6Y/a7jPdLPUo5STVn4azw7igo2Cr5vQLXn97BAzbDpUXxpCIslL2cvm7h0pfLY
	 kMNb2K6q4A+rTiMLmqWfBWRb8kIHkr65nsVC1ahI=
Date: Mon, 11 May 2026 19:27:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chhabilal Dangal <yogeshdangal66@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: sm750fb: Keep g_fbmode array non-const
Message-ID: <2026051150-yearbook-detention-49d8@gregkh>
References: <20260511170245.53556-1-yogeshdangal66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511170245.53556-1-yogeshdangal66@gmail.com>

On Mon, May 11, 2026 at 10:47:45PM +0545, Chhabilal Dangal wrote:
> The g_fbmode array is modified at runtime, so it must remain
> non-const. Added clarifying comment.
> 
> Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 9f3e3d37e82a..a553099f42f3 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -33,6 +33,7 @@
>  static int g_hwcursor = 1;
>  static int g_noaccel;
>  static int g_nomtrr;
> +/* intentionally non-const since array is modified at runtime */

No comment is needed, if you change the code, it breaks the build, so
that is very obvious as you would never submit a patch that you did not
build, right?  :)

thanks,

greg k-h
