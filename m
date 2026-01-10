Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323081F192E
	for <linux-fbdev@vger.kernel.org>; Sat, 10 Jan 2026 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768051221; cv=none; b=JNHBLKklT/pt1AUckwixnynRqHiKd4X7+HPC69qEu96aniECnplgUlYYAEy5drY/SarD4MOrT1cYXKUdXlLbdFqheLSiMNvEVHqjT9UAoHr6B+dDl6tdgaP0yfODnYeM13+B0EC4JwWZbaDIvSfxXis7fmNln33cYDbvKQzSCDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768051221; c=relaxed/simple;
	bh=mcWwAQmDQrBxrpitpaStI5w0TayFDLq0q7csjwNorjg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=e37CK/aM5w2cN7ioCSKMpaZgeLzz+3J3doZI/yXkn3+boi7LDHs7wIonEoESTqyEBd+X/4Rp1q2YnRsUhbWnfvlWtCVlmq3eNuZPVqREG9Owuon3wpjlDMRkoW8Q6DvBYZwztcC+zyAXOL7VeW0Aq2uBcUvQI3fmgwEwwXjKK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3IWCuZh; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3IWCuZh"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c15e8b2f1aso511949085a.0
        for <linux-fbdev@vger.kernel.org>; Sat, 10 Jan 2026 05:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768051218; x=1768656018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvmFtpYq3AhGNwfLF6kPdeLfesgtuyHszNnUMDnYmVI=;
        b=D3IWCuZhRINoG6MG2WCLTXLZHHEz3mHRJUlrnzzIQUEtpApPnvT6vvNAF/XxXNgSEl
         NKOcHYCkQHpXSOnTpeFBjpxJc8D2G/bNaFjqC1LvBbr3nm7JA9v8ML8FZsZy0rmDYIW7
         1c0WCnbZpNYFeRqP/9cF5+5+mr5ikycCH2J7O9j+wsmzZejtciJHpSCpJJ+cP/1YWA7c
         7fuRRcIZ5zQZ9r3C3XSE17LpNg8ElnKX+K3Tgi+nfRbEx+5TftlSDfUJwL+0z4T5RkVl
         g4KN3XFZeiGa8lsa9yK2KyWh6b1UfwLW8Zh0XYAdrwmykR1dq5p/fSUge5/vE2UWpwxg
         65Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768051218; x=1768656018;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvmFtpYq3AhGNwfLF6kPdeLfesgtuyHszNnUMDnYmVI=;
        b=mZA9wzeISu+tnyRDgY8NdCbUJwbbCQhgTIfTh5BZzab5E+2wZC9oaRQeiDA1PtjkiA
         5S+Gqk4j4mdEA6WZRlpSs/NzEa7XpKCsQxKnrG+AYH1zzbE95vAV6t6RDdX+4jR9ButI
         6zsV7et6TAVJYP0BkH6dP9F2w3GuBDymwvqGQ0GxjbM4gEQcmQa1w+yXsavtOetbRSh0
         +PuMxUu8clV+Gua+x7Bw3ofbE6DBLWyL4JOf77xrSezS+PlLyvVipqtnhk2QvvE2bRnU
         M32JMmvwF43IXjKpeaRgl2H4eomUxp/zMlE7f3geC0LhTt4TeRje3BlPWnArTZgO3GKR
         fk7A==
X-Forwarded-Encrypted: i=1; AJvYcCV4iIPSEtacPa83k688XLZTCgdSRzKQY3RROBmjLaIVQsrGy/8jcPNFvfq6hWvc4A1O3/lM/pxE3CIWPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLHvSATmOj5QfTshOZFgRsyVzwJF1KRnQ6tNEYpRbAwmwwEWW5
	4Y5QHgguHAn8n/FeEi0UsHHXwb9zaIuABByYFzGQ+gJcqLi1HeCQX6s=
