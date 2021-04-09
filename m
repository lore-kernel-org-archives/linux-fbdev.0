Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2D9C433ED
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Apr 2021 08:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B3861182
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Apr 2021 08:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhDIIH0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232362AbhDIIHZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 9 Apr 2021 04:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617955632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k2PTBL+nqzlKBelC7c/vISZYvaV01k6PixS2+D0BjW8=;
        b=CMMX+WmY7vM5QTBIFlYb5sYY79hyIrbWGTwSUtru79EJbr6I+203cmAEUcoPaZSIh59TeC
        GW/qkUP/aV3wT4eKvpM6GfQtV4i0Z2LFGp5YlzmHNKM/KHDzHyDaBln9RfohmQFygOKH6D
        0hfEbg4m9f6zJLAv28F6IpHWk2Y/P5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-sYcaZKqyO02l33jnkyP5XA-1; Fri, 09 Apr 2021 04:07:10 -0400
X-MC-Unique: sYcaZKqyO02l33jnkyP5XA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 748496D246;
        Fri,  9 Apr 2021 08:07:08 +0000 (UTC)
Received: from [10.36.115.11] (ovpn-115-11.ams2.redhat.com [10.36.115.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 701F75C1D5;
        Fri,  9 Apr 2021 08:07:02 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
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
 <7496ac87-9676-1b4e-3444-c2a662ec376b@redhat.com>
 <CAK8P3a1tVwkDbtvKi8atkrg1-CfoQHGrXLCzn_uo+=dfZJfdQA@mail.gmail.com>
 <3a2d64a7-8425-8daf-17ee-95b9f0c635f9@redhat.com>
 <CACRpkdYizKGhtYzE+22oZAduLNCOGP9Vbp=LQbXG1C-a+MyMcg@mail.gmail.com>
 <CAK8P3a2Wu7tT-YajfdXSSVvg5MYMEnEy3APJ83DcLeJdGkkSrQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e6fa1b72-24ca-28bc-0115-7ceceb101e96@redhat.com>
Date:   Fri, 9 Apr 2021 10:07:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2Wu7tT-YajfdXSSVvg5MYMEnEy3APJ83DcLeJdGkkSrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 08.04.21 15:19, Arnd Bergmann wrote:
> On Thu, Apr 8, 2021 at 2:50 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> On Thu, Apr 8, 2021 at 2:01 PM David Hildenbrand <david@redhat.com> wrote:
>>
>>>> This is something you could do using a hidden helper symbol like
>>>>
>>>> config DRMA_ASPEED_GFX
>>>>          bool "Aspeed display driver"
>>>>          select DRM_WANT_CMA
>>>>
>>>> config DRM_WANT_CMA
>>>>          bool
>>>>          help
>>>>             Select this from any driver that benefits from CMA being enabled
>>>>
>>>> config DMA_CMA
>>>>          bool "Use CMA helpers for DRM"
>>>>          default DRM_WANT_CMA
>>>>
>>>>            Arnd
>>>>
>>>
>>> That's precisely what I had first, with an additional "WANT_CMA" --  but
>>> looking at the number of such existing options (I was able to spot 1 !)
>>
>> If you do this it probably makes sense to fix a few other drivers
>> Kconfig in the process. It's not just a problem with your driver.
>> "my" drivers:
>>
>> drivers/gpu/drm/mcde/Kconfig
>> drivers/gpu/drm/pl111/Kconfig
>> drivers/gpu/drm/tve200/Kconfig
>>
>> certainly needs this as well, and pretty much anything that is
>> selecting DRM_KMS_CMA_HELPER or
>> DRM_GEM_CMA_HELPER "wants" DMA_CMA.
> 
> Are there any that don't select either of the helpers and
> still want CMA? If not, it would be easy to just add
> 
>     default  DRM_KMS_CMA_HELPER || DRM_GEM_CMA_HELPER
> 
> and skipt the extra symbol.

That sounds like a reasonable thing to do. I'll look into that.

-- 
Thanks,

David / dhildenb

