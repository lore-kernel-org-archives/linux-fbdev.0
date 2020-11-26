Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C093FC56202
	for <linux-fbdev@archiver.kernel.org>; Thu, 26 Nov 2020 16:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8125A20B80
	for <linux-fbdev@archiver.kernel.org>; Thu, 26 Nov 2020 16:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bVomFdoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390599AbgKZQdj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 26 Nov 2020 11:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbgKZQdj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 26 Nov 2020 11:33:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D43C0613D4;
        Thu, 26 Nov 2020 08:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=bqLeJ7tQgtWVqUanZNK/be2k3nwImihYsEZ6qm1//Jc=; b=bVomFdoZyMjCyp39m/+hI2Cwp+
        tB/4WCBZR50jHXKiCbmayUPoNDYFTz3eaYscv63cEpljzSt3bgj10aFLmLi9q/bV+6Lf8MCarhByy
        IqLCyoxLP4RjRInuZScNQ7WlWRaCJLoppv6mSYHkmuUGPmcGeBA3yUMdOsw44vHX7prAhVgmVc28m
        wTZBQzA4ZMerKTLED4JtJHpuXnhmFuoZTxTLwI7BuoyQrx5EgKb93P9H/24K4JirvjCpCVeSv1wh4
        3bXfigxXx+9TTJ7WRwvq1r8koyjXVmn06BUMv7X6Pdlx+UzrAO6U5yEZD+dtjZy8cVCntw0YdrBYy
        uZq6CsaQ==;
Received: from [2601:1c0:6280:3f0::cc1f]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiKD7-0001TC-NC; Thu, 26 Nov 2020 16:33:34 +0000
Subject: Re: [PATCH] fbdev: aty: SPARC64 requires FB_ATY_CT
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20201126003957.19604-1-rdunlap@infradead.org>
 <CAMuHMdVpcLc9enskSBJobmHXy3GU5ULdt78ArAr522VXRmty5w@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d0f1daa5-8d3f-4eb9-ad00-29eb344016b7@infradead.org>
Date:   Thu, 26 Nov 2020 08:33:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVpcLc9enskSBJobmHXy3GU5ULdt78ArAr522VXRmty5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 11/26/20 12:29 AM, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Thu, Nov 26, 2020 at 1:40 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> It looks like SPARC64 requires FB_ATY_CT to build without errors,
>> so adjust the Kconfig entry of FB_ATY_CT so that it is always 'y'
>> for SPARC64 && PCI by disabling the prompt for SPARC64 && PCI.
>>
>> As it currently is, FB_ATY_CT can be disabled, resulting in build
>> errors:
>>
>> ERROR: modpost: "aty_postdividers" [drivers/video/fbdev/aty/atyfb.ko] undefined!
>> ERROR: modpost: "aty_ld_pll_ct" [drivers/video/fbdev/aty/atyfb.ko] undefined!
>>
>> Fixes: f7018c213502 ("video: move fbdev to drivers/video/fbdev")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks for your patch!
> 
>> --- linux-next-20201124.orig/drivers/video/fbdev/Kconfig
>> +++ linux-next-20201124/drivers/video/fbdev/Kconfig
>> @@ -1277,7 +1277,7 @@ config FB_ATY
>>           module will be called atyfb.
>>
>>  config FB_ATY_CT
>> -       bool "Mach64 CT/VT/GT/LT (incl. 3D RAGE) support"
>> +       bool "Mach64 CT/VT/GT/LT (incl. 3D RAGE) support" if !(SPARC64 && PCI)
>>         depends on PCI && FB_ATY
>>         default y if SPARC64 && PCI
>>         help
> 
> What about letting FB_ATY select FB_ATY_CT if SPARC64 && PCI, and
> dropping the "default y"-line, instead?

Sure, I'll try it that way and repost.

thanks.
-- 
~Randy

