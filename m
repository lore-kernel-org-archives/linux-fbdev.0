Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D30C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Jan 2022 14:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbiAXOAb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Jan 2022 09:00:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237965AbiAXOAY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Jan 2022 09:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643032823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rktM0S0usSPLY5LvkfsWofVmD3HAzupt/hqZRguzdL4=;
        b=Wo6Wb5wQfh0zwtlwLdUnY5CDQ+uW01XgiMulT4lQECk9cblFRonlt+7BHuGK4RT2M/tZmp
        V3Db+fY4R6QWshssSUliR6yiNxMOCKYa6PBikZlQHMUnG8FKF6U0j869qLGc7bpkPsNuxg
        411PidehjAwFtP8uvf5ANZI1sRkUDpc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-R8eRxS5WO4OBn3H1NOhHaw-1; Mon, 24 Jan 2022 09:00:22 -0500
X-MC-Unique: R8eRxS5WO4OBn3H1NOhHaw-1
Received: by mail-wm1-f70.google.com with SMTP id c16-20020a1c9a10000000b0034dd409329eso9650075wme.3
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Jan 2022 06:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rktM0S0usSPLY5LvkfsWofVmD3HAzupt/hqZRguzdL4=;
        b=51o7HNnVV6JrjPch+2Yp4GHlh4V/bC9MEmZSKfg0d6UVdmK+VysBt4Lbfsua351X7r
         DsLKDDRjrJCBiE5Ax3VoesXxYsW1Ce/Q2dHUdj8G4wT6KNXB5BD30U0jSxm1ltM+w1Nq
         0Fj6pc+OF23Jqp2D+4ar3QMPoGyIaaNGKaYGDl0hZqMsO9NXyMpI3BbQiIkvcrX6FbQd
         OJixQSR+JNdcdlzgZvewCzMp/3WztfRQAgVcPSJ+pFxDKWNSq5LblHfp5YPHEWP3r1Ct
         BCsRwSXsE4NWruMc8eyYctV3qgc5kJbNaQR2OyzL4hpDGAQb4b+SFr+kHyA1OyjAPKT7
         gpkA==
X-Gm-Message-State: AOAM5317STbiIsuL4+Mk3jEb9G+FGtcCFPTRoKOMMt5lVqYgkXoLm7fk
        vvqHEFZccrGFoOLHkLw/xZ93EJWv1wnynoDzQw9xbgtzmdIaMfSPpLAh/aOjt9D2r/ak4HdIwnZ
        JrJTK6Jm9+EtTz0JV3S4qsAo=
X-Received: by 2002:a5d:457b:: with SMTP id a27mr9200347wrc.86.1643032820867;
        Mon, 24 Jan 2022 06:00:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytZhOKI7fYVQiuKsKaaK1W6CiHUlA4X/OwcDEUpQv/bAfKFUv01YVhuawIMIM4PyYrfjRyjg==
X-Received: by 2002:a5d:457b:: with SMTP id a27mr9200329wrc.86.1643032820652;
        Mon, 24 Jan 2022 06:00:20 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p26sm5181839wms.2.2022.01.24.06.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 06:00:20 -0800 (PST)
Message-ID: <91872b43-042e-3b8a-0dbb-f9ddebfadea0@redhat.com>
Date:   Mon, 24 Jan 2022 15:00:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/5] drm/simpledrm: Request memory region in driver
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, zackr@vmware.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, deller@gmx.de,
        hdegoede@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220124123659.4692-1-tzimmermann@suse.de>
 <20220124123659.4692-4-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220124123659.4692-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/24/22 13:36, Thomas Zimmermann wrote:
> Requesting the framebuffer memory in simpledrm marks the memory
> range as busy. This used to be done by the firmware sysfb code,
> but the driver is the correct place.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

