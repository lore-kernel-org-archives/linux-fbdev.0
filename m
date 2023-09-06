Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1849CEB8FA5
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Sep 2023 10:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjIFKC0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 6 Sep 2023 06:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjIFKC0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 6 Sep 2023 06:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FB41723
        for <linux-fbdev@vger.kernel.org>; Wed,  6 Sep 2023 03:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693994381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NmAkZbkLbqrhYKWGilvLnXtd6fKYLLSrfrWjxYIXvzE=;
        b=Jeplj1jpPPt9k4xQ7kAwPUWW+TjVvZqHOtc1KHTbmUNyDLn6cWZHB+8Qga1aT+NOPy320S
        6+oF9ONUFEb6VzfKm/Y6ywwE81tO+VQyhosnjmCadB31WEM/k94QzLZaLieftdofzt3fBo
        65R1jWIdZ3qTITrHGz4kc9yRfk3+QCY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-GIiO6lUwNFmAbPK3zFRcbQ-1; Wed, 06 Sep 2023 05:59:40 -0400
X-MC-Unique: GIiO6lUwNFmAbPK3zFRcbQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-401be705672so22357785e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 06 Sep 2023 02:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693994379; x=1694599179;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmAkZbkLbqrhYKWGilvLnXtd6fKYLLSrfrWjxYIXvzE=;
        b=Al23tGizlGP8Rnl8W0Vfxk9SWU20M8BdJ54utpm4Yw41jZnPmuQyGRUOqmRwAUCA0j
         iwys8yeDXndts6EHr/FNU8AQrePOwLEScAQKxtNtnA9N940M4WYDyeO3q7M6/X8auLZE
         Vbpm4UrwHZTxBJQwqD3SIgeJ57s2tOv7e0ZqOx2cYxQ0psUE1RSfddey8+4Lob+i63av
         HJjr29SrV8KptVJowl1m8gpPukSaJzW/yTyoZemCAFdyDKr+ByXvdjvoC677ecSgfqwK
         JsUKtK7oOFA+u0WYV33CAA7Nsy7ouiZdhnR/am5IL4X3yorvG5q0PDzjnr6r/3Y2ut7T
         Tbmw==
X-Gm-Message-State: AOJu0YyF3RPvxhVDqwxAhJdfJZFl0hPKZAV8JkV83+LV3qowDnuvt/TW
        YHLU0f2+MGZnxm62wJVqO4MDzqDsEwFdLnpNbTNIYkwHQxz8XHt8U/beIkRM2sc3/yn7ha4MSAD
        2udBdhR493fTAoflIyybAasE=
X-Received: by 2002:a05:600c:128f:b0:3fe:25b3:951d with SMTP id t15-20020a05600c128f00b003fe25b3951dmr1928469wmd.5.1693994378902;
        Wed, 06 Sep 2023 02:59:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5+OhfOUQuGHMsv/QI74pAE53OdzJ3LqKgxFhHFhepwapLYpSxbrf63ipC3UeI9PeqR2f8jA==
X-Received: by 2002:a05:600c:128f:b0:3fe:25b3:951d with SMTP id t15-20020a05600c128f00b003fe25b3951dmr1928450wmd.5.1693994378520;
        Wed, 06 Sep 2023 02:59:38 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c22cf00b003fe2de3f94fsm19249458wmg.12.2023.09.06.02.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:59:38 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 3/7] fbdev/core: Fix style of code for boot-up logo
In-Reply-To: <20230829142109.4521-4-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-4-tzimmermann@suse.de>
Date:   Wed, 06 Sep 2023 11:59:37 +0200
Message-ID: <87il8n4o6u.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix a number of warnings from checkpatch.pl in this code before
> moving it into a separate file. This includes
>
>  * Prefer 'unsigned int' to bare use of 'unsigned'
>  * space required after that ',' (ctx:VxV)
>  * space prohibited after that open parenthesis '('
>  * suspect code indent for conditional statements (16, 32)
>  * braces {} are not necessary for single statement blocks
>
> No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[...]

> -	static const unsigned char mask[] = { 0,0x80,0xc0,0xe0,0xf0,0xf8,0xfc,0xfe,0xff };
> +	static const unsigned char mask[] = {
> +		0, 0x80, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc, 0xfe, 0xff
> +	};

I didn't know that checkpatch.pl complained about this.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

