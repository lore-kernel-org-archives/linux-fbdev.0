Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C43E49EA;
	Thu, 13 Aug 2026 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657612; cv=none; b=G270/XcArkexlKR037wO3vT8mBammpZlFbKVck/cSVWYhawb6xDhqSQ7vX4lNi9Rg4f2QS8L94npLqAYbtpHz5dj7zkmULkgICMzJi5bgFxOi16a4mL1QJN/rEh1VP3vfJWsNzJwEmm2iDvVPOafxKzq9aFMind2seUvk29Bh5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657612; c=relaxed/simple;
	bh=iUN335zGwtmrC+oT4qwJ+JmNnEq3wRjGxmDaDslyR/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzZmTE5VBZvvm4IsHJnnbvVX5gesf35nor00x5P2PFmOIh2D9X7i3yyzwb8BkF0RnP43amCHha2LRsvrbK4JBQt7bk35zAptDEJXSn1WyRXxOtEKarHrB5IHUeOZR0V7W7/qV4k/w+sOyq5gytmmHVAFrlUirZeXtzrymdAJahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JvxAYEJt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JvxAYEJt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VrJjpnquoKirxGoQwEIqgJUFcxrud7TWyOeE6LNnY0Q=; b=JvxAYEJtdLMHwgdvuUhzatZqEv
	TO8AR+ev5z/sbSYaWyG/9mDVob8nZu8hxDpwe1ZTTE9ppynXUAWzrFJP9osq77Di79oNqugpWMpSX
	32nipipgxb50ZbL0JNas+c04bW0Tvtkb48rSg5h/BEJDf5196dwavEsFs/FpqcKFfvIEvNFIDN5ba
	MZW0Ld9MqPZ+eYo/U4JdPCL2+WlqGIXIXRClY3T2aHTEYK1MshnaCtDsGCfMWMxCdRVYJzFWBGqCT
	LLFkumO8P+csYLhx5S9aVdnPCDttb5FgaAFpZoXD36NxixsKqaojkczxAaWpfDGQTykVEyXTehRdf
	wAuFLFqw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wudG4-00000001fHQ-0JCi;
	Thu, 13 Aug 2026 21:46:40 +0000
Message-ID: <e4b67f1e-4afa-4d8b-bd28-28e8e991dfa4@infradead.org>
Date: Thu, 13 Aug 2026 14:46:38 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fbdev: maxinefb: fix build issues
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org
References: <20260809234810.982500-1-rdunlap@infradead.org>
 <alpine.DEB.2.21.2608131801340.48788@angie.orcam.me.uk>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <alpine.DEB.2.21.2608131801340.48788@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/26 10:31 AM, Maciej W. Rozycki wrote:
> On Sun, 9 Aug 2026, Randy Dunlap wrote:
> 
>> This is all ancient source code from the beginning of git time.
> 
>  I can dig out any further details you may need from the old LMO git tree.  
> Eventually it's planned to be put back online, but resources.
> 
>> Now builds cleanly on 32-bit and 64-bit MACH_DECSTATION.
> 
>  Thanks for doing this work.
> 
>> Suggested-by: "Maciej W. Rozycki" <macro@orcam.me.uk> # for s/KSEG1ADDR/CKSEG1ADDR/
> 
>  Eventually this code should be converted to a platform device, so such 
> hacks won't be necessary.  Sadly I declined an offer back in 2009 and I 
> have been chasing a specimen for a while now.  And since it's an onboard 
> device unlike all the TURBOchannel framebuffers, there's no alternative.
> 
>> --- linux-next-20260807.orig/drivers/video/fbdev/maxinefb.c
>> +++ linux-next-20260807/drivers/video/fbdev/maxinefb.c
>> @@ -71,19 +71,6 @@ void maxinefb_ims332_write_register(int
>>  	*((volatile unsigned short *) (wptr)) = val;
>>  }
>>  
>> -unsigned int maxinefb_ims332_read_register(int regno)
>> -{
>> -	register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
>> -	unsigned char *rptr;
>> -	register unsigned int j, k;
>> -
>> -	rptr = regs + 0x80000 + (regno << 4);
>> -	j = *((volatile unsigned short *) rptr);
>> -	k = *((volatile unsigned short *) regs);
>> -
>> -	return (j & 0xffff) | ((k & 0xff00) << 8);
>> -}
>> -
>>  /* Set the palette */
>>  static int maxinefb_setcolreg(unsigned regno, unsigned red, unsigned green,
>>  			      unsigned blue, unsigned transp, struct fb_info *info)
> 
>  It might be worth mentioning in the change description that this is dead 
> code (and overall provide a summary as to making functions static, etc.).  
> Though I'm not entirely convinced as to the removal since this function 
> documents the hardware interface, which must have been the intent to put 
> it there.  Perhaps #if 0?
> 
>> --- linux-next-20260807.orig/include/video/maxinefb.h
>> +++ linux-next-20260807/include/video/maxinefb.h
>> @@ -13,13 +13,13 @@
>>  /*
>>   * IMS332 video controller register base address
>>   */
>> -#define MAXINEFB_IMS332_ADDRESS		KSEG1ADDR(0x1c140000)
>> +#define MAXINEFB_IMS332_ADDRESS		CKSEG1ADDR(0x1c140000)
>>  
>>  /*
>>   * Begin of DECstation 5000/xx onboard framebuffer memory, default resolution
>>   * is 1024x768x8
>>   */
>> -#define DS5000_xx_ONBOARD_FBMEM_START	KSEG1ADDR(0x0a000000)
>> +#define DS5000_xx_ONBOARD_FBMEM_START	CKSEG1ADDR(0x0a000000)
>>  
>>  /*
>>   *      The IMS 332 video controller used in the DECstation 5000/xx series
> 
>  This would probably best be a separate change, especially as it's not 
> needed for 32BIT.
> 
>  I'm not sure how the actual maintainers see it (I should probably list 
> myself for all the scattered DECstation stuff), but I think this would 
> best be a patch series of 3 for each of the individual classes of fixes.  
> And since this borders on the obvious I wouldn't be too concerned as to 
> the change descriptions; just one sentence plus the relevant error message 
> quoted will do.  And your introduction should suffice as the cover letter.
> 
>  Let me know if this works for you and if you post such a series, I'll ack 
> it right away.

OK, I'll work on that.

-- 
~Randy

