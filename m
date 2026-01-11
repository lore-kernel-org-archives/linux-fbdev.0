Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBCE1632E7;
	Sun, 11 Jan 2026 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768135917; cv=none; b=kzjio9zEnXM36eN86bvR36+bUWFhhr4Lfn/1B/DT4UTbS5VTBJ/HPbE01zCtt/07t3JdyMfPcpTEgnX2Qn78bEnhR+NmRr/RBrDKgTQ8Jpp6h6UYMcTiKoLr6LyxtAQ9yz4CMDzj9jhFjqNPI+HPXd/ByLZjC9OPPrJGtkeyqGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768135917; c=relaxed/simple;
	bh=8mLSNscp3l01XXLB2rs81xxpiXbk6LvxewX4qHxK4wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3sV7132CKbU66g51JVRzfbGopzetVtbQ1w0LAolERp9Qoo+Ef6xnmCpAyV5dCFBXjyXAgpg8hXa7YrBKvAiukg68weCk+dG0CsXI2+0fQMyLtpqzKP95oBb/NqMBBv8AZsYtdV0T48003TLwExYteJdDQgi9+Y3FvpgGBaMu6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wxWQ8iuF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wxWQ8iuF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5563C4CEF7;
	Sun, 11 Jan 2026 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768135917;
	bh=8mLSNscp3l01XXLB2rs81xxpiXbk6LvxewX4qHxK4wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wxWQ8iuFJnufSiMvrJah9R65WLOZUaPnmKCwzwkyWKLgZhdEVNJLV1IZe+7wsdE44
	 UJvphcl9UrzgtL5FFyMPYf73sB8lggcEyJLQWm5b6X4bdGqz4kyhXna1OEQ2aPCLv5
	 GKguiCwcBUz37WKqozvKuspQK9dxx4HEEw/bT05o=
Date: Sun, 11 Jan 2026 13:51:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tejas Chaudhari <tejaschaudhari038@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com
Subject: Re: [PATCH] staging: sm750fb: rename fixId to fix_id
Message-ID: <2026011147-chaperone-omen-dad4@gregkh>
References: <20251223192703.16502-1-tejaschaudhari038@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223192703.16502-1-tejaschaudhari038@gmail.com>

On Wed, Dec 24, 2025 at 12:57:03AM +0530, Tejas Chaudhari wrote:
> Rename the local fixId array to fix_id to follow
> kernel naming conventions and fix a checkpatch
> CamelCase warning.
> 
> No functional changes.
> 
> Signed-off-by: Tejas Chaudhari <tejaschaudhari038@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 15b5de33b..7afb58561 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -740,7 +740,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
>  		"kernel HELPERS prepared vesa_modes",
>  	};
>  
> -	static const char *fixId[2] = {
> +	static const char *fix_id[2] = {
>  		"sm750_fb1", "sm750_fb2",
>  	};
>  
> @@ -862,7 +862,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
>  	fix->ywrapstep = crtc->ywrapstep;
>  	fix->accel = FB_ACCEL_SMI;
>  
> -	strscpy(fix->id, fixId[index], sizeof(fix->id));
> +	strscpy(fix->id, fix_id[index], sizeof(fix->id));
>  
>  	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
>  	pr_info("fix->smem_start = %lx\n", fix->smem_start);
> -- 
> 2.39.5 (Apple Git-154)
> 

Does not apply to the tree anymore :(
