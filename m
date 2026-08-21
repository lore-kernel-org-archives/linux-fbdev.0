Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE67140D57B
	for <linux-fbdev@vger.kernel.org>; Fri, 21 Aug 2026 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294656; cv=none; b=LFajHQlmCLeUs8nRDNq2B0nJ/xqOMaNVtSOqwQYdgP8GBABTtThr2b7cEVHOl5bEomFPUgmnglZVl02dHDoI1n8JE9eg8vmTlfUqe+Nqj9lOEhPNExaEUB3cAfqVrLy+T3c6eaw+84ksHC9tVhJDxToARK8NfLAqZf37ZOTIxDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294656; c=relaxed/simple;
	bh=L/UVVSeom+P59+ujN47bnKq68spw15q+i+jnk4n4Pzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5i4hr1mTsgIaUmwMQQY9LfWzLiuYfbVoYI59vNXhAEMsMy+ZpZcATujPRwZxtMyA3ngWivEExgf82lKcuFnOzR08gbaXSLH9U0rxDYqmvBLbgcWitlMLbhpco9x+4+eeE8uccshukKv2SMiY0VrhigAYaZnYNCTxVsNYF6i9Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5Yzpfy1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5Yzpfy1"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84fa3b14ee1so468640b3a.0
        for <linux-fbdev@vger.kernel.org>; Thu, 20 Aug 2026 23:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787294654; x=1787899454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S3NXjAx8DS81zlRBp1anbXWy3b9niKSDmBNBcwUXn1I=;
        b=Z5Yzpfy1fJyt+TvL0aToBx87Fg7V80xpjGfPuNfdpqIz4rNLHBTgDkB1s9A3txY+SI
         u9HQ4dz15vmJOwnVQs4tl0AvHNtyZh4ESA1MDq7ZnJZG+QT4BuCzoT08/ZRuIk6M0sbE
         F/sUgdBbMKX1GXGqPsgip08muVmIO7HNY1a4kj+4ZgnftJt3RnmEDjfN6MOCN4mlZfye
         sS2A3iD2You8scuiP94LXun5+GR507WpBliDb1yGuKBcFwcOUgYA2hDZpWyjZKqkyvWC
         sVL347zemQw2fEKkqImLXhfmQR5Ghy/IdS0oG977v6am98s8RkGFfl0ioeAw155tMjet
         orqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787294654; x=1787899454;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3NXjAx8DS81zlRBp1anbXWy3b9niKSDmBNBcwUXn1I=;
        b=E+tyZZR5xdoh3y0AS340hs7LU/87A3dsaV7MEKEdjDB4qs92JdsaRkJ8QQdpqFej0b
         fcE2ByWOpmyY4hXuvfj6k/TmYJ2RRcW69lpnhRjF1tfEsq2wz8vG5PIPYFMzEDsP2hYu
         MCJfMTM7IFfqjR58u0wfnbgtaN77gT1aC6gqfGU92vwS8RKMdVe6hqTUUDvJZRrzdaMu
         8NKQU0L3Ypp14ThFqrVhAUYd8HjKAQVqbRIXIXt6lsexWyLOeyw8XIQtvVZuBzAnzRfu
         kKcR+rmUucyQp8uSx0NGECHeDvVrsM4s8CijdtJuZrlUZdn+q/DAu+6gr3AQw56ZrJSZ
         tLZA==
X-Forwarded-Encrypted: i=1; AHgh+RrJVcZ0uVSog4ZUvAb7vysO/knLLSlNhK090x27pLtrniuU9/o/EPahijwudgrtYzh87DFbu7RdCR7H6g==@vger.kernel.org
X-Gm-Message-State: AFuF++lS/LFfa7VGo8iTUGs+hmykPt13plQ5I7h+mLmbv93CSwQZJSiU
	k2nA2UMCXUArxD7rABXpkEdb7+2az3XcBOJVkWZg8RfIOilGSZPXdUDu
X-Gm-Gg: AR+sD139cs59GXG1kTAt/vNpYbNvhXLb0fwCPietsV0mKdsSWzUMdqdrJ1onH1SwHc7
	BPW5uWy+NutYuneUWSlb8ABw7vJDZ76xkWN+Z1Y2q9KUG30I6gwKgCee7JdsxEMVyXVhalpRV7H
	pV2cyTUkk8MlHeNeXLLlWdzQg4pH3Miy7YKGw+BPcuceJ97SeqtqSt0JtAme95OeZhABpnAw/CH
	XR/s6YW7HuEnrNbg6nVtnzciDogOYZWtdDWjqyz9rhjzFRneiNjaAXR9dBXfZaoipU7DPBRWjc2
	7v7aBx1PoCh4sDg6roeHCoL0P5yO1EaKzii5Ciaq5vFveJ3sXdB0YIgKiNJllmLcdMyqecymEYY
	2KA+ZkN1UvkX4LMOivY70Yue0iUQiPLiBmTtDawmIdClWVYjsaDQ2D/JgGp7yq5jiisVQvLrRFj
	UzC8CjPGwNKhdefMmsB9PCFTnbolA/mfwV//OeRkj7GMjtg8y3drMOwK0BlIkHBjrbtA8VdIv2g
	lbHwCMckAjhcbIsIn8qO9ih0ZYvJSZ9yiW0Ig==
