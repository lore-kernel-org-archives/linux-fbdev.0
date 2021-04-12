Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2D2C433ED
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Apr 2021 13:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 372686128C
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Apr 2021 13:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbhDLNTY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238431AbhDLNTX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 12 Apr 2021 09:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618233545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ZXD0Vjr7M6pXQoqoYaNJ9fIJMRtCGqZKUK6a7IbIAM=;
        b=IfujdcitXd9kYzsj+8DDlnMxAEjGbadVBza3cHUTz9FUaG8Yd9XzCtltvTBh5btJ4Md062
        e0XtzAvn94j3qcrWUUs9/h5aYJj1WyfjDRc2XzXDp1kM6+av/4bR/79iKg9neQZiE19BVq
        x94D0YPCfff5/1n++f+Di2qy3WWhCgE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-dz2dxHC7P9aMDBHjdAv2lg-1; Mon, 12 Apr 2021 09:19:04 -0400
X-MC-Unique: dz2dxHC7P9aMDBHjdAv2lg-1
Received: by mail-wm1-f69.google.com with SMTP id j187-20020a1c23c40000b0290127873d3384so1654663wmj.6
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Apr 2021 06:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7ZXD0Vjr7M6pXQoqoYaNJ9fIJMRtCGqZKUK6a7IbIAM=;
        b=pUQ/4KCzL46ZgmeCHvojLxeNqmVMvjeMJUqkP6Hnb+QwYBaD5Y0cKcIEyM/UPgINj+
         dsx3Br1cx79ymYLEZj7LZt+rwNSRNYhZI1EXd8M3FFBkcppFYlh0Nay50Ue5xr3OnY0p
         pR8wV2ec0URixGawBGeVNk7FCFEmErw4Iwf0doVIH/eteY+RxhFGp+YHuN5fCMsX5oIA
         TOmkcGhet/PIgXixCNTYWf1SUs5mQ6OWS+GBnZSFKmd0uZ2UeCwquw5f/vcVzKH/wkFq
         rGRbIX0IBmK/VfZBfrtRC818uFxFlfJFQMYswQwc+MaZGRI56SSZH7Il4aGdA8tgL26I
         5nZA==
X-Gm-Message-State: AOAM532R4+8COYUbB8VFa3vUfSXyzoJ9ZEGcvoBwn3odL3ufkP7FmzQk
        BMeB/TP0fljvaY7pEL/QS4jSST8QsA45944maNj0p0f28Yb4My/TEHqxZYwLjjAP8jO1o+aP1jK
        nTAvAYQbVNowLXIVXp8/mLzc=
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr14516018wrq.33.1618233542685;
        Mon, 12 Apr 2021 06:19:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7xYSMl1mhv7IAg348AjhAJnlfD0ElxtQIBjiZbX8gXBrQUGHbbh/j9IzPlcTzIMjQzJv+hg==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr14515964wrq.33.1618233542418;
        Mon, 12 Apr 2021 06:19:02 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c66cb.dip0.t-ipconnect.de. [91.12.102.203])
        by smtp.gmail.com with ESMTPSA id c8sm14836856wmb.34.2021.04.12.06.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 06:19:02 -0700 (PDT)
Subject: Re: [PATCH v3] drivers: introduce and use WANT_DMA_CMA for soft
 dependencies on DMA_CMA
To:     Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Eric Anholt <eric@anholt.net>, Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joel Stanley <joel@jms.id.au>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Maxime Ripard <mripard@kernel.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Linux-MM <linux-mm@kvack.org>, Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
References: <20210409112035.27221-1-david@redhat.com>
 <CAK8P3a31uKNcim0n99=yt3zjZ+LQSw4V4+8PS8daLsBdS0iSYg@mail.gmail.com>
 <53ec94ac-ffe3-d0bc-d081-3489fa03daa1@redhat.com>
 <34350446-0e0e-6947-40bd-fabdccdc835f@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e996ca72-7857-ba50-0e7e-f0c3dab3a931@redhat.com>
