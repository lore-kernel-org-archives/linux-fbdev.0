Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37C32264D9;
	Fri, 27 Jun 2025 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011697; cv=none; b=HOitsRoJGQpKWj1Adkdlc7TchZDmYJgbSuZXO1aJQkBWyAz6u1z6x26qiWcmKxJvOUNmEqP9KgexPSVjvu4NV6X0I1tHFiuVXdynH963mbZMCy7ZKGbDCZ8j4IXMxEGJEmChsW9qDoNqkTg7+GoAguvbXKQzhz5rLb2NW8mtXrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011697; c=relaxed/simple;
	bh=fpia9a6iKw8L0D4wNnYihrwFfdgdJwMKsA+2bNyr2Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZgPySOWgy6PRprTo5IVe2HXejEZ/a7icICmpQxpkw844o6/b2+u9cfDAIHKLRkvCZJu7o9WpcHEYLHZb789iczzjQMSI/ez0jBaK5afj9+VIP6ozSvBgLCIPOMUmA2goxkDXrlAU/wTjEBYdfvtu30eks/MI0ooRC/SWdAoSj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ClxbQwWK; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ClxbQwWK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=rh9oVjrrQM8DPbLLaBegPR7NE0t6yE6U1DfP0BdJbRI=;
	b=ClxbQwWKsZjVjRh6bo2jM0tkvPv2Oe6+8DdhVtzjEAfYetwC3jintuBn59AdEF
	MXw5CCk5FgF2XqKHEkmDo+pStUT0F59LBMXxJa0F7JutcfHGHWzYvjCQMbmlSM5Z
	osAg6zICS53xfxwozAPCdM8QKHNd02YsC33MPG3i16QT8=
Received: from [10.42.20.80] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD337RWUV5olYa1Aw--.44459S2;
	Fri, 27 Jun 2025 16:07:51 +0800 (CST)
Message-ID: <24f53098-710a-43f9-8d1c-d809fb5354eb@163.com>
Date: Fri, 27 Jun 2025 16:07:50 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: efifb: do not load efifb if PCI BAR has changed
 but not fixuped
To: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>
Cc: Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
References: <20250626094937.515552-1-oushixiong1025@163.com>
 <ecf7f260-4c5f-45fc-be8d-0361b00af6a3@suse.de>
From: Shixiong Ou <oushixiong1025@163.com>
In-Reply-To: <ecf7f260-4c5f-45fc-be8d-0361b00af6a3@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD337RWUV5olYa1Aw--.44459S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtr4UuF43ZryfuFy3ur47twb_yoW3JF1fpF
	4fKw43uF48XF1xGws8Ca1DCr1Svr4v9FyqkFsxK34UA34UGF10vr97C3yq9ryUZr48Jr1x
	tw4Dtw12kF15uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UatCcUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXQd5D2heTgpVUQAAsa


