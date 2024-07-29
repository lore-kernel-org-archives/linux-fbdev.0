Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585F2770F6;
	Mon, 29 Jul 2024 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285045; cv=none; b=llZOfbARxCiFDuxGRZlfVevODh3OzcoRU5d1MZxsmUbcwAPnjm0ufkK8XgV89uP1EGmO2G0d4ucZL1jf2iKBoARfDDoKcDIijQWXV1PLh7rmwPP2yB0nTkpE5pm5c3BS7Aw14FMZ/PSZlS82vUyM1EEFcbmfR3Tgo40s+I9/sjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285045; c=relaxed/simple;
	bh=3iBi276QMKrstE80w/QQ4LQjbIoVMq1d8UN3s3vHzck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/2ShsjPbJp1rio0Ztxq2PBgLCw0m2nkqZz3KLVGcPWFUAEzf3Q3CwPNsAKHGRhxCx1Tuze5YuxTV4LpoTdJEspyyPYwM9gMXrPtZCCfbKtWc/Cup0yDm/yqOxaqIhl2hT0Qi7VX1KKcKfVV4ujS8F7Spn7NrVnf1IZpL9rymy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VOXTlI3C; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VOXTlI3C"
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id YX0rsofdW6NRTYX0rsbYtL; Mon, 29 Jul 2024 22:30:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722285035;
	bh=KGacKLXgEMga9PvcN1pKMM3xGXU2O6qYmPh2vo3fje4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=VOXTlI3C1yxm634ADdu8Ct0o6s57EC3ZmzkKkHi4UEEyUM5Ff3xYey7pjbXDkEGXP
	 b2veknTxzzFBd+nyXJMGozbIRfnGS0nG8PDwHepOnvAgHBa1RgvXmdN7kbuoJSFWwT
	 mYaPI3lYB1mflwqU1VVP7CAgiHEMfLTu9C+y+87iC5OuOMbjGiu31ZAwIElJPS9ebz
	 hm3mpi6JRREhYGPuYBRs0RCz61lKYc7lpDQCda3nFbylvaTMyliq50lDXj1Kk5aM22
	 tVr1ExmHPmYAXUDOAIPcElpfSMGm689kiNJDkzs0KY+yDcOWvGfVTkYCyLk1r/9HiW
	 yaKvq2NxhadjQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 29 Jul 2024 22:30:35 +0200
X-ME-IP: 90.11.132.44
Message-ID: <aa9fd67e-3498-4152-abbd-3f2f40b0e294@wanadoo.fr>
Date: Mon, 29 Jul 2024 22:30:33 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/hpfb: Fix an error handling path in
 hpfb_dio_probe()
To: Helge Deller <deller@gmx.de>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <dc4fe3d857849ac63131c5620f1bacf1a3d7172e.1722191367.git.christophe.jaillet@wanadoo.fr>
 <698958fb-4fc8-4288-b067-5843c651b093@gmx.de>
 <ac4c6712-c47b-4414-9640-3018bf09e8fa@suswa.mountain>
 <9dbb2b52-4fc9-4bbf-a6a2-ab6ec32adb8f@gmx.de>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <9dbb2b52-4fc9-4bbf-a6a2-ab6ec32adb8f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 29/07/2024 à 22:09, Helge Deller a écrit :
> On 7/29/24 17:59, Dan Carpenter wrote:
>> On Mon, Jul 29, 2024 at 10:13:17AM +0200, Helge Deller wrote:
>>> On 7/28/24 20:29, Christophe JAILLET wrote:
>>>> If an error occurs after request_mem_region(), a corresponding
>>>> release_mem_region() should be called, as already done in the remove
>>>> function.
>>>
>>> True.
>>>
>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>>
>>> I think we can drop this "Fixes" tag, as it gives no real info.
>>
>> If we're backporting patches then these tags really are useful.  As
>> I've been doing more and more backporting, I've come to believe this
>> more firmly.
> 
> Sure, "Fixes" tags are useful, but only if they really refer
> to another patch which introduced the specific issue.
> 
> But the tag 1da177e4c3f4 ("Linux-2.6.12-rc2") isn't useful, as it's
> just the initial git commit. It has no relation to why release_mem_region()
> might have been initially missed. See:

I agree that the description of this specific tag is not useful by itself.

But at least it means: should it be backported, it can be done up to 
there. (and sometimes LWN gives some statistics on how long it took to 
fix an "issue", should it be considered as such)

Without it, it is not easy to guess in which branch the patch is meaningful.

I'll sent a v2 with your suggested minimal change, but I'll keep the 
Fixes tag.


Up to you to remove it or not, and to add a <stable@kernel.org> or a 
<stable+noautosel@kernel.org> or none of them.

Any solution is fine with me.


> 
>   commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 (tag: v2.6.12-rc2)
> Author: Linus Torvalds <torvalds@ppc970.osdl.org>
> Date:   Sat Apr 16 15:20:36 2005 -0700
> 
>      Linux-2.6.12-rc2
> 
>      Initial git repository build. I'm not bothering with the full history,
>      even though we have it. We can create a separate "historical" git
>      archive of that later if we want to, and in the meantime it's about
>      3.2GB when imported into git - space that would just make the early
>      git days unnecessarily complicated, when we don't have a lot of good
>      infrastructure for it.
> 
> Helge
> 
> 

On:

 > HP300 are old HP machines with an m68k CPU.
 > Not sure if someone still has such a machine 🙂

so it really was the one I found on wikipedia, LoL!

So, another way to "fix" the issue is maybe to deprecate the driver or 
everything related to this old architecture?

No strong opinion about it.

CJ