Date:   Mon, 12 Apr 2021 15:19:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <34350446-0e0e-6947-40bd-fabdccdc835f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12.04.21 15:12, Robin Murphy wrote:
> On 2021-04-09 14:39, David Hildenbrand wrote:
>> On 09.04.21 15:35, Arnd Bergmann wrote:
>>> On Fri, Apr 9, 2021 at 1:21 PM David Hildenbrand <david@redhat.com>
>>> wrote:
>>>>
>>>> Random drivers should not override a user configuration of core knobs
>>>> (e.g., CONFIG_DMA_CMA=n). Applicable drivers would like to use DMA_CMA,
>>>> which depends on CMA, if possible; however, these drivers also have to
>>>> tolerate if DMA_CMA is not available/functioning, for example, if no CMA
>>>> area for DMA_CMA use has been setup via "cma=X". In the worst case, the
>>>> driver cannot do it's job properly in some configurations.
>>>>
>>>> For example, commit 63f5677544b3 ("drm/etnaviv: select CMA and
>>>> DMA_CMA if
>>>> available") documents
>>>>           While this is no build dependency, etnaviv will only work
>>>> correctly
>>>>           on most systems if CMA and DMA_CMA are enabled. Select both
>>>> options
>>>>           if available to avoid users ending up with a non-working GPU
>>>> due to
>>>>           a lacking kernel config.
>>>> So etnaviv really wants to have DMA_CMA, however, can deal with some
>>>> cases
>>>> where it is not available.
>>>>
>>>> Let's introduce WANT_DMA_CMA and use it in most cases where drivers
>>>> select CMA/DMA_CMA, or depend on DMA_CMA (in a wrong way via CMA because
>>>> of recursive dependency issues).
>>>>
>>>> We'll assume that any driver that selects DRM_GEM_CMA_HELPER or
>>>> DRM_KMS_CMA_HELPER would like to use DMA_CMA if possible.
>>>>
>>>> With this change, distributions can disable CONFIG_CMA or
>>>> CONFIG_DMA_CMA, without it silently getting enabled again by random
>>>> drivers. Also, we'll now automatically try to enabled both, CONFIG_CMA
>>>> and CONFIG_DMA_CMA if they are unspecified and any driver is around that
>>>> selects WANT_DMA_CMA -- also implicitly via DRM_GEM_CMA_HELPER or
>>>> DRM_KMS_CMA_HELPER.
>>>>
>>>> For example, if any driver selects WANT_DMA_CMA and we do a
>>>> "make olddefconfig":
>>>>
>>>> 1. With "# CONFIG_CMA is not set" and no specification of
>>>>      "CONFIG_DMA_CMA"
>>>>
>>>> -> CONFIG_DMA_CMA won't be part of .config
>>>>
>>>> 2. With no specification of CONFIG_CMA or CONFIG_DMA_CMA
>>>>
>>>> Contiguous Memory Allocator (CMA) [Y/n/?] (NEW)
>>>> DMA Contiguous Memory Allocator (DMA_CMA) [Y/n/?] (NEW)
>>>>
>>>> 3. With "# CONFIG_CMA is not set" and "# CONFIG_DMA_CMA is not set"
>>>>
>>>> -> CONFIG_DMA_CMA will be removed from .config
>>>>
>>>> Note: drivers/remoteproc seems to be special; commit c51e882cd711
>>>> ("remoteproc/davinci: Update Kconfig to depend on DMA_CMA") explains
>>>> that
>>>> there is a real dependency to DMA_CMA for it to work; leave that
>>>> dependency
>>>> in place and don't convert it to a soft dependency.
>>>
>>> I don't think this dependency is fundamentally different from the others,
>>> though davinci machines tend to have less memory than a lot of the
>>> other machines, so it's more likely to fail without CMA.
>>>
>>
>> I was also unsure - and Lucas had similar thoughts. If you want, I can
>> send a v4 also taking care of this.
> 
> TBH I think it should all just be removed. DMA_CMA is effectively an
> internal feature of the DMA API, and drivers which simply use the DMA
> API shouldn't really be trying to assume *how* things might be allocated
> at runtime - CMA is hardly the only way. Platform-level assumptions
> about the presence or not of IOMMUs, memory carveouts, etc., and whether
> it even matters - e.g. a device with a tiny LCD may only need display
> buffers which still fit in a regular MAX_ORDER allocation - could go in
> platform-specific configs, but I really don't think they belong at the
> generic subsystem level.
> 
> We already have various examples like I2S drivers that won't even probe
> without a dmaengine provider being present, or host controller drivers
> which are useless without their corresponding phy driver (and I'm
> guessing you can probably also do higher-level things like include the
> block layer but omit all filesystem drivers). I don't believe it's
> Kconfig's job to try to guess whether a given configuration is *useful*,
> only to enforce that's it's valid to build.

That would mean: if it's not a built-time dependency, don't mention it 
in Kconfig.

If that were true, why do we have have defaults modeled in Kconfig then?

IMHO, some part of Kconfig is to give you sane defaults.

-- 
Thanks,

David / dhildenb

