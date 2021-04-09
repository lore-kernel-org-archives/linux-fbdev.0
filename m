Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DD3C43461
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Apr 2021 08:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33ABB611AE
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Apr 2021 08:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhDIIKS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232493AbhDIIKS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 9 Apr 2021 04:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617955805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0CK2pH4tMSS36srqXiWiXDwOybdtTZO1Syr9BWG62Vc=;
        b=InCSkLuX659ZxZqQWQNuFW4W8e9ZF2UnGpHtnkr8EWim+/BxxljkhrLKcbf64BSr/czk+T
        ZLWYL32heKLWC6YI57anVSvha0i0MvNhIWgN6Kq+AxHo2w1qVUULPS0WTIdHWDz0a2mPla
        IKkjQ+X4xCpxO707oD1k9u91JCJ7c10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-RZ0ZAZfyOVWdvZcWXExmQA-1; Fri, 09 Apr 2021 04:10:01 -0400
X-MC-Unique: RZ0ZAZfyOVWdvZcWXExmQA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77CF783DD2E;
        Fri,  9 Apr 2021 08:09:58 +0000 (UTC)
Received: from [10.36.115.11] (ovpn-115-11.ams2.redhat.com [10.36.115.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E145319811;
        Fri,  9 Apr 2021 08:09:52 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
 <2ef3b65c-c0ef-7bbe-0e05-39ee8f2bae48@redhat.com>
 <CAK8P3a3sqZBo8-zye1yiZuD2uMUr0oE_q_QfaK9K54TEgd1Cdw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b78f2ec2-3c47-f435-6d5e-fb7330ff3907@redhat.com>
Date:   Fri, 9 Apr 2021 10:09:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3sqZBo8-zye1yiZuD2uMUr0oE_q_QfaK9K54TEgd1Cdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 08.04.21 22:29, Arnd Bergmann wrote:
> On Thu, Apr 8, 2021 at 6:45 PM David Hildenbrand <david@redhat.com> wrote:
>> On 08.04.21 14:49, Linus Walleij wrote:
>>> On Thu, Apr 8, 2021 at 2:01 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>>>> This is something you could do using a hidden helper symbol like
>>>>>
>>>>> config DRMA_ASPEED_GFX
>>>>>           bool "Aspeed display driver"
>>>>>           select DRM_WANT_CMA
>>>>>
>>>>> config DRM_WANT_CMA
>>>>>           bool
>>>>>           help
>>>>>              Select this from any driver that benefits from CMA being enabled
>>>>>
>>>>> config DMA_CMA
>>>>>           bool "Use CMA helpers for DRM"
>>>>>           default DRM_WANT_CMA
>>>>>
>>>>>             Arnd
>>>>>
>>>>
>>>> That's precisely what I had first, with an additional "WANT_CMA" --  but
>>>> looking at the number of such existing options (I was able to spot 1 !)
>>>
>>> If you do this it probably makes sense to fix a few other drivers
>>> Kconfig in the process. It's not just a problem with your driver.
>>> "my" drivers:
>>>
>>
>> :) I actually wanted to convert them to "depends on DMA_CMA" but ran
>> into recursive dependencies ...
>>
>>> drivers/gpu/drm/mcde/Kconfig
>>> drivers/gpu/drm/pl111/Kconfig
>>> drivers/gpu/drm/tve200/Kconfig
> 
> Right, this is the main problem caused by using 'select' to
> force-enable symbols that other drivers depend on.
> 
> Usually, the answer is to be consistent about the use of 'select'
> and 'depends on', using the former only to enable symbols that
> are hidden, while using 'depends on' for anything that is an
> actual build time dependency.
> 
>> I was assuming these are "real" dependencies. Will it also work without
>> DMA_CMA?
> 
> I think in this case, it is fairly likely to work without DMA_CMA when the
> probe function gets called during a fresh boot, but fairly likely to fail if
> it gets called after the system has run for long enough to fragment the
> free memory.
> 
> The point of DMA_CMA is to make it work reliably.

Right, and even at runtime there is no guarantee that DMA_CMA will do 
anything -- especially if we don't reserve a CMA region (e.g., "cma=X").

So this really sounds like a

"desires DMA_CMA"

and achieving that via an additional symbol or via "default y if ..." 
for DMA_CMA sounds reasonable.

Thanks!

-- 
Thanks,

David / dhildenb

