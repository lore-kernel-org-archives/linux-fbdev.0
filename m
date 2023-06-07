Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB548C77B7A
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 22:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjFGW0K (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 18:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjFGW0J (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 18:26:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A99A2718
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686176611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m3wnM605gKMmCudt2hcJJr2EFLF4uSnPgF/R0Xs7/Z4=;
        b=f2In9eu0fcJlyEfFJZrs+XUR8lUfcGNlW8tcJ0idu7lCXQHZpvDOUJf2ylTRDD+f/5m5Od
        rtzLAeD+OqiYXe7KU1YvIEmGMy+qkS8Etwd3sMp8riXhLYEzW7Cs1f3/9WDtWR+cAbI6K/
        x1sQ65IK7z46Lkql8W2+M+afvSYNk0I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-0PWxlvB_M1C4XiiKqScLYQ-1; Wed, 07 Jun 2023 18:23:30 -0400
X-MC-Unique: 0PWxlvB_M1C4XiiKqScLYQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7ebe8523eso9671805e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 15:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686176609; x=1688768609;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3wnM605gKMmCudt2hcJJr2EFLF4uSnPgF/R0Xs7/Z4=;
        b=fuURbyK51Rz8hnTAtw6qFWtdlNIY6+QN32d4NxtSEqhAAR5e+Ie58pJdELQPGUrerb
         XtB7IdZIuoobiJAjuZ0NLALy4D8Cldse6W0Qa07K/tgYmHo8WD37T6/DjFdw5AXYeoqJ
         DrDhfeOObyLYfHQTndkQMMcEBI7sTlnt3zl+kvfA8QwHaDu/5k8o58cxG9iEWJNdyIU0
         gX68TO0FS4WIuQDlkHQi3J5WoHgJQYaVuusx3Sfe8yMpZ2GcRcy5T0EFkZ4sMTTSz+s9
         yvvJQ1QdxNsMkxT/g0Z2zlgakM6hUZl2Wr18BQ0VQZ589SgeluC3sGwZmirVO2SefY8O
         Mo0g==
X-Gm-Message-State: AC+VfDxVgJ01yMw553SI1e1p0GDvX9X/uoBOcESj9Oa4tPsUnxTLUaFE
        sPYqi5mdBwLaSZBrpfaFmBHbm1VoNoOzFip9vHqNBdL4pEKKxgOYeHT8V4M749bcWBL0oOuUzwC
        p2IBzcgRqOIq3WCV1DG6kzDs=
X-Received: by 2002:a05:600c:230c:b0:3f7:f4bc:ebf3 with SMTP id 12-20020a05600c230c00b003f7f4bcebf3mr1544752wmo.36.1686176609315;
        Wed, 07 Jun 2023 15:23:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46AO52oYq6hkZwI7LskizRRuqd6gfq8mv/AQFd6xOXiRAiGoamovfGXQJy96q8ipeUPGiuUw==
X-Received: by 2002:a05:600c:230c:b0:3f7:f4bc:ebf3 with SMTP id 12-20020a05600c230c00b003f7f4bcebf3mr1544739wmo.36.1686176608968;
        Wed, 07 Jun 2023 15:23:28 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d10-20020a1c730a000000b003f42158288dsm3313271wmb.20.2023.06.07.15.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:23:28 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 23/30] fbdev/tdfxfb: Set i2c adapter parent to hardware
 device
In-Reply-To: <20230605144812.15241-24-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-24-tzimmermann@suse.de>
Date:   Thu, 08 Jun 2023 00:23:27 +0200
Message-ID: <87bkhqewtc.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use the 3dfx hardware device from the Linux device hierarchy as
> parent device of the i2c adapter. Aligns the driver with the rest
> of the codebase and prepares fbdev for making struct fb_info.dev
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

