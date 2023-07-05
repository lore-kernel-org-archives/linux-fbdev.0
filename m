Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C6EEB64DD
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Jul 2023 09:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjGEJIa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Jul 2023 05:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjGEJI3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Jul 2023 05:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8650B170B
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Jul 2023 02:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688548071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qr/C5LtRvrDZoQId+bjsOh/ZaHhOujfRlisJ/yVhSwY=;
        b=UkLADN8es5IicEimAEAQzF1P1WWuT+db92nJR1xZAFcvaMLDLTmGTNW0dyaZ79cVFzw+62
        kdHrmhxntk8gn2NFiJJ7k+g5Qc/7P2a0Fz2ZWETjSbtXuirPdkYul6FuzKy4WDlTMWZEnE
        ia51HoWfR+5Le0LY6B2o155X3LxWUsI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-Tiu0u_8JOVqmuHEo-PlHgg-1; Wed, 05 Jul 2023 05:07:50 -0400
X-MC-Unique: Tiu0u_8JOVqmuHEo-PlHgg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31421c900b7so3098239f8f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Jul 2023 02:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688548069; x=1691140069;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qr/C5LtRvrDZoQId+bjsOh/ZaHhOujfRlisJ/yVhSwY=;
        b=bKRsEhXLRwZ1uLghpNqKutKZ2yAL+0gXCl2acsBkJQGX6RWWmk760tBOzgOxMd2AB3
         CK4pqc7JavhDjCAlOowHdfuBW/f0EAEcB6MEQUvTnFFCxCjOrp0/ScDvUntYeVTJ9HRB
         q//q0QByj7ncZ0vqukcheqHwxtiIP8GQuGKcxOJH59NUxqgHkVyU1vHsLWRWvnHvZK3o
         dfN529i09+LzgXBiK6FYYSLPg6TRZqX1xR1jQHItS6N2q7apeUK9AznXHYoNB8W5yZGw
         u8p0bOyPXuTmQq7baIcyCQtGRjA0gwEpDKJS1f4WldCUF4klXJpmNwCx2Gy0JM+Bc3IC
         wlOA==
X-Gm-Message-State: ABy/qLbkTSs/O7jSuatk38QixM3m0Dtm59th/5eKIUy5odTPGcMs0B2u
        xQFDW8q0LR61/yf2I7jTMG1mD/0zdRV8fyoGL5vzPw2ehQjG2PfQLL9iMH8OCZE7JkRyQbr8TIu
        DmM2wp3Ldnm5+LnAoRhCTwxyM9hcIbB4=
X-Received: by 2002:adf:f504:0:b0:30f:d12a:d0b5 with SMTP id q4-20020adff504000000b0030fd12ad0b5mr13084513wro.55.1688548069027;
        Wed, 05 Jul 2023 02:07:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHf2mlJzkynZeRnACKLZDj8dpbPaRQo1oHTkYMNq2t7OkGieb7M7VOESlbgxnGoXEMWu20AzQ==
X-Received: by 2002:adf:f504:0:b0:30f:d12a:d0b5 with SMTP id q4-20020adff504000000b0030fd12ad0b5mr13084501wro.55.1688548068811;
        Wed, 05 Jul 2023 02:07:48 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n5-20020adfe345000000b0030e5bd253aasm30417562wrj.39.2023.07.05.02.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 02:07:48 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 10/10] fbdev: Remove FB_DEFAULT_SYS_OPS
In-Reply-To: <20230704160133.20261-11-tzimmermann@suse.de>
References: <20230704160133.20261-1-tzimmermann@suse.de>
 <20230704160133.20261-11-tzimmermann@suse.de>
Date:   Wed, 05 Jul 2023 11:07:47 +0200
Message-ID: <87fs62rajg.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Remove the initializer macro FB_DEFAULT_SYS_OPS and its helper macro
> __FB_DEFAULT_SYS_OPS_MMAP. There are no users.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Helge Deller <deller@gmx.de> (maintainer:FRAMEBUFFER LAYER)
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

