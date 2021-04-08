Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C87C433B4
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 12:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1203610A6
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 12:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhDHMBh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 08:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231375AbhDHMBg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 8 Apr 2021 08:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617883285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9w9YC3zCV/phM+v6dbwLtZQB2bWMLSUUDF9CJsBj118=;
        b=SYQQ6b5Ab1oPrYJTG3R7VJEj2KMCrIS76KAJEADW5MVN4rQANjVmXdhErcGbG4z7iEFgwy
        IdXnoZXf0qnVtMFmPX7uBTjK+PrISvbsFIkXt89lQcdsD2ywGB8u7RiQa7fUPhur6gL8jb
        FduycXLXb0kAI1NJbqeqIAD5dl97UWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-ipUMHffwO8qCjSquithB5A-1; Thu, 08 Apr 2021 08:01:20 -0400
X-MC-Unique: ipUMHffwO8qCjSquithB5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E741F8710FD;
        Thu,  8 Apr 2021 12:00:54 +0000 (UTC)
Received: from [10.36.112.70] (ovpn-112-70.ams2.redhat.com [10.36.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4480460853;
        Thu,  8 Apr 2021 12:00:49 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
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
 <7496ac87-9676-1b4e-3444-c2a662ec376b@redhat.com>
 <CAK8P3a1tVwkDbtvKi8atkrg1-CfoQHGrXLCzn_uo+=dfZJfdQA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3a2d64a7-8425-8daf-17ee-95b9f0c635f9@redhat.com>
Date:   Thu, 8 Apr 2021 14:00:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1tVwkDbtvKi8atkrg1-CfoQHGrXLCzn_uo+=dfZJfdQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 08.04.21 13:44, Arnd Bergmann wrote:
> On Thu, Apr 8, 2021 at 1:00 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> It is a somewhat awkward way to say "prevent this symbol from
>>> being =y if the dependency is =m".
>>
>> What would be the right thing to do in the case here then to achieve the
>> "if DRMA_ASPEED_GFX is enabled, also enable DMA_CMA id possible"?
>>
>> One approach could be to have for DMA_CMA
>>
>> default y if DRMA_ASPEED_GFX
>>
>> but it feels like the wrong way to tackle this.
> 
> I'm still not sure what you are trying to achieve. Is the idea only to provide
> a useful default for DMA_CMA depending on which drivers are enabled?

"Random drivers should not override a user configuration of core knobs
(e.g., CONFIG_DMA_CMA=n)."

Let's assume I'm a distribution and want to set CONFIG_CMA=n or want to 
set CONFIG_DMA_CMA=n with CONFIG_CMA=y; there is no way to do that with 
e.g., DRMA_ASPEED_GFX=y because it will always override my (user!) 
setting -- even though it doesn't really always need it. Using "select" 
is the problem here.

> 
> This is something you could do using a hidden helper symbol like
> 
> config DRMA_ASPEED_GFX
>         bool "Aspeed display driver"
>         select DRM_WANT_CMA
> 
> config DRM_WANT_CMA
>         bool
>         help
>            Select this from any driver that benefits from CMA being enabled
> 
> config DMA_CMA
>         bool "Use CMA helpers for DRM"
>         default DRM_WANT_CMA
> 
>           Arnd
> 

That's precisely what I had first, with an additional "WANT_CMA" --  but 
looking at the number of such existing options (I was able to spot 1 !) 
I wondered if there is a better approach to achieve the same; "imply" 
sounded like a good candidate.

-- 
Thanks,

David / dhildenb

