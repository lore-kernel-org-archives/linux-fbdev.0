Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518812AEFE;
	Mon, 26 May 2025 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249629; cv=none; b=o+MBU1gh0/n6tCy1UVnhPFc5SxtGifC/3QxHezrmSbCNFEbSou61yvt2VzXnJZEbEj8gXG7cW7KrYJ1iF2bF+oOkQPjUC5/ilzbv4P1Ja9Dairj71RmrBRl9DavSyFvUljJNyC9H5aRlDP8NCyQa6mPE9vZsqtUNH4RgHORDY3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249629; c=relaxed/simple;
	bh=fRAM41WUGULe/bhMFo31si6hcqEgtPFulyvHS6076vw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=srB5Q0db+VGlmB4c0lPa+58sK7IDuVpOKXuKmZM6yWvC3QT2GDl0U5TkpKwgJmUpc/Tvbl3t9r36QXNuNEpR4jatQ6mK9JVUiq51Oh6rIZbteUjJfJuS3xaCVVyna6adxyFxfqb5PtMgaV7BB5UzlN+uyxYUJawXuLXTpV+ElPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TV/a3tir; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TV/a3tir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748249627; x=1779785627;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=fRAM41WUGULe/bhMFo31si6hcqEgtPFulyvHS6076vw=;
  b=TV/a3tirIWhip6K+9xOv1Dki2IrwvLMDV65ZDScSIdKU5pGbsGmWKNL0
   938TnqPZ1OvVhJncjiLgCqwo/iaMRs4SFBceeloAgVu5ikAW11mNnzb6/
   OxCwI8MEwkxupIGJvqfkbma4+AmL5vafDqFcC9tJ3ijEcgEkcGD81QEv3
   aIy/nHE3EIoSpP5NJ4bB+nn6cqza6OhBpYSODKE+iEw+rDtcYUFU1tkxg
   /5Qtabo9fz1ua49+YceLQ9CIEqwGGdneckQCxV0WOMMz16p8idRSwJN77
   whSRRZ0Xx0Mz/aF5Kc621B+Ru4+E91Zr1DoBU534mqQZ3/EqSW/t+ieLD
   Q==;
X-CSE-ConnectionGUID: +eby3GR0SGOpthcB8wlYTw==
X-CSE-MsgGUID: h0FRYCF3RI2gJXxZzNdnug==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="49466343"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="49466343"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 01:53:46 -0700
X-CSE-ConnectionGUID: rfhfdvCwRlq3s+FlBv77EA==
X-CSE-MsgGUID: VgBGYmEJQACvrrstUmAMZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="143234471"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 01:53:43 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Pengyu Luo <mitltlatltl@gmail.com>, Lee Jones <lee@kernel.org>, Daniel
 Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge
 Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>
Subject: Re: [RFC PATCH 1/2] backlight: Rename duplicated devices to support
 dual-backlight setups
In-Reply-To: <20250525104022.1326997-1-mitltlatltl@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250525104022.1326997-1-mitltlatltl@gmail.com>
Date: Mon, 26 May 2025 11:53:40 +0300
Message-ID: <7dc6a9e5171bc70be23188ffd8c45168fa79aacb@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, 25 May 2025, Pengyu Luo <mitltlatltl@gmail.com> wrote:
> When registering a backlight device, if a device with the same name
> already exists, append "-secondary" to the new device's name. This is
> useful for platforms with dual backlight drivers (e.g. some panels use
> dual ktz8866), where both instances need to coexist.
>
> For now, only one secondary instance is supported. If more instances
> are needed, this logic can be extended with auto-increment or a more
> flexible naming scheme.

I think for both patches you should consider adding a new interface for
creating dual backlight scenarios.

For example, this patch turns a driver error (registering two or more
backlights with the same name) into a special use case, patch 2
magically connecting the two, and hiding the problem.

With i915, you could have multiple devices, each with multiple
independent panels with independent backlights. I think accidentally
trying to register more than one backlight with the same name should
remain an error, *unless* you want the special case of combined
backlights.

Similarly, what if you encounter a device with two panels, and two
*independent* ktz8866?

Please be explicit rather than implicit.


BR,
Jani.


>
> Suggested-by: Daniel Thompson <danielt@kernel.org>
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>  drivers/video/backlight/backlight.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 9dc93c5e4..991702f5d 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -365,7 +365,8 @@ struct backlight_device *backlight_device_register(const char *name,
>  	struct device *parent, void *devdata, const struct backlight_ops *ops,
>  	const struct backlight_properties *props)
>  {
> -	struct backlight_device *new_bd;
> +	struct backlight_device *new_bd, *prev_bd;
> +	const char *new_name = NULL;
>  	int rc;
>  
>  	pr_debug("backlight_device_register: name=%s\n", name);
> @@ -377,10 +378,23 @@ struct backlight_device *backlight_device_register(const char *name,
>  	mutex_init(&new_bd->update_lock);
>  	mutex_init(&new_bd->ops_lock);
>  
> +	/*
> +	 * If there is an instance with the same name already, then rename it.
> +	 * We also can use an auto-increment field, but it seems that there is
> +	 * no triple or quad case.
> +	 */
> +	prev_bd = backlight_device_get_by_name(name);
> +	if (!IS_ERR_OR_NULL(prev_bd)) {
> +		new_name = kasprintf(GFP_KERNEL, "%s-secondary", name);
> +		if (!new_name)
> +			return ERR_PTR(-ENOMEM);
> +		put_device(&prev_bd->dev);
> +	}
> +
>  	new_bd->dev.class = &backlight_class;
>  	new_bd->dev.parent = parent;
>  	new_bd->dev.release = bl_device_release;
> -	dev_set_name(&new_bd->dev, "%s", name);
> +	dev_set_name(&new_bd->dev, "%s", new_name ? new_name : name);
>  	dev_set_drvdata(&new_bd->dev, devdata);
>  
>  	/* Set default properties */
> @@ -414,6 +428,8 @@ struct backlight_device *backlight_device_register(const char *name,
>  	list_add(&new_bd->entry, &backlight_dev_list);
>  	mutex_unlock(&backlight_dev_list_mutex);
>  
> +	kfree(new_name);
> +
>  	return new_bd;
>  }
>  EXPORT_SYMBOL(backlight_device_register);

-- 
Jani Nikula, Intel
