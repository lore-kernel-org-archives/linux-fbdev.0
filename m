Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8D2F5461
	for <linux-fbdev@vger.kernel.org>; Mon,  5 Jan 2026 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630525; cv=none; b=Pw8zRkzVJ6Pd4yaJZmlQwiOnrATB6u57iQVLKfixifSUGM2C6xhgdN5cVLIKzlF0aVIph6J7tp+9DtKqVBr9NpX+g8eC5bwt6g4tuwhAMY/OEaNIr0LPEgF3g4WHR4qc9ljbKx6V6rG4kHuavGZVAQHsbgBBiNDZmkCXQHEA3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630525; c=relaxed/simple;
	bh=FsPS/LubOaNTccnvOYz0BxmjeM7vrFfXaA9Rl62TCtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhWsupcnrs7BrpwP7QvrxFAp1nIvICW+/Cj+j8AKi5Fi5w44aWkD81dvLbmbB0hIHDoR9gwIq/eUWQhBiFW4AG/aYcqZZebsN4jcTWAO9ZUslLgezm0gkmRlt2e1S7ZKGcZ/lpPWKUr4gb/Jctoj81o38SwZjGXnd/DEfIgsm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efzPRygm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efzPRygm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767630521; x=1799166521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FsPS/LubOaNTccnvOYz0BxmjeM7vrFfXaA9Rl62TCtg=;
  b=efzPRygm/zt9+ZjT2+PrJizr5HUs3anK0QkUKsApKlF6dPtWPAc8ZFFy
   BtW6/l7GSR/526wLFj4WQWu2JWXDlXgL6qO61xbaBgaXlTmbOjS4HpB5V
   JI1RUN0Bqf+m5EgPmtkVQYoh/5EPuVWNjwVqWU5GZul0EeKOro46MWd7U
   nkyx0vyS+WtGAv0ooCZRxEAnrhR+Kq+SerON56RuCWlwnhC4ccN7oHr0h
   59kH/5j4lUaz1q1zwnKy77AxbkoDdPk1sBdiFainPpWrPxa8IcHkldyxe
   PkwEjnbDHolL7hztOZFAqwevVOt1k8dqAGpk66SX6fUwk1la690wKmoua
   w==;
X-CSE-ConnectionGUID: OCGVwOnVRaOS5m4ND5+zbA==
X-CSE-MsgGUID: 3X0xFdeLShGAbtRi0d29Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="71574085"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="71574085"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 08:28:35 -0800
X-CSE-ConnectionGUID: yjeDY+T2RFOcWKugteKcWw==
X-CSE-MsgGUID: HHb9E8xQQ6CS5mko4iL4fA==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 08:28:33 -0800
Date: Mon, 5 Jan 2026 18:28:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 1/4] staging: fbtft: core: avoid large stack usage in
 DT init parsing
Message-ID: <aVvmr2qOrFvoEKGV@smile.fi.intel.com>
References: <20260104110638.532615-1-sun.jian.kdev@gmail.com>
 <20260104110638.532615-2-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104110638.532615-2-sun.jian.kdev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jan 04, 2026 at 07:06:35PM +0800, Sun Jian wrote:
> Clang reports a large stack frame for fbtft_init_display_from_property()
> (-Wframe-larger-than=1024) when the init sequence is emitted through a
> fixed 64-argument write_register() call.
> 
> write_reg()/write_register() relies on NUMARGS((int[]){...}) and large
> varargs which inflates stack usage. Switch the DT "init" path to send the
> command byte and the payload via fbtft_write_buf_dc() instead.
> 
> No functional change intended: the same register values are sent in the
> same order, only the transport is changed.

How did you test this?

...

>  	struct device *dev = par->info->device;
> -	int buf[64], count, index, i, j, ret;
> +	u8 buf[64];
> +	int count, index, i, j, ret;

Please, try to preserve reversed xmas tree order.

>  	u32 *values;
>  	u32 val;
>  

...

> -				buf[i++] = val;
> +				buf[i++] = val & 0xFF;

Unneeded change, I suppose.

...

> -			par->fbtftops.write_register(par, i,
> -				buf[0], buf[1], buf[2], buf[3],
> -				buf[4], buf[5], buf[6], buf[7],
> -				buf[8], buf[9], buf[10], buf[11],
> -				buf[12], buf[13], buf[14], buf[15],
> -				buf[16], buf[17], buf[18], buf[19],
> -				buf[20], buf[21], buf[22], buf[23],
> -				buf[24], buf[25], buf[26], buf[27],
> -				buf[28], buf[29], buf[30], buf[31],
> -				buf[32], buf[33], buf[34], buf[35],
> -				buf[36], buf[37], buf[38], buf[39],
> -				buf[40], buf[41], buf[42], buf[43],
> -				buf[44], buf[45], buf[46], buf[47],
> -				buf[48], buf[49], buf[50], buf[51],
> -				buf[52], buf[53], buf[54], buf[55],
> -				buf[56], buf[57], buf[58], buf[59],
> -				buf[60], buf[61], buf[62], buf[63]);
> +			/* buf[0] is command, buf[1..i-1] is data */
> +			ret = fbtft_write_buf_dc(par, &buf[0], 1, 0);
> +			if (ret < 0)
> +				goto out_free;
> +
> +			if (i > 1) {
> +				ret = fbtft_write_buf_dc(par, &buf[1], i - 1, 1);
> +				if (ret < 0)
> +					goto out_free;
> +			}

I believe this is incorrect change and has not to be applied. write !=
write_register. Without any evidence of testing, definite NAK to it.
Otherwise, please provide detailed testing pattern and which devices were
tested.

-- 
With Best Regards,
Andy Shevchenko


