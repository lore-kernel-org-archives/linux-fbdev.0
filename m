Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0012931C7;
	Tue, 14 Jul 2026 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056726; cv=none; b=gdLHorWb/0CJiYjT6v9bs49niRE0hgGeyTHrc72AN5TE9vaYPnklZEV0Cg/TeLavqSfisiCG9BGp9NG0+13aDuHSXZiLIa1a4qg0Vuw6ROWXiTrlCInlGJKNvegsex9MSI/VMFXdu4FhN/h1UIePyflruvLA9DNfq08UzSZ6Tho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056726; c=relaxed/simple;
	bh=GfOYDJlWg3IZFciu0wTO8HAj2UD1NUueTFeDJjUZDeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMjG1KBmYSUF24SmTj14ORNoS524XkQPhLemkRvS+t2JI3Pe2tWfZ2CmrDw4hPmQ/5t9CnQM5aOqmaFmWws3t8f5604EGH7wrvsoL4PrsfO2KK6rmP45i0XWNUEKeIr1e3mZZPSQNOdXvrwWLQY0xvz1buBBAh9FljJ/Vs1BMzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jr2ky4QC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jr2ky4QC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784056725; x=1815592725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GfOYDJlWg3IZFciu0wTO8HAj2UD1NUueTFeDJjUZDeQ=;
  b=Jr2ky4QCcSJgrvHH0cizZiwzLi2BAou/Fl5aSJtgw16Rrz6TkshCdLSG
   K6AuVOotqZdDRbgoMjOp2DFhMhF1wvCQnRamBqB7SOfNHgGrUVvaRaZjq
   eSnN0fFZNrZE7FyKh+JVqp+B+/9cuAPaqhqmyqRG4pgcTxDZLwqQSNlBw
   PRApQpKMh6KPeJZuUMfxtdYOkoSr5D5C/t7fJB/rILXNv9HBg5cYyGYEU
   3T/Sbyk/kPulwD4RD8rVvdYHf3sPsoDr4Dg2mH+H2+C7+CKgA82zwKAI8
   D2BAeifBlZgZ95WV+q9mVj8JI8NUy7nIiRHOT0gE2kMoIidu1kfleIJ5t
   A==;
X-CSE-ConnectionGUID: NkhesPlbSwuPgdkTB6JU6Q==
X-CSE-MsgGUID: BOUyspVeSQqtd3YcQSCj0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="72211823"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="72211823"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:18:44 -0700
X-CSE-ConnectionGUID: 9jbTOM19QO6MueOyBhvGoA==
X-CSE-MsgGUID: QKTFd/3vT42zxW848QgXAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="254826846"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.44])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:18:42 -0700
Date: Tue, 14 Jul 2026 22:18:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, namcao@linutronix.de,
	tomasz.unger@yahoo.pl, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging/fbtft: Minor cleanups.
Message-ID: <alaLj25guWgLapBE@ashevche-desk.local>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 10:09:38PM +0300, Panagiotis Gravias wrote:
> Solved some style errors,
> parenthesis spacing, aligning arguments, replacing udelay() with
> usleep_range().
> 
> I hope this makes future checks with the style script cleaner and more
> helpfull.

To understand the resolution, read the mailing list archives for
the last ~6-9 months against this driver.

Also read and understand README in the folder of the driver.

-- 
With Best Regards,
Andy Shevchenko


