Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4701953BB;
	Sat,  5 Apr 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743860238; cv=none; b=ThOOPW93Qek8DoHxYu7XOJxhJCKJNh4YHQIKsxHcoTcKAxBalmmewi7WClPodM6xU/xOooo4GoSDjq8+n/OvSfG7fLTDdPl50r/269WpqgwEFKi7pk9XyoE1wyRRYQC5JNDc+yPB+wr0Ig6H/mBGn2AJNnKRLjqYTkNEP7aFM0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743860238; c=relaxed/simple;
	bh=nswXIf2fYzDy8jVaYi9j4BNtU418xGPfp26gCcX51Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnDEXloDARM0H0BU3xNvcR3VahcduYroTEXVFEURiVZkJu580018ab+1DyQS07Le0DVz3hPXlrrIWWqdHafH/gs3mDJVDdQJr270TcygoHYgnqS7KH68so+kjrl5F3t1NpW1phukqOQxG/QP8l/7/l+YDABA8WWNNv89U/Dx+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mKRcpgvf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mKRcpgvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262D9C4CEE4;
	Sat,  5 Apr 2025 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743860237;
	bh=nswXIf2fYzDy8jVaYi9j4BNtU418xGPfp26gCcX51Hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKRcpgvfll7v6Q17xRHg5zrMSP5v/lXpF7tKsi6qhAJwhWi5MPrXwqlHOi8b8xpO3
	 fDEuPHKlCn1SLDOnrGV9WcawnKUwDE+E7vYgbd0VhfsNGJIjqGMmp8w/a43u7pRr6L
	 yjM9Mhacjt7oGAU3aRbM8E/4Xrmo8ZRtB7dLkhwY=
Date: Sat, 5 Apr 2025 14:35:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Akintola <princerichard17a@gmail.com>
Cc: outreachy@lists.linux.dev, sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] staging: sm750fb: change function naming style
Message-ID: <2025040538-breeze-espionage-dc6e@gregkh>
References: <cover.1743857160.git.princerichard17a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1743857160.git.princerichard17a@gmail.com>

On Sat, Apr 05, 2025 at 02:00:51PM +0100, Richard Akintola wrote:
> Address checkpatch's "Avoid camelCase" for sm750fb module by changing
> function name to conform to kernel code style.
> 
> The patches are required to be applied in sequence.
> 
> Richard Akintola (8):
>   staging: sm750fb: change sii164GetDeviceID to snake_case
>   staging: sm750fb: change sii164ResetChip to snake_case
>   staging: sm750fb: change sii164SetPower to snake_case
>   staging: sm750fb: change sii164GetChipString to snake_case
>   staging: sm750fb: change sii164EnableHotPlugDetection to snake_case
>   staging: sm750fb: change sii164IsConnected to snake_case
>   staging: sm750fb: change sii164CheckInterrupt to snake_case
>   staging: sm750fb: change sii164ClearInterrupt to snake_case
> 
>  drivers/staging/sm750fb/ddk750_dvi.c    | 16 +++++-----
>  drivers/staging/sm750fb/ddk750_sii164.c | 42 ++++++++++++-------------
>  drivers/staging/sm750fb/ddk750_sii164.h | 16 +++++-----
>  3 files changed, 37 insertions(+), 37 deletions(-)
> 
> -- 
> 2.39.5
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
