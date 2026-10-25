Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792962143;
	b=1OAhB0cGWSMRVrME9dm1JOLJAIXSvUumhGZAc8J82zmpwZQIndBVOPplTyaJqqWf3rtR
	 RJPEXkLfadX2gYylAYXnx1EMiBnzu1H3XMu7M6+m2E8ipzY0TmzK6I4BFAj9aWF0KQKbI
	 wKUds/2ihQ38kZGE++XF8cloh7xKcCnQV+G/gIt1PbscKrGMTYnhOLw63oVBXB6sNu61o
	 0NllXH+FAHwqTJo8kXImCTe9FcchbwTD6ZETw5GUPfdyN6EkswR32Xczp0ZyYVi+Fnuhr
	 yE4M5+RRh84TBsCI86QTq7LmrU/M1pTQTKYeBfXYACVbliOJcfw/eZ4ROHfktXPde2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792962143;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=JI1KjX9oYdbMluQobFDYz8GG+0ettcywSW7VnmGSih0=;
	b=tQCmWxGDKyBWYz4rzR9YPf6ooWWPutBH2v/hy+A+F1bB0hOX4W0jNM2PJAHscqFy95wA
	 JW92jfmwttgiYPjt0UWLoQZkNTB/PvwOoKo7v35JqsW04xEiqqI3FM/jjOacXSNGvpQP7
	 i5RRbimmJBzq+nu7aQl73EZpOOZA17uHQa5yZkQyfEp8HC4CnBAN8kRhXBZaqOeUv8T7B
	 WMRw3b11tHpapdfuB3NhX2+OBMmZ8w9F6IZ7y8snR8bL4KHLlRUVhHT5qZTn9DjIUY0GS
	 JxtEzeI7JotTBt+UYQSuY9mkV1tp9WLKArX5D1no27zAE5MN/r1SapBFlzjLbEz5tvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J5UxPb0b;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453C5606A31A;
	Sun, 25 Oct 2026 21:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 453C5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J5UxPb0b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792962142; x=1824498142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=37MGO2THk65O9dDokHGzcZKqr//7mBwQ9K6mW3baZm0=;
  b=J5UxPb0bOFqmL0XhRfCwfZsip+8QAw9YrhJ8qXu1ps+0BO7TOjk18DEz
   xAT4TqN7De5t3iuydmM4Ch7TV6SCm7aRA+dDZ4lCkiFNo5KnhOZ+oWy81
   Y3+YSx2hiV9lemORPC+/rCtiJg9ttR91XHIgjQknVsCfCPYSTRObK/RF+
   VJHaVUqKsnwxUVk2gM1fUHou8Yu6jhSkmmNawxeYD0NUS5T81vUY7fwl7
   JKr9DBJXHwrwC7muWOIEOssD1j1uSyC7ngSuJnJZlXwsfDajThN/g9E9b
   iuE4THvuulCBz21BtDuUjDA0dKt8bEquSen+loG9CCSPOPUU4vnwXXjiR
   A==;
X-CSE-ConnectionGUID: U31uO4nsTjaOkOyWmgjB1g==
X-CSE-MsgGUID: qz/eJVd8QQSYjN9QA+Dhbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1528273"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1528273"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:02:21 -0700
X-CSE-ConnectionGUID: ToPmKdFtRiuRbKxXnKj03g==
X-CSE-MsgGUID: 0To/CPXJSHa4daZpMUiu4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4133394"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:02:18 -0700
Date: Sun, 25 Oct 2026 23:02:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: Fix line length warning
Message-ID: <at5uWNXO1pP3kAPD@ashevche-desk.local>
References: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
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
In-Reply-To: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 10:10:03PM +0530, himanshu bakshi wrote:
> From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> 
> Hi Andy,
> 
> I have made sure that the \ (backslash) is properly aligned to the same
> column as the rest of the macro. I have also taken into account your
> advice and hence added a local variable for platform data.
> 
> After some thorough searching through the respective directory, I have
> not found any calls for fbtft_init_dbg. This might be because it's a
> helper macro that might be useful as the driver progresses.
> 
> I have also noticed that some other macros around this one have simple
> style issues and if you would like, I can send another different patch
> cleaning up those too.
> 
> I have also done minimal testing by using the macro once to make sure it
> compiles and has no errors, if you would like, I can also run any
> standalone tests for this macro.
> 
> Thanks and Regards,
> 	Himanshu Bakshi

It's not a commit message. Please, make commit message be appropriate and
any comments like above is better to be sent in the reply of the previous
discussion (v1 round in this case, for instance).

> Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> ---

-- 
With Best Regards,
Andy Shevchenko


