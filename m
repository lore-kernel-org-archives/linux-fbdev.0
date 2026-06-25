Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AE4326924;
	Thu, 25 Jun 2026 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396001; cv=none; b=oSSRwH+v1275LnfG9qgD1PppfktWONrApTNhGiEP34K3GWMtbCNRVLZANI6huhSqoE99ESnu9IjbSKL4yT7RpHgq4pCNgSjEMYB2DX+KN5Ez0NOfz7wUfCvY8DGjNK6fklXVAgbCFd7s5GJQtOnlJbe3CYMs8mROY0W70b3jAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396001; c=relaxed/simple;
	bh=H+7DugO4QPsYK+5l9G86Mtbq1kKJwp90ZGLt7miTQJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DubValy6SUpwul66IOpwGJNliFi6XCnVCtgxV+R3QKUUutswSZAVjl1HZsNFHFYIWdwc2ywKhV9LXacwtPMd25/NlLxAoObh6UZx9N8PDKsAdy3jM71m+b+VJz0Ghzn5JWsE2lhJIuPHRiKz1R8PhDyWGo5pPblr6YDekwKvKjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/N7acC+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/N7acC+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782396000; x=1813932000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H+7DugO4QPsYK+5l9G86Mtbq1kKJwp90ZGLt7miTQJ4=;
  b=Q/N7acC+WisoU9ttoY3GCP5/+98/NavKoqMGgZyYbRhxHp9IoRAnz9th
   igAkfnHIQkmxK45mFlotMJI0Id5bUNfGPxO0DJuy6NssfCVzHMMpDLDId
   ohl9PmigPJFzH7bWAU83ydcZZl+/wKCPU1JEmimxT39RlOnSQbaANhh81
   dUWuf7kECCnIYogH+XJryHzBdfG7jJW+uy+otRokL5gyiRhQxBP0s4jgk
   ONUP2AHsSORxu+wLJ7uUoIvjjn1LzCDEm/Ci3b1SXve82ybN+vfv3kzUj
   wvhPUu9gEsEOR6g844mgSPLmdIGRe39XtN4l9DRVF3tC/ZKrT6YY+iMnn
   A==;
X-CSE-ConnectionGUID: ZlzdbheYSsyRYcLLN5hw/Q==
X-CSE-MsgGUID: UpIqXBPUQIqKA0yXpQIBLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82156377"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="82156377"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 06:59:59 -0700
X-CSE-ConnectionGUID: FUXGyTl8SKqiZbGKsj3rlA==
X-CSE-MsgGUID: chE6dVCaSNC1bwlI3PARCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="246351708"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 06:59:57 -0700
Date: Thu, 25 Jun 2026 16:59:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: suryasaimadhu <suryasaimadhu369@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix unaligned vmem writes when txbuf is
 byte-offset
Message-ID: <aj00W8sbiqsYDH7b@ashevche-desk.local>
References: <20260625104220.21E5A1F00A3D@smtp.kernel.org>
 <20260625110237.304435-1-suryasaimadhu369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625110237.304435-1-suryasaimadhu369@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 07:02:37PM +0800, suryasaimadhu wrote:
> fbtft_write_vmem16_bus8() and fb_ra8875's write_vmem16_bus8() offset
> txbuf16 by one byte for a command/start prefix, then store 16-bit pixel
> data via txbuf16[i]. On strict-alignment architectures this can fault
> the same way as the write_reg path fixed in the previous patch.

.write_reg()

Can you provide a real world example of the failure?

> Use put_unaligned() for these stores.

Sounds like a fix without Fixes tag.

> Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>

Use your name in accordance with your official documents.

...

> +++ b/drivers/staging/fbtft/fb_ra8875.c
> @@ -10,6 +10,7 @@
>  #include <linux/delay.h>

>  

You should move this blank line to be...

>  #include <linux/gpio/consumer.h>
> +#include <linux/unaligned.h>

...here.

>  #include "fbtft.h"

...

>  #define DRVNAME "fb_ra8875"

Are other drivers also being affected?

...

> +++ b/drivers/staging/fbtft/fbtft-bus.c

Also needs linux/unaligned.h.

> +			put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);

-- 
With Best Regards,
Andy Shevchenko


