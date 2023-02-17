Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C22FC636D4
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Feb 2023 09:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBQJEZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Feb 2023 04:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQJEY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Feb 2023 04:04:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5299C5FBFE
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 01:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676624615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BhPN5mXNi0FwgA6Dw1wLPbnc9UnJcdK55RqJoCtSbCM=;
        b=KzdQ1giy8S9nwHE5Csndl5Z1HY2OmJUtEbmK9ZR2FAevwkVGdQOlhdnYoCquXwzujELigL
        klfBrmqpWGJ7Og2XVN/+W6UbtjdMHJbM+cpUJP1TigAX9MCP+Da/JXnMq55daoFv+WqXYs
        ZcqbCa7AFwCa7qecPp+viw5isQzcMMQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-125-GUX4rG3lNGaevq8qrfhuug-1; Fri, 17 Feb 2023 04:03:34 -0500
X-MC-Unique: GUX4rG3lNGaevq8qrfhuug-1
Received: by mail-wm1-f72.google.com with SMTP id s10-20020a7bc38a000000b003dfecb98d38so272118wmj.0
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 01:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhPN5mXNi0FwgA6Dw1wLPbnc9UnJcdK55RqJoCtSbCM=;
        b=B9sjtDxNdcWdwYg2jreWz4TZ5xbVicSynCh8+MFMgNtNj1blmQOvLGmDeJ3cU6aWAU
         s0zhL0Fw9wUVhaPWt8xPsa4wc+EgNEclAVyCWldliC2HuOYbLmrQOmMbNvcLTpNWbivr
         y94H/DWGt4IB+D9wn0s595iRjPUELW1hMf/adn0vg0SkBvv2lSE3rtZBNaBJh1tiKzPM
         ekkApXpABgBqaMbFvfGtDJ8x6Fc5TPjLSnArNT7i6bWd+cCVvLI5RpMcNyKjkjy33s8M
         FjpGz5yRUXKsqRVGctPM0tcfxBETnGW+1E6u10YJwL0ADvYWY+vcJtlp2cR35WRP+89d
         1rVA==
X-Gm-Message-State: AO0yUKVXRxvNA7UpzPCpr3efIcfsT2tCwzFE/4u+LeKOiIGxZY18Mot4
        tNZlCBmvGtba7nxHxCTWdp9dy3VT5Pgj4OBJTrH3xVA/BKwHFIL7xdSZ6J3V6fTwFD/Pqzvg5GJ
        cxfk/tB7cGySRySaNQgUEGVQ=
X-Received: by 2002:a05:600c:43d5:b0:3e2:1d1e:78d0 with SMTP id f21-20020a05600c43d500b003e21d1e78d0mr2417369wmn.22.1676624612972;
        Fri, 17 Feb 2023 01:03:32 -0800 (PST)
X-Google-Smtp-Source: AK7set9DaCWKnN1w1UtSO4QwVrREcTxPmS1GlzqesHtTH8itx7pHTxCmH391IDvaQDCHi/hMWPC/XA==
X-Received: by 2002:a05:600c:43d5:b0:3e2:1d1e:78d0 with SMTP id f21-20020a05600c43d500b003e21d1e78d0mr2417345wmn.22.1676624612696;
        Fri, 17 Feb 2023 01:03:32 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bi23-20020a05600c3d9700b003e200d3b2d1sm4400599wmb.38.2023.02.17.01.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 01:03:32 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        geoff@infradead.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 10/11] drm: Include <video/cmdline.h> for mode parsing
In-Reply-To: <20230209135509.7786-11-tzimmermann@suse.de>
References: <20230209135509.7786-1-tzimmermann@suse.de>
 <20230209135509.7786-11-tzimmermann@suse.de>
Date:   Fri, 17 Feb 2023 10:03:31 +0100
Message-ID: <87k00gwtng.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Include <video/cmdline.h> in drm_connector.c to get video_get_options()
> and avoid the dependency on <linux/fb.h>. The replaced function
> fb_get_options() is just a tiny wrapper around video_get_opions(). No
> functional changes.
>
> Include <linux/property.h> to get fwnode_handle_put(), which had been
> provided via <linux/fb.h>.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier

