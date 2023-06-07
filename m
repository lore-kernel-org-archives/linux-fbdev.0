Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2528C8300C
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 09:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbjFGJLk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239867AbjFGJLN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 05:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AB42101
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 02:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686128965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G+PL21gB/daxR4zsJJ2MptIbuOMEv26lDV4Pg4ezd44=;
        b=arIXfBEYN6IM8CQbHpUfWR8D6iaDFiQbOWVyTTSvfj8nnZOr7p2sIRIYIH4Jy8Ufwyokgu
        /g2v84TNtexuhPSIDFT7mXHg16BNzNE/vRZUNtx+5tYcspqA9jk+mloVnj3Nc2We9deP81
        2j+vPm5/natzbSqgMPcKR/OpzUbnPNk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-0USb4Qe5N1qYdtlzuNWzYA-1; Wed, 07 Jun 2023 05:09:24 -0400
X-MC-Unique: 0USb4Qe5N1qYdtlzuNWzYA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f6089a9689so43220065e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 02:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128963; x=1688720963;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+PL21gB/daxR4zsJJ2MptIbuOMEv26lDV4Pg4ezd44=;
        b=VPazhtmVHJtRECfzibimr9d9uCeQCi032mzyc5eLr4zB3AFmh1nIQSt/MR3Pjv4sZw
         v4hMAt2VjKOfXYqhCSqBItdTElhfQgKjRKxLuNdPdxtRMKTtD3KnRkAcGgu0iCgAToBX
         lknt7rb0WeK/Rvp9MhFa7kfm3r4PSRpbW/a+fsyflRq9NCVGzfD75XnrRuUsHECr6bdp
         zZwXkWHdbWDQLeuiuTHIgYmUsFOeJrst8eJ7C5TRQw1z1u+JLNVpKq5qc+HxqcRHVYbY
         uxQN4E20BihiRwm84rO6nwzrX3FInYok5GqMNHxbJ+grvvewWKVyOZpNgdoNlsovHUJX
         g0XA==
X-Gm-Message-State: AC+VfDzuIIXPN/FdNPbMwIW9CpkzWewlZ1T178kqDjNhHBwXtIvs3rMv
        KatOmLbCXQRT5tO5R1cxkGmiPrltXj0ky4GIZbSw3XPJabuCuqul4XQ4yJJALkBy9uqDEnZFx3e
        FgdQaNAyiJ0CtH8uwpCimZeg=
X-Received: by 2002:a05:600c:b45:b0:3f4:d18f:b2fb with SMTP id k5-20020a05600c0b4500b003f4d18fb2fbmr4423504wmr.8.1686128962967;
        Wed, 07 Jun 2023 02:09:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7KIDwr6/boDKEelyImr80QUEOg3IdkbWZ6AUo87k2W9nGNMdMne7IQ3JZzUQzQ4CBO1bqmKA==
X-Received: by 2002:a05:600c:b45:b0:3f4:d18f:b2fb with SMTP id k5-20020a05600c0b4500b003f4d18fb2fbmr4423483wmr.8.1686128962700;
        Wed, 07 Jun 2023 02:09:22 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k26-20020a7bc41a000000b003f60e143d38sm1426996wmi.11.2023.06.07.02.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:09:22 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 16/30] fbdev/pxa168fb: Do not assign to struct fb_info.dev
In-Reply-To: <20230605144812.15241-17-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-17-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:09:21 +0200
Message-ID: <873533fxku.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Do not assign the hardware device to struct fb_info.dev. The
> field references the fbdev software device, which is unrelated.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

