Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209C4C433B4
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 11:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3C3608FE
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 11:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhDHLBM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 07:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230501AbhDHLBM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 8 Apr 2021 07:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617879660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQhqnjeZkCOh2eK1FDK8AD+p6DMcS/hFEdzGcfPMAFo=;
        b=Vbirf+j5/oeKrWyHHsAyReKkCVP8+9mSK+SYEN/DKRbvwPxg7sh293vcSCMuaXwb1GtqPn
        ho08YQA1oDMqYtSgMTU4su5nfupkCnix8QZuYQ0zG3/1vEIzPzNDNPkr2JoCqKHsaUFMYf
        FuhK1E8jOpmDnJdFpoRIcG3OmK1d6no=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-cf3ok8EPM6mmTtU9zSKjug-1; Thu, 08 Apr 2021 07:00:57 -0400
X-MC-Unique: cf3ok8EPM6mmTtU9zSKjug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E56F83DD21;
        Thu,  8 Apr 2021 11:00:54 +0000 (UTC)
Received: from [10.36.114.231] (ovpn-114-231.ams2.redhat.com [10.36.114.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF0CA5D9D0;
        Thu,  8 Apr 2021 11:00:48 +0000 (UTC)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Joel Stanley <joel@jms.id.au>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
References: <20210408092011.52763-1-david@redhat.com>
 <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
 <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com>
 <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
Message-ID: <7496ac87-9676-1b4e-3444-c2a662ec376b@redhat.com>
Date:   Thu, 8 Apr 2021 13:00:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

>>> In particular, it does not prevent a configuration with 'DRM_CMA=m'
>>
>> I assume you meant "DRM_CMA=n" ? DRM_CMA cannot be built as a module.
> 
> Ok, at least that makes it easier.
> 
>>> and 'DRMA_ASPEED_GFX=y', or any build failures from such
>>> a configuration.
>>
>> I don't follow. "DRM_CMA=n" and 'DRMA_ASPEED_GFX=y' is supposed to work
>> just fine (e.g., without HAVE_DMA_CONTIGUOUS) or what am I missing?
> 
> I thought you were trying to solve the problem where DRMA_ASPEED_GFX
> can optionally link against CMA but would fail to build when the CMA code
> is in a loadable module.

Yes. I was trying to say: it works with this patch just fine. The issue 
you described does not seem to apply (DRM_CMA=m).

> 
>> Your example looks more like a NOP - no?
>> Or will it have the same effect?
> 
> The example I gave is only meaningful if both are tristate, which is
> not the case here as you explain.

Okay, thanks.

> 
> It is a somewhat awkward way to say "prevent this symbol from
> being =y if the dependency is =m".

What would be the right thing to do in the case here then to achieve the 
"if DRMA_ASPEED_GFX is enabled, also enable DMA_CMA id possible"?

One approach could be to have for DMA_CMA

default y if DRMA_ASPEED_GFX

but it feels like the wrong way to tackle this.

Thanks!

-- 
Thanks,

David / dhildenb

