Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792940662;
	b=3zyd4qPsd1HzdQjNsqoejKEmrWhO+uCDLeL4Tez9I1gx9I1fjJmCjK1cU6vVKDow+OgM
	 FPUQasGT0Ib6MerzmNcquxGt88wqvpB0DX/reSkb1Zw+IBGc/PJN2E1QYi0C7YNtpin1I
	 kkRAZlKW7wVO4TKE5/lEnuwEPUrNDFhRxx4XEDSnSQ8RuJQrMpmKrEJb4pysiX3QXrC1T
	 1cNub6dyzh210S+dS46w8YdlRUq3kCq/pK49zup+xKnn9W7KRGwvkpPnYzjU8hecyPoE2
	 N4lP3N7MVzYQWvLX7bbLzHiKizm9NIHndILDJdeprnMo+WYykgHcEy7/AAQSmS40wyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792940662;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=rS3/wqoyUiFC/nwlEVyVdFa4VAmvnpE3Qb2WkVE+lSE=;
	b=344R/nswe8DinE1bbZJaxP1J8e7r6Vrmw8slnnkRRCGxUh2fHb79UXKHPp/R54HZbEh3
	 lWwattlyPLwqeHZ+ThO2A2AAP8E+O4nst2flpNOs7ITblyocbvJS/eGOi6zWAayPG460+
	 83BBCyvVQBBYewgUaSkfstkyTlj0tHpTjus0lxC6ZhuOFt546BiVv22UosUY5fhBrTlig
	 ExVIKpEK+3B3v97fvOsx0mhmZDOzqpNQ0QfdW0D3OwI1pkmw5PSIu5O3XlYReY3mQmwiS
	 9ag777omlqL/7wRTRONBGrT+UZXOlzd3QIIobtcOqhyOLUNbFPN/HIioFKI81MCvP6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NT8kzVzT;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B98606A31B;
	Sun, 25 Oct 2026 15:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63B98606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NT8kzVzT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792940661; x=1824476661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mbitdxTff249OBDqO5321R0i6ugZINRmq8qsd0e14/U=;
  b=NT8kzVzTDbOLMSXUsBaCvB7A4KRSJGK2b+C4a4c+yZpz0qpdpUozKdWa
   ML2W/d4UK9xQKJZe7baMbDdIpXEDLpIW8PZzWvWPM30QlhmkhoD3P5Ia1
   vSGXgLg/TY7tr5zEorNxfA86Bkyqr+79NPkbXa3o0o3mO9n11Ya/3GuJ7
   wxaRwu4TGXKrg+gXZ7Rc4VpFu3UnA57w4u9Eg2Y6PW0DwxlGK4V85pfY6
   2vQzhJQ1kxGo7EHrcwA0ToCXJ13fLQwQOmS+heVfceuRp0CohQiS1Lfus
   97Dq3rxGzemlHj/v7sgvoxgYyjbnoeYzp7IJ2oTzgpCn+LIaR8Rj14eBX
   g==;
X-CSE-ConnectionGUID: e6424VpLTsa44yc9Fd4Mnw==
X-CSE-MsgGUID: swPqWkwWSaGqb7qNh9blIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1623171"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1623171"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 08:04:21 -0700
X-CSE-ConnectionGUID: pobX85RvRdSp/PhX9BTmGw==
X-CSE-MsgGUID: g5SvmkfrRiurS7nX9CyIDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4404121"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 08:04:18 -0700
Date: Sun, 25 Oct 2026 17:04:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
Cc: julia.lawall@inria.fr, gregkh@linuxfoundation.org, andy@kernel.org,
	outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: fbtft: fb_upd161704: Replace udelay() with
 usleep_range()
Message-ID: <at4acP_svOxU9_mP@ashevche-desk.local>
References: <CAHxSwT_bdBdiwwXpGpr9+rGizZU3p+RsB18hPH5TxqMuMZOsQw@mail.gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHxSwT_bdBdiwwXpGpr9+rGizZU3p+RsB18hPH5TxqMuMZOsQw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 03:22:30PM +0100, Abubakar Musa Samaila wrote:
> Replace udelay() calls inside the init_display() initialization
> sequence with usleep_range() to avoid CPU busy-waiting. Since
> init_display() runs in a non-atomic context, sleeping allows the CPU
> to yield, improving power efficiency and system responsiveness.

Please, slow down. I have already answered on very beginning version.
Don't waste time on this.

-- 
With Best Regards,
Andy Shevchenko


