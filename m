Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06154908D7;
	Mon, 27 Jul 2026 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114633; cv=none; b=QUvORZ1PHuOYdaQll/MgbuX+Y24zrN2MYhl+TTyeUArmAQuBK7+PuoB8aO7Hxo5rUAQPRlecDdRCUOQHq5X0q0q6J/RARvV1zlGuFgL7hdXNizt9iuQw9dUN1/fMW1OfJxcZFy1wBt1tn31B1DPrSyJmqApHN5CrOVJUZrLhmKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114633; c=relaxed/simple;
	bh=MHW719x5Zt4bSDfUlERu8/Rt6gCGf9Oguw9726P1e4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBfKsZ0bQc0WtKqPBXlI0SKRjAqqm4qIMmoh0wqGHHeWckuhOTQ27A5h2qFaAxWguzo35jjnhA6nDEuJNu45eRj6RuBmBHdo/22lsnT6cjBsmAE3a2p2mDHhVAuBkMdpHTcA19nJpcpdxTAri2rUyRORq2MMLVeIgOkwBFkq2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h7gVD3btqzKHMP0;
	Mon, 27 Jul 2026 09:09:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 85A0340561;
	Mon, 27 Jul 2026 09:10:15 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgC3pkXzr2ZqufZSAA--.19931S3;
	Mon, 27 Jul 2026 09:10:12 +0800 (CST)
Message-ID: <69302a3f-c11c-403f-9bf6-8449a592f6ad@huaweicloud.com>
Date: Mon, 27 Jul 2026 09:10:10 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] fbdev: Fix out-of-bounds access when rotating console
 after font resize
To: Helge Deller <deller@gmx.de>, Zizhi Wo <wozizhi@huaweicloud.com>,
 simona@ffwll.ch, tzimmermann@suse.de, sam@ravnborg.org,
 ville.syrjala@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20260722062216.2574546-1-wozizhi@huaweicloud.com>
 <125aed01-4a98-4424-9276-c105c839fb7f@gmx.de>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <125aed01-4a98-4424-9276-c105c839fb7f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgC3pkXzr2ZqufZSAA--.19931S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw1kJw1rtFy7Cr1DKrWxZwb_yoWxZF15pr
	1vyry7trW5Crn5Ar1jgr45WFyjqr4kJ3WDGrWrJFyUtFW5ZryvqF4UWr1q9rWkJrs7Gr18
	J3WUtr47Za1DZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2026/7/25 23:37, Helge Deller 写道:
