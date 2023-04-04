Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75C4C761A6
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 Apr 2023 10:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjDDKGa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 Apr 2023 06:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjDDKG2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 Apr 2023 06:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5383E19AE
        for <linux-fbdev@vger.kernel.org>; Tue,  4 Apr 2023 03:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680602740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UMCzWKaut/dN2TteOQeTt4t+0LoKg/jXl68FDuqkqUg=;
        b=D6CT/czG2494BcUHXKKnDkCkCKiXnTKbZBLzELPvwCREYxINCpqvdOrWPsPqi4LX8sWVZo
        q3grfCEDjn9f/AaE86pYq+JZqa1ICKVhwuFt3FMBrf70chmcfCklZIjb0wNmf9kJxsIL8d
        lIIphGV7UJJYCOOfqexHlIfjGN+4Fn4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-GkFof7yOPNyk_d9whKjdJw-1; Tue, 04 Apr 2023 06:05:39 -0400
X-MC-Unique: GkFof7yOPNyk_d9whKjdJw-1
Received: by mail-wm1-f69.google.com with SMTP id n11-20020a05600c3b8b00b003f04739b77aso5609852wms.9
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Apr 2023 03:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680602738;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMCzWKaut/dN2TteOQeTt4t+0LoKg/jXl68FDuqkqUg=;
        b=ZsKsbokyDJ0ZSatGZRix6AyTIUfEe2soUtFXQsrL8/YTNHKphP846fUellhyfLttsP
         csyy5afJX33XjjjX4nOxPWKsTb71G8m20j1Rwk2A7D1/oohlqnIixIjXYk//IUVE8mHg
         pzF4noHHoBCEmBJdLtAiQhujx9sTdCAtR/RdNeFnJSEl6TaX8IIqWgppYBcRHyBt6Eex
         SpoDCvEpTCyb7RYdyxRpTcr6eJJi9wcxyzVSDPGOU2xD5ffEeYnup7jVHkWLuofdj+RV
         42Nm8ocfW+b6llaSdrVDPzoOUdhipTTM0UxTzRhrDABgn057p+brydRAU3OLzncwQ0Sq
         i8Xg==
X-Gm-Message-State: AAQBX9cKVQIHw8H6adRmn5JtCMLjWsNL/yS6UMlUhD0UGAjJDN7qwtAK
        QnFLcZMLOmhrPwz5WdgyIJMtVIPn3xZZw99smyxKdlsDk1buSngMD5Ug+C4wcy2wPFgwPehTOso
        86DDGSQzdJAk8UD07bX4FPMs=
X-Received: by 2002:a05:600c:2304:b0:3eb:383c:1870 with SMTP id 4-20020a05600c230400b003eb383c1870mr1736138wmo.11.1680602738075;
        Tue, 04 Apr 2023 03:05:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350YDNcJtl8vS0GQ3xwhc4h9mR4/DZ4CsaVtJuVBEk4OvhBOdtLF2QHnh3n/hwDWqXrOpPWKP1w==
X-Received: by 2002:a05:600c:2304:b0:3eb:383c:1870 with SMTP id 4-20020a05600c230400b003eb383c1870mr1736121wmo.11.1680602737684;
        Tue, 04 Apr 2023 03:05:37 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b003ef5e5f93f5sm22001437wmq.19.2023.04.04.03.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 03:05:37 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>,
        Christian Koenig <christian.koenig@amd.com>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video/aperture: fix typos
In-Reply-To: <20230404040101.2165600-1-suijingfeng@loongson.cn>
References: <20230404040101.2165600-1-suijingfeng@loongson.cn>
Date:   Tue, 04 Apr 2023 12:05:36 +0200
Message-ID: <878rf8dksv.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


Sui Jingfeng <suijingfeng@loongson.cn> writes:

>  EFI FB, VESA FB or VGA FB etc are belong to firmware based framebuffer
>  driver.
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

