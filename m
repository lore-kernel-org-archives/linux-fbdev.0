Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB3FC3DA79
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiLTJX2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiLTJXL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:23:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B761834E
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671528148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kA4MxY/xt1b965fBBWiuXbuP8HCDa5veURhTEDS4ghc=;
        b=hPIZVqeLo4DPsvJ+/uFFfGNPiwq2+cMYaTNhORZzyBMRkzGLuwXavwTEhTlBGbL2IreWj4
        xnYaex/8/hkMZ4cUK0O9eCxjMlQcs4p3HnHzV5SVIPRIw30eK+HhOJUIPinNs4ljXH5UEU
        LAwRKuXSocEu7HcPDW6AxGFDvkOqzv4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-EVoaWtqFNySXDN10sWtJ9A-1; Tue, 20 Dec 2022 04:22:26 -0500
X-MC-Unique: EVoaWtqFNySXDN10sWtJ9A-1
Received: by mail-wm1-f69.google.com with SMTP id c1-20020a7bc001000000b003cfe40fca79so2388833wmb.6
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kA4MxY/xt1b965fBBWiuXbuP8HCDa5veURhTEDS4ghc=;
        b=o9bgCWydbboNOZwMnFid8MH1HZEuKalQcLciq4HkNAOrCxGeArQQOjeQNCMxE1RIpo
         AJmDW+HrPRWDNqGHGanCmBdAXl+9UaKWCPWbbDh+lopLAuDaoBRrxx8q7LZIpy83V3Ie
         oej06qM3TuzaAoEfKl8kP8K46nVOrEYZ7H5LcpkLpn9T5rvoaOCfYlgxKUYPYDNudzeB
         2QV5juYBgkFYVm9myFvXJtftZf4jclAxGf62RdSoIr4DxwM0Av/imZEvGhNJQfMqbT7T
         TtHVnt3+j/NNpP14PdkwAQt0Llibcgm9W6/Kp4Uz7/iiiGqsUDB/SMcuA7bSm+I9LIGO
         dbRw==
X-Gm-Message-State: ANoB5pkMg+ifeSNADyfM1vKyfw0QiiX0z5LPmsMoVoR0JPrWTa7pKFJH
        mpPk2lwsJKzDKj/8EcVzUoPRcrJTmHcaRAYutS6OgprzSRiJc5Ga9YXam7HInyoRPtoMrbtEIUi
        hDQeDsDGwpW8YzE/WtYTc2No=
X-Received: by 2002:a05:600c:4e14:b0:3d2:4234:e8fe with SMTP id b20-20020a05600c4e1400b003d24234e8femr16310093wmq.19.1671528145671;
        Tue, 20 Dec 2022 01:22:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7D1EDbJcc4QdZIvJK/Fm89Zwd1JGt/mFkIkcyx0LysVtTks8a6AInaJGEHTgImFr5Ff5SiAA==
X-Received: by 2002:a05:600c:4e14:b0:3d2:4234:e8fe with SMTP id b20-20020a05600c4e1400b003d24234e8femr16310078wmq.19.1671528145416;
        Tue, 20 Dec 2022 01:22:25 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m1-20020a1c2601000000b003d1d5a83b2esm22817348wmm.35.2022.12.20.01.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:22:25 -0800 (PST)
Message-ID: <d3370b05-cf1f-c3b2-678b-30708c549acb@redhat.com>
Date:   Tue, 20 Dec 2022 10:22:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 06/18] drm/fb-helper: Do not allocate unused apertures
 structure
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-7-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> The apertures field in struct fb_info is not used by DRM drivers. Do
> not allocate it.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

