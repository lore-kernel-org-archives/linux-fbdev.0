Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83771C77B7A
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 09:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbjFGJMr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239807AbjFGJMQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 05:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2BD11F
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 02:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686129027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EIz8b97+2mar2ffqQ22U9WQizWobZ+ziDNV+MHu5qjc=;
        b=JY+mwF/pf9OnprNtZLhk/UnUqGl6KHprB0Nx5I4sEopGBFyaXz5wxoZL3uCL6WWTFKKiQZ
        vUn2hEg01hgtLBifOfdkZ/ckRrxv7H6sb6hPIbeF3EDZWfyUg7gWW8L+dg9ddgCRsJVMW4
        LrHf1IQ1niWZlRvzTfjP/BicdzGTVMI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-ltmN4cUeMZeNYLyTaZRyYw-1; Wed, 07 Jun 2023 05:10:26 -0400
X-MC-Unique: ltmN4cUeMZeNYLyTaZRyYw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7aad897a5so55128115e9.3
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 02:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129025; x=1688721025;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIz8b97+2mar2ffqQ22U9WQizWobZ+ziDNV+MHu5qjc=;
        b=Jl+9kjniXBmc+D06mza295uUAD72eRHV2yotlHXPnhH3CnZUo6wtVkBvNnzY9giwZj
         nVwXOA5qvyuUW/Y3jMxHgOpx/QwSakLVbLaSJm+0Pv/7DcANwHzT+LmEgY64t7Fnum/C
         77i2fY5wnr8yLG0ub/PtcfuGksAGW3c/VPaOMxav/s98Gl4mJxmEGUqjqVwM1+psngVx
         7o6W45VFDtoQqfXy6FT3il8B1Mdm5fNOFPOd5U/1+gTiexwNEIKuw0POTwrdkT6Gn5KV
         jmPQ8uPgm3i7MLR662+k+cPkrR3f/EBkXnHe3Y3bDPOAV6ZLOgMw9ikxNc8Mk/xA6x8E
         lYSQ==
X-Gm-Message-State: AC+VfDwSaoQgSdcU/SCAU6Qvr4CzWEbU8cG+xQ4ZSRZemwu0Au+qfjxh
        4TCbH/2pm/1VBjNwBo/uAHmS2K9CZXe/gsv08IjxPN1iEQ25DkDMyqG6KZmy7uwgwRTlp+fEuj5
        4XMX8dDhtcHek5AskkHAZgdc=
X-Received: by 2002:a05:600c:a395:b0:3f7:3401:17ac with SMTP id hn21-20020a05600ca39500b003f7340117acmr4587430wmb.5.1686129024878;
        Wed, 07 Jun 2023 02:10:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ePD432YmabNuUR+sxJiR/Lq4y75rOFMJQocJYAFtsL3UId8CM+YY12IKNvHU0PgR+SDGlYA==
X-Received: by 2002:a05:600c:a395:b0:3f7:3401:17ac with SMTP id hn21-20020a05600ca39500b003f7340117acmr4587416wmb.5.1686129024708;
        Wed, 07 Jun 2023 02:10:24 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bc8ca000000b003f7f249e7dfsm983105wml.4.2023.06.07.02.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:10:24 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 18/30] fbdev/radeonfb: Use hardware device as backlight
 parent
In-Reply-To: <20230605144812.15241-19-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-19-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:10:23 +0200
Message-ID: <87wn0feiyo.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use the hardware device in struct fb_info.device as parent of the
> backlight device. Aligns the driver with the rest of the codebase
> and prepares fbdev for making struct fb_info.dev optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

