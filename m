Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218BAC7EE29
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 09:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjFGJM3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbjFGJLp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 05:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983A52701
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686128998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RSdIsVX6ecFqz04GkrugK7lp/x5jJUtqPYllPP5sQjg=;
        b=SVsN5vU9K8FT/r1Ft2radZh+CWKDa0llXTI0Q+7QyXNmTqBx4yHVeN2g+zUFavw0nGHeXX
        Vtee6T+qxMA24BX4/4PbrIxgBZLC+Zz2RNnai8L2fp7HZz+51EKcMHHG27j9xupm5JOYU7
        GT9Kpv1Tjd09iWj/LoJzfOYHJ5zvo4g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-z99s7H5nNISJ8RkxqL-Cxg-1; Wed, 07 Jun 2023 05:09:57 -0400
X-MC-Unique: z99s7H5nNISJ8RkxqL-Cxg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7eb415010so2069805e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 02:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128996; x=1688720996;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSdIsVX6ecFqz04GkrugK7lp/x5jJUtqPYllPP5sQjg=;
        b=Sg7i1KyUa2FzQuFGALK2K6XBDEMqxHMAI4thVr93raZSSARWzGCJvDWEqgzqXlSJGh
         Fz6nBcIhehpwhWIxy9bPy45H8CIRtODONISePelSJw1rU3D0wu8K1QAs2cMDLjDKDmtV
         EqKN7z2nt5ML1f/VLnHCwsoj4eMw2QwrskJI7VhzwO3ePdzIfhFhpxC5m1ORrYBzY7YN
         /s+YwdnGqcQ5Gkte15sEXYlFxsn6r/WCCMipX8BPq57zjB9BVpTVHy6nIMPO8BwFuk0S
         PenW2G5Vh0w/M6uawFKbdHI2zmxIEU6rVcQbCwHv3+bAHDEX/f7+5DBQgXIQ4kJ/IXEK
         bLxA==
X-Gm-Message-State: AC+VfDzAM1TBCkWmWr+A20gAZukUKI+A9LfY8dqPq41w4kRsJv1YPEJ4
        M1czvGyafPIGOii1ouyR4hOa3Ln+GO711TkORq4zXyb8nUuLWmzEJgovmKx/eUInio7tX/3FyiY
        77vJtn0JmouRUGsMUs2C2vc8=
X-Received: by 2002:a05:600c:220f:b0:3f7:395d:6585 with SMTP id z15-20020a05600c220f00b003f7395d6585mr7850357wml.15.1686128996490;
        Wed, 07 Jun 2023 02:09:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4S4Ug1fiHJ0oCExHc5SSiTGb/dJv10TIcn7zVRyFtmlI7TI/i0oDDpnO/bY0dqK+vi3g6l4w==
X-Received: by 2002:a05:600c:220f:b0:3f7:395d:6585 with SMTP id z15-20020a05600c220f00b003f7395d6585mr7850336wml.15.1686128996200;
        Wed, 07 Jun 2023 02:09:56 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v25-20020a1cf719000000b003f736735424sm1425404wmh.43.2023.06.07.02.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:09:55 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 17/30] fbdev/radeonfb: Reorder backlight and framebuffer
 cleanup
In-Reply-To: <20230605144812.15241-18-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-18-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:09:55 +0200
Message-ID: <87zg5beizg.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The driver's backlight code requires the framebuffer to be
> registered. Therefore reorder the cleanup calls for both data
> structures. The init calls are already in the correct order.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

