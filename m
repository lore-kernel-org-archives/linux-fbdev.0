Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AAE27602C
	for <linux-fbdev@vger.kernel.org>; Mon,  5 Jan 2026 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631044; cv=none; b=k2TaZcuYlhwxUDfKGNM4AHqe/dIjJ9kSfQHKfi/C/FUdXqshioKJkNqEnabFp+WUyU0Q2zxvPfSMFaJm0frxHsr2IQuUfEJ4ntn63kO0hX56hy2bsT/8UFBgEqMgkZ5lE3yr6sGLwB260chlWjTGT7hJQKYJfYMc48N8oRGE+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631044; c=relaxed/simple;
	bh=qZAn9J61xyp2Ig1CyWZxSXFDkMK7qiIB3/dvwnNhe+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNqcg4sC1nhk4hxAe6k2zGBbUQMGOwZA4dOWjSfAgnfkI8AUe/3dM/3Hc0Sq6XuK9Lz9KEIh1TBWSoeMzE44gNmVQgND4RqQ1/vOgzzD+gPkLbx93evvi7XyirkHz7P/wDBRfsJuB4P1ZDE2gac4TVGFaIOrJLOFn7O4TUjoPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j48M/g0y; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j48M/g0y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767631043; x=1799167043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qZAn9J61xyp2Ig1CyWZxSXFDkMK7qiIB3/dvwnNhe+g=;
  b=j48M/g0y9HdvltDknINJnonCXlcNqCcZ4k5TI8dUrNYSl2p4GkO6RzlY
   2LVV2fVxht5ZVzlDLNLewRPNcIl2u47AhiHBAHS286bdrOOTESJ8liVRf
   n9VLDma/qPsKks88UcMKXACjFPqVnqIomIdij6SXQuZBYdnlXGCkCEgTe
   eE0xHIwz52lxzu1dRYxemcU/543e8Pa3/3UIXHJB2pXnRWFPM8LW11nYX
   4JLzQEZzgXuJYiSLn3WY/FpsiXHDshq8QUYrZTQ8AGgnqzyog/ELEZGiR
   BRqZjpSkOdM2IqiJe+d/vorQHeWuGo2i415Mdw6R3RyxVCs7P7TQii7Ki
   g==;
X-CSE-ConnectionGUID: BIWR09puS6aMfogFtZoeWg==
X-CSE-MsgGUID: 0Rmg/PyxQl2xktmXrQqd1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79632668"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="79632668"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 08:37:01 -0800
X-CSE-ConnectionGUID: y6OEChXgRsWd37sdoT/7/w==
X-CSE-MsgGUID: TKzZCZDEQLevivsC5HWQ9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="202475744"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 08:36:59 -0800
Date: Mon, 5 Jan 2026 18:36:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 4/4] staging: fbtft: hx8353d: send LUT via buffer to
 reduce stack usage
Message-ID: <aVvoqP9ONrNF45N4@smile.fi.intel.com>
References: <20260104110638.532615-1-sun.jian.kdev@gmail.com>
 <20260104110638.532615-5-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104110638.532615-5-sun.jian.kdev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jan 04, 2026 at 07:06:38PM +0800, Sun Jian wrote:
> Clang reports a large stack frame in init_display()
>  (-Wframe-larger-than=1024) due to the very large
>  write_reg(MIPI_DCS_WRITE_LUT, ...) call.
> 
> Send MIPI_DCS_WRITE_LUT followed by the LUT payload using
> fbtft_write_buf_dc() to avoid the varargs/NUMARGS stack blow-up.
> 
> No functional change intended.

...

> +static const u8 lut[] = {
> +			  0,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30,
> +			 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62,
> +			  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
> +			 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
> +			 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
> +			 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
> +			  0,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30,
> +			 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62,
> +			  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
> +			 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
> +			 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
> +			 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,

Two tabs too many on each line.

> +		};
> +

-- 
With Best Regards,
Andy Shevchenko


