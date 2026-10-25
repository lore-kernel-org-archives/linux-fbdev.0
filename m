Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792940498;
	b=2A5D9l3KST6bNwLiZ4fQXDq0QpA1of/YO+NJcYBatiWMrwIbb7BDeqID/Z8YTMUEqiR4
	 7tfPXVXU8jNCyxnq54CDhs6Ib+oLsrw/HSuxVHBatSy3n8iNRfEe2IPC/0V8rjHs1H1Gd
	 eqsNCCCjC8MNDgtKeBuYB+EsjckDHIcZi6/o0bnNCCFsrdil7Dy103pfqV2IGQbnIJbMd
	 Z5abL6LTcDXiQ2MJfYN4ybdU7Ah7SxYhbYaI2Wi42H0Rzcuw/ZxnVkb08E9jqB2VqVImR
	 5wjEbN92sBUciWarOCvLgoj/ILWTnO/Gsp5KtSq4GKmL0ku+BEHlpIpm/6nRdXN927A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792940498;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=D9mREOesp9ix2gw/zcluHwQx8Ah3Xmw9pk+GCQ06GNs=;
	b=kBNOirYctXHSV+NVxzhI6hRhMkzlFVguK8r5PEaPTCUn9X9qY1tz87Yu3+dGRWqIg/ia
	 lHQLPw8W+t59lfM/9tfzvfVRxE6mhO8RGqfeoiYfzHTfWH89mXuJoMG8dobwzjgUFc58K
	 qoGQPu5Y4i5yeOHTxYkBDlru10un6B3jtyjCq1g6J5jq9OkpwR1s8LqHmPha9tk4c4uIu
	 NOxImwt7xDj6CD/tQJcpxiFM1pqiywbm1hxCDrEEibiZlj2OsYIDMYqMRWzA9QQfjBqTw
	 h3gixlbTHESgltsBeihq4wVGa8naastEwBay8h1pL5FOkD8A3gwQqVwEoM8rJBS5cNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nJaZNf5L;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B85606A31F;
	Sun, 25 Oct 2026 15:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84B85606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nJaZNf5L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792940496; x=1824476496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L3ipZTsNucMPzNkW+kxXI9G3iUL6JjrKCA2IMBnMnBo=;
  b=nJaZNf5L/rYoCssx9wNz2/xvR4nyix5cog2qweK5jFqDMsQiepwEWdLu
   c5wuHliK/bbNdOSyciMQnWoBEWnjaO+rZVa8jLLnnQw8IoaFl4OPxvAP5
   oSBV2DVMbb8p0k3qj8P5D9IsjXA3gxY7J+nNd2q2oJFd3BmvLEMhv0yJ+
   hKAzHip4PRODg8Uk7u8ikWuIjm02oE26gE7588Nnz0eAY3RN3jqA0JnGU
   F3Qjyl/UXl3Izl7+l7Qyrz7RIaaTYYZluNRLp8DoBLGT9dRiTgDJfgGeD
   SD6Npq/F2v98aUevdSK07kY+Z26FY0HroHdy1Xqxu4r/lCZJ+hx+Xe9LJ
   g==;
X-CSE-ConnectionGUID: jqNSNDGfTEiF9mOugw0qVg==
X-CSE-MsgGUID: TbYBP1jiSziU6xjkTnm+Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1629432"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1629432"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 08:01:35 -0700
X-CSE-ConnectionGUID: IJ5YdLbERyyITfSahx/fEQ==
X-CSE-MsgGUID: jbpnSTeYSNOhBbOZEZN2nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4097073"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 08:01:33 -0700
Date: Sun, 25 Oct 2026 17:01:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Fix line length warning
Message-ID: <at4Zyt9QP3Yo-ZTC@ashevche-desk.local>
References: <20261024180803.108872-1-himanshu.bakshi478@gmail.com>
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
In-Reply-To: <20261024180803.108872-1-himanshu.bakshi478@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 11:38:03PM +0530, himanshu bakshi wrote:
> 
> Split the line in fbtft_init_dbg macro to keep it within the limit of 100
> columns and address the check-patch warning.

checkpatch
(in one word)

...

>  #define fbtft_init_dbg(dev, format, arg...)                  \
>  do {                                                         \
>  	if (unlikely((dev)->platform_data &&                 \
> -	    (((struct fbtft_platform_data *)(dev)->platform_data)->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
> +	    (((struct fbtft_platform_data *)(dev)->platform_data)-> \
> +	    display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
>  		dev_info(dev, format, ##arg);                \
>  } while (0)

First of all, make sure that \ (backslashes) occupy the same column on each
line of this macro. Next one, it's better to add a temporary variable to
hold the platform data pointer. Something like

	struct fbtft_platform_data *__pd = dev_get_platdata(dev);	    \
									    \
	if (unlikely(pd && pd->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS) \
		dev_info(dev, format, ##arg);				    \

And last, but not least, have you checked with `git grep` how it's being used?

-- 
With Best Regards,
Andy Shevchenko


