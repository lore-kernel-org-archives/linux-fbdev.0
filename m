Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F1AC4332F
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 16:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353864AbiEDQwh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 12:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353766AbiEDQwT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 12:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1673147394
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651682914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C80PpJdtHsQYh9YgWUU5AwvnusQPkG7yGp50RdkZ4AQ=;
        b=QrjpOCjn3qeEBvxQ0thItK9MBahgDD6bMrdTZM1lDi5MsRp7WlUR47IPhmtIr119BGp9vL
        aoyTx/sK5JvpeRsHzbJjippFxH3pNKb3yQPNTW8Luqgu30JMHa9QlBuZmri6jOXfheiCa0
        N2BaLjjhsB7QAavrwgpW01UE8jeeoKQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-X4sN3_IzOUmjcaQsgfNjRw-1; Wed, 04 May 2022 12:48:33 -0400
X-MC-Unique: X4sN3_IzOUmjcaQsgfNjRw-1
Received: by mail-wr1-f69.google.com with SMTP id o11-20020adfca0b000000b0020adc114131so565227wrh.8
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 09:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C80PpJdtHsQYh9YgWUU5AwvnusQPkG7yGp50RdkZ4AQ=;
        b=xeYUnPN1l3rX8oyfu4shPYjdATZTgxk53FmKPvKGi9zpfJ2UQFXgUvt6RM/kiQ2LE8
         MmY2WrtwIR39r3DPHeH1CiVzv0J9KdB7JVPzG6bovgJGgT+aEjKWkbdVTDsdd6HpJ8Vl
         2uZ0wFGaWYMyxJbIhlLflxOEzj9XaXyIiN+Bjf5v9WEgyn6HY/oevDvCl+akg/o78MRh
         Y4J/B83Lp5PHBhM6h5baVCNfdWxNM/pWczGxJ47GDYuK+GdIZzzLooMRyhe629FPz7C+
         ap0/4xgTETRBEcvpigWijMbwkHiEnrFilfnTdt/a15RIzzRaDta+rAygrkfpnjF2u2eK
         H3NA==
X-Gm-Message-State: AOAM533qdkL5LYIZt9maV9LMoZheIRU6mkIU5T7K/oBZ4utKVLjeWVUg
        ceYo//FUFIKV1vsZfwWyFZDUJpGOlNU2ZaoQdDBAIoGBiepB0zRoV+7+EUZcSXy2pWBgLNxVvEj
        s4F9NenPobhu0w3/s2jCD1zs=
X-Received: by 2002:a05:600c:2315:b0:394:1f6:f663 with SMTP id 21-20020a05600c231500b0039401f6f663mr246776wmo.115.1651682912621;
        Wed, 04 May 2022 09:48:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZK5Pq2mU8Y6HYAf07iPFmDU9QsrrAa709Zmpug1Tah5gE9QRBp5SnHlIO72P1fOlS/u8xMw==
X-Received: by 2002:a05:600c:2315:b0:394:1f6:f663 with SMTP id 21-20020a05600c231500b0039401f6f663mr246763wmo.115.1651682912419;
        Wed, 04 May 2022 09:48:32 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n124-20020a1c2782000000b0039447beb28asm293220wmn.23.2022.05.04.09.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 09:48:32 -0700 (PDT)
Message-ID: <6bf00fca-20c6-b682-1806-e7ff49568532@redhat.com>
Date:   Wed, 4 May 2022 18:48:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] Revert "fbdev: fbmem: add a helper to determine if an
 aperture is used by a fw fb"
Content-Language: en-US
To:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <20220504134833.1672728-1-alexander.deucher@amd.com>
 <20220504134833.1672728-2-alexander.deucher@amd.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220504134833.1672728-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 5/4/22 15:48, Alex Deucher wrote:
> This reverts commit 9a45ac2320d0a6ae01880a30d4b86025fce4061b.
> 
> This was added a helper for amdgpu to workaround a runtime pm regression
> caused by a runtime pm fix in efifb.  We now have a better workarouund

s/workarouund/workaround

> in amdgpu in
> commit f95af4a9236695 ("drm/amdgpu: don't runtime suspend if there are displays attached (v3)")

Again I would write it as:

commit f95af4a9236695 ("drm/amdgpu: don't runtime suspend if there are
displays attached (v3)")

> so this workaround is no longer necessary.  Since amdgpu was the only
> user of this interface, we can remove it.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

