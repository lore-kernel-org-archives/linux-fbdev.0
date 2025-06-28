Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132B1DE4FB;
	Sat, 28 Jun 2025 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751099366; cv=none; b=eadgz1N5yxBN01FPWPXcADRLnxfy4MWsGn/PHa7ZdKQCi8i78YwR6gG5V3s5Y+LkUcDz6yM2/Voxs1f/fatbKtabmacG/7yoi2nv10yhnUqJwwJS+OKL4EsKwB1DMpVTemNbQeB0UGkBf6SOW+0B1NgsxOnxq5HLsMtBCpB2e80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751099366; c=relaxed/simple;
	bh=XUVgWuL6+H8JHuXLgLLOh47JwD9EdzSN4VmosdXNanQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ph/3E3S+0ASi0Qyql6kKeKjmFHwAkc7qXHsYYDCyQh2u1hVWtCMNVIJdjpeaQjImEus2l+UAYzJs2sTMPl/KIgsTdDx6/Oy5SJPmM/rZMWoretKigwW6uMB6TX8MdEAFio0U1mSfoF4mC6frfaGlqU8p8COwd7ezsH2BzWXTuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aR2nD0Uz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aR2nD0Uz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C2AC4CEEA;
	Sat, 28 Jun 2025 08:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751099365;
	bh=XUVgWuL6+H8JHuXLgLLOh47JwD9EdzSN4VmosdXNanQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aR2nD0UzCyjc9hoxjEZGseN9z4YarsqTxr8HPEZLxYDklv/lWp7wNYLRYeBtT7lm+
	 hvX6y+HmkgwQbT6MR/VknQ+tWeO+OWZXjpc5yzDcK3DUiX6wKGoJCS/c+/71ul6afS
	 WwweIWqodgpHwlt5GT6vl76KqnfFt2FNVIV/x654=
Date: Sat, 28 Jun 2025 10:29:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Manish Kumar <manish1588@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix all checkpatch warnings in .c and
 .h files
Message-ID: <2025062806-fit-harness-3d72@gregkh>
References: <20250628082305.20847-1-manish1588@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628082305.20847-1-manish1588@gmail.com>

On Sat, Jun 28, 2025 at 01:53:05PM +0530, Manish Kumar wrote:
> This patch resolves all checkpatch.pl --strict warnings in the
> sm750fb driver source files, including both C and header files.
> 
> Changes include:
> - Replacing CamelCase identifiers with snake_case
> - Avoiding chained assignments
> - Fixing indentation, spacing, and alignment issues
> - Updating function declarations and comment styles
> - Making code conform to kernel coding style
> 
> No functional changes.
> 
> Signed-off-by: Manish Kumar <manish1588@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c       |  90 ++++++++++---------
>  drivers/staging/sm750fb/sm750.h       |  32 +++----
>  drivers/staging/sm750fb/sm750_accel.c | 120 +++++++++++++-------------
>  drivers/staging/sm750fb/sm750_hw.c    |  24 +++---
>  4 files changed, 135 insertions(+), 131 deletions(-)

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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
