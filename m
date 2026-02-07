Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB70313550;
	Sat,  7 Feb 2026 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770470881; cv=none; b=czb/G4cB/bNs7ckwlkjj+Zera9SQ0wgJ6ypDwL0rrtYRwFEsk/abk2OTMI49FI5fwGbCbiCcw7GPUqXle1X5APGxbw6xAZ988NlJ/mc//kOrekhmte8rP4akmloJnm/rrHzcYw3xG+2GojdoFFBs20ezKQEaikEce5PzyPM4oko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770470881; c=relaxed/simple;
	bh=yq+kuzVL6YjEnrpSrgsycigIJhcgaRzx+F8iRWvzS6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scBivGe1jYYF4hjwSrubo+q0nQQ/DjYumhVLY81Flnvc7vlCT18PtWULuRgt5sa1098pidP4WIWQGJ7TjcBmkPkJv7x4Zhjxqi0DLMAdoT0grVouMQZF9AopdeLAEP9fudNoFboURlg9fFjyzEP6+bDdKuAJoplc8KBh6omuEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FGUlbTtU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FGUlbTtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E28EC116D0;
	Sat,  7 Feb 2026 13:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770470881;
	bh=yq+kuzVL6YjEnrpSrgsycigIJhcgaRzx+F8iRWvzS6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FGUlbTtUlKt35G8oLp3SSTYnKcYG8DoS+OBAiCcgdsdwa3Z4CryQPp1V7bjJmwFYL
	 sQ+q65ZD9w2Bl8yqF54Rn/jePXPbRG86O+arokqLnnCRgNBL9iH9UcibaZI/KNnFio
	 Pev/BR0v55p8sMqWMOJmDmXvOO49IGmtVUYWR388=
Date: Sat, 7 Feb 2026 14:27:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] staging: sm750fb: replace strcat() with memcpy()
 in lynxfb_setup()
Message-ID: <2026020706-unfixable-finch-0e17@gregkh>
References: <20260204120602.6715-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204120602.6715-1-iprintercanon@gmail.com>

On Wed, Feb 04, 2026 at 12:05:58PM +0000, Artem Lytkin wrote:
> As part of kernel hardening, I am auditing calls to strcat().  This
> code works but it is a bit ugly.
> 
> This function takes a string "options" and allocates "g_settings"
> which is large enough to hold a copy of "options".  It copies all the
> options from "options" to "g_settings" except "noaccel", "nomtrr" and
> "dual".  The new buffer is large enough to fit all the options so
> there is no buffer overflow in using strcat() here.
> 
> However, using strcat() is misleading because "tmp" always points
> to the next unused character in the "g_settings" buffer and it's
> always the NUL character.  Use memcpy() instead to make the code
> easier to read.  This also removes an instance of strcat() which
> is a #NiceBonus.
> 
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index fecd7457e..4c6e84c03 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -1163,7 +1163,7 @@ static int __init lynxfb_setup(char *options)
>  		} else if (!strncmp(opt, "dual", strlen("dual"))) {
>  			g_dualview = 1;
>  		} else {
> -			strcat(tmp, opt);
> +			memcpy(tmp, opt, strlen(opt));

You are open-coding a call to strcat() here :(

Please don't replace one "warning" with another, this will just cause
code churn over time.  If the original code is fine, just leave it
as-is, your change here did not actually do anything at all.

thanks,

greg k-h
