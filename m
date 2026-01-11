Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23A1632E7;
	Sun, 11 Jan 2026 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768136304; cv=none; b=UNq+KOTomOq28v1GlZl5YGaZVoIefaaUfW8DcPwdgArx8tNr9zMcT3HbAC+7id7t/9Dj2n/0x6xGPuHUQDpcgDhhaba2TJRiNkg4BVL8dZnHbkfXAnKbbqoQOVmoz+rKLMw3MCkE+Oab2hvICiMjJI7rAFQ3yAaX2bJTh5WzRfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768136304; c=relaxed/simple;
	bh=GmfSfmPP+llNjnkJvijPfhTrU+M/HZEwOHYx86pfGUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkEIZesJ6Srh42Ud8qZ2bByLoEB5nmyx652N6ob9D3+JJ15suH5WzDtDQZUKzl/Vpng3AcCOQOzpaBhHU1B4mGJ2caUrJBIXTWDfqBJyNtWMTcredAduV8X4QCpDIxuCaR4225QEHTf+aT41pcx/DhP4w+6Bdgl7Gt5CpoQ1hkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fzj+0VQq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fzj+0VQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360B7C4CEF7;
	Sun, 11 Jan 2026 12:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768136304;
	bh=GmfSfmPP+llNjnkJvijPfhTrU+M/HZEwOHYx86pfGUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzj+0VQqijHQwvHL83klo6rMbYqo8h3DlACdp0LCz4pGK1udwa1/a5jhMctG0byYC
	 lD2b2ZvppFvB/lUnqSsZ/yKkqdRIWsJtccni2zC++pIgeg0b9vQowl23cp94mefdI7
	 J8PgDU/UdTMLz5ho9gpRPVGtxwfb7naQUuH8obC4=
Date: Sun, 11 Jan 2026 13:58:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lorenzo Simonelli <lorenzosimonelli02@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: sm750fb: fix static const char array warning
Message-ID: <2026011155-unworried-service-d78e@gregkh>
References: <20260107094714.300380-1-lorenzosimonelli02@gmail.com>
 <20260107094714.300380-2-lorenzosimonelli02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107094714.300380-2-lorenzosimonelli02@gmail.com>

On Wed, Jan 07, 2026 at 10:47:12AM +0100, Lorenzo Simonelli wrote:
> Fix the checkpatch.pl warning: "static const char * array should
> probably be static const char * const" by adding the missing
> const modifier.
> 
> Signed-off-by: Lorenzo Simonelli <lorenzosimonelli02@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index fecd7457e..15b5de33b 100644
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
> 2.52.0
> 

Please ALWAYS test-build your patches before sending them out.  That way
you catch obvious bugs like the one that this change introduces :(

thanks,

greg k-h
