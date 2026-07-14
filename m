Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF572931F9;
	Tue, 14 Jul 2026 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056610; cv=none; b=I3/6FZ9MymTpOx2xF9ll/zyKCZ3mAucXXrWTroMhGhKbEdU/vgOSa2aBnmOOlfvX9xQ9hQbY0rlrM47CgeqhxoTWj7Fbp5jr5L0qpzVPeoryFD1cBjkaAmPfuVerxIPpzAMRqi6HzzX95AFzWl4/sH9dD+9yQJ79ATMdT3Fsyok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056610; c=relaxed/simple;
	bh=vwEUmzthtgXtBV3gviih/x4BpS1vwgxMWy4IoVbq670=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPZQwUbA7ubtYxnUVSd4LGLSLWiNfzcTvo8HG1olhS6yIEkPHGG4q76eXbJWjSga9QpeSLDFSY8J96IwejdXkWyBWeETv+n0x57EHlxnLKz+5QsjNIcpz3VKqY7RRBGUqqHKtuciChpk3Xy/UlO9VehTVrNe2iBJylvjX6KZbBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNPv7V2P; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNPv7V2P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784056606; x=1815592606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vwEUmzthtgXtBV3gviih/x4BpS1vwgxMWy4IoVbq670=;
  b=kNPv7V2Pc8UucK2mvFdaq1s28nVHBnke5rLYTkemZ8ZbcRguXaPzWQFy
   nD1ipikv8NBokc1yBqZ3U8wvMRovO7XGAB7shZqAvv979f2+gDX64FWhs
   fct8EODzMqThiRzE997RF/kGx5CMQlX8a7dlc+kCVZnjd2INpe1MCcwye
   tFmb4RRmC5scdmOAVRHAx4D6pfuT0DRnvYFzHmaZuzLBNNVrmrXRX6qqd
   q5JkvNSfIe+GfkqFg27r+XQ1/DmuxEKEV+ufGUi1oN2vJVxPg79CNkWSY
   xFRQnRTDrcpU0jal8zznHdSJFjRgnGXdmYFUwkoEsPJP1ANAg9nb9I40T
   g==;
X-CSE-ConnectionGUID: fUbhhAFCTQK0MES0Y8aqZQ==
X-CSE-MsgGUID: 0Rdv6/xRR7qpzlrb9x+Ffw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84732415"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84732415"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:16:45 -0700
X-CSE-ConnectionGUID: Pc3ozczLRQK/CP7exILsDQ==
X-CSE-MsgGUID: XQVqW0MwR4ybMGmuIeD89Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="259786700"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:16:43 -0700
Date: Tue, 14 Jul 2026 22:16:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, namcao@linutronix.de,
	tomasz.unger@yahoo.pl, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging/fbtft: Remove prohibited space before close
 parenthesis
Message-ID: <alaLGAYrBYkP_x5T@ashevche-desk.local>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
 <20260714190958.219437-4-graviaspanagiotis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714190958.219437-4-graviaspanagiotis1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 10:09:40PM +0300, Panagiotis Gravias wrote:
> Fix checkpatch error: "space prohibited before that close parenthesis"
> in the define_fbtft_write_reg macro.

NAK.

-- 
With Best Regards,
Andy Shevchenko


