Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD21C84A2;
	Fri, 14 Aug 2026 02:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786675631; cv=none; b=iB6UvJgBtMoSWpCCH4o8LNKdZIXzuiNj1+wJwF6TthCNLDeyx6hUlbJoDLlGiNmbXb8huUldMKUD3Do+fP6bplC806pK5vofJQzZeN7oiuqb2J6O08rYS2OhZ54LsuYA6VMIoy+VXHNPxcV2+kjDt9EWK4r9ne5BEnDHsepgAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786675631; c=relaxed/simple;
	bh=OBs7spVAqp61lolc2/N2LLJtXywiYLgQ7b22BineEqU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uHqidEsjfLOYzHAr3lLMpNHqUQXoBKHqT72Ef0Hfor54Nginh+ArCkPkP31PdsmaItS5SSUuDqWQL2MxEu5stiz8akFN/MVkWe7PvU6zG8oAO0HjyqBL37ktAy+SubTYv2RLkRR/u2ZGCEzyVqaXhoMosaj6sjbABJrbu1+HQUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ErY2++rI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ErY2++rI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IjbqGBh5OA/8x0Qxv8wHfpIOWZltvzeMbsgtQ5FZn6c=; b=ErY2++rIlq4hFGYFf5NKErYUKm
	d+eaxrk+iTXxK7bFLG19jmmd8QcjLNYkU+InoqDkxUkALpPV3/FQHn5j/W5R3mR9h/6ZKfhxBbM7M
	aLv7uSJGu3y5tpB9SpiETgvEwu4/XayBvY29NGMz8L7gapfSLVS+6pjG/2a9VcOKeVxMOWVVbc/Eh
	jnDP76SSY/dd7eXV79jMrMW4P2B5wG116pXWcyDik9P70UxSSnwjcqOsjWerRDLmKIaS+PGfE2Vzm
	V4pJSH5EgPNEQCM4J4EHRDMM07s+h0OlcDUElj/Jz1pKBM1QxGzUsGrM/Lzg9Di2D9cYhyx18PJuD
	1WfXoBmg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuhwm-00000001sUm-1vPi;
	Fri, 14 Aug 2026 02:47:04 +0000
Message-ID: <6cd9df3f-4fec-451b-a3f0-d23b435802fd@infradead.org>
Date: Thu, 13 Aug 2026 19:46:58 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fbdev: maxinefb: fix build issues
From: Randy Dunlap <rdunlap@infradead.org>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 linux-mips@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20260809234810.982500-1-rdunlap@infradead.org>
 <20260810000251.55AD61F000E9@smtp.kernel.org>
 <e0488e93-eb19-42d4-a7c0-64657141b398@infradead.org>
Content-Language: en-US
In-Reply-To: <e0488e93-eb19-42d4-a7c0-64657141b398@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/9/26 5:27 PM, Randy Dunlap wrote:
> [adding Cc:s]
> 
> On 8/9/26 5:02 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] Initialization function returns positive value `1` on failure, breaking module load semantics and causing subsequent `registered_fb` array corruption on unload.
>> - [High] `maxinefb_fix.smem_start` is initialized with a virtual address (`CKSEG1ADDR`) instead of the hardware physical address, breaking user-space `mmap()`.
>> --
>>
>> --- Patch [1]: [RFC PATCH] fbdev: maxinefb: fix build issues ---
>> commit e391418fa2f21f8c420eccb513c031674ef184c6
>> Author: Randy Dunlap <rdunlap@infradead.org>
>>
>> fbdev: maxinefb: fix build issues
>>
>> This commit fixes build errors and warnings for the maxinefb driver on
>> 32-bit and 64-bit MACH_DECSTATION. It updates KSEG1ADDR to CKSEG1ADDR and
>> adds the static keyword to missing prototypes.
>>
>>> diff --git a/drivers/video/fbdev/maxinefb.c b/drivers/video/fbdev/maxinefb.c
>>> index 52528eb4dfb41..8aa1389e2d4c8 100644
>>> --- a/drivers/video/fbdev/maxinefb.c
>>> +++ b/drivers/video/fbdev/maxinefb.c
>> [ ... ]
>>> @@ -111,7 +98,7 @@ static const struct fb_ops maxinefb_ops = {
>>>  	.fb_setcolreg	= maxinefb_setcolreg,
>>>  };
>>>  
>>> -int __init maxinefb_init(void)
>>> +static int __init maxinefb_init(void)
>>
>> [Severity: High]
>> This is a pre-existing issue, but does returning 1 on failure in this function
>> cause issues with module load semantics?
>>
>> In maxinefb_init():
>>
>>         if (register_framebuffer(&fb_info) < 0)
>>                 return 1;
>>
>> If register_framebuffer() fails, returning a positive integer causes the kernel
>> to treat the module as successfully loaded because the module init framework
>> expects negative error codes for failure.
> 
> Ack. I'll change that.

I had this fixed locally and then forgot about it in the 3-patch series.
I'll add it as patch 04/04.

-- 
~Randy

