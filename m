Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B697C636D4
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Feb 2023 09:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBQJB4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Feb 2023 04:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBQJBy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Feb 2023 04:01:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3299661856
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 01:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676624448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B97UIS8ie9w9KzGcrCkLog9xnQRWw2knn3o4yQp4rpI=;
        b=Ehjb2094xhTOgt8TgC/jXo4imbipng3Y1uEDPKk2O1M/cyvj6rZpxhB7UTuycXGS6hP7NK
        44t3PTbMO5LyEQhdpi0r6f7Ohac1Ym2cJkGwK6lKDPui4lm7tY1AJihUPI0pxEB8MkQYqM
        y99hROoEVauDER9C9zidqrWRhh4z7co=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-3roDGXmiPP66tovT1LNL5Q-1; Fri, 17 Feb 2023 04:00:46 -0500
X-MC-Unique: 3roDGXmiPP66tovT1LNL5Q-1
Received: by mail-wr1-f70.google.com with SMTP id u1-20020a5d4681000000b002c3f54b828bso51711wrq.21
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 01:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B97UIS8ie9w9KzGcrCkLog9xnQRWw2knn3o4yQp4rpI=;
        b=5S1hsTYWJn5OHDxEBrx5svd8JGFFCKFPMMsVZxWMGhAPdfMRz/I7ay6e6fii6XItEv
         vw5ttkK4gjOgGw0H3F2YvxzaZTXk4O8NbbNC6jtMHwUlLUmrNhIi/sGEsy4FnNvhmAMf
         Nm2J9RK1+2z1N9xURrkEf6YMCTU44wNoeYYkilGJQJi3rheZx7EfgdZwovc/KI8BUegI
         ijQgfNzKpnHeRzZYsiTI4wwsFMTMzroJePS+wYEuRBR5xHVhQyJl0koxG+85Q4+mt0nA
         qhjqYR86vPAzlH4r2awKFiwMLRzc5NX1DYNxReUFY/d6ozkTsj3M+im+QPtcJyH7YlXM
         06tQ==
X-Gm-Message-State: AO0yUKWyRoJuasqVNRpTIbxNodS30Jb/Ik8+2g+CEcE3xkknZ5a+navb
        Iflf8bOj86W4Z/PO9l6gxA4VERmaeKGauq61VVbNj+zzkw/a3OJPoIQCcz/vxfLrtDMlIdH2GOM
        Iq2x/NdeNBvfD/Etiro6YR68=
X-Received: by 2002:a5d:5144:0:b0:2c5:5d1d:b244 with SMTP id u4-20020a5d5144000000b002c55d1db244mr7050956wrt.29.1676624445657;
        Fri, 17 Feb 2023 01:00:45 -0800 (PST)
X-Google-Smtp-Source: AK7set+GAEaS+cnDn75pZnbKNpaEwNXZM1nwMs4PYXOVZhHBD2pvwDjNBKmLaq3OkX/jJUVj+CLJgg==
X-Received: by 2002:a5d:5144:0:b0:2c5:5d1d:b244 with SMTP id u4-20020a5d5144000000b002c55d1db244mr7050941wrt.29.1676624445403;
        Fri, 17 Feb 2023 01:00:45 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f18-20020adff592000000b002c592535838sm3149086wro.2.2023.02.17.01.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 01:00:44 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        geoff@infradead.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 08/11] fbdev: Handle video= parameter in video/cmdline.c
In-Reply-To: <20230209135509.7786-9-tzimmermann@suse.de>
References: <20230209135509.7786-1-tzimmermann@suse.de>
 <20230209135509.7786-9-tzimmermann@suse.de>
Date:   Fri, 17 Feb 2023 10:00:43 +0100
Message-ID: <87pma8wts4.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Handle the command-line parameter video= in video/cmdline.c. Implement
> the fbdev helper fb_get_options() on top. Will allows to handle the
> kernel parameter in DRM without fbdev dependencies.
>
> Note that __video_get_options() has the meaning of its return value
> inverted compared to fb_get_options(). The new helper returns true if
> the adapter has been enabled, and false otherwise.
>
> There is the ofonly parameter, which disables output for non-OF-based
> framebuffers. It is only for offb and looks like a workaround. The actual
> purpose it not clear to me. Use 'video=off' or 'nomodeset' instead.
>

s/it/is

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[..]

> +#include <linux/fb.h> /* for FB_MAX */

I believe including <uapi/linux/fb.h> is enough here.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier

