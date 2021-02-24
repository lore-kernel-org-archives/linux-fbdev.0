Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CF7C433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B283264F03
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhBXWS4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 24 Feb 2021 17:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhBXWS4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 24 Feb 2021 17:18:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02A3C061574;
        Wed, 24 Feb 2021 14:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=NmMzVRS0kxP0bdHCCqL7SOLVBngEB4S9wkbjjir8I38=; b=2GUNnrC9tpda1NsnhbgrIo7/nC
        QV6opykR+PbvjtNZc3e9y95X2TpnxLmHsv8uTKUunhoKqDacWrRCRfg9SGauLo4W823LrcOhFH5Yd
        NqsMdbE3eZabRZtdJaJrM51fbuEMvZIYUlIyYao2pJhvc3Ys06mDbegPhaRda28bBmbDfYp5KOrt9
        EG2enDnn9Q3onH4J1/eXng7i0Ra6udynxUtL4AQCAPiHldZwEdOX6C8BEYkfSZ3/RKPDtbzLCwDUe
        XieJUTMo4utfpBUA0AuTqHTSqLxd4SnbfjKj+fM+/wPX9e0nBVaSUPZOKjQFXJVjgBJjgTPmSJxi9
        C2NawDsA==;
Received: from [2601:1c0:6280:3f0::d05b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lF2Tq-0003Rn-G9; Wed, 24 Feb 2021 22:18:02 +0000
Subject: Re: [PATCH -next] fbdev: atyfb: always declare aty_{ld,st}_lcd()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20210224215528.822-1-rdunlap@infradead.org>
 <CAKwvOdn5mF4UQ9F1h-ZSRKUk3Yq8QS4AExV6kCFY88W3KsK72g@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6083478-0f9b-ab8d-c93b-c5c06283865f@infradead.org>
Date:   Wed, 24 Feb 2021 14:17:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdn5mF4UQ9F1h-ZSRKUk3Yq8QS4AExV6kCFY88W3KsK72g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/24/21 2:07 PM, Nick Desaulniers wrote:
> On Wed, Feb 24, 2021 at 1:55 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> The previously added stubs for aty_{ld,}st_lcd() make it
>> so that these functions are used regardless of the config
>> options that were guarding them, so remove the #ifdef/#endif
>> lines and make their declarations always visible.
>> This fixes build warnings that were reported by clang:
> 
> Yes, though I think GCC would warn similarly with W=1 builds as well,
> which was set for the 0day bot report.
> 

<knocks head> I should enable that until it hurts too much.

>>
>>    drivers/video/fbdev/aty/atyfb_base.c:180:6: warning: no previous prototype for function 'aty_st_lcd' [-Wmissing-prototypes]
>>    void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
>>         ^
>>    drivers/video/fbdev/aty/atyfb_base.c:180:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>>    void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
>>
>>    drivers/video/fbdev/aty/atyfb_base.c:183:5: warning: no previous prototype for function 'aty_ld_lcd' [-Wmissing-prototypes]
>>    u32 aty_ld_lcd(int index, const struct atyfb_par *par)
>>        ^
>>    drivers/video/fbdev/aty/atyfb_base.c:183:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>>    u32 aty_ld_lcd(int index, const struct atyfb_par *par)
>>
>> They should not be marked as static since they are used in
>> mach64_ct.c.
> 
> Probably don't need to be marked extern either (since that's the
> implicit default), but I don't feel strongly about it.

Yeah, I was just leaving it as it was...

> Thanks for sending a cleanup for this.
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> 
>>
>> Fixes: bfa5782b9caa ("fbdev: atyfb: add stubs for aty_{ld,st}_lcd()")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: linux-fbdev@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Cc: Sam Ravnborg <sam@ravnborg.org>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> ---
>>  drivers/video/fbdev/aty/atyfb.h |    3 ---
>>  1 file changed, 3 deletions(-)


-- 
~Randy