X-Received: by 2002:a05:6a00:39a4:b0:851:804c:f4eb with SMTP id d2e1a72fcca58-851f9a4b174mr5908647b3a.4.1787294654092;
        Thu, 20 Aug 2026 23:44:14 -0700 (PDT)
Received: from [10.1.1.100] (122-59-250-182-adsl.sparkbb.co.nz. [122.59.250.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d366f028sm2470992b3a.53.2026.08.20.23.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 23:44:13 -0700 (PDT)
Message-ID: <b9883e21-3ce7-4d0c-aa11-53d8d6d78e60@gmail.com>
Date: Fri, 21 Aug 2026 18:44:08 +1200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] fbdev: Give atafb proper parent
To: Helge Deller <deller@gmx.de>, linux-m68k@vger.kernel.org,
 geert@linux-m68k.org
Cc: Miro Kropacek <miro.kropacek@gmail.com>, linux-fbdev@vger.kernel.org
References: <20260819222838.21256-1-schmitzmic@gmail.com>
 <20260819222838.21256-3-schmitzmic@gmail.com>
 <aa508c70-ccd3-4fc0-86fc-e45746e68405@gmx.de>
Content-Language: en-US
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <aa508c70-ccd3-4fc0-86fc-e45746e68405@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks Helge,

On 21/08/2026 9:51 AM, Helge Deller wrote:
> On 8/20/26 00:28, Michael Schmitz wrote:
>> From: Miro Kropacek <miro.kropacek@gmail.com>
>>
>> The atafb fb device registers no parent, causing a missing symlink
>> (/sys/class/graphics/fb0/device). Xorg fbdevhw driver looks for that
>> symlink when scanning for devices, so add a parent node for atafb.
>>
>> The proper way to do that is use of framebuffer_alloc(), which
>> requries refactoring atafb to move from static fb_info to allocation
>> of fb_info by framebuffer_alloc().
>> About the only location where a fb_info pointer cannot be passed
>> is monspec setup in atafb_setup(). Store static monspecs there
>> and copy into place after framebuffer_alloc().
>>
>> Pass fb_info everywhere it's needed (detect, decode_var and
>> do_fb_set_var functions), and remove the static fb_info struct.
>>
>> Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
>> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> Cc: <linux-fbdev@vger.kernel.org>
>> Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
>>
>> ---
>>
>> Changes in v3:
>>
>> - fbdev: refactor atafb fb_info use to allow use of framebuffer_alloc()
>>    (Thomas Zimmermann)
>> ---
>>   drivers/video/fbdev/atafb.c | 174 +++++++++++++++++++-----------------
>>   1 file changed, 92 insertions(+), 82 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
>> index b8ed1c537293..a9be06ded5c9 100644
>> --- a/drivers/video/fbdev/atafb.c
>> +++ b/drivers/video/fbdev/atafb.c
>> @@ -158,14 +158,6 @@ static int DontCalcRes = 0;
>>   #define VMO_PREMASK        0x0c
>>   #endif
>>   -static struct fb_info fb_info = {
>> -    .fix = {
>> -        .id    = "Atari ",
>> -        .visual    = FB_VISUAL_PSEUDOCOLOR,
>> -        .accel    = FB_ACCEL_NONE,
>> -    }
>> -};
>> -
>>   static void *screen_base;    /* base address of screen */
>>   static unsigned long phys_screen_base;    /* (only for Overscan) */
>>   @@ -175,6 +167,12 @@ static int current_par_valid;
>>     static int mono_moni;
>>   +/* monspecs passed by user */
>> +
>> +static __u32 mcap_hmin;        /* hfreq lower limit (Hz) */
>> +static __u32 mcap_hmax;        /* hfreq upper limit (Hz) */
>> +static __u16 mcap_vmin;        /* vfreq lower limit (Hz) */
>> +static __u16 mcap_vmax;        /* vfreq upper limit (Hz) */
>>     #ifdef ATAFB_EXT
>>   @@ -299,7 +297,7 @@ static int *MV300_reg = MV300_reg_8bit;
>>   /* ++roman: This structure abstracts from the underlying hardware 
>> (ST(e),
>>    * TT, or Falcon.
>>    *
>> - * int (*detect)(void)
>> + * int (*detect)(*fb_info)
>
> I fixed this comment up to become:
> + * int (*detect)(struct fb_info *info)
>
> Other than that I've replaced the latest patch series by this series in
> the fbdev for-next git tree.

Appreciate the fast work - I'm working on another patch for atafb to 
update error handling in atafb_probe() (just calling panic() when 
something goes wrong is a little rough these days). Will take a little 
longer to test though.

Cheers,

     Michael

>
> Thanks!
> Helge
