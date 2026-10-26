Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008090;
	b=rDcxy7TJD15Y9rjV+hnTsJRX7uSv0Adtj3W/plsWGh/Ht7az4pqO3A7IltfSN8/67xNw
	 pd6eMmt3kNo9MbsRtrSKBQ3JxHOtiILaBAJLgCD3JJ+yXENNCDwh5UN9xFP+GElw5wZTc
	 2MvEFEZTW+wl151He3gbXYHisUCTzsPHuhM6g6NvOLCzzTvsW5wUzk7ZJodcQgVElvFn5
	 pwmztgsHIBhzY/ZSBKKhv3+vINgLNZ1ymSoa0J1OOo57tMosk8ZI/gCEnPKXxzIlZDsMi
	 fUGvI5pJJyZAwqISwQ8wHlG6EnXKMntLCB6Nq6AvrhQbWjaJEjpUyOH9Drhf6BVF8Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008090;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=lKpxVBbLN2YxvRBv0VOPgTbhxs5jD0Cdmck3wTOZ8EE=;
	b=O1QwOdUI/vX3FQAxwhHvM+L/E4B0RzfVkMjetlqZeTUdJMvxW6sD7vRbZNTW2k9sQ86Y
	 KpqLbK4cgF12XbnwaSEgOgcw2d+ItG5VvEDsnoXmmff3s1LXlwoUY0nGzhvj5LgU5VYL+
	 Iuo+7qgCgfVNrfbf3Oaegf0eOMrj2n0SyBYLTJc3aBVDVK7ccEusf/nanZt7miWdOxXFL
	 1O8wo3vLMb7x/NfM/9BH1p3QpwKB7rKCKES8bMEyhrl4vKuTLeo69LuvVP8zhhM+t3/UJ
	 rysxVQdp7QqoQn2z9yGw6GMYb9uq84ZBs+WfJm3YEjWtcc2Ccm+TKVG9T4f0ug+ONlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R5GKzUDl;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26286606A321;
	Mon, 26 Oct 2026 09:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26286606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R5GKzUDl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793008089; x=1824544089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FO5YVRrreTVeqfWv1jXBJOTTkZR0P+8NlwynvXxgcVc=;
  b=R5GKzUDlpVvR+tdMOYjmlTwkQEV3qAZUbRJzcR1hK977/Hn0ZE2Tg3cW
   H9jwBdzK9JJK89kkuFadqiW9+CUwf+bQvabvQahUQXDL67OHezxDaYu++
   fOQYgSeTpwZKq957T3P+h+XBsthOxBoMojjytHNLtP1Lj4jpsV6hsWQY9
   iWCCxrfpkU2wrgBo/6U9AUF5QaC0Ffv3LK6o9qWfHQA0CJ/tOMdpGBsQv
   5/adFC+ZVQaO6b9i5nScbA6iWnQbw2c2oSnXJXEA7jDsiS+3IpWtXK5j8
   53LWY2a0kYnmCXexMlxO76CEds1YXdpX5JKWxpkZs9yuViEgOgk0Oqh1g
   w==;
X-CSE-ConnectionGUID: /YLjbVL5QA6ph9oEcUVNuw==
X-CSE-MsgGUID: cVGsrqPBSPqAZqsbX7Im0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1680432"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1680432"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:48:09 -0700
X-CSE-ConnectionGUID: TlYW+mW7QnibfSWzmgSNuw==
X-CSE-MsgGUID: VjeOwo7CTom/BJPW5wLfjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4233961"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:48:04 -0700
Date: Mon, 26 Oct 2026 11:48:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com,
	cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH v2] staging: fbtft: Remove unused fbtft_init_dbg()
Message-ID: <at8h0ignZd8srvBi@ashevche-desk.local>
References: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
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
In-Reply-To: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 02:54:23PM +0530, himanshu bakshi wrote:
> 
> The fbtft_init_dbg() macro is not being used, so delete it.
> 
> Reviewed-by: Dan Carpenter error27@gmail.com
> 

No blank line in the tag block.

> Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> ---

You must learn to provide a changelog!
What has been changed? Why (whose request was that)?

>  drivers/staging/fbtft/fbtft.h | 7 -------
>  1 file changed, 7 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


