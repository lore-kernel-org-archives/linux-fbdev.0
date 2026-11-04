Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782580;
	b=AwxzNd8nYO3tQEMO5R4buUMgxJ6PKpPWZtzhCdhATiJzvdSs/BJCnqPIGYmSWop0G0OI
	 sWqMzlTZN+a0DiJx8/lkTqU/vdm0F3JVrgDQmwlwVaHAyVdsPN6qI1kAJ1bG/8BLYA9SV
	 LBs5ANXy9vCYWfo0R35E+bElWsSTgKrZfRpqUkNUEsS+kULfI6Y02OE/cMFC5OHZ6IWlW
	 uY6erBkOa+2eKq59R5mFaCCtapjWVZ7I6voSckZcwQ8mAHh+v9WmLp5ztzYDirIRP7uOU
	 BQof6qzFcJg7klFF7UUHjCGJTuYeNPgShl6TSA4aUDoH+N6KBGQThDw7f9oNL2tkPWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782580;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=UGaAgMpnljfOyuN0SyGCmbKUbOqRCYoSBuFFDyHRatM=;
	b=VvDV0EEG8QSGP7XB2OdSSv2cWnh1UQnyZsPsImyInvva3EVeO3dlFAkcBFsAB7xOjM0V
	 5QnUFBKDSWh4tmg+6Gpk5s1vmvhoha9caxISgBgGuLgtDCsVOF0vYEZjxl2jAe6QOy1Vm
	 /PCF5S7TaMpdTatIsu3Ia5Yv/pfi8CQNw5v6iKr58lQA9fpDxZCDBzEi6fp36EAPTJIas
	 /Ya4HgYetu5K5wNuEna9fOd8ZO0Dfkyr3Z9FgghvZ9Osk91Soav15nwZRqzgUlXJkq4tG
	 octYeUyIIBiefrRMEEy62LWo2vmIyNp70vzqFtzI3CD6SkT2M1e/Z6wu0E87QKwklgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BO+mjVab;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C7E606A337;
	Wed,  4 Nov 2026 08:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8C7E606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BO+mjVab
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793782580; x=1825318580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WEdnh3Um7RLyVQ8huXyPus5xQBPLH8vtUBUJSepuOP0=;
  b=BO+mjVab5YgIj25H2esws5VfMXuKu+IrdHJPGy7f+r767gi1Zd76MtLn
   wFsHDeOSh3UcJQkVANx+dm2yExwKEYNkCqwHz6ahn/+YA7ebuRHSQ/Q0v
   M61Pv4I+OXP4rtk5lwagd38mavUdcFbFbYqpwEscGuB4X4nu4s8yuHJog
   Ylne3u+KyvC9am1gJlCgq4nJ9ri0kSUZY96Edfg1PRdlLwb6F2F4/h1nX
   rhMcxn8qKq9/M5D6MKrqqlPLTTWXeUaiHl5SDWJkrLUP+ebRlIpIrN+LJ
   syyT/ccpCCw0bau8VN12bFeOqfr8+PhFftdNuzFiCgmUlx7TsUTWlJ3Vk
   w==;
X-CSE-ConnectionGUID: VU6EbLnxSH6iXe+ZcoluUw==
X-CSE-MsgGUID: +cgAn+SaR1uA/NcKk7enrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2416683"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2416683"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 00:56:17 -0800
X-CSE-ConnectionGUID: /gOq8NuZS6ib1xsECxEouA==
X-CSE-MsgGUID: 6RQJzOOWQ9OH1ccyCgP24A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6515010"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 00:56:15 -0800
Date: Wed, 4 Nov 2026 10:56:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Eileen Blessing Kabi <kabiblessing5@gmail.com>
Cc: outreachy@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>, linux-staging@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix spelling mistake "writte" ->
 "written"
Message-ID: <aurzLD-baoebpE2N@ashevche-desk.local>
References: <20261103221142.45100-1-kabiblessing5@gmail.com>
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
In-Reply-To: <20261103221142.45100-1-kabiblessing5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 10:11:41PM +0000, Eileen Blessing Kabi wrote:
> Fix the spelling of "written" in the write_vmem() kernel-doc comment.
> 
> Found with codespell.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


