Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76961C6FD18
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Apr 2023 16:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbjDYQvM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjDYQvL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Apr 2023 12:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47388693
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682441421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1IBNqcRqeTZzne8M/J8hr1xuha01SHIRztHOGGgQpCw=;
        b=FN++nP45r6YbmYDs6V/vglSbLp84sZDpflCweIVvmBf83s9QR4SJRXo4mSYLNopFRrPdP/
        BXQar3d1W25h1FRZs5gl4N+yW8mgRp763lfSt6Wp8EmpN+ScgmpHOBhfeYbMxFZjXsss8R
        0Y3RwbmfiRgIvOFtmElcfleuNGr9HDI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-eVXOhs8kMIyO1WBUeNhr6Q-1; Tue, 25 Apr 2023 12:50:19 -0400
X-MC-Unique: eVXOhs8kMIyO1WBUeNhr6Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30479c17304so937576f8f.3
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 09:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682441418; x=1685033418;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IBNqcRqeTZzne8M/J8hr1xuha01SHIRztHOGGgQpCw=;
        b=EuPnE46M+ufMAYoCVNtpd/YeSbpkP0nrMhF9zGCRhTRCB2RCLLzn/UxEml7d8WvRnv
         GWcHuqe8yrHsUPEEa2iR7NvznJCFaVYipXkwaZ0cmhhP/b/XReTWH7YSK9ycAaSicSOE
         /TAwYORH9emB+Ju5biJu2QdiTpq6ue32KaF//7rOp+LFIBIZC3oEVh4G5r4V3g87O+j6
         /08m6GRsHjWqG0rH+plY8R/yyVd5G3/PoXku/QlggMrjAdrDIhFO8flk7oOHubmPUAyi
         ADwF6yxGMjWX4Cr1wlYEeVe+R5lxYoURH9zqAGlGukINVxav3QPwDiBDuamChm1SxRCc
         aouQ==
X-Gm-Message-State: AAQBX9d0EH/+3WKVZQoqhWp0I83mw7UaN9KbT6vszCIUWhVZENjKkm2U
        y7CJKJIiT0jxpTNPQe4sVlrYgQiFqoc6IOD1ZdfCbNw2t0IumTixuyGsQyRCOmJ5bK0xVlsyysf
        M84RKfQBuoDGdGXEj5hMn1hg=
X-Received: by 2002:adf:dd85:0:b0:2f1:d17f:cf95 with SMTP id x5-20020adfdd85000000b002f1d17fcf95mr13070160wrl.12.1682441418534;
        Tue, 25 Apr 2023 09:50:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350a3fROSX8v9F9liQzoUUOVdfUK7aaTD4NXiculnVAEJdMY1kulAFQvsEsKKeaI17R2OBKp7fg==
X-Received: by 2002:adf:dd85:0:b0:2f1:d17f:cf95 with SMTP id x5-20020adfdd85000000b002f1d17fcf95mr13070145wrl.12.1682441418213;
        Tue, 25 Apr 2023 09:50:18 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z18-20020adfe552000000b002f3e1122c1asm13541319wrm.15.2023.04.25.09.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:50:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 6/6] drm/fb-helper: Use fb_{cfb,sys}_{read, write}()
In-Reply-To: <20230425142846.730-7-tzimmermann@suse.de>
References: <20230425142846.730-1-tzimmermann@suse.de>
 <20230425142846.730-7-tzimmermann@suse.de>
Date:   Tue, 25 Apr 2023 18:50:17 +0200
Message-ID: <87y1mfhpo6.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement DRM fbdev helpers for reading and writing framebuffer
> memory with the respective fbdev functions. Removes duplicate
> code.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_fb_helper.c | 174 +-------------------------------
>  1 file changed, 4 insertions(+), 170 deletions(-)
>

Very nice cleanup!

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

