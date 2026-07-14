Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0A2931D9;
	Tue, 14 Jul 2026 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056645; cv=none; b=Spcv3MHb4aFtBMoxwqCbjQ1UCkLy2XiZ22aZvkKeNvsTbUhzV+9cehvgqf07D5VAlvQ/Mz7GnC3OJbOIKpAHCU0JMfqCtNmqYJ4QxuTk3rt2SH2UuGESUZ3Pb7ZSMUy1EpVuz5jzUwZngyVe4/OQvco9xKEcFL/LjNJ8JLsLz0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056645; c=relaxed/simple;
	bh=7oMSiFqzsngJQfhftA9zEgk1fk7cR0n1+K9qdFdbQLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuJTizPZwVXiRUHCsW7OjJYA0qcSRkFg7o6LGWlDVF7mzZKuoAn9ys0Kp6/d97hh1PEZtxkiom1cQ7RS4syuiNIo8vDRxiMAVl65zYFuSaoPlRLRqknMCyZ0grnmvKOiw6Q+qqh5uhWDWEBdPRnRMjmL0dH5Lqr4mkxmf6mlYOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKhKI6Di; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKhKI6Di"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784056644; x=1815592644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7oMSiFqzsngJQfhftA9zEgk1fk7cR0n1+K9qdFdbQLY=;
  b=HKhKI6DivQjWUoUl5o/izv8Ieg1s5Z04u5dQjoLEOkJK1uqj7SeSnq16
   Jo6RoLkss7tSGFdlBnWrdKwlI6VVDZG+HnlFobFiu1oqAdY8tJaFNPenq
   QxmckWM6+SzCP8V/cU+ZucZIPRcJ4Cc6P/RTNAhgP4M68AsBg2uXcsOHP
   mWSVei2xVasH1ReiURGdh3x9ZzNowlob/vBDt7+CnU6XlRmly7NPacgX7
   gd4zw1w+qPAc8q40ALTKB3Q8CKGYDW1Vm7DJL/27hn+6tMkg0dxKywbTc
   U6XoRyqxWq4NpYPooKD5aQHikMXHa4X/wfg9vVX5hijd4zbiNkkXm1Q3p
   g==;
X-CSE-ConnectionGUID: u4C+JeStRtyfq3jkbX8bFw==
X-CSE-MsgGUID: AaRXHmmeRWywfHPjIfa3sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84571089"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84571089"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:17:23 -0700
X-CSE-ConnectionGUID: ZC1i3ojGT8G8KVTmVn6frQ==
X-CSE-MsgGUID: o9ZdukvkTd2+FbCv3zJ26w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="280366155"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:17:21 -0700
Date: Tue, 14 Jul 2026 22:17:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, namcao@linutronix.de,
	tomasz.unger@yahoo.pl, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: fbtft: Replace udelay with usleep_range
Message-ID: <alaLPsPIfCxyGVPK@ashevche-desk.local>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
 <20260714190958.219437-6-graviaspanagiotis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714190958.219437-6-graviaspanagiotis1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 10:09:42PM +0300, Panagiotis Gravias wrote:
> Fix checkpatch warnings preferring usleep_range over udelay.
> Replaced udelay() calls with usleep_range() providing a reasonable
> upper bound to allow the scheduler to coalesce timer interrupts.

NAK.

-- 
With Best Regards,
Andy Shevchenko


