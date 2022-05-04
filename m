Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEA8C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 16:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353626AbiEDQtw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353612AbiEDQtq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 12:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E1AC645D
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651682769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t24tg6/LveWdhoRmGGn+/iiJbZYvngbtfY/IYKt0y+w=;
        b=IJR1SYR0t+7Cf2+jfZ9DDCYXvRYcrcp/1ayRk3IAMCmKyEWAKmGbDvc225x7lBtQsIRcjn
        oojSa92pHV7sKQhRluDCJi2C1XrL09/S5Y99JtPMDlpz4r64gIwBvn6CYFxC32QtJt5lPY
        2OltXaygSF7Js4WwxFeHvuQXCz3uBtw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-FCr-dmcSPAyqHZWBUiecVA-1; Wed, 04 May 2022 12:46:01 -0400
X-MC-Unique: FCr-dmcSPAyqHZWBUiecVA-1
Received: by mail-wr1-f71.google.com with SMTP id v16-20020adfd190000000b0020c8fb5106dso57500wrc.19
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 09:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t24tg6/LveWdhoRmGGn+/iiJbZYvngbtfY/IYKt0y+w=;
        b=AVH1xEPeBsVg66I7/CmXipS6d1XeD74/9HxQi/TAl3XwXVG02hqvYY1E0fhM2iN/iE
         myOBvfHUJI/oj0LBoNiYmyEEn/aE0uUIOEzlIR3+IzK1AIj/BToiQrSSKAnSOjsvWmCa
         21zlxqmIGTJ3ORXGbLegGgUt/TZswIduTtnAvI2Jf/jN7LlWnJLoROPuygotzH6sSba0
         5HtweWHKx3mXEVQQDt8XBXW2bE7ffkk/5pGvSFztECu/KR9vJdpuzdolM+X1+KCJxC4Q
         v64FWIhDG19KBp0A1aMqCiw4kblIUS06N0n/8mBYK2NnTh401UYpBUfUmuvrto1RV7+Z
         lpFg==
X-Gm-Message-State: AOAM5329LWZ7d3vCU8Rcz+lAB4tICdgQiWUI7aPqSxzL+KS90lVgptQ/
        IGVzRRRNpwKuZzI6vr1Z8kK4h/fgumcW5bdGTjdCRsdGAZwY2GimVDkOZYY2snOb0td3RfV1+Xa
        oxvQZKPK7skPTE1CZSmJMBlE=
X-Received: by 2002:a5d:5707:0:b0:20a:c768:bc8 with SMTP id a7-20020a5d5707000000b0020ac7680bc8mr17217017wrv.565.1651682759558;
        Wed, 04 May 2022 09:45:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoBEhaKvAsH6E5U+GUSakxLdWaK4c4jZF2naFOjXjnwL8n8hWZp8qeW7Mx6pNpMgWwSO5Z0Q==
X-Received: by 2002:a5d:5707:0:b0:20a:c768:bc8 with SMTP id a7-20020a5d5707000000b0020ac7680bc8mr17217006wrv.565.1651682759336;
        Wed, 04 May 2022 09:45:59 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l1-20020a1ced01000000b003942a244f4fsm4143450wmh.40.2022.05.04.09.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 09:45:59 -0700 (PDT)
Message-ID: <f48a0482-7be9-29d5-b179-e572dfac11fa@redhat.com>
Date:   Wed, 4 May 2022 18:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu: disable runpm if we are the
 primary adapter"
Content-Language: en-US
To:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <20220504134833.1672728-1-alexander.deucher@amd.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220504134833.1672728-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Alex,

On 5/4/22 15:48, Alex Deucher wrote:
> This reverts commit b95dc06af3e683d6b7ddbbae178b2b2a21ee8b2b.
> 
> This workaround is no longer necessary.  We have a better workaround
> in commit f95af4a9236695 ("drm/amdgpu: don't runtime suspend if there are displays attached (v3)").
>

I would write this line instead as:

in commit f95af4a9236695 ("drm/amdgpu: don't runtime suspend if there are
displays attached (v3)").
 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---

The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

