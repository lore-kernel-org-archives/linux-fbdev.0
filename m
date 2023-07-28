Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D74DC001DE
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Jul 2023 10:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbjG1KEQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Jul 2023 06:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjG1KDy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Jul 2023 06:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D659235AB
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Jul 2023 03:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690538591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p9uBh6FMvfeDKYc8dvTUQUg/D36NNqMboTJZgEA5t70=;
        b=NhdTBWxS5zR1hpSMFz0ovjNKayFZuMdr9Ia+UJXS92OtxtnMCdsxoWcggPNmIPsvytudVs
        WCG+b/ggyLRvIW44zHMMoNAiZnbiTKmumvZF8CbEo7ibPVKNVFy+9sJr5jVsSs8hXMRTyv
        bJL0UN4PkKDt+6wUBDTtp7/9hpWsJp0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-i5rQoNbNMWi0L95jeM9E_w-1; Fri, 28 Jul 2023 06:03:09 -0400
X-MC-Unique: i5rQoNbNMWi0L95jeM9E_w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fd2e286689so10897995e9.3
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Jul 2023 03:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690538588; x=1691143388;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9uBh6FMvfeDKYc8dvTUQUg/D36NNqMboTJZgEA5t70=;
        b=RRxNeNFfXO+jK8rNW4V5eiwtEut/z/mKdOG/JRwIM9RKSRQ3TjFsTp8c56mlRcbMaI
         y+BGb0VwhmXUFmvXwtpiuzpJ0a2JS2zwxK2Ij/2fVnklYlBDmgdXGSEcR9eBVL/vpfds
         F5IarvUYKgOCGGeeqYCTca3Pe2PmYYfEYpX0TSzsSRAUqfJbKvVXV6F0rEijQ63PU9ux
         0svPCOl+g952qVMXkwHkVm3WlQgYhFj8Ecrq8APa5kimxgof7kMlyTdI5hPPnyRDi2ac
         OMDCK0N3SFQ5uHc+ZhwlQ6LcY0DUAHNnHimfLfxI3ZGn8u9esKvNcfWRnHYCZUXsXA3v
         rIVg==
X-Gm-Message-State: ABy/qLaiVFE+k2Y+eFfLYCjPvGUllWxwGnqsvTk04vOxp5Pq1s77TcWc
        QfQHxnWEHVUHD7o86zkIlhh/TumwRPSax+GMz8SgaIrEdn4WS8jItnoYc0VK0UaZSt4t0PJFifC
        bfqvrDHtxPditO+VkTorg1IU=
X-Received: by 2002:a05:600c:20f:b0:3fe:785:ac0b with SMTP id 15-20020a05600c020f00b003fe0785ac0bmr1222139wmi.5.1690538588605;
        Fri, 28 Jul 2023 03:03:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHtdYABsrhIonVjfx9OTENY+L0T6vf82VlJ9iuT/7Og+9ZVj9h0aqYiRuknX63TfNx/AP5fxg==
X-Received: by 2002:a05:600c:20f:b0:3fe:785:ac0b with SMTP id 15-20020a05600c020f00b003fe0785ac0bmr1222130wmi.5.1690538588357;
        Fri, 28 Jul 2023 03:03:08 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y17-20020a05600c20d100b003fba6709c68sm3763721wmm.47.2023.07.28.03.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 03:03:08 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2] video: logo: LOGO should depend on FB_CORE i.s.o. FB
In-Reply-To: <e4142b7cc9aad9975de1bc6b1c7d86ccee487e4c.1690535997.git.geert+renesas@glider.be>
References: <e4142b7cc9aad9975de1bc6b1c7d86ccee487e4c.1690535997.git.geert+renesas@glider.be>
Date:   Fri, 28 Jul 2023 12:03:07 +0200
Message-ID: <87tttoxsis.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> If CONFIG_FB_CORE=y and CONFIG_FB=n, the frame buffer bootup logos can
> no longer be enabled.  Fix this by making CONFIG_LOGO depend on
> CONFIG_FB_CORE instead of CONFIG_FB, as there is no good reason for the
> logo code to depend on the presence of real frame buffer device drivers.
>
> Fixes: 55bffc8170bb5813 ("fbdev: Split frame buffer support in FB and FB_CORE symbols")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