在 2025/6/26 18:31, Thomas Zimmermann 写道:
> Hi
>
> Am 26.06.25 um 11:49 schrieb oushixiong1025@163.com:
>> From: Shixiong Ou <oushixiong@kylinos.cn>
>>
>> [WHY]
>> On an ARM machine, the following log is present:
>> [    0.900884] efifb: framebuffer at 0x1020000000, using 3072k, total 
>> 3072k
>> [    2.297884] amdgpu 0000:04:00.0: 
>> remove_conflicting_pci_framebuffers: bar 0: 0x1000000000 -> 0x100fffffff
>> [    2.297886] amdgpu 0000:04:00.0: 
>> remove_conflicting_pci_framebuffers: bar 2: 0x1010000000 -> 0x10101fffff
>> [    2.297888] amdgpu 0000:04:00.0: 
>> remove_conflicting_pci_framebuffers: bar 5: 0x58200000 -> 0x5823ffff
>>
>> It show that the efifb framebuffer base is out of PCI BAR, and this
>
> The patch at
>
>   https://patchwork.freedesktop.org/series/148057/
>
> is supposed to fix the problem. It has been merged with v6.16-rc1 as 
> commit 2f29b5c23101 ("video: screen_info: Relocate framebuffers behind 
> PCI bridges"). It is in your tree?
>
> Best regards
> Thomas
>
yeah, this patch is in my tree. but do not fix the problem.

this is some message:

kylin@kylin-pc:~$ dmesg | grep BAR
[    0.688192] pci 0000:00:03.0: BAR 15: assigned [mem 
0x1000000000-0x101fffffff 64bit pref]
[    0.688200] pci 0000:00:00.0: BAR 0: assigned [mem 
0x1020000000-0x10200fffff 64bit pref]
[    0.688205] pci 0000:00:00.0: BAR 14: assigned [mem 
0x58000000-0x580fffff]
[    0.688210] pci 0000:00:01.0: BAR 0: assigned [mem 
0x1020100000-0x10201fffff 64bit pref]
[    0.688215] pci 0000:00:02.0: BAR 0: assigned [mem 
0x1020200000-0x10202fffff 64bit pref]
[    0.688221] pci 0000:00:02.0: BAR 14: assigned [mem 
0x58100000-0x581fffff]
[    0.688225] pci 0000:00:03.0: BAR 0: assigned [mem 
0x1020300000-0x10203fffff 64bit pref]
[    0.688231] pci 0000:00:03.0: BAR 14: assigned [mem 
0x58200000-0x585fffff]
[    0.688237] pci 0000:00:04.0: BAR 0: assigned [mem 
0x1020400000-0x10204fffff 64bit pref]
[    0.688243] pci 0000:00:05.0: BAR 0: assigned [mem 
0x1020500000-0x10205fffff 64bit pref]
[    0.688249] pci 0000:00:05.0: BAR 14: assigned [mem 
0x58600000-0x586fffff]
[    0.688253] pci 0000:01:00.0: BAR 0: assigned [mem 
0x58000000-0x58003fff 64bit]
[    0.688290] pci 0000:03:00.0: BAR 6: assigned [mem 
0x58100000-0x5817ffff pref]
[    0.688296] pci 0000:03:00.0: BAR 0: assigned [mem 0x58180000-0x58181fff]
[    0.688303] pci 0000:03:00.0: BAR 5: assigned [mem 0x58182000-0x58183fff]
[    0.688317] pci 0000:04:00.0: BAR 1: assigned [mem 
0x1000000000-0x101fffffff 64bit pref]
[    0.688326] pci 0000:04:00.0: BAR 0: assigned [mem 0x58200000-0x583fffff]
[    0.688332] pci 0000:04:00.0: BAR 6: assigned [mem 
0x58400000-0x584fffff pref]
[    0.688336] pci 0000:04:00.1: BAR 0: assigned [mem 0x58500000-0x58503fff]
[    0.688360] pci 0000:06:00.0: BAR 0: assigned [mem 
0x58600000-0x58601fff 64bit]
kylin@kylin-pc:~$ dmesg | grep framebuffer
[    1.137536] efifb: framebuffer at 0x1020000000, using 3072k, total 3072k

the efifb base address is still at 0x1020000000 after calling 
pcibios_bus_to_resource().


>> results in both efi-framebuffer and amdgpudrmfb co-existing.
>>
>> The fbcon will be bound to efi-framebuffer by default and cannot be 
>> used.
>>
>> [HOW]
>> Do not load efifb driver if PCI BAR has changed but not fixuped.
>> In the following cases:
>>     1. screen_info_lfb_pdev is NULL.
>>     2. __screen_info_relocation_is_valid return false.
>>
>> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
>> ---
>>   drivers/video/fbdev/efifb.c     |  4 ++++
>>   drivers/video/screen_info_pci.c | 24 ++++++++++++++++++++++++
>>   include/linux/screen_info.h     |  5 +++++
>>   3 files changed, 33 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
>> index 0e1bd3dba255..de8d016c9a66 100644
>> --- a/drivers/video/fbdev/efifb.c
>> +++ b/drivers/video/fbdev/efifb.c
>> @@ -303,6 +303,10 @@ static void efifb_setup(struct screen_info *si, 
>> char *options)
>>     static inline bool fb_base_is_valid(struct screen_info *si)
>>   {
>> +    /* check whether fb_base has changed but not fixuped */
>> +    if (!screen_info_is_useful())
>> +        return false;
>> +
>>       if (si->lfb_base)
>>           return true;
>>   diff --git a/drivers/video/screen_info_pci.c 
>> b/drivers/video/screen_info_pci.c
>> index 66bfc1d0a6dc..ac57dcaf0cac 100644
>> --- a/drivers/video/screen_info_pci.c
>> +++ b/drivers/video/screen_info_pci.c
>> @@ -9,6 +9,8 @@ static struct pci_dev *screen_info_lfb_pdev;
>>   static size_t screen_info_lfb_bar;
>>   static resource_size_t screen_info_lfb_res_start; // original start 
>> of resource
>>   static resource_size_t screen_info_lfb_offset; // framebuffer 
>> offset within resource
>> +static bool screen_info_changed;
>> +static bool screen_info_fixuped;
>>     static bool __screen_info_relocation_is_valid(const struct 
>> screen_info *si, struct resource *pr)
>>   {
>> @@ -24,6 +26,24 @@ static bool 
>> __screen_info_relocation_is_valid(const struct screen_info *si, stru
>>       return true;
>>   }
>>   +bool screen_info_is_useful(void)
>> +{
>> +    unsigned int type;
>> +    const struct screen_info *si = &screen_info;
>> +
>> +    type = screen_info_video_type(si);
>> +    if (type != VIDEO_TYPE_EFI)
>> +        return true;
>> +
>> +    if (screen_info_changed && !screen_info_fixuped) {
>> +        pr_warn("The screen_info has changed but not fixuped");
>> +        return false;
>> +    }
>> +
>> +    pr_info("The screen_info is useful");
>> +    return true;
>> +}
>> +
>>   void screen_info_apply_fixups(void)
>>   {
>>       struct screen_info *si = &screen_info;
>> @@ -32,18 +52,22 @@ void screen_info_apply_fixups(void)
>>           struct resource *pr = 
>> &screen_info_lfb_pdev->resource[screen_info_lfb_bar];
>>             if (pr->start != screen_info_lfb_res_start) {
>> +            screen_info_changed = true;
>>               if (__screen_info_relocation_is_valid(si, pr)) {
>>                   /*
>>                    * Only update base if we have an actual
>>                    * relocation to a valid I/O range.
>>                    */
>>                   __screen_info_set_lfb_base(si, pr->start + 
>> screen_info_lfb_offset);
>> +                screen_info_fixuped = true;
>>                   pr_info("Relocating firmware framebuffer to offset 
>> %pa[d] within %pr\n",
>>                       &screen_info_lfb_offset, pr);
>>               } else {
>>                   pr_warn("Invalid relocating, disabling firmware 
>> framebuffer\n");

And should something be done after __screen_info_relocation_is_valid() 
return false?

Best regards
Shixiong.

>>               }
>>           }
>> +    } else {
>> +        screen_info_changed = true;
>>       }
>>   }
>>   diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
>> index 923d68e07679..632cdbb1adbe 100644
>> --- a/include/linux/screen_info.h
>> +++ b/include/linux/screen_info.h
>> @@ -138,9 +138,14 @@ ssize_t screen_info_resources(const struct 
>> screen_info *si, struct resource *r,
>>   u32 __screen_info_lfb_bits_per_pixel(const struct screen_info *si);
>>     #if defined(CONFIG_PCI)
>> +bool screen_info_is_useful(void);
>>   void screen_info_apply_fixups(void);
>>   struct pci_dev *screen_info_pci_dev(const struct screen_info *si);
>>   #else
>> +bool screen_info_is_useful(void)
>> +{
>> +    return true;
>> +}
>>   static inline void screen_info_apply_fixups(void)
>>   { }
>>   static inline struct pci_dev *screen_info_pci_dev(const struct 
>> screen_info *si)
>

