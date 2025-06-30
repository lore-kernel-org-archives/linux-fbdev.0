Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A36B1FF7D7;
	Mon, 30 Jun 2025 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751277524; cv=none; b=LnwPAnfIc4DQ3QtjkRMDB2fW4MMDsRruyKwOEByeqUOuvR9W2yCGXoz9dixoS6Ch/fgLMMFCbKqyTLz7TTDrxRxuqv5KoQbdVtfHVGv2aabBs4A1VPuP82Gbfx1TQRXXJrPLa1oaTbXMQrn2cr5AVM1Doz0ziF84+q6Abp4v0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751277524; c=relaxed/simple;
	bh=u23tRIG5AKycjYRdWZohGiYfkQVU8vEmAjQn2jj4E/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ppf0hYGtV/Ji0+3nCcWbVN71U7OGSV6ZjhJqswryTftoZqqm04jBOmvKHpiT2PJ8QkqoKsAIR+rMc+Omgady/CxWqEZIowjtjJBxawsXNNmiHnSe4LXJvBYOHyrgNVmNEQTmioBhx+hSVMdbHs83/sgomRYTy3On+A+9YLpWxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+CCT5Xf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+CCT5Xf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751277523; x=1782813523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u23tRIG5AKycjYRdWZohGiYfkQVU8vEmAjQn2jj4E/Q=;
  b=h+CCT5Xf3feFS6Ol5EEGQtsFQavL6Q9WWvNxXA7G2WS8Ze5sG9aYmQ+e
   6QAqio6awnx1SUYsEeLtqydfz9B81wqz/U6YRElXB3r8MccrBgkl83FHX
   F84Kb83WeOyXxNX/S+KeXVJAE6yx5ald1kVZy3nR7NXtWxIZtrEJx84fw
   QnUDwL0SOsrAOaOFa4tV7GRoGPX/VL9naMX2Vv8X4ob+J9SBesNKs99UI
   /VRTXoifA2V98p+TF8UQ397FG2i98jraeftbRBdvNH7dDXwyB57IWv7Kj
   GgL74Al8KEmfDPAD4maWSG0vylNfYCYGXVXtDXVPSDYaSyvtWnqNE50r3
   A==;
X-CSE-ConnectionGUID: QSOfDBgdTTuDy0Iso22mYQ==
X-CSE-MsgGUID: /8erv1LFTGSWEtNKqJJ0Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53373450"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="53373450"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 02:58:42 -0700
X-CSE-ConnectionGUID: wbaq0Jy1R1akqnHbwhDl6A==
X-CSE-MsgGUID: dzXN/BXlSgGoFTxg4XM9Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="154129567"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 02:58:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWBHX-0000000BGjL-2p1S;
	Mon, 30 Jun 2025 12:58:35 +0300
Date: Mon, 30 Jun 2025 12:58:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: andy@kernel.org, dan.carpenter@linaro.org, gregkh@linuxfoundation.org,
	lorenzo.stoakes@oracle.com, tzimmermann@suse.de,
	riyandhiman14@gmail.com, willy@infradead.org, notro@tronnes.org,
	thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] staging: fbtft: cleanup fbtft_framebuffer_alloc()
Message-ID: <aGJfy2YUZW0cXk3B@smile.fi.intel.com>
References: <cover.1751207100.git.abdun.nihaal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751207100.git.abdun.nihaal@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 29, 2025 at 08:10:09PM +0530, Abdun Nihaal wrote:
> Fix a potential memory leak and cleanup error handling in
> fbtft_framebuffer_alloc().

Both looks okay to me now.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


