Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F714A90
	for <linux-fbdev@vger.kernel.org>; Mon,  5 Feb 2024 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127523; cv=none; b=itcxdKQgPcByKBazOst0o4b9+fuhP/X8PB1Ks6q43dD8D7RN9oK/G1yE5KWbSeTnotstoiVnMPOgUmxEEE5Ci5oQJYEYdyyTO9LP1W6fAjBlWq9BtUfF5ruz7Votm1OGivJ552cUNLdufDF8beUYgXpx1oxxHOlKOyE6fXH/LWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127523; c=relaxed/simple;
	bh=RmbuzgeQ5GImLa1ISfJzwE9p7oJbI7tTF38zP5zhK2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dd/x5H1JiZ21h/QSsBx8iSWdMrhZMGYk95GAVedsU3GF9gEbzcaNQgRt+OaPta1R9dU8lvckxjMfeF6F20KAb2lbOAyfJJVTOf8tVEyLxH1BTLTXjxrJwx7/wXscLSAu8GU5deZa7q4h3mc22CR5ojIKFP6+m76HOeIdobdJew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=afmcMWX0; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="afmcMWX0"
Message-ID: <1d28e615-4c40-4c43-ac97-915ca25e1cd7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707127517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ht2SGZcLR56qHuGqVBuPYaMZcogs2lbBpnDwi6AkSmc=;
	b=afmcMWX0DOiT7FHYJZbc95+NvPOCvjx7DZrxgQeb55B3ZpEkKGETF+MJkBFCpxMfhEy6Aa
	5RkRYrvou7R09yv50LXHRitfGMslTKskY1k1OnPebI9h6xi1xxggRAS6LLMsmB5CLnKSw3
	eaQIVGyoOFrA5XTsE0n9yO0HBZ10eHQ=
Date: Mon, 5 Feb 2024 18:05:02 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v2,2/8] video: Provide screen_info_get_pci_dev() to find
 screen_info's PCI device
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 pjones@redhat.com, deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20240202120140.3517-3-tzimmermann@suse.de>
 <16b3f80f-9b55-4b91-8fc3-9b8ad414437b@linux.dev>
 <0293822c-b261-4725-8cca-3b6dd8e2991d@suse.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <0293822c-b261-4725-8cca-3b6dd8e2991d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2024/2/5 16:17, Thomas Zimmermann wrote:
