Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77334C83F3F
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Sep 2023 13:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbjIDN3r (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 4 Sep 2023 09:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbjIDN3r (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 4 Sep 2023 09:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9322BCDB
        for <linux-fbdev@vger.kernel.org>; Mon,  4 Sep 2023 06:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693834136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ogc35j5wnFZjYknca/Dmxrctu7aJYOr7uX6tINC9GWs=;
        b=MT9rONXWmKqayuinndSRntId4rEkoxltvjHGZXZbHstvHH9dU8T3N5/NPkj3TvUTdeoVeA
        6JQn9J2QTGT8i4e+l+1g0hxMXj57MjylYSmxx7FE+oAxn9Y344kweJ2GshmN0yCJlytZ/m
        Y2cn/viTK2Cot/qw8XfO00pOEHwOnME=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-3W9PlKJ4N-KbqqeNs1Om4Q-1; Mon, 04 Sep 2023 09:28:55 -0400
X-MC-Unique: 3W9PlKJ4N-KbqqeNs1Om4Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3feeb420c8aso8821735e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Sep 2023 06:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693834134; x=1694438934;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ogc35j5wnFZjYknca/Dmxrctu7aJYOr7uX6tINC9GWs=;
        b=HbIZy1zoXVa0VGn3dJq6dPd1mtDGJlUlQ1AY1G++a+ppOHewvbzF1zKk+m2wKou1DP
         /2L1vZbykZK++XWUf7GPxWJv8f4y5lr6s14fwFYG1wVo8267iqWYOrhTuswX1GqW9r9F
         YLr1i43Yq+CFLSnCBBemf8KlV6b/sWDAlNUvsLS9QEZtimL4sL63XGg/sqhOuiHAG83+
         /n7hiSrCr7AYGrjgKcbwr4vWW5TU4uo8UvjgFh9qHCuMPOIO350mJ5YMv/COs7CXGjq8
         SbrN7YGuUtRYqf95FfQDav5cEZDI12iomF8ILEmD0hcVNB8TXf0jtc1EML/wVbiQ1Jjm
         drPQ==
X-Gm-Message-State: AOJu0YzLH571HfZwqgP//DkanWFu1m0p56pGciDQf05C7147vCYVW04E
        TfjiHTDdztefth1zrA0x4LQ0ADCpZheoEO7gNqpOReK1J718eRXdwnhi93gsgUUaScQFAVMuNHZ
        GkpmBnfxlcpALmnkeCxKf8bo=
X-Received: by 2002:a5d:43c3:0:b0:317:3d36:b2cd with SMTP id v3-20020a5d43c3000000b003173d36b2cdmr6107645wrr.71.1693834134388;
        Mon, 04 Sep 2023 06:28:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3pL/7M37MZ8DDYOtxB0J933cOF0hsfKFCSqFaXm8ULHyrObL/1Lf5LyHUOXJD35lTdHtBaw==
X-Received: by 2002:a5d:43c3:0:b0:317:3d36:b2cd with SMTP id v3-20020a5d43c3000000b003173d36b2cdmr6107629wrr.71.1693834134083;
        Mon, 04 Sep 2023 06:28:54 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c1d8300b00401e32b25adsm14407260wms.4.2023.09.04.06.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:28:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 8/8] staging/fbtft: Use fb_ops helpers for deferred I/O
In-Reply-To: <20230828132131.29295-9-tzimmermann@suse.de>
References: <20230828132131.29295-1-tzimmermann@suse.de>
 <20230828132131.29295-9-tzimmermann@suse.de>
Date:   Mon, 04 Sep 2023 15:28:53 +0200
Message-ID: <874jkacbje.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Generate callback functions for struct fb_ops with the fbdev macro
> FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS(). Initialize struct fb_ops to
> the generated functions with an fbdev initializer macro.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

