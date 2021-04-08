Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F57C433B4
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 10:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DCA361055
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 10:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhDHKh7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 06:37:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231213AbhDHKhV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 8 Apr 2021 06:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617878230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLjjLoz+QeRsQ1MOoIX2RgV24dAqIxs+wPP9bncu07U=;
        b=i+C7ge30tw5xFMKA1wVe6fbbB6suJdNSLDmzeJunsfLUfODVl93biI943xsgCXYMEvXlBv
        nPcpWzaU8lkys/p/fUy1DkYm73roDvcjWCzsC51NcSroZTcG/02Vf2sicXifTvZMYpV3zH
        A0TfL7JLFPPEtjaBVKN+5+eQPOBa9oM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-2LSDVNSAMvy_w6wcmDZmyA-1; Thu, 08 Apr 2021 06:37:08 -0400
X-MC-Unique: 2LSDVNSAMvy_w6wcmDZmyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 761D4CC622;
        Thu,  8 Apr 2021 10:37:05 +0000 (UTC)
Received: from [10.36.114.231] (ovpn-114-231.ams2.redhat.com [10.36.114.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A5151001B2C;
        Thu,  8 Apr 2021 10:37:00 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
From:   David Hildenbrand <david@redhat.com>
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
Organization: Red Hat GmbH
Message-ID: <0b1928a8-99c3-f1f1-ad66-40145199d9bc@redhat.com>
Date:   Thu, 8 Apr 2021 12:36:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 08.04.21 12:27, David Hildenbrand wrote:
> On 08.04.21 12:20, Arnd Bergmann wrote:
>> On Thu, Apr 8, 2021 at 11:22 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> Random drivers should not override a user configuration of core knobs
>>> (e.g., CONFIG_DMA_CMA=n). Use "imply" instead, to still respect
>>> dependencies and manual overrides.
>>>
>>> "This is similar to "select" as it enforces a lower limit on another
>>>    symbol except that the "implied" symbol's value may still be set to n
>>>    from a direct dependency or with a visible prompt."
>>>
>>> Implying DRM_CMA should be sufficient, as that depends on CMA.
>>>
>>> Note: If this is a real dependency, we should use "depends on DMA_CMA"
>>> instead -  but I assume the driver can work without CMA just fine --
>>> esp. when we wouldn't have HAVE_DMA_CONTIGUOUS right now.
>>
>> 'imply' is almost never the right solution, and it tends to cause more
>> problems than it solves.
> 
> I thought that was the case with "select" :)
> 
>>
>> In particular, it does not prevent a configuration with 'DRM_CMA=m'
> 
> I assume you meant "DRM_CMA=n" ? DRM_CMA cannot be built as a module.
> 
>> and 'DRMA_ASPEED_GFX=y', or any build failures from such
>> a configuration.
> 
> I don't follow. "DRM_CMA=n" and 'DRMA_ASPEED_GFX=y' is supposed to work
> just fine (e.g., without HAVE_DMA_CONTIGUOUS) or what am I missing?
> 
>>
>> If you want this kind of soft dependency, you need
>> 'depends on DRM_CMA || !DRM_CMA'.
> 
> Seriously? I think the point of imply is "please enable if possible and
> not prevented by someone else". Your example looks more like a NOP - no?
> Or will it have the same effect?

I just tried (remove CONFIG_DMA_CMA from .config followed by make) and 
the default will be set to "N" (when querying the user). So it indeed 
looks like a NOP - unless I am missing something.

-- 
Thanks,

David / dhildenb