X-Gm-Gg: AY/fxX5+lv5BxhiGWbwBxRgwJoQLhzP6Vp53zRgT/fOuKA7+g1rxJF89+Xg/pVcgNPM
	QitIs84Kq2VR84nf0SVJrZoqa+Eou3/2SpguwnA+hKYfgh4FBMuG4ZtrVRE2yWW3D23NjQPNqxb
	9u66ZpJbrYRVJvq2FiNuSYEROJpVzBE7GR6q4/wo+j7RWBiXEv5ChWeAAf1xKtWF8Fd9ryG1w3z
	Qj/GRS4+rPx2YJhHRPaRQWEUZnx9yirLb2V1S5LRaC7xAoMZ0p9cqH0YZTZQqj7vPV272x//LoG
	X1JFrloPogmk5fQM09JrcgICbAW1IqqU6n4mTmfNGeQxp5mjNchupwLVc1zFEltLRtrg1q+cbt7
	s9Vq6sOxOTpQN+lqKXv6wSFc5wzFIEfuAWUfiAOag70B6D8VNw/vpPCK/HyvtlAb6yJQr6dUWYn
	mhUrlKuHpHAaVX1fsD8orXU5vs7bwlEIT4qg1ZNR8=
X-Google-Smtp-Source: AGHT+IHYkrReK4yF4naTlaDor67swNTpLoEWAakzLr0Pf9Lu/+qdcpqgONPLVqMEeWigmof52e/WWw==
X-Received: by 2002:a05:620a:2910:b0:8a1:ac72:e3db with SMTP id af79cd13be357-8c389429138mr1637486585a.72.1768051218033;
        Sat, 10 Jan 2026 05:20:18 -0800 (PST)
