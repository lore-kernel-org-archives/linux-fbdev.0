Received: from mailrelay3-1.pub.mailoutpod3-cph3.one.com (mailrelay3-1.pub.mailoutpod3-cph3.one.com [46.30.211.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECA869DF4
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353009; cv=none; b=ROQMoxSpX9nrNcgOtPlbjuYyUi64nhvYkCD+4AdGngF++TiThJHhe84/rAtAKnqTTxE56QianLy4cnk2feBvohIi9xY68FPfH3+Ex0wB4Ev9Y7fV3qbMiDQFUWnl4kZKJDaGAdT/U7QnL4ezITqce42qgu4/w1tdulz1LfLlJco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353009; c=relaxed/simple;
	bh=ZpttA8+hb/NixojX4dDgWmtMSlr++0GFXAQgIDK8A0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCKvVwNXEmDVb2s3Z4JWB3s/UNHip/65N9RmDSwo2eEth3b/0x3DPq0eBrG0d1EBTUpLB2XELmCNfymA048VIibdK9sFusjmA16og3Utb8SSpNsgT3b9C8dIgJOXYtaAxovBL/peDIJx4hGWSro3mp9+nI7pLyJ44mq15c5HBGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=tevnMCJk; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=TZO+r5m+; arc=none smtp.client-ip=46.30.211.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="tevnMCJk";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="TZO+r5m+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=6PGWeMg8CNoy/+zkkS9L2OPt1xF6lAFCedewPNY1+gY=;
	b=tevnMCJk8m3Q3lHNsK/vsFd2oLyyaME32NEciLoUeFC62HGUXH4g1OqCUCC6bVzRwREk3f/d3M8Z4
	 XIKt+Ehv2gkYhwPMDxdWedKZrHVdc2SirJJ+oJZqIocTcLDG/kYW8XaHwfXlRJBVTlC8ZxROp6Gee0
	 HLXtwDdwjOw2v5PegqtMzvnrezq8tR3ThfQZHSGPcWKU5YvJeP5Zps70UcFVSJyDaj3lfNiCCJ0qaM
	 dCrN0huZ2hN67MNXSb+Isi7ftollrRSn2NitD4/N0BP68deC6aW6Z6wpNdAbj6pReA8wETL6Azhem3
	 W67wvtOViZ4hxwa+c22pdEeVup7YAlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=6PGWeMg8CNoy/+zkkS9L2OPt1xF6lAFCedewPNY1+gY=;
	b=TZO+r5m+DD97Bajo9cNaV45NQ+MWPh5byWOV27p3eZWWpbwJ2ah9m2/MBz7lI9UZ+pxMqwI15gqq5
	 GbscVlPCg==
X-HalOne-ID: d2e14a62-e163-11ee-a17c-ff813d2dbafc
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay3.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id d2e14a62-e163-11ee-a17c-ff813d2dbafc;
	Wed, 13 Mar 2024 18:02:18 +0000 (UTC)
Date: Wed, 13 Mar 2024 19:02:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/6] backlight/omap1-bl: Remove unused struct
 omap_backlight_config.set_power
Message-ID: <20240313180216.GD96726@ravnborg.org>
References: <20240313154857.12949-1-tzimmermann@suse.de>
 <20240313154857.12949-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313154857.12949-3-tzimmermann@suse.de>

On Wed, Mar 13, 2024 at 04:45:01PM +0100, Thomas Zimmermann wrote:
> The callback set_power in struct omap_backlight_config is not
> implemented anywhere. Remove it from the structure and driver.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/video/backlight/omap1_bl.c     | 3 ---
>  include/linux/platform_data/omap1_bl.h | 1 -
>  2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/video/backlight/omap1_bl.c b/drivers/video/backlight/omap1_bl.c
> index 69a49384b3de4..84d148f385951 100644
> --- a/drivers/video/backlight/omap1_bl.c
> +++ b/drivers/video/backlight/omap1_bl.c
> @@ -39,9 +39,6 @@ static inline void omapbl_send_enable(int enable)
>  
>  static void omapbl_blank(struct omap_backlight *bl, int mode)
>  {
> -	if (bl->pdata->set_power)
> -		bl->pdata->set_power(bl->dev, mode);
> -
>  	switch (mode) {
>  	case FB_BLANK_NORMAL:
>  	case FB_BLANK_VSYNC_SUSPEND:
> diff --git a/include/linux/platform_data/omap1_bl.h b/include/linux/platform_data/omap1_bl.h
> index 5e8b17d77a5fe..3d0bab31a0a94 100644
> --- a/include/linux/platform_data/omap1_bl.h
> +++ b/include/linux/platform_data/omap1_bl.h
> @@ -6,7 +6,6 @@
>  
>  struct omap_backlight_config {
>  	int default_intensity;
> -	int (*set_power)(struct device *dev, int state);
>  };
>  
>  #endif
> -- 
> 2.44.0
