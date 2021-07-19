Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E639AC07E9B
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Jul 2021 23:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0BA6113A
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Jul 2021 23:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbhGSWpx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386015AbhGSTXI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 19 Jul 2021 15:23:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AF6C061574;
        Mon, 19 Jul 2021 12:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=/Va7aGBo6zBlj5l5FvHAL96Jxg2PHZuQ/EZJgrQ6pXY=; b=uIllQ1oDecOK6YrHSA/xXpXAoa
        dih8CbN+tqUG3wjtT2oCviI53z39WfQLun7bH3S4ooLvohHCRHh3+pXKaYQXZvqQAhhS7PMEbkz3I
        itfHGwOnblx3sLdxdsdl7+eeixxVLvIT7iImpTGK9BGHTxUUM00dN6C2+ruCRvSJbXwF4BJnMWD+f
        pLqCAuHot4f0VhJNoVcB9P6Fnrar88g5dMSXPdKCyESEuuBEpTFZRx3f5FyX1exaRWuXUGmOJNvGP
        KM6sjHfiNZIHW2eAaIp9rDQtu8hi2Yspq374sk/EBPgYq67XpTuf3HPl4fF3VMPj8ZFttVLTxFBs2
        meQtNccg==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5ZUO-00BDRo-88; Mon, 19 Jul 2021 20:03:44 +0000
Subject: Re: [PATCH] fbdev: simplefb: limit its use to DRM_SIMPLEDRM=n
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20210719023327.17039-1-rdunlap@infradead.org>
 <CAMuHMdUtTzgnP4GR5phFcVnFVCrU1J87sner-XN6Koc_eZ7Zhg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5a667be9-d2cb-d8fd-d321-b35e673b237e@infradead.org>
Date:   Mon, 19 Jul 2021 13:03:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUtTzgnP4GR5phFcVnFVCrU1J87sner-XN6Koc_eZ7Zhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/19/21 1:06 AM, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Mon, Jul 19, 2021 at 4:34 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> When DRM_SIMPLEDRM=m, all of FB_CFB_{FILLRECT,COPYAREA,IMAGEBLIT} are =m,
> 
> Why does that happen?
> FB_SIMPLE does select FB_CFB_*, so all of the latter should be builtin?
> Do I need my morning coffee? I'm about to fetch it...

Hi Geert,

I have no idea why this happens. It feels like a kconfig bug to me.

>> causing undefined references in fbdev/simplefb.o.
>>
>> By restricting FB_SIMPLEFB to be set only when DRM_SIMPLEDRM is not set,
>> the FB_CFB_* symbols are =y and the build completes without these
>> undefined references.
>>
>> IOW, really "disable simplefb if simpledrm has been selected".
> 
> That does make sense, regardless of my question above ;-)
> 
>> or1k-linux-ld: drivers/video/fbdev/simplefb.o:(.rodata+0x2c): undefined reference to `cfb_fillrect'
>> or1k-linux-ld: drivers/video/fbdev/simplefb.o:(.rodata+0x30): undefined reference to `cfb_copyarea'
>> or1k-linux-ld: drivers/video/fbdev/simplefb.o:(.rodata+0x34): undefined reference to `cfb_imageblit'
>>
>> Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
>> --- linux-next-20210716.orig/drivers/video/fbdev/Kconfig
>> +++ linux-next-20210716/drivers/video/fbdev/Kconfig
>> @@ -2192,7 +2192,7 @@ config FB_HYPERV
>>
>>  config FB_SIMPLE
>>         bool "Simple framebuffer support"
>> -       depends on (FB = y) && !DRM_SIMPLEDRM
>> +       depends on (FB = y) && DRM_SIMPLEDRM=n
>>         select FB_CFB_FILLRECT
>>         select FB_CFB_COPYAREA
>>         select FB_CFB_IMAGEBLIT
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


-- 
~Randy

