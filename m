Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CE4C432BE
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 14:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FCFB60E98
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 14:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbhH3O1Q (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:27:16 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53668 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbhH3O1Q (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Aug 2021 10:27:16 -0400
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17UEPqjZ076941;
        Mon, 30 Aug 2021 23:25:52 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Mon, 30 Aug 2021 23:25:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17UEPqK6076922
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Aug 2021 23:25:52 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 vga16fb_fillrect
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        syzbot <syzbot+04168c8063cfdde1db5e@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        syzkaller-bugs@googlegroups.com
References: <000000000000815b9605c70e74f8@google.com>
 <131b24e5-ee31-6f7b-42b4-c34583711913@infradead.org>
 <2fccb5d3-191c-924e-159f-1c9d423e282f@i-love.sakura.ne.jp>
 <CAMuHMdV=xVhEHLEoYt3OF+kmGrLOr6t7SP1sghSmp9JqXD+3Og@mail.gmail.com>
 <20210830130000.GW7722@kadam>
 <8ed0ca59-226b-2d0e-b1ae-82305202558d@i-love.sakura.ne.jp>
 <20210830134719.GI12231@kadam>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <03d0f549-9731-8b06-1393-60d4bef27884@i-love.sakura.ne.jp>
Date:   Mon, 30 Aug 2021 23:25:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210830134719.GI12231@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2021/08/30 22:47, Dan Carpenter wrote:
> On Mon, Aug 30, 2021 at 10:37:31PM +0900, Tetsuo Handa wrote:
>> On 2021/08/30 22:00, Dan Carpenter wrote:
>>>>> diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
>>>>> index e2757ff1c23d..e483a3f5fd47 100644
>>>>> --- a/drivers/video/fbdev/vga16fb.c
>>>>> +++ b/drivers/video/fbdev/vga16fb.c
>>>>> @@ -403,7 +403,7 @@ static int vga16fb_check_var(struct fb_var_screeninfo *var,
>>>>>
>>>>>         if (yres > vyres)
>>>>>                 vyres = yres;
>>>>> -       if (vxres * vyres > maxmem) {
>>>>> +       if ((u64) vxres * vyres > (u64) maxmem) {
>>>>
>>>> Mindlessly changing the sizes is not the solution.
>>>> Please use e.g. the array_size() helper from <linux/overflow.h>
>>>> instead.
>>>
>>> On a 64bit system the array_size() macro is going to do the exact same
>>> casts?  But I do think this code would be easier to understand if the
>>> integer overflow check were pull out separately and done first:
>>>
>>> 	if (array_size(vxres, vyres) >= UINT_MAX)
>>> 		return -EINVAL;
>>
>> This is wrong. array_size() returns ULONG_MAX on 64bits upon overflow and
>> returns UINT_MAX on 32bits upon overflow. However, UINT_MAX is a valid
>> value without overflow (e.g. vxres == UINT_MAX / 15 && vyres == 15).
> 
> Huh...  I just assumed we didn't allow resolutions that high.

Of course, we don't allow resolutions that high. ;-)

Since I don't know possible max resolutions, I chose UINT_MAX + 1 as a common
limit for returning -EINVAL. Unless overflow happens, vga16fb_check_var() will
return -ENOMEM on such high resolutions.

> 
>> Comparing like "> (u64) UINT_MAX" is to detect only overflow.
>>
> 
> Of course, that doesn't work on 32 bit systems.  Also the cast isn't
> required because of type promotion.

Indeed, "> UINT_MAX" seems to work on both 32bits and 64bits.

----------
#include <stdio.h>
#include <limits.h>

int main(int argc, char *argv[])
{
        unsigned int w = 0x600;
        unsigned int h = 0x10000000;
        if ((unsigned long long) w * h > UINT_MAX)
                printf("Overflowed\n");
        else
                printf("No overflow\n");
        return 0;
}
----------

