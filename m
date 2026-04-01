Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C37394780;
	Wed,  1 Apr 2026 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042298; cv=none; b=ha6redQL99hLqI1wx5vlf0G0RlM+jIX8bmZm4PZy+Hi6W4cP5wfG22J0tHwa+Fp5k7x5o3oisyffeDTlHfyIuyXB8ksBmqHN+Tc9fsnPW28o/qnsKR7ZEOYqqWmbiB6IgNFzjVghihbSS7ZAucpI/1tt9EW1Vzk1k7cY1G1QvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042298; c=relaxed/simple;
	bh=2VZjSsrgWZm87rACxyz8KW0J81OjZHVvT9OfYcZnCTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3mRbSj2Urq1Rs75wl8EfM6t1dKc8ZCz8dY4I8lUmEcY5JyPwWl217SvZ2GixjPTnJw52PgnUJNObT8ZSrs1MNZ+tpM92Ev2WsS7M6koXU8sXn5bFp+89CVlF2bWi1VfaF20aQ+jJD0ZSlOj2BMtJHQcUF4N8UJEUTgstCmBnYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WlQteTOH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WlQteTOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D25C2BCB0;
	Wed,  1 Apr 2026 11:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775042297;
	bh=2VZjSsrgWZm87rACxyz8KW0J81OjZHVvT9OfYcZnCTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlQteTOHaX+UGfDuXqvV2kApnzM4SLokgfTexMV0sVbJ0kaCM3onUzo5L2nLrsx7r
	 HsK96pOn2nfGSQk8FgeMuAcy0nnH6M11kuW+b0Fd0XbDRhs9Qp6OUSTIrpaiLvopkz
	 6yiCerjdmjvpF3vEj0ujE6AJD2CPL0NlGnFdw1cU=
Date: Wed, 1 Apr 2026 13:18:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: sm750fb: constify fix_id array
Message-ID: <2026040134-stimulant-resisting-869b@gregkh>
References: <20260401110333.2535-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401110333.2535-1-dennylin0707@gmail.com>

On Wed, Apr 01, 2026 at 11:03:33AM +0000, Hungyu Lin wrote:
> Make the static fix_id array const-qualified so it can be placed
> in read-only memory.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> 
> ---
> Changes in v3:
> - Drop g_fbmode change as it is modified at runtime.
> - Resend as a new thread as requested.
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 9a42a08c8..f7b5b22f1 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -728,7 +728,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
>  		lynx750_ext, NULL, vesa_modes,
>  	};
>  	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
> -	static const char *fix_id[2] = {
> +	static const char * const fix_id[2] = {

Wait, is this really right?

You have a const char * array, and now you make the pointer to that
const char * array const as well?  But that was static already, so what
exactly just got moved to read only memory?  What does the compiler do
differently here?  How was this tested?

I need a bit more "proof" that this change really is correct as the
const * and * to const and static stuff here always is confusing.  There
used to be some tool that would "unwind" this to figure it all out, but
I can't find that at the moment...

thanks,

greg k-h