Received: from [120.7.1.23] (135-23-93-252.cpe.pppoe.ca. [135.23.93.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51d06fsm1031114585a.32.2026.01.10.05.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 05:20:17 -0800 (PST)
Subject: Re: [PATCH v2] fbdev: bitblit: bound-check glyph index in bit_putcs*
To: Vitaly Chikunov <vt@altlinux.org>, Junjie Cao <junjie.cao@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Zsolt Kajtar <soci@c64.rulez.org>,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251020134701.84082-1-junjie.cao@intel.com>
 <aU23brU4lZqIkw4Z@altlinux.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <e6aac320-846d-eecf-0016-23b56d7cd854@gmail.com>
Date: Sat, 10 Jan 2026 08:20:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aU23brU4lZqIkw4Z@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Vitaly Chikunov wrote:
> Dear linux-fbdev, stable,
>
> On Mon, Oct 20, 2025 at 09:47:01PM +0800, Junjie Cao wrote:
>> bit_putcs_aligned()/unaligned() derived the glyph pointer from the
>> character value masked by 0xff/0x1ff, which may exceed the actual font's
>> glyph count and read past the end of the built-in font array.
>> Clamp the index to the actual glyph count before computing the address.
>>
>> This fixes a global out-of-bounds read reported by syzbot.
>>
>> Reported-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
>> Tested-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> This commit is applied to v5.10.247 and causes a regression: when
> switching VT with ctrl-alt-f2 the screen is blank or completely filled
> with angle characters, then new text is not appearing (or not visible).
>
> This commit is found with git bisect from v5.10.246 to v5.10.247:
>
>    0998a6cb232674408a03e8561dc15aa266b2f53b is the first bad commit
>    commit 0998a6cb232674408a03e8561dc15aa266b2f53b
>    Author:     Junjie Cao <junjie.cao@intel.com>
>    AuthorDate: 2025-10-20 21:47:01 +0800
>    Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>    CommitDate: 2025-12-07 06:08:07 +0900
>
>        fbdev: bitblit: bound-check glyph index in bit_putcs*
>
>        commit 18c4ef4e765a798b47980555ed665d78b71aeadf upstream.
>
>        bit_putcs_aligned()/unaligned() derived the glyph pointer from the
>        character value masked by 0xff/0x1ff, which may exceed the actual font's
>        glyph count and read past the end of the built-in font array.
>        Clamp the index to the actual glyph count before computing the address.
>
>        This fixes a global out-of-bounds read reported by syzbot.
>
>        Reported-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>        Closes: https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
>        Tested-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>        Signed-off-by: Junjie Cao <junjie.cao@intel.com>
>        Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>        Signed-off-by: Helge Deller <deller@gmx.de>
>        Cc: stable@vger.kernel.org
>        Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>     drivers/video/fbdev/core/bitblit.c | 16 ++++++++++++----
>     1 file changed, 12 insertions(+), 4 deletions(-)
>
> The minimal reproducer in cli, after kernel is booted:
>
>    date >/dev/tty2; chvt 2
>
> and the date does not appear.
>
> Thanks,
>
> #regzbot introduced: 0998a6cb232674408a03e8561dc15aa266b2f53b
>
>> ---
>> v1: https://lore.kernel.org/linux-fbdev/5d237d1a-a528-4205-a4d8-71709134f1e1@suse.de/
>> v1 -> v2:
>>   - Fix indentation and add blank line after declarations with the .pl helper
>>   - No functional changes
>>
>>   drivers/video/fbdev/core/bitblit.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
>> index 9d2e59796c3e..085ffb44c51a 100644
>> --- a/drivers/video/fbdev/core/bitblit.c
>> +++ b/drivers/video/fbdev/core/bitblit.c
>> @@ -79,12 +79,16 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
>>   				     struct fb_image *image, u8 *buf, u8 *dst)
>>   {
>>   	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
>> +	unsigned int charcnt = vc->vc_font.charcount;
>>   	u32 idx = vc->vc_font.width >> 3;
>>   	u8 *src;
>>   
>>   	while (cnt--) {
>> -		src = vc->vc_font.data + (scr_readw(s++)&
>> -					  charmask)*cellsize;
>> +		u16 ch = scr_readw(s++) & charmask;
>> +
>> +		if (ch >= charcnt)
>> +			ch = 0;
>> +		src = vc->vc_font.data + (unsigned int)ch * cellsize;
>>   
>>   		if (attr) {
>>   			update_attr(buf, src, attr, vc);
>> @@ -112,14 +116,18 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
>>   				       u8 *dst)
>>   {
>>   	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
>> +	unsigned int charcnt = vc->vc_font.charcount;
>>   	u32 shift_low = 0, mod = vc->vc_font.width % 8;
>>   	u32 shift_high = 8;
>>   	u32 idx = vc->vc_font.width >> 3;
>>   	u8 *src;
>>   
>>   	while (cnt--) {
>> -		src = vc->vc_font.data + (scr_readw(s++)&
>> -					  charmask)*cellsize;
>> +		u16 ch = scr_readw(s++) & charmask;
>> +
>> +		if (ch >= charcnt)
>> +			ch = 0;
>> +		src = vc->vc_font.data + (unsigned int)ch * cellsize;
>>   
>>   		if (attr) {
>>   			update_attr(buf, src, attr, vc);
>> -- 
>> 2.48.1
>>
I have done the same bisecting work, too bad I did not notice Vitaly's 
work earlier :-(

There is a "cheap" workaround for systems before 5.11, (not addressing 
the root issue but) working:

diff --git a/drivers/video/fbdev/core/bitblit.c 
b/drivers/video/fbdev/core/bitblit.c
index 7c2fc9f..c5a1a9d 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -86,7 +86,7 @@ static inline void bit_putcs_aligned(struct vc_data 
*vc, struct fb_info *info,
      while (cnt--) {
          u16 ch = scr_readw(s++) & charmask;

-        if (ch >= charcnt)
+        if (charcnt && ch >= charcnt)
              ch = 0;
          src = vc->vc_font.data + (unsigned int)ch * cellsize;

@@ -125,7 +125,7 @@ static inline void bit_putcs_unaligned(struct 
vc_data *vc,
      while (cnt--) {
          u16 ch = scr_readw(s++) & charmask;

-        if (ch >= charcnt)
+        if (charcnt && ch >= charcnt)
              ch = 0;
          src = vc->vc_font.data + (unsigned int)ch * cellsize;

I will try next to go full backport from 5.11 as Thorsten has suggested.

However the bigger problem is that the fbdev patch has landed in the 
5.4.302 EOL, and essentially the 5.4 EOL kernel is now hanging broken :-(

Thanks, Woody

