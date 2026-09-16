Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27772BE7BE;
	Wed, 16 Sep 2026 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571889; cv=none; b=RtSe1sv/5EE0DU1pnd8jPecsniMC8iG++LFDFIT+VWrbgFQwCOfE8hikNHueMSV/RBcK5nH1fYxbkyHq/+2XE6eJgy5YexSKpTSKtS7fhexjqM4RGfqZuryRtHsVSBBRcp/cOE2Sni294gJqfKZjzw+REbikmzXnK8IEj7OJAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571889; c=relaxed/simple;
	bh=VNhfwe1YQNfXfL4xlEP5bFJpLb9Qtlo/4pyZP6bIrus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFvvbJ+4uY9kKHUsFjRa5gPS1BhvaOoKg7rr8r/6aiPYsMsU7VnGxdynKUZa6WsCZTijLvr2oyox0Cbf4PHYbaC9fDTc10qC3fpqqbKkUmLKFOTTsOrxN8C2NCgzZb/wBSQbvFkZS8++ZHnJCR5N7S9gzVG455bpBFs7+YGvVS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sw3fZ1Il; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sw3fZ1Il"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789571886; x=1821107886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VNhfwe1YQNfXfL4xlEP5bFJpLb9Qtlo/4pyZP6bIrus=;
  b=Sw3fZ1Ilzruuy/TVt/tjUBz8rYUoLv2RpY2D7oKy0M1uMGL2zWAZ3cP7
   nGA7ZwT7VDQ/rx5pYf9/oK09x9O5ABi1GFbvf7JNUrYK3QeBOgQH8oAg7
   bjCxYYe+BmoIrdjreOeO+lY/U2pZZI5AwBL4k54EtODDentRSDCY9f8W8
   +4sDSAqEPnRxFidvL2q8zxCCf0vvmVl1HK/FEs/UPeBPGKRqWEPKmV7d5
   cmF0F1QvmZvwflb7wXoyBQ3owv096Emg+17yszk/EcXQiTsgbE3YgTODf
   +9Epbe0NUasGqEPv1eFox7ihpqfWJI1yOIH9iGwUotc0a941US+sztFXn
   A==;
X-CSE-ConnectionGUID: +qLrWvKFTSqExsby88A5uQ==
X-CSE-MsgGUID: TixoiuaiRFakNPUWO6QS/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112719140"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="112719140"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 08:17:48 -0700
X-CSE-ConnectionGUID: UjFCmABbSWSbvLBWnu+Ucw==
X-CSE-MsgGUID: xzBrnVp1SNiA+cWrRKRxIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270736684"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 08:17:46 -0700
Date: Wed, 16 Sep 2026 18:17:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?=D6mer?= PALA <palaomer100@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, andy@kernel.org,
	gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_upd161704: replace udelay with
 usleep_range
Message-ID: <aqqzFxRfbxf14uld@ashevche-desk.local>
References: <20260916093928.52057-1-palaomer100@gmail.com>
 <87ecet5xos.fsf@yellow.woof>
 <aqp4GA1q6cLKivZo@ashevche-desk.local>
 <CAKhZXnr0GdUrEu9vyMAWRCWyQzPM7cWQ6LRDa8fX0hnMkTN0RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKhZXnr0GdUrEu9vyMAWRCWyQzPM7cWQ6LRDa8fX0hnMkTN0RQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 03:08:06PM +0300, Ömer PALA wrote:
> On Wed, Sep 16, 2026 at 12:39:28PM +0300, Andy Shevchenko wrote:

...

> Second, do you understand the difference on what
> code is doing before and after your change?
> I understand that udelay() provides deterministic, busy-wait timing required for
> hardware register initialization, whereas usleep_range() introduces scheduler
> overhead and non-deterministic delays.
> Out of technical curiosity regarding the driver IC: theoretically, if we knew
> the exact window between the hardware lock/stabilization
> time (min) and the internal state-machine timeout (max) from the datasheet,
> would a range like usleep_range(min, max) be acceptable,
> or does scheduler wake-up latency make it too risky for
> timing-critical init sequences without hardware validation?
> I will drop this patch series.

It's not only about timings, longer sleeps most likely are fine, the main
problem is atomicity.

...

Note, your reply is malformed. Choose proper tools to communicate in
the Linux kernel mailing lists.

-- 
With Best Regards,
Andy Shevchenko