> Hi
>
> Am 02.02.24 um 18:03 schrieb Sui Jingfeng:
>> Hi,
>>
>>
>> On 2024/2/2 19:58, Thomas Zimmermann wrote:
>>> +
>>> +/**
>>> + * screen_info_pci_dev() - Return PCI parent device that contains 
>>> screen_info's framebuffer
>>> + * @si: the screen_info
>>> + *
>>> + * Returns:
>>> + * The screen_info's parent device on success, or NULL otherwise.
>>> + */
>>> +struct pci_dev *screen_info_pci_dev(const struct screen_info *si)
>>> +{
>>> +    struct resource res[SCREEN_INFO_MAX_RESOURCES];
>>> +    ssize_t i, numres;
>>> +
>>> +    numres = screen_info_resources(si, res, ARRAY_SIZE(res));
>>> +    if (numres < 0)
>>> +        return ERR_PTR(numres);
>>
>>
>> Please return NULL at here, otherwise we have to use the IS_ERR or 
>> IS_ERR_OR_NULL()
>> in the caller function to check the returned value. Meanwhile, I 
>> noticed that you
>> didn't actually call IS_ERR() in the sysfb_parent_dev() function 
>> (introduced by the
>> 3/8 patch), so I think we probably should return NULL at here.
>>
>> Please also consider that the comments of this function says that it 
>> return NULL on
>> the otherwise cases.
>
> Right. The idea is to return NULL is there is no parent device. 


return NULL is more easier and clear, it stand for "None" or "don't exist".
There is another reason that I want to tell you:

Some systems which don't have a good UEFI firmware support for uncommon GPUs.
the word "uncommon" means "not very popular GPU" or "extremely new GPU" or
"just refer to the GPUs that UEFI firmware don't know(recognize) about"

On such cases, there is no firmware framebuffer support. I means it is possible
that screen_info_resources() return -EINVAL because of not support yet. Then,
the screen_info_pci_dev(si) returns ERR_PTR(-EINVAL) and sysfb_pci_dev_is_enabled()
will take this error code as a pointer and de-reference it, cause the following
problem:

And even the x86-64 motherboard will not likely support all GPU(for example the one
with a old UEFI BIOS). And for an example, The intel Xe is the "extremely new GPU".


[    5.031966] CPU 4 Unable to handle kernel paging request at virtual 
address 000000000000081a, era == 900000000329b448, ra == 900000000329b440
[    5.044587] Oops[#1]:
[    5.046837] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc1+ #7
[    5.053062] Hardware name: Loongson 
Loongson-3A6000-HV-7A2000-XA61200/Loongson-3A6000-HV-7A2000-XA61200, 
BIOS Loongson-UDK2018-V4.0.05636-stable202311 12/
[    5.066803] pc 900000000329b448 ra 900000000329b440 tp 
90000001000d0000 sp 90000001000d3d40
[    5.075100] a0 ffffffffffffffea a1 90000001000d3c38 a2 
0000000000000003 a3 9000000003867ce8
[    5.083398] a4 9000000003867ce0 a5 90000001000d3a80 a6 
0000000000000001 a7 0000000000000001
[    5.091695] t0 ac81f55e34713962 t1 ac81f55e34713962 t2 
0000000000000000 t3 0000000000000001
[    5.099992] t4 0000000000000004 t5 0000000000000000 t6 
0000000000000030 t7 0000000000000000
[    5.108290] t8 00000000000070b1 u0 0000000000000000 s9 
0000000000000008 s0 9000000003d58b48
[    5.116587] s1 9000000003c0b4a8 s2 9000000003787000 s3 
9000000003778000 s4 90000000032c0578
[    5.124884] s5 ffffffffffffffea s6 90000000032c0560 s7 
90000000032df900 s8 ffffffffccccc000
[    5.133182]    ra: 900000000329b440 sysfb_init+0x80/0x1f0
[    5.138545]   ERA: 900000000329b448 sysfb_init+0x88/0x1f0
[    5.143905]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
[    5.150048]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[    5.154373]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[    5.159131]  ECFG: 00071c1c (LIE=2-4,10-12 VS=7)
[    5.163717] ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
[    5.169164]  BADV: 000000000000081a
[    5.172623]  PRID: 0014d000 (Loongson-64bit, Loongson-3A6000-HV)
[    5.178587] Modules linked in:
[    5.181614] Process swapper/0 (pid: 1, threadinfo=(____ptrval____), 
task=(____ptrval____))
[    5.189827] Stack : 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
[    5.197782]         0000000000000000 ac81f55e34713962 
90000000032c0000 9000000003778000
[    5.205736]         90000000032c0578 0000000000000000 
900000000329b3c0 9000000003c54000
[    5.213691]         90000001000d3db8 9000000002260154 
0000000000000006 0000000000000000
[    5.221645]         0000000000000000 0000000000000000 
0000000000000000 0000000000000000
[    5.229599]         0000000000000000 0000000000000000 
0000000000000000 ac81f55e34713962
[    5.237553]         90000000037468f8 90000000037468f8 
90000000032c0578 90000000036a7658
[    5.245508]         0000000000000006 9000000100041e00 
0000000000000a55 9000000003260ff4
[    5.251549] ata3: SATA link down (SStatus 0 SControl 300)
[    5.253463]         0000000000000000 90000000032600b0 
0000000000000000 0000000000000000
[    5.266777]         0000000000000000 0000000000000000 
0000000000000000 0000000000000000
[    5.274731]         ...
[    5.277154] Call Trace:
[    5.277155] [<900000000329b448>] sysfb_init+0x88/0x1f0
[    5.284678] [<9000000002260154>] do_one_initcall+0x78/0x1cc
[    5.290213] [<9000000003260ff4>] kernel_init_freeable+0x228/0x298
[    5.296267] [<900000000324d104>] kernel_init+0x20/0x110
[    5.301455] [<90000000022611e8>] ret_from_kernel_thread+0xc/0xa4
[    5.307421]
[    5.308892] Code: 561667fe  0015009c  40007080 <2408308c> 29403860  
02c2e09b  0040818c  6400180c  1a007d45
[    5.318579]
[    5.320053] ---[ end trace 0000000000000000 ]---
[    5.324640] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b
[    5.332247] Kernel relocated by 0x2040000
[    5.336226]  .text @ 0x9000000002240000
[    5.340031]  .data @ 0x90000000032f0000
[    5.343835]  .bss  @ 0x9000000003c3f200
[    5.347640] ---[ end Kernel panic - not syncing: Attempted to kill 
init! exitcode=0x0000000b ]---


> Best regards
> Thomas
>
