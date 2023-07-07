Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73037C0015E
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 Jul 2023 13:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGGNnC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 7 Jul 2023 09:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjGGNnB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 7 Jul 2023 09:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1194226A6
        for <linux-fbdev@vger.kernel.org>; Fri,  7 Jul 2023 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688737313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lszDzBh1sFuGKtdYdBJwoIUw40PY44r7U0tPTyFHI1Y=;
        b=C/uyhEkVC0bU0K+UW/LzuhSwAQkh8RUXH/vtze2/wMvwdbIS6mpPJv3Xu3DQcfmXbrKWlr
        xwKyboxorQGfX2QYyxKvBVUnogYoc3GxjMECSJzQGQgG+LY3k8WPWFxbjOX/xe4Mee/cK4
        IV43bpa3bZmt7xDYjDJ1e+egK+hvwrg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-LruRFjD_Nn-GN079Cjrrpw-1; Fri, 07 Jul 2023 09:41:52 -0400
X-MC-Unique: LruRFjD_Nn-GN079Cjrrpw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-314134f403fso999269f8f.2
        for <linux-fbdev@vger.kernel.org>; Fri, 07 Jul 2023 06:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737311; x=1691329311;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lszDzBh1sFuGKtdYdBJwoIUw40PY44r7U0tPTyFHI1Y=;
        b=VMNZly04cmAYfs7c+EHCWaNd/nsX12I0/K9NNQsRiWoLgvVR0ZTUgp8b59ScLsgX2Y
         u4Op7mILdOAuYACU6Doy4msCQ+ZPZpSH/dRJg8hMCxQovsxQmxpDqpr8kW83sLMT6/a8
         /dyZ9v/agRZI9W1hIQ4WHnFyGlOMB7JhiAdTQXIQLNB8spGKx8xfWLuCy2ROx8M65vtF
         ROJD6oshRaCo0YpExmV6r/oTP7sqyxBDvr4Mxvpfo45l6dvNfkyULtaEfqdaVVGIXR0M
         bcvj6L2Bw6iyYXoXGI2a7KGmalAdWTdh3397HDWbF/uZhs6lCzi7vxGbS5cBAbCZBtGi
         ju6A==
X-Gm-Message-State: ABy/qLYZB++0VbkYnrE19rMtVyCFhxSSLJt0qPNgCCKXkfa8lbVNv+5Z
        Aa7tyo6m+1448N8YNTTU+XY2trEQleBpYwZDuH7AfgNZWBnOViecUTkldNv6BjlxJs9LAwLLOg6
        SM7ddNY/BpZ/xDcrPixZGdYo=
X-Received: by 2002:a5d:4d4d:0:b0:313:ed1d:39d5 with SMTP id a13-20020a5d4d4d000000b00313ed1d39d5mr3821981wru.35.1688737311022;
        Fri, 07 Jul 2023 06:41:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHSL73NnelkECzSlrHFzZyBm2hgT0OM42vU9A9OivdXpoF5fr4x25M2kgCTNebgI6XNosfvXQ==
X-Received: by 2002:a5d:4d4d:0:b0:313:ed1d:39d5 with SMTP id a13-20020a5d4d4d000000b00313ed1d39d5mr3821963wru.35.1688737310726;
        Fri, 07 Jul 2023 06:41:50 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g23-20020a7bc4d7000000b003fc02a410d0sm181059wmk.48.2023.07.07.06.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:41:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] dummycon: limit Arm console size hack to footbridge
In-Reply-To: <20230707095415.1449376-3-arnd@kernel.org>
References: <20230707095415.1449376-1-arnd@kernel.org>
 <20230707095415.1449376-3-arnd@kernel.org>
Date:   Fri, 07 Jul 2023 15:41:49 +0200
Message-ID: <87h6qfyh2a.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The dummycon default console size used to be determined by architecture,
> but now this is a Kconfig setting on everything except ARM. Tracing this
> back in the historic git trees, this was used to match the size of VGA
> console or VGA framebuffer on early machines, but nowadays that code is
> no longer used, except probably on the old footbridge/netwinder since
> that is the only one that supports vgacon.
>
> On machines with a framebuffer, booting with DT so far results in always
> using the hardcoded 80x30 size in dummycon, while on ATAGS the setting
> can come from a bootloader specific override. Both seem to be worse
> choices than the Kconfig setting, since the actual text size for fbcon
> also depends on the selected font.
>
> Make this work the same way as everywhere else and use the normal
> Kconfig setting, except for the footbridge with vgacon, which keeps
> using the traditional code. If vgacon is disabled, footbridge can
> also ignore the setting. This means the screen_info only has to be
> provided when either vgacon or EFI are enabled now.
>
> To limit the amount of surprises on Arm, change the Kconfig default
> to the previously used 80x30 setting instead of the usual 80x25.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

