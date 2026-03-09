Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A013E51DF;
	Mon,  9 Mar 2026 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072089; cv=none; b=Uz1xN4JMJ2ensimnEP8VbCzm8GsRhRdrud6HPVGUSuR4icvOSKqbrTLa4H4uASHi6PElRWVWkInesQF1P0rYhRT9FMDggMyLCNHrPd8eSpUrTfhrRzhhduO0Of/5QggU7HGu9yTdqydXZz9rdz1XzLlMxZD6itUQ5L+KYlpQk7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072089; c=relaxed/simple;
	bh=i7g3HWQcK16ok8cijcScoEFgjsKZfj6VDXCCMiv0RiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/EtLxg5MWUdbwncmpJcqlxZQ38sFP3vVy5zsdxoGwa/15+iM+IKiUixjEFhGKPduLYVC1WjbJ41mOXqR6gjv6bxE2tBGqg48RzY2YvEEM0KyQsBSejc1U16zzEOQclyx4MnQiSMJitND/ykdzLbjZBgCgqWnbBvkwBwg0rBFsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0TZUauSM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0TZUauSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AEBC4CEF7;
	Mon,  9 Mar 2026 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773072089;
	bh=i7g3HWQcK16ok8cijcScoEFgjsKZfj6VDXCCMiv0RiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0TZUauSMSSpKmMxgwX3JD8dac0sesR5bayqyg+LXH750pNiTBBdqYMMHIXs9rUl4a
	 /Zcdhp13fTjmY5mLeCkKdpnNeSzLZa8lOkt43W89S5l/6LRbKAtqJfqAkzZ/gDREsw
	 tFHOQ1S0HHfEotbOdju3DGewZTaPXd4jPB8G0Ri4=
Date: Mon, 9 Mar 2026 17:01:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: sluisr <luistermc789@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, sluisr <contact@sluisr.com>
Subject: Re: [PATCH] staging: sm750fb: fix static const char * warning
Message-ID: <2026030910-prewashed-bush-8e4c@gregkh>
References: <20260309002809.15746-1-contact@sluisr.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309002809.15746-1-contact@sluisr.com>

On Sun, Mar 08, 2026 at 06:28:09PM -0600, sluisr wrote:
> This patch fixes a checkpatch.pl warning:
> WARNING: static const char * array should probably be static const char * const
> by adding the missing const keyword to the g_fbmode array declaration.
> 
> Signed-off-by: sluisr <contact@sluisr.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index dec1f6b88..08d4979c6 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -33,7 +33,7 @@
>  static int g_hwcursor = 1;
>  static int g_noaccel;
>  static int g_nomtrr;
> -static const char *g_fbmode[] = {NULL, NULL};
> +static const char * const g_fbmode[] = {NULL, NULL};
>  static const char *g_def_fbmode = "1024x768-32@60";
>  static char *g_settings;
>  static int g_dualview;
> -- 
> 2.53.0
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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
