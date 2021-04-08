Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B5DC433B4
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 09:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2E861157
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 09:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhDHJ5y (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 05:57:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230412AbhDHJ5x (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 8 Apr 2021 05:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617875862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5qRbCj/1Pw0sbqnFA7cAFN0KaHJ1niBYvUatQLNt7yA=;
        b=ALb58AOwBwYK8A7HXNk0ZWUrNaJeeHWvTMAN6gIOEl4lTYeKuY7pp7iLmYkl5oCBAVqeME
        Q9qxFD21gOvcIyZo20Uy0RYHLOna8MsMcj4b6uAjz9RfqpawpqoR8y3OvryR+mu+v8oV3h
        H8OZv7Nl7WUtty44R8z9YGigPjAQibs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-NppAuqKfOUeFeTzIB7gHeQ-1; Thu, 08 Apr 2021 05:57:39 -0400
X-MC-Unique: NppAuqKfOUeFeTzIB7gHeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8F5987A83A;
        Thu,  8 Apr 2021 09:57:36 +0000 (UTC)
Received: from [10.36.114.231] (ovpn-114-231.ams2.redhat.com [10.36.114.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5501E5D9CA;
        Thu,  8 Apr 2021 09:57:32 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Joel Stanley <joel@jms.id.au>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        etnaviv@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20210408092011.52763-1-david@redhat.com>
 <20210408092011.52763-3-david@redhat.com> <YG7TZa8VP458QS5y@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9826d7ef-7f7e-987e-c305-7ae3c533d591@redhat.com>
Date:   Thu, 8 Apr 2021 11:57:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YG7TZa8VP458QS5y@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 08.04.21 11:56, Mike Rapoport wrote:
> On Thu, Apr 08, 2021 at 11:20:11AM +0200, David Hildenbrand wrote:
>> Random drivers should not override a user configuration of core knobs
>> (e.g., CONFIG_DMA_CMA=n). Use "imply" instead, to still respect
>> dependencies and manual overrides.
>>
>> "This is similar to "select" as it enforces a lower limit on another
>>   symbol except that the "implied" symbol's value may still be set to n
>>   from a direct dependency or with a visible prompt."
>>
>> Implying DRM_CMA should be sufficient, as that depends on CMA.
> 
>            ^ DMA_CMA
>>
>> Note: If this is a real dependency, we should use "depends on DMA_CMA"
>> instead -  but I assume the driver can work without CMA just fine --
>> esp. when we wouldn't have HAVE_DMA_CONTIGUOUS right now.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   drivers/gpu/drm/aspeed/Kconfig  | 3 +--
>>   drivers/gpu/drm/etnaviv/Kconfig | 3 +--
>>   2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/aspeed/Kconfig b/drivers/gpu/drm/aspeed/Kconfig
>> index 5e95bcea43e9..a055f763d230 100644
>> --- a/drivers/gpu/drm/aspeed/Kconfig
>> +++ b/drivers/gpu/drm/aspeed/Kconfig
>> @@ -6,9 +6,8 @@ config DRM_ASPEED_GFX
>>   	depends on MMU
>>   	select DRM_KMS_HELPER
>>   	select DRM_KMS_CMA_HELPER
>> -	select DMA_CMA if HAVE_DMA_CONTIGUOUS
>> -	select CMA if HAVE_DMA_CONTIGUOUS
>>   	select MFD_SYSCON
>> +	imply DRM_CMA
> 
> Ditto

Gah, thanks!


-- 
Thanks,

David / dhildenb

