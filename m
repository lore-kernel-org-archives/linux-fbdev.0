Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36201A0727
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Sep 2024 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727123210; cv=none; b=cc+qlYj58cVYraHuW/l5E9ebYzEDMlD8NKgLhq8k+uUbCwrZyq4QNGzE+ByvijZyb6zWD2tE/DPUo1fzXXpx7J1CU0xbmjLNwWwmIuD4vsLAkHQeTPe78r4chCweG+ESoIVVIQNTeDmrt7x0DDeTsOoFNgwwFFk2Xpktd2iHkr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727123210; c=relaxed/simple;
	bh=diFYIrVYUjXjF+5MnI8hisPee6mEeIVLiIQVHwB3h5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNnNWU6QCQnsZ6zgc0T9y6ZOrYYXLY6l/OtkIzwGgwJK8j4+GcuQpWnke/sbe8ErU7rah6GMWxaXcVeC4MBblGFZaPefPpUmBtClN70TbxY4xkbEPvNHNwdCx5m6imzUsM7+pno1/1r9VgdxYn9os/JBswANFVkDr1MQwC2e1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+OQfIvW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+OQfIvW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727123209; x=1758659209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=diFYIrVYUjXjF+5MnI8hisPee6mEeIVLiIQVHwB3h5k=;
  b=H+OQfIvWm1AuzJvdQoql1+g0LyjBxT5546+sDkHlVyPifaUwuyFgYYt6
   N3L6cRsMojkOtiG0UvZqqiDYF9RdJI2zNlpJHWbZZFPJDaNs61ZiY4cK7
   E6snFs3CbrhdJN9FPqlbNQWcqUD0WVICwx85AKxfGcOjoh9/m4QP/NM14
   Jy6cZ1xYaZApGqVs2c387deyiTv4yI9lA2PvBuZun0EyL7IArUqKZcxOT
   meTeOjR6dxt2jcDXR0Az8iTztXQ0HySUo0zQwnBpHNM/uTyvN7bqfbWEz
   fnwb8czcCOLf8X76BrxdCoK4EZKtTVZCswTI3//s//eomtqeMlPBjS7Wu
   g==;
X-CSE-ConnectionGUID: 9UMngH70QaOTAIU2Y1wdSw==
X-CSE-MsgGUID: 4yPRzWKWT7SklHqpRzIEzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="37228661"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="37228661"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 13:26:48 -0700
X-CSE-ConnectionGUID: 3Zzwn6WYSVWgYT5hnxTZvA==
X-CSE-MsgGUID: ZJk5wLqAQ6Wdyu7QkPUgtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="71320966"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 23 Sep 2024 13:26:45 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 23 Sep 2024 23:26:44 +0300
Date: Mon, 23 Sep 2024 23:26:44 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/6] fbcon: fbcon_cursor_noblink -> fbcon_cursor_blink
Message-ID: <ZvHPBGPqFznIxV1R@intel.com>
References: <20240923155749.30846-1-ville.syrjala@linux.intel.com>
 <20240923155749.30846-4-ville.syrjala@linux.intel.com>
 <89c4a5c6-d83d-4b7e-9a92-99e382e6061d@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89c4a5c6-d83d-4b7e-9a92-99e382e6061d@gmx.de>
X-Patchwork-Hint: comment

On Mon, Sep 23, 2024 at 09:46:03PM +0200, Helge Deller wrote:
> On 9/23/24 17:57, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >
> > Invert fbcon_cursor_noblink into fbcon_cursor_blink so that:
> > - it matches the sysfs attribute exactly
> > - avoids having to do these NOT operations all over the place
> >
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >   drivers/video/fbdev/core/fbcon.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > index bbe332572ca7..eb30aa872371 100644
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -166,7 +166,7 @@ static const struct consw fb_con;
> >
> >   #define advance_row(p, delta) (unsigned short *)((unsigned long)(p) + (delta) * vc->vc_size_row)
> >
> > -static int fbcon_cursor_noblink;
> > +static int fbcon_cursor_blink;
> 
> Shouldn't it default then to value 1, e.g.
> +static int fbcon_cursor_blink = 1;

Indeed, good catch. Thanks. 

Had to double check that my udev rule still actually works
and it wasn't just caused by this fumble. Fortunately it
still seems effective. Phew.

> 
> Looks good otherwise.
> 
> Helge
> 
> >
> >   #define divides(a, b)	((!(a) || (b)%(a)) ? 0 : 1)
> >
> > @@ -399,7 +399,7 @@ static void fbcon_add_cursor_work(struct fb_info *info)
> >   {
> >   	struct fbcon_ops *ops = info->fbcon_par;
> >
> > -	if (!fbcon_cursor_noblink)
> > +	if (fbcon_cursor_blink)
> >   		queue_delayed_work(system_power_efficient_wq, &ops->cursor_work,
> >   				   ops->cur_blink_jiffies);
> >   }
> > @@ -3214,7 +3214,7 @@ static ssize_t rotate_show(struct device *device,
> >   static ssize_t cursor_blink_show(struct device *device,
> >   				 struct device_attribute *attr, char *buf)
> >   {
> > -	return sysfs_emit(buf, "%d\n", !fbcon_cursor_noblink);
> > +	return sysfs_emit(buf, "%d\n", fbcon_cursor_blink);
> >   }
> >
> >   static ssize_t cursor_blink_store(struct device *device,
> > @@ -3230,7 +3230,7 @@ static ssize_t cursor_blink_store(struct device *device,
> >   	console_lock();
> >   	idx = con2fb_map[fg_console];
> >
> > -	fbcon_cursor_noblink = !blink;
> > +	fbcon_cursor_blink = blink;
> >
> >   	if (idx == -1 || fbcon_registered_fb[idx] == NULL)
> >   		goto err;

-- 
Ville Syrjälä
Intel
