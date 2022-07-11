Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567BAC43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 11 Jul 2022 11:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiGKLml (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiGKLma (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 11 Jul 2022 07:42:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BDF0CDC
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 04:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657539211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C+eRpdrxBgQt0p6K0v1wmxFNTfVvVH/tFOB6mgp15MI=;
        b=eZQFrXb4TBRjn20paMUJ7te8wa9HPV1OznJBzT1tok6RVixm7WZEioH2y0q/0lmSdjU0P6
        kSeLKHQtS/PFyDiFiu0ia/M2dIB1NNgWOfy5YFPntgteBGeT0gzA5s8kdlDczy9iAxxssJ
        fwuixmGRVjPqcp2jxGdyRqZ1clM5+gY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-IFDxCkHCPA2dI3hoQ_Q--Q-1; Mon, 11 Jul 2022 07:33:27 -0400
X-MC-Unique: IFDxCkHCPA2dI3hoQ_Q--Q-1
Received: by mail-wm1-f71.google.com with SMTP id c187-20020a1c35c4000000b003a19b3b9e6cso5092482wma.5
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 04:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C+eRpdrxBgQt0p6K0v1wmxFNTfVvVH/tFOB6mgp15MI=;
        b=m/nlNvSnbtVrKmOaYPJCDzBbaBf6w7F+VUYW8NHRxeGycAUGNC4XO1BDsE1R1ycjoz
         43oegtOvZHJRmHOEU7sPg9M/IzAcir9xGsyNdcl3mSa33j/HJQ9SmJwH4ClBr8I65uFT
         bYva9VlWZJztlp0YtrbZcyzXZVuPDo7bKJ5OTxhCKCVyRyjFX11hzQVt7BDWEkO4hEl1
         RC3b6S3z5wamu2dkAASWHFRPSsYkWPp7NifnuqmIcmC5g3MiBobSPJDC2tW7GlvtQKV8
         G4v5M8Dja5Bh4zmXW0UJLLNP56d8AN8njzc7uf3uFl9tWnJS3qWahl+lj/WMp4h9pkf3
         Dc3A==
X-Gm-Message-State: AJIora/KGY3K11M8N81pxUjqKWUe1MaWsStAY79XV5g4GyCFNfawabCA
        BXWxlhu1g3Jp9+BKJPSDp6d9i/09ArsXAjtpcURrhhD8lK5laLKb8wE59kSblaT/g0W97R+2aca
        +XlgaL1IW6T+rOo+43SRo934=
X-Received: by 2002:a05:6000:1846:b0:21d:90e9:eb38 with SMTP id c6-20020a056000184600b0021d90e9eb38mr15874534wri.264.1657539206839;
        Mon, 11 Jul 2022 04:33:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ukVj1igcMMa9SefXsYyz4JKT4jyMTF7lkAOL7ByBHf0PskNwLBAgeRnDAzuL41/lTsk2X9tQ==
X-Received: by 2002:a05:6000:1846:b0:21d:90e9:eb38 with SMTP id c6-20020a056000184600b0021d90e9eb38mr15874520wri.264.1657539206675;
        Mon, 11 Jul 2022 04:33:26 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q6-20020a1cf306000000b003a033177655sm9811923wmq.29.2022.07.11.04.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:33:26 -0700 (PDT)
Message-ID: <93fd9fd9-eb43-49b2-4322-95952626895b@redhat.com>
Date:   Mon, 11 Jul 2022 13:33:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 11/11] fbdev: Remove conflict-handling code
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-12-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220707153952.32264-12-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/7/22 17:39, Thomas Zimmermann wrote:
> Remove the call to do_remove_conflicting_framebuffers() from the
> framebuffer registration. Aperture helpers take care of removing
> conflicting devices. With all ownership information stored in the
> aperture datastrcutures, remove remove_conflicting_framebuffers()

data structures.

> entirely.
> 
> This change also rectifies DRM generic-framebuffer registration, which
> tried to unregister conflicting framebuffers, even though it's entirely
> build on top of DRM.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Amazing patch! The whole series really. Thanks a lot for working on this.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