> On 7/22/26 08:22, Zizhi Wo wrote:
>> From: Zizhi Wo <wozizhi@huawei.com>
>>
>> [BUG]
>> Recently, we encountered a KASAN warning as follows:
>>
>> BUG: KASAN: slab-out-of-bounds in ccw_putcs+0x8bd/0xa80
>> Read of size 1 at addr ff11000110067100 by task bash/1209
>> CPU: 10 UID: 0 PID: 1209 Comm: bash Not tainted 7.2.0-rc3 #69 
>> PREEMPT(full)
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
>> 1.17.0-4.fc41 04/01/2014
>>   Call Trace:
>>    <TASK>
>>    ...
>>    kasan_report+0xf0/0x120
>>    ? ccw_putcs+0x8bd/0xa80
>>    ccw_putcs+0x8bd/0xa80
>>    ? __pfx_ccw_putcs+0x10/0x10
>>    fbcon_putcs+0x338/0x410
>>    ? __pfx_ccw_putcs+0x10/0x10
>>    do_update_region+0x21d/0x450
>>    invert_screen+0x29d/0x5e0
>>    ? __kmalloc_noprof+0x493/0x640
>>    ? vc_do_resize+0x17c/0xe50
>>    clear_selection+0x4c/0x60
>>    vc_do_resize+0xaee/0xe50
>>    fbcon_modechanged+0x2bd/0x640
>>    rotate_all_store+0x298/0x380
>>    ...
>>
>> reproduce:
>> 1) issue two ioctls: first a KDFONTOP ioctl with op.op = KD_FONT_OP_SET,
>> op.width = 1 and op.height = 1, then a TIOCL_SETSEL ioctl
>> 2) echo 2 > /sys/devices/virtual/graphics/fbcon/rotate_all
>> 3) issue two ioctls: first a KDFONTOP ioctl with op.op = KD_FONT_OP_SET,
>> op.width = 8 and op.height = 1, then a TIOCL_SETSEL ioctl
>> 4) echo 3 > /sys/devices/virtual/graphics/fbcon/rotate_all
>>
>> [CAUSE]
>> The root cause is that fbcon_modechanged() first sets the current 
>> rotate's
>> corresponding ops. Subsequently, during vc_resize(), it may trigger
>> clear_selection(), and in fbcon_putcs->ccw_putcs[rotate=3], this can 
>> result
>> in an out-of-bounds access to "src". This happens because par- 
>> >rotated.buf
>> is reallocated in fbcon_rotate_font():
>> 1) When rotate=2, its size is (width + 7) / 8 * height
>> 2) When rotate=3, its size is (height + 7) / 8 * width
>>
>> And the call to fbcon_rotate_font() occurs after clear_selection(). In
>> other words, the fontbuffer is allocated using the size calculated 
>> from the
>> previous rotation 2, but before reallocating it with the new size,
>> con_putcs is already using the new rotation 3:
>>
>> rotate_all_store
>>   fbcon_rotate_all
>>    fbcon_set_all_vcs
>>     fbcon_modechanged
>>      set_blitting_type
>>      ...
>>       par->bitops = &ccw_fbcon_bitops
>>      vc_resize
>>      ...
>>       clear_selection
>>        highlight
>>        ...
>>         do_update_region
>>     fbcon_putcs
>>     ...
>>      image.dy = vyres - ((xx + count) * vc->vc_font.width) [1]  // 
>> overflow!
>>      ccw_putcs_aligned
>>       // old buf size is still being used during the read!
>>       src = par->rotated.buf + (scr_readw(s--) & charmask) * cellsize
>>       fb_pad_aligned_buffer----[src KASAN!!!]    [2]
>>       info->fbops->fb_imageblit(info, image)
>>        sys_imageblit
>>         fb_imageblit
>>          fb_address_forward
>>           // offset: image->dy * bits_per_line + image->dx * bpp
>>           unsigned int bits = (unsigned int)adr->bits + offset
>>           adr->address += (bits & ~(BITS_PER_LONG - 1u)) / 
>> BITS_PER_BYTE    [3]
>>          fb_bitmap_imageblit
>>          ...
>>           fb_read_offset    // page fault!    [4]
>>      update_screen
>>       redraw_screen
>>       ...
>>        ccw_cursor
>>         soft_cursor
>>          memcpy(src, image->data, dsize)----[src KASAN again!!!]    [5]
>>       fbcon_switch
>>        fbcon_rotate_font
>>         font_data_rotate
>>     dst = kmalloc_array(charcount, d_cellsize, GFP_KERNEL)
>>         // the new size is allocated only here!
>>         par->rotated.buf = buf    [6]
>>
>> [FIX]
>> A fairly obvious approach is to follow fbcon_switch(): in
>> fbcon_modechanged(), call rotate_font() before vc_resize() so that a
>> correctly sized buffer is allocated in time, as done in [6]. This fix is
>> necessary, but it is not sufficient on its own.
>>
>> In [1] it causes an image.dy overflow (ccw_putcs: vyres = 768,
>> image.dy = 4294967040), because vc_cols has not been updated in time at
>> this point (it is likewise only updated after clear_selection()). This
>> allows (xx + count) * width to exceed vyres, causing image.dy to 
>> overflow.
>> Subsequently, address in [3] is incremented by an even larger amount, 
>> which
>> triggers a page fault at [4].
>>
>> Therefore, a second fix is required in combination with the first: move
>> clear_selection() earlier, before set_blitting_type() in
>> fbcon_set_all_vcs(), to prevent the out-of-bounds access. fbcon_rotate()
>> has a similar problem, so add the same clear there. Since vc_is_sel() is
>> not exported, the fbdev side is currently forced to call 
>> clear_selection()
>> unconditionally, causing the global selection to be cleared prematurely.
>> And this will not cause any other significant impact.
>>
>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>> ---
>> v2:
>> Fixed the issue by calling clear_selection() earlier, and updated the
>> related description in the commit message.
>>
>> v1: https://lore.kernel.org/all/20250905024340.337521-1- 
>> wozizhi@huaweicloud.com/
>> ---
>>   drivers/video/fbdev/core/fbcon.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/ 
>> core/fbcon.c
>> index 9f5c4c101581..3361479d139d 100644
>> --- a/drivers/video/fbdev/core/fbcon.c
>> +++ b/drivers/video/fbdev/core/fbcon.c
>> @@ -2639,13 +2639,20 @@ static void fbcon_modechanged(struct fb_info 
>> *info)
>>       vc = vc_cons[par->currcon].d;
>>       if (vc->vc_mode != KD_TEXT ||
>>           fbcon_info_from_console(par->currcon) != info)
>>           return;
>> +    clear_selection();
>> +
>>       p = &fb_display[vc->vc_num];
>>       set_blitting_type(vc, info);
>> +    if (par->bitops->rotate_font && par->bitops->rotate_font(info, 
>> vc)) {
> 
> Do you mind adding some comments before this rotate_font(), so that people
> may understand why you rotate the font here?
> 
> Same for the two added clear_selection() calls.... A short comment which 
> explains
> why the selection is cleared.
> 
> Thank you!
> Helge
> 

Thanks for the review. I missed the comments here. I'll add them in the
next version :)

Thanks,
Zizhi Wo





