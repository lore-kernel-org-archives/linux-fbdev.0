Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1588FC001DD
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 Jul 2023 10:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjGGKOi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 7 Jul 2023 06:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjGGKOH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 7 Jul 2023 06:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D5830D7
        for <linux-fbdev@vger.kernel.org>; Fri,  7 Jul 2023 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688724749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DlW1R/8hRwezlWgbC+wvZSXHhVUh/eG+VQMZJgN0Tvc=;
        b=SKvhzrwoSXjEeAVCIGLfT5B6/Ux74RR+4qclTt80kZw2qgHW+ph0GeZ+BZJdiml1m1mkVO
        Qm95Bq+9Xw04mzOS7EH849Oq9qjkGgT+lq+VE8KrkO5mvGDffZGf8nSfdBhYQ+KyTP7dav
        QkxCazsX36QdyvZtGIq4cq6Q8MS7Dhc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-nXTbHQs3O0mtFu0jaaA5AQ-1; Fri, 07 Jul 2023 06:12:27 -0400
X-MC-Unique: nXTbHQs3O0mtFu0jaaA5AQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3158a22534aso115025f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 07 Jul 2023 03:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688724746; x=1691316746;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlW1R/8hRwezlWgbC+wvZSXHhVUh/eG+VQMZJgN0Tvc=;
        b=aPeXHATpeIl/sTHupK0v3HstQvmlABSVMzt15dIV7iWH4S5PN1SzFVNQAevFV6pWEU
         csQC5Y771VOGU8f0G6dEHqyG7Nxz7Z6OnGP9tz9uLqU6z3BaFa7YpLpNYGEFNYtPW6At
         uoFwnRjsVuu5EsoOwaapR9gr5x0a2l8K69zOFyJtsNb9JANlBXoTK54OiVB5DRcy4nBO
         BBVKG35j7bT1uSNBnvCuPGysX8kItoC2BL7RJDdahahu+quaXUm/cBAKwRIbiGOkhHFH
         WC9eBWnUjx64dqh8DalGRP7N57A4LLTtziB9lEI/wcCR5a7KgfiHlbZWm4Xn1/muMdJE
         8bqQ==
X-Gm-Message-State: ABy/qLZc+QxsH/Txg2M+OSmG3N9xn0+KRfNLQ2g9vNKlXfvVkWMMjjG+
        TMY5pWALILy8uMOdQugG8Xu/kkUOOPFOP4xBEOIIveL5TsuY2ICA1mhoeOX5X+p6jFgc7Hx6428
        kR7RMDP6sYyMhxBRQfkK+WOo=
X-Received: by 2002:adf:e40b:0:b0:313:f02f:be7f with SMTP id g11-20020adfe40b000000b00313f02fbe7fmr3429135wrm.55.1688724746545;
        Fri, 07 Jul 2023 03:12:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEl0rRQx8YRJhH9y3kGM2crHvIosSMl2yPsiQFeLRX1mWJpZ5P5lO4jWKSG6bWALHyxhssqPQ==
X-Received: by 2002:adf:e40b:0:b0:313:f02f:be7f with SMTP id g11-20020adfe40b000000b00313f02fbe7fmr3429126wrm.55.1688724746175;
        Fri, 07 Jul 2023 03:12:26 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m5-20020adfe945000000b00313f9085119sm4031028wrn.113.2023.07.07.03.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 03:12:25 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v3 05/12] drm/tegra: Store pointer to vmap'ed
 framebuffer in screen_buffer
In-Reply-To: <20230707083422.18691-6-tzimmermann@suse.de>
References: <20230707083422.18691-1-tzimmermann@suse.de>
 <20230707083422.18691-6-tzimmermann@suse.de>
Date:   Fri, 07 Jul 2023 12:12:19 +0200
Message-ID: <87pm54xc70.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Tegra uses DMA-able memory, which has to be acessed with CPU ops
> for system-memory. Store the framebuffer's vmap address in struct
> fb_info.screen_buffer. The currently used field 'screen_base' is
> for I/O memory.
>
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

