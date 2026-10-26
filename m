Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011682;
	b=WRBjfBuRQHscs8GJYg08jvYtIr76+ITeZgDO+UXVyZsP/xN03mXDtBkzgJmLHvp+m9Dr
	 GlfKeTXkmwZF7W0MMmSx5e4u5cB7JDQzKE9kxbQPD9u5bfroFlBcqSfU24AXWJPsCy8N8
	 R4IyrKeCcOZaLMnMWb+Z/Vy/qxSZ+6IY1lsf5ExF/qpEnnrnmGWMtGIbBGiYx1nistqjR
	 5SJtR2Pm4TaW7HFw47QV2A2hF44Y8U8kEEirnARgZvNmFuqAW7RSyyd8i6mBggK4VWYvv
	 Bnmeshr3lfLGUAiuWSGSLOtsYelneXKV1t0NGspBtEBLSW0BM9UH3Jwn+6XC/KVIU7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011682;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=sB84iaBihThD3vkR0cJzbiSk7HWt7uW2J8rzQhkPKpY=;
	b=DNrWFDf6VMMqgSES+To/E4TkUWNhB0N7Vu7RsMccCyrB3FVaXDKbjKuxEYmNmjFILGLi
	 hs9Z9lEAQcX1k3ieSRobAtst8diduOy96vqpuvlWiXFCB9X4Jtqgkr5LA3cjbDrhXkSnT
	 mHyd+XxuIm+lzv07XaZHlcYUYYRJ34CBlqb6upKnUFul4Ka8OXdINW4GNZ3dE0IgPG4A7
	 6TfWqJK0ehc+sx95aQbmpwukGj5BZKUaelXKp4B+54X9nfbMBAx0jmY1OO6xQ8o5YBi1A
	 OhxpYB+MlhT4DVoLqDLRgBZKQ7LZ6KUocbpCY/19KZ/B+VpoCm8Q5/S80BVOXPmh8RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TRNsowGJ;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854F5606A31B;
	Mon, 26 Oct 2026 10:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 854F5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TRNsowGJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793011681; x=1824547681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9OD6Fc3Ri4/TWa2rRS9xHRLtGqIf8adQMmCjobWsN9c=;
  b=TRNsowGJLHh/t34fhkWdYffiQKrE8xYChRWTqjw1Ub3QpcuknfVag5Tq
   30mubGL4unTAAQOX3o8tEXDGXUGBTlJ/plfE1zzNKc9pZB5BkT573LXFL
   8qgiO5rtazibi9yQIQohzxVOM2K/S1D/aXQuPK9toNV/GJBLrQ/DR9gQT
   hsD1+CqjkFVGqnLTPSZD9+qYhM6wPo3TolNp59zT/Jk/yS9xnG75K37Jr
   m8JG2pbXaqSKsfvvGF3Xk6PmiZAmkuAWroaK/FNO/ddlG1h6eCyfZfDdZ
   SWeMGmjvBmLKaFN60YhZEQP8adw07GnfKIs07GKw2wKLTQTM5xqUeiKxt
   Q==;
X-CSE-ConnectionGUID: 8jUvV7o4RFKS1MQMV4sdGw==
X-CSE-MsgGUID: 8GGwUHvISCuZYZ8pnRMrCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1679197"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1679197"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:48:01 -0700
X-CSE-ConnectionGUID: vLuXQWh/RL6fYdilE8RQsw==
X-CSE-MsgGUID: yV79jj5PQye8KK3QcSefAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4268706"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:47:59 -0700
Date: Mon, 26 Oct 2026 12:47:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com,
	cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH v3] staging: fbtft: remove unused fbtft_init_dbg()
Message-ID: <at8v3P1bbai9lQPY@ashevche-desk.local>
References: <20261026101815.73722-1-himanshu.bakshi478@gmail.com>
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
In-Reply-To: <20261026101815.73722-1-himanshu.bakshi478@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 03:48:15PM +0530, himanshu bakshi wrote:
> 
> The fbtft_init_dbg() macro is not being used, so delete it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Next time wait at least 24h before resend.

-- 
With Best Regards,
Andy Shevchenko


