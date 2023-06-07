Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3F9C7EE23
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 07:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjFGH4a (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 03:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjFGH4a (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 03:56:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21871721
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686124543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tzwKDEeExwlnpVxIio+gh6QukNcWAFoM0lG5LiuVXys=;
        b=SF0Vl229DIVNRfYr51yR+kiUWV7SkW2aHJ78w1ND86/vOVTZPZ4gHLrFuCSAfBHfq9X4vl
        mMadCzcErYgaaGSq/ypyVR9Zv+UoNqyVNsNjGkRjVRKIXd42OgTNODTGYfAmXnw/qQKKz4
        hXBcMkUXNr7rLNX33CbBmDeJqTNrFvs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-5wXCtWkLNPGP7trPEI-ncA-1; Wed, 07 Jun 2023 03:55:40 -0400
X-MC-Unique: 5wXCtWkLNPGP7trPEI-ncA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7eb415010so1689345e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 00:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686124539; x=1688716539;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzwKDEeExwlnpVxIio+gh6QukNcWAFoM0lG5LiuVXys=;
        b=Zl5wIgz+CHFwo8FbtEFU28KFab/z4umC2iAjLrZXFQtSQEwSNntktRjUSSylvw7pFC
         RppOcR7jts/DlLcK4YduClo1ZysOWykLz/4hKzM+ARCCoJBAiyQRk5rnUKVK9rVAMHZi
         1sS3u5HX2ypXdXfppDLRlm/qXn82IF2lIjKZHn7cbb0Gk8Ush4QDAnLkupzQmN+IOFry
         hXRX0zSp3J0P81Qq+Hl0z4dRIoipxOzhi6F0KEfK3z/P1t287pWoIdXIyT3d+Mbxz9P1
         iTlrMKuGJSSj4KBG1Nz2wmhy63lF9O0a1CN4lL8VU6AbtGFv2muLqMXJhxJWq3FvrHpi
         aPWA==
X-Gm-Message-State: AC+VfDwnf1FZspC8APlPhBvYtxFg/Lf6WdVN7YiY2LFaGHzHkX5joI5U
        /t2doTP1kFU8fahmn8U5Y1BL+/xm/cv+4TUpF2DdonlsTiVqP9/sCd6icE2umb0zAdCAaOtfYW/
        0c4IQCIEfEvBIaP3jN57ElFw=
X-Received: by 2002:a05:600c:b89:b0:3f7:3284:4e51 with SMTP id fl9-20020a05600c0b8900b003f732844e51mr8903493wmb.4.1686124539609;
        Wed, 07 Jun 2023 00:55:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7XsE1MIBLkrKPsF0to0MXFrankIK5l3IfIsZWE8tI4gRDcEz1ZX1KmYbQPpdwp7XOKQIbPMQ==
X-Received: by 2002:a05:600c:b89:b0:3f7:3284:4e51 with SMTP id fl9-20020a05600c0b8900b003f732844e51mr8903472wmb.4.1686124539336;
        Wed, 07 Jun 2023 00:55:39 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j27-20020a05600c1c1b00b003f4283f5c1bsm6978981wms.2.2023.06.07.00.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:55:39 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 08/30] fbdev/broadsheetfb: Call device_remove_file()
 with hardware device
In-Reply-To: <20230605144812.15241-9-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-9-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 09:55:37 +0200
Message-ID: <87r0qng0zq.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Call device_remove_file() with the same device that has been used
> for device_create_file(), which is the hardware device stored in
> struct fb_info.device. Prepares fbdev for making struct fb_info.dev
> optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

