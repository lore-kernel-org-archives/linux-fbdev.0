Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAA3C7EE2E
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 09:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbjFGJNk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbjFGJNI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 05:13:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFCD271C
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 02:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686129078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mH0V+GQH9u3hTOintFl8kIUIu94Srk8ZL012Xjzg5pc=;
        b=WvbcGYu6FP6Lt1P5LgqBBZfIPTFVLMlIt5SHTmzJMA2RASbYF8kkueXZx86n28ZNnmfGb6
        6Mp0+uULma8HsW3KzNoeqhbxN2cuzEcC/e1acZ49MdCIpe2WW9k7tP2B+YT39JAjISikTB
        rdMZCfXiK8ekvjZmdecEbUjvdDppaSc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-ROomcxxDMQWPBPjcUVY8Jg-1; Wed, 07 Jun 2023 05:11:15 -0400
X-MC-Unique: ROomcxxDMQWPBPjcUVY8Jg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30c5d31b567so2534919f8f.2
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 02:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129074; x=1688721074;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mH0V+GQH9u3hTOintFl8kIUIu94Srk8ZL012Xjzg5pc=;
        b=e+nXahKujZp2R1MNaRp/FbNC67WmkAOeJGdULJu9+FrPtbPrf+cSx2nRIZiFx4v5sw
         bhIbejpVNib15jiiFg8oMAk2MDEdXQ9kG/O9KkGayuQOlcy1POSJQqexs9unxyRG9cxw
         jSE+Lkzw+Zpz7gIuXp0YJGdMSbKHf1Qfg1T0g/bw3okiJvuzCr4yGCd6DnNyBlpYJp6S
         pIs/c1WbgWPmU9C6v93yPkRd+hTEaq9njzxbg+dPYLafFGL4e0Wb3ttBteHuISmr8Oxf
         Ija6J4f+2F9OgBhzpY3ouO6jIu2xbY/1mHXgic9lS7wKeL7GtvMfc2ttCxjcS5H8pugE
         KvWA==
X-Gm-Message-State: AC+VfDx2pv5b4jeUXP+jl5ilQ33dXFTX1BUZqa8HHdYLC3XO8V9B1pjN
        dtGxglgbUCOpw0TzZOSGNIvjYVYQ6o1JEvGh5bGMFyJK5evsU/zAjtsvLHyQdJ8ArurrnpQR86E
        S+O1PhdhpUf9m8IieABMhKkw=
X-Received: by 2002:adf:e688:0:b0:30e:32b4:88b1 with SMTP id r8-20020adfe688000000b0030e32b488b1mr3941826wrm.9.1686129074281;
        Wed, 07 Jun 2023 02:11:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4KJfeyDxYfcACaVW0UaN5JNsg10BzGoz+FuMEljUH8CXhTXkm2kLiaHaEUmQ35VeCWg/34qw==
X-Received: by 2002:adf:e688:0:b0:30e:32b4:88b1 with SMTP id r8-20020adfe688000000b0030e32b488b1mr3941796wrm.9.1686129073975;
        Wed, 07 Jun 2023 02:11:13 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b003f735ba7736sm1412543wmr.46.2023.06.07.02.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:11:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>,
        linux-sh@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 19/30] fbdev/rivafb: Reorder backlight and framebuffer
 init/cleanup
In-Reply-To: <20230605144812.15241-20-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-20-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:11:12 +0200
Message-ID: <87ttvjeixb.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The driver's backlight code requires the framebuffer to be
> registered. Therefore reorder the init and cleanup calls for
> both data structures.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Antonino Daplas <adaplas@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

