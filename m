Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000EB24A051;
	Wed,  3 Dec 2025 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764755354; cv=none; b=Otlv9EE4LOoq3b6V8O4fMCoDJ7PPL6hGK4ucOTSc1rxK43PD9++uRKbbO3kVwtCKFoII8m02TFaq62/DtYATaeRCWT+NXjdnWplc0bVjiDbG89l+qXzpnPNX2ORofLBnACqeteRyzOzNIuC0Is6fl5LFa2+zPbCePf8dB7KSIuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764755354; c=relaxed/simple;
	bh=+y+ApfGHtvycxU7K4CHZWLTcI3W9kqMhc7+aZGtfHlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/xYI8zsECZQ6MlC5j5gVJgUcY9rrD2/5uXdywWhypo4FPR0FfYdKarEnUev0T4+PnUWrx5ZtUK9uLFCheA7DI9JQtIS6KzG4Z0NK86xtkJEzajxQQ6/vjXZx9xt2px+L6G/xDwh4sWcIxumGTrd2iHvZKUpiLr+vztFhB24A3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHj0cfMI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHj0cfMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764755353; x=1796291353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+y+ApfGHtvycxU7K4CHZWLTcI3W9kqMhc7+aZGtfHlE=;
  b=OHj0cfMIXEsJNpTgDcJLP/dK6NCY2pxYBwg9mufr86zJLlGCBX1VhY4Y
   6S+jOputN11I11BtqCg+9H/rzqVA+s6CjrEol/D8nIswk2FqGQmk2wmlZ
   Ryw/8wo0nC2efkTNiRknA/sILj+RyRhhRabmMUTWU1PpSeydiuhXxujFq
   TguRcB4Zu5+jEUbYjUKtw3KKDZrXWObdFGCrqN9UgCw50lFjjvnwMzyoX
   TgstBddoJAIzffJAY2Jp2qRrUVyUtsAHMoCCUz41TJYmh1q4sCfxZEQTi
   /PtwS2KiMG6ZrArPR6TJUVxr2iaZ0Bkjw1G+kkH+tVV0JE/Bh5zwLHgB+
   A==;
X-CSE-ConnectionGUID: nSEZ2B1sTjSPxet9Y8qYSQ==
X-CSE-MsgGUID: tgLrpGErTBuOxFnAWRykeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="65931140"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="65931140"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 01:49:12 -0800
X-CSE-ConnectionGUID: Ligm7xApQ+ysHdo5uJFotw==
X-CSE-MsgGUID: 2GSroBjKTIScsZRWaWWZ6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="193915649"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 01:49:10 -0800
Date: Wed, 3 Dec 2025 11:49:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Helge Deller <deller@gmx.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Raag Jadav <raag.jadav@intel.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev/pxafb: Fix multiple clamped values in
 pxafb_adjust_timing
Message-ID: <aTAHkxg1_LDzZNSb@smile.fi.intel.com>
References: <20251202181600.511166-2-thorsten.blum@linux.dev>
 <a7213b69-f6ae-4975-8c8b-2783dbe9f9b3@gmx.de>
 <C3FDBCE7-14D9-4999-B463-C2E3E384E7DB@linux.dev>
 <77ac64e5-709d-4eb5-8b47-9fc15e579d1a@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ac64e5-709d-4eb5-8b47-9fc15e579d1a@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 02, 2025 at 08:36:08PM +0100, Helge Deller wrote:
> On 12/2/25 19:36, Thorsten Blum wrote:
> > On 2. Dec 2025, at 19:28, Helge Deller wrote:
> > > On 12/2/25 19:15, Thorsten Blum wrote:

...

> > > How did you notice? Do you actually have the hardware and tested it?
> > 
> > I only compile-tested it.
> > 
> > I stumbled upon another driver with the same bug and then used grep to
> > search for other instances and found about 6 or 7, including this one.
> 
> Ok. But this then means, maybe the clamping isn't needed (since nobody complained),
> or that nobody noticed because nobody uses the driver any longer.

I think it's a combination of factors: 1) rarely people have this hardware,
especially nowadays, to run more or less new kernel; 2) there are no conditions
happened that this patch fixes in their environments; 3) something else I
missed.


-- 
With Best Regards,
Andy Shevchenko


