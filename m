Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84739C83F33
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Sep 2023 13:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353007AbjIDNTB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 4 Sep 2023 09:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352994AbjIDNTA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 4 Sep 2023 09:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98376C1
        for <linux-fbdev@vger.kernel.org>; Mon,  4 Sep 2023 06:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693833490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBLzSQTLv+8pipDzuuK9IQr80p06o9JPiTCzfewmJxw=;
        b=JSaCtwUapIaYsR7l6FcK6XEyuFHlAlzDnqiO4Eek9d4+nHsEvbWuDhAWkA/iuV3ED49Zpv
        +4Zyi1mp9cFMyBoDFHPfGUByd0ZA9lNlRafBtPhCgxUYviZv5A/7FXQyKJh/DmbXX1uOim
        ecO3+3TaxDJiwLl+2kpBg0nQbbzMgT4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-U6wKmgRYM2GPChD_iqvfdQ-1; Mon, 04 Sep 2023 09:18:09 -0400
X-MC-Unique: U6wKmgRYM2GPChD_iqvfdQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4011fa32e99so9447645e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Sep 2023 06:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693833488; x=1694438288;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBLzSQTLv+8pipDzuuK9IQr80p06o9JPiTCzfewmJxw=;
        b=GlebLPGVMHZ/1g6KcVLFp6DdQSnEBdYdUCYMipWbcPS3cTq3/8Ja9r/autwtaWzsTc
         R5kc6fNqDKnooTlONF2BgmcOI4masBdh3e99/xet5WRtXOmHjmnJY6gwDcF1KkIOxblJ
         5t6DPhxbAaBZx/jvNWL17ROy0Np5GCcP3aqQCWSUtDW2SNClrpn79JpgP6ZF8tfHJ3oM
         Gohscduq8eu+LpvLnuh5FWt6LzGQ2Q8nSjNHEf7vWwUMVOGMYCzR/0KJ8Lj+SgnaRcCP
         DYUzSBD+qJaax8NSRqNLnVhTaU9Qp9FV8oRVwgxExu8DDrFIc1eu/wrX8gg3yPE2VWKA
         X5OA==
X-Gm-Message-State: AOJu0YweL31Y2cImLsAtpylCOxr9MmuzdtyS9BExPEVSDvao7Pwfxd5A
        waD9auXTMEsjJ6HZl7e+BI5dvvrJfoYi/ror+2gzOS3j23y08Ia6s2/IgCVQn8Fx2ISE1dfPNoR
        PZdCkvmll/JNVGLOnd3gjGFApZFiTgVQ=
X-Received: by 2002:a05:6000:82:b0:31d:cd2f:4a4b with SMTP id m2-20020a056000008200b0031dcd2f4a4bmr6453148wrx.50.1693833488025;
        Mon, 04 Sep 2023 06:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMneOVTl+tO7EjPHxWk7aAIbA+6YIUPO8GkkaydyT763T9pc7YLR5Hmg/1C6iUl0u80TgQ3Q==
X-Received: by 2002:a05:6000:82:b0:31d:cd2f:4a4b with SMTP id m2-20020a056000008200b0031dcd2f4a4bmr6453136wrx.50.1693833487752;
        Mon, 04 Sep 2023 06:18:07 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d6643000000b00318147fd2d3sm14498682wrw.41.2023.09.04.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:18:07 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 4/8] fbdev/hyperv_fb: Use fb_ops helpers for deferred I/O
In-Reply-To: <20230828132131.29295-5-tzimmermann@suse.de>
References: <20230828132131.29295-1-tzimmermann@suse.de>
 <20230828132131.29295-5-tzimmermann@suse.de>
Date:   Mon, 04 Sep 2023 15:18:06 +0200
Message-ID: <87fs3ucc1d.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Generate callback functions for struct fb_ops with the fbdev macro
> FB_GEN_DEFAULT_DEFERRED_IOMEM_OPS(). Initialize struct fb_ops to
> the generated functions with fbdev initializer macros.
>
> The hyperv_fb driver is incomplete in its handling of deferred I/O
> and damage framebuffers. Write operations do no trigger damage handling.
> Fixing this is beyond the scope of this patch.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

