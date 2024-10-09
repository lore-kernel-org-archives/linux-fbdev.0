Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E79188901
	for <linux-fbdev@vger.kernel.org>; Wed,  9 Oct 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481500; cv=none; b=U8Vv5UGwV2Z10iWbp0AtfXwKTt/twGhO6r4fIjOFrULpfzTgzrl2VQh7FsnqYx2+BTq5rBB/0983rmvYCsGOHUzsFXL/JxfV0inuBihT2hHTUlsnHIk70D1+oBV80fnR8FKaCb8fhKkSTfWJhCmfY2Rx262TOjWa5Dfth3/vfbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481500; c=relaxed/simple;
	bh=5r+GMHSj63RYi/J4H0h7uqDa4DrIu6yTU3ihuErU0pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4rdtIU0zUwspPByumLwNb4QpYV1RJ45aYv/snAFhDVxoS8cWbantT//8qA6023f6ZsyRXbPsNapEUWQt2IH3L5R/B0VPYKpntOOOkaNxRs17ONsxej6VI/1shbB/gMl1vIom3kt1wLySpYP3ariiBXZXvsroL11ojfP92mrptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=qdNUZd/n; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=hB4hSmKR; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="qdNUZd/n";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="hB4hSmKR"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=qdNUZd/nVEljgYp/f1vPbtQdck4IsprrIYzmCPogI7HPF8YJB3Ox/1Pzf4NtNOqTFsjB2GuGHxRuUchJK3h5Q2mGRJg8UyrIZTbKU5dDap/1PkGkwQCs1lFcGVfnxehbODlCd4E3nKXzfO14Q/xCsAEUv/1V12Bw+JX9V4T/DBE8yUHubZwvXFJFLKWcoo+QEMJAfq/BoTK7AcgQzDU6qtq7QdJ1mihYTSEVYrUhkB5UJJaPhKzQcsEYCmRx42Q/9DEtgbk0Ci03QW3h6pR9tdLd+xxeydhBS1jlSv2M9Hja3YFOcrsY+5GkXXc2QTjcL6T1ytfVjr0xuTpbG4iJVw==; s=purelymail3; d=lkcamp.dev; v=1; bh=5r+GMHSj63RYi/J4H0h7uqDa4DrIu6yTU3ihuErU0pg=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=hB4hSmKRysELw5XqyuU07J/N0tgIHTlecw0aZ2JllPh3cmBXzxDWTdORnlsNdx75sv0/wjGRN2G9kuQsAujHw2JGGvNioQbJ94ULyRDYGtIfPuY/gkY5yJ1WKXOhezWF0EqmrDVM3kuSthFV7vhQ+5hrH2pm+1uU/F35X9NGsawSY4zNtYcM3k0zfy/rryLNLFqH2e4LZFyRqJiYddAbbfsgf1lANsKgEhiixl5jGblx7nJLKbytAhQFQpohibM+1zbNRIs5F9UFoDVEw8sIEiZMyGRrXS0nSNY/opJmJvMphArpaFisvr+slszhGPXx4FZqG0yGk6ZSDAtdIyDG1w==; s=purelymail3; d=purelymail.com; v=1; bh=5r+GMHSj63RYi/J4H0h7uqDa4DrIu6yTU3ihuErU0pg=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 40580:7130:null:purelymail
X-Pm-Original-To: linux-fbdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 875396785;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 09 Oct 2024 13:44:41 +0000 (UTC)
Message-ID: <b8c3c51e-375f-4139-8336-76b6df56e8ea@lkcamp.dev>
Date: Wed, 9 Oct 2024 10:44:38 -0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750: Fix missing config in Kconfig
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Fabricio Gasperin <fgasperin@lkcamp.dev>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Teddy Wang <teddy.wang@siliconmotion.com>, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 ~lkcamp/patches@lists.sr.ht
References: <20240921180612.57657-1-fgasperin@lkcamp.dev>
 <20240921180612.57657-2-fgasperin@lkcamp.dev>
 <2024100925-lend-aging-2ff3@gregkh>
Content-Language: en-US
From: Vinicius Peixoto <vpeixoto@lkcamp.dev>
In-Reply-To: <2024100925-lend-aging-2ff3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

On 10/9/24 06:56, Greg Kroah-Hartman wrote:
> On Sat, Sep 21, 2024 at 03:06:09PM -0300, Fabricio Gasperin wrote:
>> Fixes the following compilation error:
>>
>> ERROR: modpost: "fb_io_read" [drivers/staging/sm750fb/sm750fb.ko] undefined!
>> ERROR: modpost: "fb_io_write" [drivers/staging/sm750fb/sm750fb.ko] undefined!
>> ERROR: modpost: "fb_io_mmap" [drivers/staging/sm750fb/sm750fb.ko] undefined!
>>
>> Signed-off-by: Fabricio Gasperin <fgasperin@lkcamp.dev>
>> ---
>>   drivers/staging/sm750fb/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/staging/sm750fb/Kconfig b/drivers/staging/sm750fb/Kconfig
>> index 08bcccdd0f1c..eca1aa43d725 100644
>> --- a/drivers/staging/sm750fb/Kconfig
>> +++ b/drivers/staging/sm750fb/Kconfig
>> @@ -3,6 +3,7 @@ config FB_SM750
>>   	tristate "Silicon Motion SM750 framebuffer support"
>>   	depends on FB && PCI && HAS_IOPORT
>>   	select FB_MODE_HELPERS
>> +	select FB_IOMEM_FOPS
>>   	select FB_CFB_FILLRECT
>>   	select FB_CFB_COPYAREA
>>   	select FB_CFB_IMAGEBLIT
>> -- 
>> 2.46.1
>>
>>
> 
> What is causing this error? What commit created the problem, and why
> has no one reported it yet?

This happens because drivers/staging/sm750fb/sm750.c, defines an fb_ops 
structure:

static const struct fb_ops lynxfb_ops = {
	.owner = THIS_MODULE,
	FB_DEFAULT_IOMEM_OPS,
	...
};

FB_DEFAULT_IOMEM_OPS expands to the fb_io_* helpers declared in 
include/linux/fb.h and defined in drivers/video/fbdev/core/fb_io_fops.c; 
however, the latter is gated by FB_IOMEM_FOPS, so when compiling a 
kernel with CONFIG_STAGING=y + CONFIG_FB=m + CONFIG_FB_SM750=m, you get 
the following error:

ERROR: modpost: "fb_io_read" [drivers/staging/sm750fb/sm750fb.ko] undefined!
ERROR: modpost: "fb_io_write" [drivers/staging/sm750fb/sm750fb.ko] 
undefined!
ERROR: modpost: "fb_io_mmap" [drivers/staging/sm750fb/sm750fb.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1

So in order to solve it we select FB_IOMEM_FOPS, much like the other 
FB_* drivers do in drivers/video/fbdev/Kconfig.

Not entirely sure why this wasn't caught before, but the commit that 
broke the build for sm750fb is 6b180f66c0dd ("fbdev: Provide I/O-memory 
helpers as module"), which made the fb_io_* helpers be built as a 
separate module instead of being bundled in fb.o (which is what sm750fb 
was relying on). I think Fabricio can add a "Fixes:" tag in v2.

Thanks,
Vinicius

> 
> confused,
> 
> greg k-h

