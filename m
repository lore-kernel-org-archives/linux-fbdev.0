Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C37341650;
	Thu, 19 Feb 2026 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512948; cv=none; b=XbyqAedxxlFTACGLeg1Tmt12e45qtC+ODu+kvNtGrhCLN/fy+j0aHYO+7v/SKxKUczcp3T/qEFoMSVt4iaqBcvubCh1BrsEGLA6/CqO5XfkSi7X7g4+JWp3sl20pXF9PWxTYHN3DwmR0ShfnBEXghwDB8eGKMlbjWEuv2FLH7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512948; c=relaxed/simple;
	bh=Kakgbj90xo1a4sN+CkBTR5X/lHwejqpJ11SnCbBfSeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNRTtljL79Y6OWhRHaf+x/eXf5CknXvt5NFd3mU3lQRruMdDdGg8cgPM+wXYbMl+nyDqPc1VWNsM50Mt2TFDKOp9Jbue0TszSHjdfxTVk3PqMbZssSBNoN4cbKUr/zaAXpll+7y5XxSqlMXLeA8s6wTAQIvevQpROALbK2rDnDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKXVJkRM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKXVJkRM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771512946; x=1803048946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kakgbj90xo1a4sN+CkBTR5X/lHwejqpJ11SnCbBfSeQ=;
  b=FKXVJkRMnScFvo93vhT/BVxWe4FRchDNeYtrFpXHKAnw0uQmg8uudzlw
   o346QoYMpgvQw7jM/D5JviK90amvaGrfxjOZWd6m/f3rmVQZP/kM3a2ML
   YgRfVp9YDEnCSRzdwonTgWDjDBP+9zlZ60zhhtHdH8ORX5LKON0vij9ZG
   pPQvJMff0cvXeZqlTZQNO52XTzV1Wk5kC5IMkRvnqEeXm67ny+m0Wdsii
   L3gxymTHGcVGJ7fdsZ6+1pUBsPfJkqrEyL57tnWJDdUnhPaYAtVzgdI/0
   SjzvAVl0xK3AZuPPZ2GU1SffZFpCLwDfHl8HN01pZXtq1ZMovY1UH2uqX
   g==;
X-CSE-ConnectionGUID: mmqCb/llS1G2JjzGNztxGQ==
X-CSE-MsgGUID: Fhko318YQG6bLSILbtkFtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76433575"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76433575"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 06:55:46 -0800
X-CSE-ConnectionGUID: vatI92R9QsWahZErNqcu/w==
X-CSE-MsgGUID: bxWYZY9+THykDzHhuKLjvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="214391077"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.114])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 06:55:43 -0800
Date: Thu, 19 Feb 2026 16:55:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: tomasz.unger@yahoo.pl
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: fb_tinylcd: replace udelay() with
 fsleep()
Message-ID: <aZckbewfoAJsPLXJ@smile.fi.intel.com>
References: <20260219142942.74087-1-tomasz.unger.ref@yahoo.pl>
 <20260219142942.74087-1-tomasz.unger@yahoo.pl>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219142942.74087-1-tomasz.unger@yahoo.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 19, 2026 at 03:29:42PM +0100, tomasz.unger@yahoo.pl wrote:

> fsleep() is the preferred modern API for flexible sleeping as it
> automatically selects the best sleep mechanism based on the duration.
> Replace udelay() with fsleep() to improve power efficiency.
> 
> init_display() is a driver initialization callback which runs in
> sleeping context, so fsleep() is safe to use here.

OK.
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


