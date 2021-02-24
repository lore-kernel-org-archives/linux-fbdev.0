Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5097EC433E6
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Feb 2021 20:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0230664F2C
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Feb 2021 20:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhBXUBZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 24 Feb 2021 15:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbhBXUAo (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 24 Feb 2021 15:00:44 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E76BC061788;
        Wed, 24 Feb 2021 12:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=mK+T5LZEHxUksn3PjQrSRU0QW6w+r5cczZPe9bp7WQc=; b=ymChzcmZ4zZ45BLC9ht82keWKW
        TZOE9uyAotQdztvvzgsaOlE2jfJTL2HGpfDUcmKuHjVX1zvziS4fn6+tbdOOgWZYe0Fb0U7XNiJpd
        HHqGejZ/CSqYwqVjHJ+eeZcdO0Rf18cJlYPkMHr/KfYjIZRKA29QjN/wfkbBgNRjHLI0JBsWQOfxn
        WkxCs+0YtPRv64pO/h+s+xLF+vaZ/JMvBu+T+QgwuECIQD7/FwayU5kR5DtONXT4P/NjCx7eqp36K
        /x+x7e7PhAJdd8E7S6pONo+QFVq6HoCw6aW4sww42C9joDOmpJ6sOjBLmpgG9m5iGn28OFtLTAPrG
        Jj8d6J9A==;
Received: from [2601:1c0:6280:3f0::d05b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lF0K6-0002CE-7b; Wed, 24 Feb 2021 19:59:50 +0000
Subject: Re: [PATCH] fbdev: atyfb: add stubs for aty_{ld,st}_lcd()
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>
References: <20210222032853.21483-1-rdunlap@infradead.org>
 <YDPtYx1uU5Y4HNZ7@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7d416971-ae9b-52a8-bfba-79c2c920ec6c@infradead.org>
Date:   Wed, 24 Feb 2021 11:59:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDPtYx1uU5Y4HNZ7@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/22/21 9:44 AM, Ville Syrjälä wrote:
> On Sun, Feb 21, 2021 at 07:28:53PM -0800, Randy Dunlap wrote:
>> Fix build errors when these functions are not defined.
>>
>> ../drivers/video/fbdev/aty/atyfb_base.c: In function 'aty_power_mgmt':
>> ../drivers/video/fbdev/aty/atyfb_base.c:2002:7: error: implicit declaration of function 'aty_ld_lcd'; did you mean 'aty_ld_8'? [-Werror=implicit-function-declaration]
>>  2002 |  pm = aty_ld_lcd(POWER_MANAGEMENT, par);
>> ../drivers/video/fbdev/aty/atyfb_base.c:2004:2: error: implicit declaration of function 'aty_st_lcd'; did you mean 'aty_st_8'? [-Werror=implicit-function-declaration]
>>  2004 |  aty_st_lcd(POWER_MANAGEMENT, pm, par);
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: linux-fbdev@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Cc: Sam Ravnborg <sam@ravnborg.org>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> ---
>>  drivers/video/fbdev/aty/atyfb_base.c |    9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> --- linux-next-20210219.orig/drivers/video/fbdev/aty/atyfb_base.c
>> +++ linux-next-20210219/drivers/video/fbdev/aty/atyfb_base.c
>> @@ -175,6 +175,15 @@ u32 aty_ld_lcd(int index, const struct a
>>  		return aty_ld_le32(LCD_DATA, par);
>>  	}
>>  }
>> +#else /* defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_BACKLIGHT) \
>> +	 defined(CONFIG_FB_ATY_GENERIC_LCD) */
> 
> A better fix would seem to be to include these functions if
> CONFIG_PPC_PMAC is enabled. Otherwise the PM code will surely
> not work correctly. Though I'm not sure if that PPC PM
> code makes any sense w/o LCD/backlight support anyway.

Hi Ville,

I tried this:

-#if defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_GENERIC_LCD) || \
-defined(CONFIG_FB_ATY_BACKLIGHT)
+#if defined(CONFIG_PPC_PMAC)

in both atyfb_base.c and atyfb.h, but then there is a build error in
mach64_ct.c when PPC_PMAC is not enabled but FB_ATY_GENERIC_LCD is enabled.
[mach64_ct.c is the only other user of aty_{ld,st}_lcd()]

or did you mean adding CONFIG_PPC_PMAC to that longish #if list?
(that's not how I understood your comment.)


I'll gladly step away and let you submit patches for this. :)

>> +void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
>> +{ }
>> +
>> +u32 aty_ld_lcd(int index, const struct atyfb_par *par)
>> +{
>> +	return 0;
>> +}
>>  #endif /* defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
>>  
>>  #ifdef CONFIG_FB_ATY_GENERIC_LCD
>> _______________________________________________


thanks.
-- 
~Randy

