Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BDB148FFF
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Feb 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896880; cv=none; b=s4IxLYvfNMoHGOyH5obZrKdchcYz7pK8UbBMqPtmU1Qn1qbDf74N6Mxze9jU4T0m84KHHOjlFDfcfK1UqqvAKS0PHQWSgCKFp+MMm3TUNIZ53nVX8jkZepy1tAb5YVzaB+oPW9VOMVbvaiXE1CXRI4p81RFe+Vetn7dFTmTAWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896880; c=relaxed/simple;
	bh=3C8AQDSBzkmZkCjT0k5yI3Kb9MDrMK3EsmMyHTkb/ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDM9UZ13Png7k0yXbZ8XeqK+uz5fi6jSf/QXJ7Cco2I9YiDaQD67+vV15ZFY47plXlGn6VcIMPkpy5vQ2dC/ymgeVBaFdy3dDaem4Sh7i9yjYXuqrqyOO9D06AZf+V9hfFkh+ZXQSWjKzHgzO0NYVwXabIjR0BJ1idHst6PhwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UyN4V3i0; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UyN4V3i0"
Message-ID: <77dded7a-5643-4050-9121-f666d3b8d59e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706896877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZSu2ibUQJB3ag94oCyfM2tDgrVh/1VzNoi9e8hYKQM=;
	b=UyN4V3i0tMmJlXy9GWc3JEjIkUJ3fwhrCZ4wTt30TQYlicLL8R6j/dpeV1+ALzRGcdAvzd
	3z2YkrLnvPSffq9+oFroaDyGaAkmSX2SMA/CEwx1vWPqXUzKbgLNOMPmzBB2DeTjNvBZxw
	ZkO7XlsF/XnY++n5+jTk0xjm47+jGYs=
Date: Sat, 3 Feb 2024 02:00:45 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v2,7/8] firmware/sysfb: Update screen_info for relocated EFI
 framebuffers
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 pjones@redhat.com, deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20240202120140.3517-8-tzimmermann@suse.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240202120140.3517-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/2/2 19:58, Thomas Zimmermann wrote:
> +static inline void __screen_info_set_lfb_base(struct screen_info *si, u64 lfb_base)
> +{
> +	si->lfb_base = lfb_base & GENMASK_ULL(31, 0);
> +	si->ext_lfb_base = (lfb_base & GENMASK_ULL(63, 32)) >> 32;


I want to ask a trivial question: why not simply write it like below?

si->lfb_base = (u32)lfb_base;

si->ext_lfb_base = lfb_base >> 32;

I'm asking because I feel it is a little bit complicated.

> +	if (si->ext_lfb_base)
> +		si->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
> +	else
> +		si->capabilities &= ~VIDEO_CAPABILITY_64BIT_BASE;
> +}
> +
