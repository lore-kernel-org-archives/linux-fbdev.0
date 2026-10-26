Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006599;
	b=36kIJFF5Ch0/fRBjISn5/lnWYJ1NLv5rbFCQKaF+uBMe2dse7JGm/XVwkPwltiPJ+ptl
	 Y4yXaxLTnhgSnul4gAJ99d5ULLkMAiFpdtoidk2mP2yWJcjvrGuSBFnoMd4R3mgm8RWVI
	 yC4Tq3Ww/oLuXT6usMkI/f3cjYpN8rrw4ksesD4ncexRyhr2tvzJ9YCn8LR8+t1YiF/yz
	 lzvY9Pfp36vL1jG6u+7+htLAFRHXWLflwiQ/tiqN5LeBKO/AKyq/qPtLOrT9udB/8QtvJ
	 LqoFXGS5N9LESb1Fdvvp1kzY90YDXECG2fbZmqxu+D0JxHwBAJsC7ZeLe1xXqRtI2zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006599;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=9VDRmMuQ5dSrHl8KcWe2A3th4bGKKhbN9IY80G3C7/I=;
	b=anhCqLJIUbxNwivyXD2u0iXQHaahy4Dr6bObapaMvbeOzLCm0E5lCmlimXC60EdyB+Ys
	 iUYkwYFf1u836Nleo3aDMNgLdmi1cx+EXU2cwN/BgRkdYWfvSJtlYLeE5WKVNAcVqBiC+
	 utV+zbXpOqwMvRoraxtf6kJSa5riXcSDngkf+tak5xKSgCX2rXmVLBnXZfHF51pimVj1l
	 DcUlgyJXlOeQZqxKsokpw+dol4APcfIsnzet3q+fBeSy/gSprgtHKoIZN7973BYreQ4Kl
	 EErqw4Huc9Gr/sR8d/t4QdnXhILTmQntWgTVpZT8ti5pdXQ/YRnn4bHQMCZJhlJdfJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ddU5GUeq;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3CA606A31D;
	Mon, 26 Oct 2026 09:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A3CA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ddU5GUeq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793006598; x=1824542598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ALfXT6p+x9/XFdJ+2jlIdBOHagihEU97rKVJ21I5/o4=;
  b=ddU5GUeqjNpW36ea1Ne2kiQuxTw0ce0UbPwOUXSxnrxJpD1dJH1/JXNr
   0JWXifo2MB2y3Tnoctvgx3ewWYhiVDtvxV1ID17NOuPVos7+a+/bpQpr/
   y92gXIMuKyLRvrBq2B6/R68VxcHJ1UsFcPvyXDw3TG1d4AyzsUHqw2/gc
   5DJmxScLt2T83/NEDjtoSN3FSVfL+5mXNOtuhQ9ZsMZf6EN4/mvoegfc1
   07hydsokyBAwmGMwkUrtwpXOEbxjQhNfmRsEqGMEM7TtTraJ5MeD1BiHc
   jqVQf+SsKegCAQxqBNykl0qrAx1RbDl5N2OETkxghlCMpOpu5BQh7iyeZ
   w==;
X-CSE-ConnectionGUID: HYkL1yXSR6W9lcwG8YkYLg==
X-CSE-MsgGUID: pE+xM6wORMCQXIsQh6xuZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1567461"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1567461"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:23:17 -0700
X-CSE-ConnectionGUID: lGKcouszRSCw3Nn7lI1Gxw==
X-CSE-MsgGUID: PAVjpMrQSGeEQKIGwuH/3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4269885"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:23:15 -0700
Date: Mon, 26 Oct 2026 11:23:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com,
	cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org
Subject: Re: [PATCH] staging: fbtft: Remove unused macro
Message-ID: <at8cAMm6psyWsqbe@ashevche-desk.local>
References: <20261026081832.60570-1-himanshu.bakshi478@gmail.com>
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
In-Reply-To: <20261026081832.60570-1-himanshu.bakshi478@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 01:48:32PM +0530, himanshu bakshi wrote:
> From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> 
> fbtft_init_dbg is not used in drivers/staging/fbtft directory and

We refer to the functions and semantically similar macros as
func() or macro() in the text and comments.

> since dev_dbg messages are good enough, fbtft_init_dbg should be

Ditto for both dev_dbg() and fbtft_init_dbg().

> removed. After compiling the driver, there are no undefined macro
> issues.

> Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> ---

It doesn't say how you tested this, though.

...

Code wise LGTM.

-- 
With Best Regards,
Andy Shevchenko


