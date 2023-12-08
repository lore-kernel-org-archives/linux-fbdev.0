Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4RHEYlM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BE21729
	for <linux-fbdev@vger.kernel.org>; Fri,  8 Dec 2023 08:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702051243; x=1733587243;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+EXHcrZrZBDOueveSwNkypo7KesWZ6TZf0l97Fvq+84=;
  b=S4RHEYlMWFj0FDXAY8xJbHGU6roqm6z2s6k9YJugGPNbTNeSdRiMxjVT
   tR4IRwcVU7ReHvpDbO8c/qX7IwVj1m0Ku4FZqsq8eAc7B9BZXKUdNnRnl
   gI9WstEI26e8WrT806Lsx//xDhC1L3t/pmf4Eg/y4YptDUW3U9jOyBHMz
   0vFHv28zlfLmHdQ+6303rgjN93nNifIbgXoWnaScEkkMMISx3vhBq6sQ9
   UUoXaYig+8D6Qc192XPCvA33nn5vA08skoALBQ4hXW8wWd+NXdGoUZbi/
   VcBeVaV3Wt0dJQ9XHfvTuZesRCTBKTBcivmFAfXSWoRgoxLT9yT1ArlIS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1244977"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="1244977"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 08:00:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1019381416"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="1019381416"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 08:00:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rBdHI-000000047LX-3TqS;
	Fri, 08 Dec 2023 18:00:36 +0200
Date: Fri, 8 Dec 2023 18:00:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Priit Laes <plaes@plaes.org>, Dillon Min <dillon.minfei@gmail.com>,
	Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
	David Lechner <dlechner@baylibre.com>
Subject: State of affairs with Ilitek 9341 support
Message-ID: <ZXM9pG-53V4S8E2H@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

Included authors and latest (non-white-space) contributors to the drivers
in question along with relevant mailing list and respective (active in the
area) maintainers.

I already had risen the question in times when 4th (sic!) driver for the same
hardware was about to be pulled into upstream that we have to somehow reduce
the code base and unify device properties.

So, the main question here "What is the plan and where are we now?"

I admit that fbtft case is special as it supports, in particular, platform
device (parallel interface) and also well established in the embedded world.
What about the rest?

N.B. Besides the fact that panel drivers are too OF-centric, which is bad
practice for the new kernel code in general and has to be stopped. I.o.w.
seeing of_property_*() or alike in the driver after ca. 2020 should be
immediate NAK unless it's very well justified why it may not be used on
non-OF systems.

-- 
With Best Regards,
Andy Shevchenko


