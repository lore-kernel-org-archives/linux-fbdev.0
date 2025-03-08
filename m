Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B738F91;
	Sat,  8 Mar 2025 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741467675; cv=none; b=uFERoTaD+PW7svyrJo/t/NYO8g0LvkK0GJWkfDyvIrKHT4jkQorn2Wg4h8ZkZK5XvhcDarZ+qo+yPbKkArK7iNG3OVNlguDtse2G2cA/a9xQsJWc0hkd2u/nehuFSmsZ3OE+jjlgIUkz+OrGfbhUbFqVOCXoP9CYC0lobA8mjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741467675; c=relaxed/simple;
	bh=Llm0VCPcIbPZNGLaBuiTx5atCb6gaqgG3GYtd5TmHMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDg9hDS9cn5BKOf4DuFh9xqhtM0GzBhx/5SnJOBwdHaPz2httq3Zlz3sSLoL93uU4WSjOgNgC5wh1yFqGB7X1e2qgtcoqbpKOKz285AZDUjFcyP94ona9LT2k/7YxPD2UfQVYNZjgzYItVg0wR5c4IYWela67YJ2ShkKD0IRwhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D26bn7Wy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D26bn7Wy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741467674; x=1773003674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Llm0VCPcIbPZNGLaBuiTx5atCb6gaqgG3GYtd5TmHMw=;
  b=D26bn7Wy73LtrwSUzU3YQQQYXEJjvyk4br7KksAW373PEZ516Vof/TwZ
   PK3rbLdIaMs3XYCNTGtWaI8SB2r2cOvbyMs9XCBYF8DB3i3CW0hKT9V/G
   1yEsz9H7MQYxyik5uBCunl3K2KStSakOUZhJmJ+WY8naaMRNlWjOGXdx3
   jhJ+TjjFfxJuf74bg/bvELwzTVS/JLTt1O2q8xBsuYn60j3A81at1lvzw
   pLcr7Qp1sj8caVyRHc5mk1novr8EvKm+4VVMpguqjNPYSMSWJ5VrgPtpN
   saFEY3iB4wPhg1ooXpf7g6BQgEM57nVYa7buniNjIiP0bdzmGgG+H2rbx
   g==;
X-CSE-ConnectionGUID: G1n6M3WBR/COgKsI0Y1xyg==
X-CSE-MsgGUID: HWpNl6gTTlC+J7E1q4cY2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="60051970"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="60051970"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:01:13 -0800
X-CSE-ConnectionGUID: 5eRYaizUQ/O1oISBG1P12g==
X-CSE-MsgGUID: pkpBJONxSqemJs0xVtyonQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120540422"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:01:11 -0800
Date: Sat, 8 Mar 2025 23:01:07 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: deller@gmx.de, tzimmermann@suse.de, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fbdev: pxafb: use devm_kmemdup*()
Message-ID: <Z8ywEzFvWxb59LqK@black.fi.intel.com>
References: <20250228071009.150971-1-raag.jadav@intel.com>
 <Z8Gt8fg07Y-bFPGT@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8Gt8fg07Y-bFPGT@smile.fi.intel.com>

On Fri, Feb 28, 2025 at 02:37:05PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 28, 2025 at 12:40:09PM +0530, Raag Jadav wrote:
> > Convert to use devm_kmemdup() and devm_kmemdup_array() which are
> > more robust.
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you.

Anything I can do to move this forward?

Raag
