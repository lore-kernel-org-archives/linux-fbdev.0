Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [46.30.211.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776D5D903
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352925; cv=none; b=tGbPaLXUWnLsnaKtSbpyMjefzTIaybVHpW8YEHrh2y19GhIWQ9jjwjTQBZbNlDLYu/qZGzU2Bg95lLhKTYuWRMzDt+ZKtoDHeOxMx7G2ZaktCKM8Y09ku1XWeh0nltP6MKI3PazB+fDAKYbjpe/HoFBR0QAbYWJm+xrcOzAUgIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352925; c=relaxed/simple;
	bh=bDFBZw+yJHqLJWkNmlTm+jhrAeI3UMwj23RRKeQN+GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYrGMALxOXutfWo7zGdS6AxHUEqhN1iSIsYpN+jCRkiC0AKjleH2R5VbyhN7T9U3/jp0X7dXV96VnAW5dN43btpkIgG9BeZUDYfqjOMJ+OYsQEJYnWsIL/H83hBHxePIJzCiw+E/TE5zQZl0cUX5BIfCTCYdRzEMdGmyXItV/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=H+00MaWs; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=DPKi7Bcr; arc=none smtp.client-ip=46.30.211.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="H+00MaWs";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="DPKi7Bcr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=5EHsIVjha4wRSL46vF6lOzFgvJbdU5IeMBGmfbQ427I=;
	b=H+00MaWsTMKg/0cixoKmrC2R9XiLtIxsOcN+V3G2q7XUPbmw57FoaT1ghKvqxdgZAbJbiRTmNdBZi
	 xBcz/7sCjHcjqB7Xbe7Da5UpGz/Z647u9lq+T1+kvJuY0hRp1K+66DKYu1CaRnb8zEbyhyK+SdaAPR
	 zSgcSlHaO290T3Mrh3r2m7NYayb69R+y2pY+jO3/l0hlLKWrRQCnAp26KOfuRDBT00MSJNK6MRN9h0
	 GaTZGpT0Rv0mb+J61YlrCyewiK/D1hFZbZZB0cAgeaZ+KnVeqX0er6Dv5pldYi8hLDFVL56O2IjwaW
	 L+hSxAfyuL/cLz3FZAi1CIgvroMPJsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=5EHsIVjha4wRSL46vF6lOzFgvJbdU5IeMBGmfbQ427I=;
	b=DPKi7BcrVx/Vk9QQ4K5glo9NfxDX3LPaqu49IcLt2Snml2ihPtcN2gA6wlGF2LXHDplnwN/7KywMr
	 j3RcGjnAA==
X-HalOne-ID: c66704fa-e163-11ee-9c87-657a30c718c6
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id c66704fa-e163-11ee-9c87-657a30c718c6;
	Wed, 13 Mar 2024 18:01:56 +0000 (UTC)
Date: Wed, 13 Mar 2024 19:01:54 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	Robin van der Gracht <robin@protonic.nl>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 1/6] auxdisplay/ht16k33: Replace use of fb_blank with
 backlight helper
Message-ID: <20240313180154.GC96726@ravnborg.org>
References: <20240313154857.12949-1-tzimmermann@suse.de>
 <20240313154857.12949-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313154857.12949-2-tzimmermann@suse.de>

On Wed, Mar 13, 2024 at 04:45:00PM +0100, Thomas Zimmermann wrote:
> Replace the use of struct backlight_properties.fb_blank with a
> call to backlight_get_brightness(). The helper implement the same
> logic as the driver's function.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Robin van der Gracht <robin@protonic.nl>
> Cc: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/auxdisplay/ht16k33.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> index a90430b7d07ba..83db829b97a5e 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -314,14 +314,9 @@ static int ht16k33_initialize(struct ht16k33_priv *priv)
>  
>  static int ht16k33_bl_update_status(struct backlight_device *bl)
>  {
> -	int brightness = bl->props.brightness;
> +	int brightness = backlight_get_brightness(bl);
>  	struct ht16k33_priv *priv = bl_get_data(bl);
>  
> -	if (bl->props.power != FB_BLANK_UNBLANK ||
> -	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
> -	    bl->props.state & BL_CORE_FBBLANK)
> -		brightness = 0;
> -
>  	return ht16k33_brightness_set(priv, brightness);
>  }
>  
> -- 
> 2.44.0
