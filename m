Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14131DFF7;
	Wed, 12 Mar 2025 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798027; cv=none; b=N2rpldwLfd0f1zYWYep7c5MUnEhBSd11F1DxvMrOmF3HwJc2dFWF/fbIK/jFPmZGY65gE6cItUsXabc1SYbZG4Z2XVSo0IBeZZ3vIuc9ZA/Psd+ymMtgaiI5RkxxCPVajfxO8XQOkDTB8IvjVfkjjTg35OrN1r675twaCHGwRBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798027; c=relaxed/simple;
	bh=voXwxyPr3ciIUBdDoZLd8jJ6DoVzdCGFX5m1S7xK+2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gu3k1SoR9O3U29iQCjC4ZwWP67s22nm+I7cVUXO88x7aA+NiaovsCas6dRQGwGFkYqJopntqJwQ63RKMmC3woah9pLSrbiftTeQkKf1ZpPupdD+0lYDTQrIPvKeBAo76E/mhvZZ1l/HL0KQ/JW/lxVB/El8N5uM+EuyTvxWOdlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=igv7JrfK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3xBicEhh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="igv7JrfK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3xBicEhh"
Date: Wed, 12 Mar 2025 17:47:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741798023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2QE9UCBqSCGXkPrnwpgIHkqrluQ4QTo/4d5UyfJZsbk=;
	b=igv7JrfK1vzEv5SOvRWBd9vJWbBub3JBvfER5uLvUcv6Dsnvcj1If6NrBg0ikCSgBVzrOi
	Rf1lYfnIKd1h+XVpbVHYM7ML/R1xVaGW++lSBtX/zxNGz5/dvMF7LmvCZZUjOCPp6+AW27
	Lp5zvEQtSI3f24hwiweXj1B54bS23v7JE/xupV1VBai3XRTJ6cNP5oGunwtijZuDWWaL4e
	9fRIUiqkZxDigGZxkLOO4KNQ/d/7qru8AfNfbXBanSkeSwL02dcquwexW67g1KqU7C0FWs
	2vUQ/NzzxXrE1K54Rb7G3/izE7Cd4KBHmHGtzBzS46Vfw8ORxwFopPvjg8Fw6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741798023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2QE9UCBqSCGXkPrnwpgIHkqrluQ4QTo/4d5UyfJZsbk=;
	b=3xBicEhhd4YZ7GJ/J+7kw7d2OCvQGZjhtuGzL2AbqQRmyyq7/Ap0/dpzfsCOTDy98WYU9d
	NSoJZoQS7jZKHBAg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: oushixiong1025@163.com
Cc: Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
	Zsolt Kajtar <soci@c64.rulez.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH 1/2] fbcon: Register sysfs groups through device_add_group
Message-ID: <20250312173916-23dd381c-2111-413f-8b90-6bda1faaf3d5@linutronix.de>
References: <20250311112856.1020095-1-oushixiong1025@163.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311112856.1020095-1-oushixiong1025@163.com>

Hi,

On Tue, Mar 11, 2025 at 07:28:55PM +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> Use device_add_group() to simplify creation and removal.
> 
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>  drivers/video/fbdev/core/fbcon.c | 48 +++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 07d127110ca4..51c3e8a5a092 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -3159,7 +3159,7 @@ static const struct consw fb_con = {
>  	.con_debug_leave	= fbcon_debug_leave,
>  };
>  
> -static ssize_t store_rotate(struct device *device,
> +static ssize_t rotate_store(struct device *device,
>  			    struct device_attribute *attr, const char *buf,
>  			    size_t count)
>  {
> @@ -3181,7 +3181,7 @@ static ssize_t store_rotate(struct device *device,
>  	return count;
>  }
>  
> -static ssize_t store_rotate_all(struct device *device,
> +static ssize_t rotate_all_store(struct device *device,
>  				struct device_attribute *attr,const char *buf,
>  				size_t count)
>  {
> @@ -3203,7 +3203,7 @@ static ssize_t store_rotate_all(struct device *device,
>  	return count;
>  }
>  
> -static ssize_t show_rotate(struct device *device,
> +static ssize_t rotate_show(struct device *device,
>  			   struct device_attribute *attr,char *buf)
>  {
>  	struct fb_info *info;
> @@ -3222,7 +3222,7 @@ static ssize_t show_rotate(struct device *device,
>  	return sysfs_emit(buf, "%d\n", rotate);
>  }
>  
> -static ssize_t show_cursor_blink(struct device *device,
> +static ssize_t cursor_blink_show(struct device *device,
>  				 struct device_attribute *attr, char *buf)
>  {
>  	struct fb_info *info;
> @@ -3247,7 +3247,7 @@ static ssize_t show_cursor_blink(struct device *device,
>  	return sysfs_emit(buf, "%d\n", blink);
>  }
>  
> -static ssize_t store_cursor_blink(struct device *device,
> +static ssize_t cursor_blink_store(struct device *device,
>  				  struct device_attribute *attr,
>  				  const char *buf, size_t count)
>  {
> @@ -3281,32 +3281,30 @@ static ssize_t store_cursor_blink(struct device *device,
>  	return count;
>  }
>  
> -static struct device_attribute device_attrs[] = {
> -	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
> -	__ATTR(rotate_all, S_IWUSR, NULL, store_rotate_all),
> -	__ATTR(cursor_blink, S_IRUGO|S_IWUSR, show_cursor_blink,
> -	       store_cursor_blink),
> +static DEVICE_ATTR_RW(rotate);
> +static DEVICE_ATTR_WO(rotate_all);
> +static DEVICE_ATTR_RW(cursor_blink);
> +
> +static struct attribute *fbcon_device_attrs[] = {
> +	&dev_attr_rotate.attr,
> +	&dev_attr_rotate_all.attr,
> +	&dev_attr_cursor_blink.attr,
> +	NULL,

No trailing commas after sentinel values.

> +};
> +
> +static const struct attribute_group fbcon_device_attr_group = {
> +	.attrs		= fbcon_device_attrs,
>  };
>  
>  static int fbcon_init_device(void)
>  {
> -	int i, error = 0;
> +	int ret;
>  
>  	fbcon_has_sysfs = 1;
>  
> -	for (i = 0; i < ARRAY_SIZE(device_attrs); i++) {
> -		error = device_create_file(fbcon_device, &device_attrs[i]);
> -
> -		if (error)
> -			break;
> -	}
> -
> -	if (error) {
> -		while (--i >= 0)
> -			device_remove_file(fbcon_device, &device_attrs[i]);
> -
> +	ret = device_add_group(fbcon_device, &fbcon_device_attr_group);
> +	if (ret)
>  		fbcon_has_sysfs = 0;
> -	}
>  
>  	return 0;
>  }
> @@ -3389,11 +3387,9 @@ void __init fb_console_init(void)
>  
>  static void __exit fbcon_deinit_device(void)
>  {
> -	int i;
>  
>  	if (fbcon_has_sysfs) {
> -		for (i = 0; i < ARRAY_SIZE(device_attrs); i++)
> -			device_remove_file(fbcon_device, &device_attrs[i]);
> +		device_remove_group(fb_info->dev, &fbcon_device_attr_group);

Please at least compile-test your changes before submission.

>  
>  		fbcon_has_sysfs = 0;
>  	}

All of this can be simplified even more:

* fbcon_deinit_device() can be removed easily, as the attributes are
  automatically removed when the device is destroyed.
* Using device_create_with_groups() the device core will take complete care of
  the attribute lifecycle, also allowing to remove fbcon_init_device()


Thomas
