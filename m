Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD51C0015E
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Jul 2023 08:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjGEIZE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Jul 2023 04:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjGEIZD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Jul 2023 04:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEA41710
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Jul 2023 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688545454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HXRUz+auagzZsOaKQHNMqYO4qOJECVy27UGXYE5lEfo=;
        b=GcCDGJ+dbTk4SpjKEZRn8ZVgDMK4mcVfAPhKkL17le9gVR6GIesH32EdoqOXfRXDDQKuOW
        +W/6o5E1WUgmS2tLQBIwNmJsdgdbZWDR3TBT1wU+2Vc+MMoYoG+5m+34TuGursNZjbnGiR
        qWqzv4UckKeDBxfx2utdVmJZ7vMSMhk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-6pgOuGLsOcezF0hE89J9xw-1; Wed, 05 Jul 2023 04:24:10 -0400
X-MC-Unique: 6pgOuGLsOcezF0hE89J9xw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6c272b0dbso53995001fa.3
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Jul 2023 01:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688545449; x=1691137449;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXRUz+auagzZsOaKQHNMqYO4qOJECVy27UGXYE5lEfo=;
        b=RTzizB5I/W20n14U8ohf30m9ssBoVJKHZmL0piCou80IuIaW8R/jC1TJFanqbOqMSl
         87wn3E1l3jmaHgaB00i5uSuhiPDWZf+6wKqlvb6iyBjH8V/lJib5fja7LTdI7bdWymJS
         HzhNykkBnDGSjOiMFkxV2GUJ9KjopPCteRm40+0yQ2kYXErTUM3QGPTFHiD91DXwviGK
         Rn/SypfN5CT9EDnPMfugtCnVH/N4XCntJqLQ/Gki6iq7gyq6evmqNCqiF9+1U8IIYnC/
         Pqm2tSZO3y2OGK1/CRay8FRxNJsMT2R2rN1qJF6JBH+m9WKYMIiGad5QPlnww0c3feKs
         Mgmg==
X-Gm-Message-State: ABy/qLZOMbaKdhWgREuCvTu74ajCaKfIY2Ds1JG4uzNAOh/ijLQo+K0c
        f6RU9mtNr4U9nn4kplYfgIWhBgzmzc+2Jrby7XxYUwMzbyZHDKSfAicLTF1QuIp4eQZjHKfo9Rg
        mq0sHD+pDcCT4E3FlU3QdoeQ=
X-Received: by 2002:a2e:90c2:0:b0:2b6:ac18:aaae with SMTP id o2-20020a2e90c2000000b002b6ac18aaaemr12062944ljg.11.1688545449237;
        Wed, 05 Jul 2023 01:24:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHoQycU00p6ugiTa1dDXde4hKV6yZxsdqHhYJgQjyIpKck2z33xRFZIUGg8lxMqFb6zKqgffQ==
X-Received: by 2002:a2e:90c2:0:b0:2b6:ac18:aaae with SMTP id o2-20020a2e90c2000000b002b6ac18aaaemr12062929ljg.11.1688545448949;
        Wed, 05 Jul 2023 01:24:08 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c26-20020a7bc01a000000b003f7f475c3bcsm1436708wmb.1.2023.07.05.01.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 01:24:08 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 02/10] drm/fbdev-dma: Use fbdev DMA helpers
In-Reply-To: <20230704160133.20261-3-tzimmermann@suse.de>
References: <20230704160133.20261-1-tzimmermann@suse.de>
 <20230704160133.20261-3-tzimmermann@suse.de>
Date:   Wed, 05 Jul 2023 10:24:07 +0200
Message-ID: <873522sr4o.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use fbdev's DMA helpers for fbdev-dma. They are equivalent to the
> previously used system-memory helpers, so no functional changes here.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

