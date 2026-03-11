Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E9A37B028;
	Wed, 11 Mar 2026 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244641; cv=none; b=NRCxLZ7A0BHWTjoW92Y3gtFhw9L9R+w/SnpVz7sT0sFU1DQpmAi9ahZIoFU6f3Lz5ctaTpCiZ1Tv/397OmPZGe2KgYFP8F2wEAJAOHA7kzSZPCW8BQ4HEyVVDZZ1bFVpEDkK/7tdBGSG1twS/VEflzciDAckd53Q4cuUAudLZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244641; c=relaxed/simple;
	bh=UfABTIU/4Gqrp5HiRVH34wdE+IYX3i9i9/pnHRemkkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+yJ6eQnWXq5N51sF9J3pmwEzmX6vaqKriYwM4jl1tdc7J3cZe3/MFdrwgMevwIkrYtWoEpnFFLrPw8+MNopQ53FMVs2b7OAddGBBJxMm2wj8r0H3DqUlROGq+7eS3/Tu5aKh3Lhrf6mS1upvYYXW7NEn7UkcTIet0VwtSRYL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZH+ltopU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZH+ltopU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773244637; x=1804780637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UfABTIU/4Gqrp5HiRVH34wdE+IYX3i9i9/pnHRemkkw=;
  b=ZH+ltopU7r/6ttXdzPZ2agTQYV6llnY/MdnUOv2nolYyImCZWeVarTki
   rtg/mBppiYYqEHIDoHs5q8cTkFNqQLZ/qGuzSP0bpQw5a1yUvQaACEHii
   7+b5TR7/pEHa3dHcKUB+kanPqilFzgTzRTRMKQ90kDi4SHypibUdWbSd5
   MI1OwlAcFkNepRPLifZA7teCTf4Op92HdHg+da9GGw+f1fDL96wXf3r7J
   ifV1PJMG4gEXbrWW2SjSZDd8zpxarDOJHtyl6xyMhM8jEx8cZ5L++z55W
   pioAXKIXSpxg3XnDloVaDDVkb68enuo2wHaVvNqGFCSh2TZ7o9y6EeQhy
   w==;
X-CSE-ConnectionGUID: we/jS1sNQA6DJxjjnkRxlg==
X-CSE-MsgGUID: RA0TQIDwR8O0+DoU5sX7rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74287809"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74287809"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 08:57:16 -0700
X-CSE-ConnectionGUID: XvLDTjaIS863YF22+DhFgw==
X-CSE-MsgGUID: jk2Vl4wHQ/qAgpESBKYU1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220561556"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 08:57:14 -0700
Date: Wed, 11 Mar 2026 17:57:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Anas Iqbal <mohd.abd.6602@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_ra8875: replace udelay() with
 usleep_range()
Message-ID: <abGQ16azmUyMRHre@ashevche-desk.local>
References: <20260311135245.32730-1-mohd.abd.6602@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311135245.32730-1-mohd.abd.6602@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 11, 2026 at 01:52:45PM +0000, Anas Iqbal wrote:
> Replace udelay() with usleep_range() for 100 microsecond delays as
> recommended by checkpatch.pl. usleep_range() avoids busy waiting and
> allows the scheduler to run other tasks.

fsleep().
Now, read README here:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/fbtft/README
and act accordingly.

If you have been mentored on this, show the above link to your mentors.

-- 
With Best Regards,
Andy Shevchenko


