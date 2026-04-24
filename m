Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A638AC88;
	Fri, 24 Apr 2026 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023531; cv=none; b=Aask4LqjC62zYTTJkGQr1SPWIHLH6jBgAkazU/3a0eX34NRoglkcXjupSs3icGN3Zh2Bz2z8cHP4/bH0DssJkEeozQlfXKFHWEMG2hUmA8tq9msb3AkgsMsR1itCVpsQZWi+1B7Vrp6oeO0G7mi4/dGYsUxM6cNnMyJ0md+I/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023531; c=relaxed/simple;
	bh=avwJV/Zc9vgx6d4vXiWKmwklGRqAQzwWkTaaoTqstbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIkmd7cuhdRsAnzt7O/RzpPf4RAvwbj6A0weraicC406mbhbwm6hpTmy+yCfI7mHqkZUVrJMS0pz7WakYfPSvX/PF/pvT399GtRvNRmuGkvqAb2zgEXXm0amRHQY1p+/WNbzkAOAk64g478EDIUGtSbZlNujHBIc2R25vtrXxG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHAOnc8M; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHAOnc8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777023531; x=1808559531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=avwJV/Zc9vgx6d4vXiWKmwklGRqAQzwWkTaaoTqstbk=;
  b=cHAOnc8MNmWjTlxCnMl0DlrxjHfnTB9sC9piz3Iril9j3FZ01NFns0M7
   +oo/rUiCVe+SWiOokjZh5vzcm5HRMWDQ6W5NLYn6cB45kOkvZ+3e6tor+
   lYhKNZk7Y8+9cr9G5g7KTaaeBVbPXLNXd8xo/8NQ8VSlFGs3jfL0Hy0nw
   FvtSd2nzBGB+Iee7JNsBkWK7ZHYqVLA+9NqFcrja4jRb/4THqlGPt4pMa
   M+BOHsOcblXurfReSDrEFkm91dM36f+/HPi/qKggW/IPe+V2lwRGfIQ+m
   KD4hu1wOtcV7PMV8S4QWjFgzraVcpB8Vp9l3d9kLRG5of55kBcwvC4ecX
   A==;
X-CSE-ConnectionGUID: 60dFAQLJQaO28i6vXo2g2A==
X-CSE-MsgGUID: cGRxtoZ4RIuUoysCEsydyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89385608"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="89385608"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:38:50 -0700
X-CSE-ConnectionGUID: Y/IR1RYtSGuwgcjP8vnOug==
X-CSE-MsgGUID: /cTZSaDwR4CzRkjjkfwQCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="271031942"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:38:48 -0700
Date: Fri, 24 Apr 2026 12:38:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fbtft-bus: replace function-defining
 macro with concrete functions
Message-ID: <aes6JY3Ht6p1VpFa@ashevche-desk.local>
References: <20260424092818.3322248-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424092818.3322248-1-hossu.alexandru@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 11:28:18AM +0200, Alexandru Hossu wrote:
> The define_fbtft_write_reg macro defines full function bodies including
> a goto statement and a trailing semicolon on EXPORT_SYMBOL(), which
> violates kernel coding style (checkpatch reports 2 ERRORs, 2 WARNINGs,
> and 5 CHECKs).

OK.

> Replace it with three concrete C functions that are semantically
> identical to the macro expansions:
>   - fbtft_write_reg8_bus8   (u8 buffer, u8 data)
>   - fbtft_write_reg16_bus8  (__be16 buffer, u16 data, cpu_to_be16)
>   - fbtft_write_reg16_bus16 (u16 buffer, u16 data)
> 
> The function declarations in fbtft.h are already present and unchanged.

I'm not sure this patch improves the code. What I see it's harder to follow.
NAK.

You can consider different approach(es), using _Generic() or so, but I forecast
that none of them will be better than the current code.

You also can address just a small chunk of that, exempli gratia, moving out
EXPORT_*() along with some wrappers leaving the main body of the macro
untouched. This might be a compromise. Dunno. If Greg has no objections, you
can try it out.

-- 
With Best Regards,
Andy Shevchenko


