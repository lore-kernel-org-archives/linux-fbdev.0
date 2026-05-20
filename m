Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6713D3A0B2E
	for <linux-fbdev@vger.kernel.org>; Wed, 20 May 2026 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314009; cv=none; b=r+ruh+294BheaPf1418ugxJDit9/tPmO5hydsUf4WLoXW6EHBkzyheZ1tXyznnbcXsmJnrCiUTiiBgYQYg4SJUIyGa2VMak59s6WeGrfUpq7WYzOWiIeOA4Sk+TlnuNn2ASR4Geo4JPj5Aoa3BcUU+/eIRc7W/wesTt4KDlYIWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314009; c=relaxed/simple;
	bh=5uxbAp1RvoNuAxJCfhgvIZm6DVR63xONZaM0/YNo3V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtwGUbavQp+1pXY6Xy2GCWjzVXWd6277RR95y9F7bWbUZQiw0Zz2G5xbXub/OMUC933S3eN9Kve8Ubbkbjyml4Jl0F1kfXQ12Ggim+57OqGmgsIOiwlps6BcrP4IviOaxrZofHHuekoXqonBuXVhNIgWod6KRW6dYRqMARWJWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lITw4wyv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lITw4wyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AF61F000E9;
	Wed, 20 May 2026 21:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779314008;
	bh=xPV2dKwaE2Vd6MXTyx7rLZbYWuBOQncN75Rd2vCx2ro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lITw4wyvZjTzkXXF5BIabqkOsAkkTnk8NhyhWVUYyUzfg8BYN44UNob3dHZktS4jb
	 0rY1QfWGESKKYfKb35cHc9ouS6SRzDNrtDqOyXSwStx4n5IqrLOIUg4NqxJ+3l+P4Z
	 hJ+Sif5F4oRLchBTgqzGD0vCKxDN9sjh96QZoas3YsExzAGbOJvSQOlB3jvMsjTY2u
	 vhMi7dUtv/xuNIXN5QmfBJA1F0VJAiw0ADJ4fw7+WuBG2qxJVFj7W7HeH7wPo1EClo
	 3bDRRGlRvuSwHcqF9y/LfpaiXl8c222ySl6UJAjoAKo2AP3HuWYctiHwggEKw8RhmQ
	 unjGGhixMCQZQ==
Message-ID: <1e0bc483-ed98-41ae-a5a1-a6ac5069c010@kernel.org>
Date: Wed, 20 May 2026 23:53:21 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] fbdev: Wrap user-invoked calls to fb_set_var() in
 helper
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 simona@ffwll.ch, airlied@gmail.com, lukas@wunner.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260520160744.130841-1-tzimmermann@suse.de>
 <20260520160744.130841-2-tzimmermann@suse.de>
 <0ce59eaf-1124-48c5-b812-c8e6b58e01d0@gmx.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <0ce59eaf-1124-48c5-b812-c8e6b58e01d0@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 20/05/2026 à 20:51, Helge Deller a écrit :
> On 5/20/26 18:00, Thomas Zimmermann wrote:
>> Handle fbcon during display updates in fb_set_var_from_user(). Check
>> with fbcon if the mode change is possible, update hardware state and
>> finally update fbcon. Update all callers.
>>
>> Only the FBIOPUT_VSCREENINFO ioctl currently does all steps. Other
>> mode-changes callers in sysfs and driver code are missing fbcon-related
>> steps.
>>
>> With the new helper, ps3fb and sh_mobile_lcdcfb no longer maintain
>> fbcon state themselves.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/video/fbdev/core/fb_chrdev.c   |  6 +-----
>>   drivers/video/fbdev/core/fbcon.c       |  2 --
>>   drivers/video/fbdev/core/fbmem.c       | 13 +++++++++++++
>>   drivers/video/fbdev/core/fbsysfs.c     |  4 +---
>>   drivers/video/fbdev/ps3fb.c            |  5 +----
>>   drivers/video/fbdev/sh_mobile_lcdcfb.c |  5 +----
>>   include/linux/fb.h                     |  2 ++
>>   7 files changed, 19 insertions(+), 18 deletions(-)
>>
>> ...
>> diff --git a/include/linux/fb.h b/include/linux/fb.h
>> index 5178a33c752c..88680a7cabd5 100644
>> --- a/include/linux/fb.h
>> +++ b/include/linux/fb.h
>> @@ -533,6 +533,8 @@ extern int fb_set_var(struct fb_info *info, struct 
>> fb_var_screeninfo *var);
>>   extern int fb_pan_display(struct fb_info *info, struct 
>> fb_var_screeninfo *var);
>>   extern int fb_blank(struct fb_info *info, int blank);
>> +int fb_set_var_from_user(struct fb_info *info, struct 
>> fb_var_screeninfo *var);
>> +
> 
> "extern" int fb_set_var_from_user(...) ?

No, 'extern' is pointless for function prototypes and 'checkpatch 
--strict' will complain about it.

See following link, search for extern : 
https://docs.kernel.org/dev-tools/checkpatch.html



> 
> Other than that the series is a nice cleanup!
> 
> Thanks!
> Helge

