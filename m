Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD433859C3;
	Mon,  9 Mar 2026 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050164; cv=none; b=TjVBX9JLB6nz11PBpmAAQ8AYGoenu5wuMuXPDdHNzDUTQHSt5hEGsKwBFvBJ5/n9+Y5wpCQVCsGcZnWrrWFW4GzWASVV2AbkosOIBU7ZgrzxyN0RvZvh4yYiORsXn00rGss2LdSA/WHqeqWOg4ukkBOp/8cCsFrq5Z9p04dIjwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050164; c=relaxed/simple;
	bh=r/rX+8B3OcjIowjnENHFgOtcFRjiTZJJiV5my7CDCfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=by8Z7hhTwUMnayvuESJzMGKswGmBq3JtjQ3EFc8NEt8C0iGjpnp/KmW2hEKcRFB37EYjKK+yX779OTgRjcXYbCeQdn/x9vcmBr6KweI5UbmKsxRxlhIL+cOw/FuIP7kCEgkb7c9EE1ixKtALa4pdCJIfFhg/AxG9BeYBR8qVGHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RJKwPlJ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RJKwPlJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB395C2BCB1;
	Mon,  9 Mar 2026 09:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773050164;
	bh=r/rX+8B3OcjIowjnENHFgOtcFRjiTZJJiV5my7CDCfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJKwPlJ//ldEEcu8p99ZATzPgu7HCtMderGGQMcz9X9ESFiFNi602P9u0A4iR+sWL
	 09s2hrVN70sxjmOeko/pKrnGqvXrWzzK00Z1tr+HQYjQQ4fsdQSQVzuhkZ9S5GNMU8
	 IjGNaBOZ/27olkslDrVmF2WC402VBl3zu36+gE+E=
Date: Mon, 9 Mar 2026 10:56:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: dipesh chaudhary <me@dipeshchaudhary.in>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: constify g_fbmode array
Message-ID: <2026030943-obscure-alive-fa6e@gregkh>
References: <9e566c42-8ec3-4d06-91be-0489de4e91c0@smtp-relay.sendinblue.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e566c42-8ec3-4d06-91be-0489de4e91c0@smtp-relay.sendinblue.com>

On Mon, Mar 09, 2026 at 09:49:57AM +0000, dipesh chaudhary wrote:
> 
> Fix checkpatch warning for static const char array. Make the array of pointers read-only to improve memory safety.
> 
> Signed-off-by: dipesh chaudhary <me@dipeshchaudhary.in>
> ---
>  Makefile                        | 6 +++---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index df471d4212cc..e944c6e71e81 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
> -VERSION = 6
> -PATCHLEVEL = 19
> +VERSION = 7
> +PATCHLEVEL = 0
>  SUBLEVEL = 0
> -EXTRAVERSION =
> +EXTRAVERSION = -rc1
>  NAME = Baby Opossum Posse
>  
>  # *DOCUMENTATION*

Why have you changed the Makefile?

And did you test-build your change?

thanks,

greg k-h
