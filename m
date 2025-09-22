Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44043064BC;
	Mon, 22 Sep 2025 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545017; cv=none; b=gkbY7uVJOzWrXFKI0dX/2sbbZ3/yN7KfGciTSlrztQmEySBiT2+QNNw5bebs8HDhiAoDwRKP3xHVcqVTHGawgT3QmSoZyJ9xM+1/ZXHeEgxmxV3zk5OCRgPy0eEqosPsDPh8uiKoNVJic6oz8BdpXt94hc5SGGIl8NDhrqswShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545017; c=relaxed/simple;
	bh=APuMRP3rBerOLEZakooMja47D9AUuHnsvpBbckyw0fw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dgVTWw+ojHWxXOnzZKYkY04/Meyd7nr0tPn3v8z8xYh68L3NXtbvuqNeVYns7Mo1PvA+cYZW/VIXfqjI5KHpmwpVYXsnvNorJCDYoVKymR2axEcEx8YciDbvP+V59CiO0Dw6x2RFPEeP6sOGKPG6cu53jV4SfW+3qqfUgZ9TYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lccEoa99; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lccEoa99"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758545015; x=1790081015;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=APuMRP3rBerOLEZakooMja47D9AUuHnsvpBbckyw0fw=;
  b=lccEoa99ZYUtjdDfc5RJl1N5BAuXS/B+0eif9SFlsgHOl6XVSGeBh4Vi
   /nz4F7fyApfhSAIOp3RzKqqN+o/OngombtRaBEy8Xg5sAXJFDumBUZtUl
   1H1dBkj2aPd/rvJ0TB6s8bCAtocbYJcR745c8riITVJ8R+pMcP82v5U/i
   qlqK+7PMO6vwQNZ3tBsaDrzpARHnI18DLVWgf71jwj2kFgHXPoDtv9zKN
   DQCA6V36Ntf7VJSSFN5Rj7oft3PbOZKrPcNCx/gb/rFJCITSdJbfXwkqt
   6RD+X6cok5HXk0K/pNkrkdNYHc/cIX9G81+1I2mVrJYNw1/E68ByZj58s
   w==;
X-CSE-ConnectionGUID: turXMXcWSHWsmjT5CmYySg==
X-CSE-MsgGUID: bAqlACbfT/eoqtbpay+xdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="64444130"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="64444130"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 05:43:34 -0700
X-CSE-ConnectionGUID: rL8CtahTTW6tjiuE4pausg==
X-CSE-MsgGUID: zxS0a5yzTc60Txy1+7JaXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="176848451"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.61])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 05:43:31 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 simona@ffwll.ch, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tzimmermann@suse.de
Subject: Re: [PATCH] fbcon: fix integer overflow in fbcon_do_set_font
In-Reply-To: <20250912170023.3931881-1-samasth.norway.ananda@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250912170023.3931881-1-samasth.norway.ananda@oracle.com>
Date: Mon, 22 Sep 2025 15:43:29 +0300
Message-ID: <12cfe7be56a4eeed0f32d8da69d06f0490a9eec9@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 12 Sep 2025, Samasth Norway Ananda <samasth.norway.ananda@oracle.com> wrote:
> Fix integer overflow vulnerabilities in fbcon_do_set_font() where font
> size calculations could overflow when handling user-controlled font
> parameters.
>
> The vulnerabilities occur when:
> 1. CALC_FONTSZ(h, pitch, charcount) performs h * pith * charcount
>    multiplication with user-controlled values that can overflow.
> 2. FONT_EXTRA_WORDS * sizeof(int) + size addition can also overflow
> 3. This results in smaller allocations than expected, leading to buffer
>    overflows during font data copying.
>
> Add explicit overflow checking using check_mul_overflow() and
> check_add_overflow() kernel helpers to safety validate all size
> calculations before allocation.
>
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 55f5731e94c3..a507d05f8fea 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2531,9 +2531,16 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
>  	if (fbcon_invalid_charcount(info, charcount))
>  		return -EINVAL;
>  
> -	size = CALC_FONTSZ(h, pitch, charcount);
> +	/* Check for integer overflow in font size calculation */
> +	if (check_mul_overflow(h, pitch, &size) ||
> +	    check_mul_overflow(size, charcount, &size))
> +		return -EINVAL;
> +
> +	/* Check for overflow in allocation size calculation */
> +	if (check_add_overflow(FONT_EXTRA_WORDS * sizeof(int), size, &size))

This change stores the intermediate value into size, but fails to take
into account that size is used just a bit later in the function,
expecting the original size:

	new_data += FONT_EXTRA_WORDS * sizeof(int);
	FNTSIZE(new_data) = size;
	REFCOUNT(new_data) = 0;	/* usage counter */
	for (i=0; i< charcount; i++) {
		memcpy(new_data + i*h*pitch, data +  i*vpitch*pitch, h*pitch);
	}

	/* Since linux has a nice crc32 function use it for counting font
	 * checksums. */
	csum = crc32(0, new_data, size);

What was supposed to address an unlikely integer overflow seems to have
caused a real buffer overflow [1].

BR,
Jani.


[1] https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15020

> +		return -EINVAL;
>  
> -	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);
> +	new_data = kmalloc(size, GFP_USER);
>  
>  	if (!new_data)
>  		return -ENOMEM;

-- 
Jani Nikula, Intel
