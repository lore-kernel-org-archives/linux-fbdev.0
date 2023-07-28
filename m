Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C4CC04E69
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Jul 2023 10:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjG1KDh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Jul 2023 06:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbjG1KDc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Jul 2023 06:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8263B3C0A
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Jul 2023 03:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690538559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJxfGpxbppzJwgJdPmeEdmGhAfwaruKH//tjBHG7QkQ=;
        b=UcW/bvsfuhZr/nwmvVUjy/TSHGeqUP9SzsPLXJnkWIR0Sbz1CeQ14a7oG5HO2DipEdRmxO
        QaIYvYTxaFWeblsrzNF/Jyg73INo2TW19gtRjXQzIpUR1cLDTLy1BLjeZPcpAYtEiJpJnV
        SFpwbl+ioRsa5jF0xNAnQ9D35AuXYIU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492--GAgf_-lOGmSQzqcgjD3-w-1; Fri, 28 Jul 2023 06:02:38 -0400
X-MC-Unique: -GAgf_-lOGmSQzqcgjD3-w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fa8f8fb7b3so10622625e9.2
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Jul 2023 03:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690538557; x=1691143357;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJxfGpxbppzJwgJdPmeEdmGhAfwaruKH//tjBHG7QkQ=;
        b=JdF8CcG/cIo4Z084ncih5Bq+C4wW4T5nJDfiLWIdDCMIxnJGrh4/tCtK9DDz7E/iUW
         R2Ox4IbX/J8ELhLKFeKlmfwS0JxP3gPIz+NL8pSTFZs6FxxKttLmYC8uqB2S+XRayBIg
         5DqkDrDO6oubFQQBFAfrpTfBbA6g42CHMboVfjq3UQe+xTNNJQ52EJ28tmz2SyjCyxi9
         NdMvIlB6lFMnaDHrrxWCAuRtboIKaTyNZZGOEXQ39WseAj5s3VlMkA+qr+8RvtooQWb6
         54J/Ye45E+fbHbmt2mrlBxpTYhnWAa3o0deY+r+c5NsDCE4xn1agkbhylAzyp3SyXMUT
         blyg==
X-Gm-Message-State: ABy/qLbq8QopolxLEtF1+rL0NBMJLz7ycPtuK1bwVir+q3L+YUiRLM+Y
        1XyxevfRBb+CYb3HZaMGI1UKSUfe0hxVkxbiVj3jbpL18SyK+VEiqYBCUSjHq10Bx2Dd5HOuR9S
        gApkIynFM9U9XbBuXDt/6Y24=
X-Received: by 2002:a05:600c:290b:b0:3fd:1cfa:939e with SMTP id i11-20020a05600c290b00b003fd1cfa939emr1548199wmd.4.1690538557636;
        Fri, 28 Jul 2023 03:02:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGZAUlnXLzjKeLMo1ALDnDndM9wZM0oCDKowY7IKMK5H4noYhpTucg62NPlgPhdJHLTvyOrGA==
X-Received: by 2002:a05:600c:290b:b0:3fd:1cfa:939e with SMTP id i11-20020a05600c290b00b003fd1cfa939emr1548187wmd.4.1690538557338;
        Fri, 28 Jul 2023 03:02:37 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bcb99000000b003fc0505be19sm3716930wmi.37.2023.07.28.03.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 03:02:36 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>
Cc:     Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-fbdev@vger.kernel.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        dri-devel@lists.freedesktop.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] Revert "fbcon: Use kzalloc() in fbcon_prepare_logo()"
In-Reply-To: <bd8b71bb13af21cc48af40349db440f794336d3a.1690535849.git.geert+renesas@glider.be>
References: <bd8b71bb13af21cc48af40349db440f794336d3a.1690535849.git.geert+renesas@glider.be>
Date:   Fri, 28 Jul 2023 12:02:36 +0200
Message-ID: <87wmykxsjn.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

Hello Geert,

> This reverts commit a6a00d7e8ffd78d1cdb7a43f1278f081038c638f.
>
> This commit is redundant, as the root cause that resulted in a false
> positive was fixed by commit 27f644dc5a77f8d9 ("x86: kmsan: use C
> versions of memset16/memset32/memset64").
>
> Closes: https://lore.kernel.org/r/CAMuHMdUH4CU9EfoirSxjivg08FDimtstn7hizemzyQzYeq6b6g@mail.gmail.com/
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

