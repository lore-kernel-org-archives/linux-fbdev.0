Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9A42054EF;
	Tue,  1 Apr 2025 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524814; cv=none; b=C39owBg5REEB2huWrJNsYwqcCHAOSm/UVTUlWlRFmtG5aZUdyDhU7B7Gl4GTZVTUbt4R1H9Tbm3id8a0x0ezBJDS26pAyiKnsmQjvKYf16XtYAuN2AMZ+8s9epnZkZDapyKHZOANZ0AxZCOTh4li/XimUcn5PZxoQxVQsxkjpAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524814; c=relaxed/simple;
	bh=EAyuzCs+2aGA6JWNoYg1cV/7AgO8c1Rwc/lh1E8GXvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmL4THjPoKKNaxvRHT/xWf2yLXP+M4g32xvR9t3+d7aaesWRqTPuloiD5dqTqqYZ/6r5lOcCmt9xrOvMa+NVjk5QDAJ/mkqbryEa1Tw0EiDPJid2y/hI1r4xUdfvaWVpUJ1KWqfssdb3j4ir42XVvVLfWVqOtW75l4mdV5iP72E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bY21t0uU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bY21t0uU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743524812; x=1775060812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EAyuzCs+2aGA6JWNoYg1cV/7AgO8c1Rwc/lh1E8GXvE=;
  b=bY21t0uUDJaEHR3KJlklgPEBqHLY8DoRRVYDfqKe3ByQBpT4ifw2aL54
   OiSboFHZS6CrTf50zlH89tSFIH7wDq3AHoHvNCKMbzS6/L+tStbvGQ+I0
   si3kTfvIA2H+gmAOHW3Dqt5tKAExFqoauheq2n/DNuHaMrRh+juFKajAU
   FlMKcIgY5vabIcBP8+u6q/l8gCCenkUj8xt0ZduETcQ6wighe0u3c6Wpc
   hdNfVkwWbcI63CQVKVPo2eC+lYotN8tZcjkpYH3SNcWXL6iZRgMQrl84+
   Rd8tz2OxoPkhz00dUxBciRpTd8X6NvWBHfgt9E45ZLZHLttp6wmbRNh+5
   w==;
X-CSE-ConnectionGUID: kdEFvyT5QTG+SPoZkwAYsw==
X-CSE-MsgGUID: FNIhqHJnRVmo7EOyWbub6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="55518118"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="55518118"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 09:26:51 -0700
X-CSE-ConnectionGUID: Dgz+hd4dTCWbkQrj6Lu6qQ==
X-CSE-MsgGUID: jUmcCMq5R7adXtl8eFdEPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="131633982"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 01 Apr 2025 09:26:48 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 01 Apr 2025 19:26:46 +0300
Date: Tue, 1 Apr 2025 19:26:46 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Denis Arefev <arefev@swemel.ru>
Cc: deller@gmx.de, dri-devel@lists.freedesktop.org, jani.nikula@intel.com,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, tzimmermann@suse.de
Subject: Re: [PATCH 1/1] fbdev: atyfb: Fix buffer overflow
Message-ID: <Z-wTxsV9C9MzoXl9@intel.com>
References: <e04f012b-cf10-4a84-8fbe-ece1a06f0f66@gmx.de>
 <20250401102330.7759-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250401102330.7759-1-arefev@swemel.ru>
X-Patchwork-Hint: comment

On Tue, Apr 01, 2025 at 01:23:30PM +0300, Denis Arefev wrote:
> > It's old, but still runs in some configurations and people
> > still (although probably not on daily bases) use it.
> > Also don't forget about the various old non-x86 hardware machines
> > which often used ATI cards too, and those machines are still
> > supported by Linux as well.
> 
> Hi Helge.
> Thanks for the reply.
> 
>  Ok. Everyone agrees that there is an error (buffer overflow 
> lt_lcd_regs[LCD_MISC_CNTL]).

As I said, that will never happen.

>  Ok. Everyone agrees that this code is still needed.
> 
> Then I propose to fix this error.  :)
> 
> Unfortunately, I can't do everything by the rules, I didn't save
> the chip datasheet. (I didn't think I would ever need it again.). 
> 
> Regards Denis.

-- 
Ville Syrjälä
Intel
