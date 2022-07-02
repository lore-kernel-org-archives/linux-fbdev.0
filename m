Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59286C43334
	for <linux-fbdev@archiver.kernel.org>; Sat,  2 Jul 2022 12:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiGBMOY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 2 Jul 2022 08:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGBMOS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 2 Jul 2022 08:14:18 -0400
X-Greylist: delayed 517 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Jul 2022 05:14:16 PDT
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21606B7
        for <linux-fbdev@vger.kernel.org>; Sat,  2 Jul 2022 05:14:16 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4LZrPC55Klz9sS1;
        Sat,  2 Jul 2022 14:05:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1656763535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T4i6YsC82SbgYm466G0gN0m48qpoPvni1wETTM+UPl4=;
        b=XhNHIiUw7S9BqDa+9Dt0jRBXYiCz9rxGvsZriqthJT7vZ9YXEDxgcSuMNbImJu2T/RU312
        s6zO8YuG7W+YFo1BiW7FtKrtFg0kkSFaTryu+pbZmSBnmorDR0IISqN8PODz2nbU3Qb2I3
        C+R1cugSwuNcMzYe/HcNqxiDTdd5OKgLhxCOJ7+t3Waa67KsSD/mHkQr20bIA+3qmyHmsD
        yjjpatAASZ0YIt9t5JeAH6eIpYHj7CumPndZnrAeH3fbtXuGCzDTaShFhFXvppNxF9CSTn
        vLwX5PvND36xhhMq538ElLsYawhob5Vmnik+zgDpiaVHYc93CnelPYRMfpbQHA==
Message-ID: <f6c687a5-539d-965f-fc2a-6ff3044798a8@mailbox.org>
Date:   Sat, 2 Jul 2022 14:05:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] fbmem: Prevent invalid virtual screen sizes in
 fb_set_var()
Content-Language: en-CA
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
References: <20220629200024.187187-1-deller@gmx.de>
 <20220629200024.187187-5-deller@gmx.de>
 <CAMuHMdVJ0PsDyTdGoOHPOKdaR7AffG2FpFmw6fxoNdXx9y-J4A@mail.gmail.com>
 <1ba5f6d6-1c31-a8fb-867b-e2a7fda7da56@gmx.de>
 <CAMuHMdVMp-ywWmDevdZTwHHhdiHnsFhze376guTEMd1T=tb-Pg@mail.gmail.com>
 <CAMuHMdVs1J0kvA2Kinx121vF=35dUEY+1Jrx3sjF3NHoD=wMfQ@mail.gmail.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <CAMuHMdVs1J0kvA2Kinx121vF=35dUEY+1Jrx3sjF3NHoD=wMfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wbzqs45mrdut6b6uzcqddhdyp311iwnw
X-MBO-RS-ID: a026cb9e7468604e143
X-Rspamd-Queue-Id: 4LZrPC55Klz9sS1
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2022-07-01 16:49, Geert Uytterhoeven wrote:
> On Thu, Jun 30, 2022 at 9:38 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Thu, Jun 30, 2022 at 9:17 PM Helge Deller <deller@gmx.de> wrote:
>>> On 6/30/22 21:11, Geert Uytterhoeven wrote:
>>>> On Wed, Jun 29, 2022 at 10:00 PM Helge Deller <deller@gmx.de> wrote:
>>>>> Prevent that drivers configure a virtual screen resolution smaller than
>>>>> the physical screen resolution.  This is important, because otherwise we
>>>>> may access memory outside of the graphics memory area.
>>>>>
>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>> Cc: stable@vger.kernel.org # v5.4+
>>>>
>>>> Thanks for your patch!
>>>>
>>>>> --- a/drivers/video/fbdev/core/fbmem.c
>>>>> +++ b/drivers/video/fbdev/core/fbmem.c
>>>>> @@ -1006,6 +1006,12 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>>>>>         if (var->xres < 8 || var->yres < 8)
>>>>>                 return -EINVAL;
>>>>>
>>>>> +       /* make sure virtual resolution >= physical resolution */
>>>>> +       if (WARN_ON(var->xres_virtual < var->xres))
>>>>> +               var->xres_virtual = var->xres;
>>>>> +       if (WARN_ON(var->yres_virtual < var->yres))
>>>>> +               var->yres_virtual = var->yres;
>>>>
>>>> This should be moved below the call to info->fbops->fb_check_var(),
>>>> so the WARN_ON() catches buggy fbdev drivers, not userspace fuzzers.
>>>
>>> Yes, makes sense.
>>
>> And print the name of the frame buffer device driver, so people know
>> who to blame.
> 
> Or better, do not continue, but return with a failure:
> 
>     if (WARN(var->xres_virtual < var->xres || var->yres_virtual < var->yres,
>         "%ps for %s is broken\n", info->fbops->fb_check_var, info->fix.id)
>             return -EINVAL;

I'd also recommend WARN(_ON)_ONCE, or users with a broken driver might get spammed.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
