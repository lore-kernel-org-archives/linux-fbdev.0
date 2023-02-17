Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A657BC636D4
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Feb 2023 08:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjBQIrL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Feb 2023 03:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBQIrL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Feb 2023 03:47:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1015F279
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 00:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676623584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zj7ME0Zls97ljpljDJh+52JR4W0iO9sdC4iOpN3awy4=;
        b=JMf7EBFhZjUjJD+bV91DGj1t50LNFDbJwA6WXf7n/5WCK/cDSFiKRA30qcT8qSvjTBd8WP
        xQX9ILqoV98MuSWn3FEjUhQ17N7YEOBaFRoxPYdDLQkCMOtJ600EjqZnCayGCQcx5QZsQM
        nf/KdGorYXAFATdp4cBhyu+Li/ORVDI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-375-7UBSIvSRMHyqhorBWAHniQ-1; Fri, 17 Feb 2023 03:46:22 -0500
X-MC-Unique: 7UBSIvSRMHyqhorBWAHniQ-1
Received: by mail-wm1-f70.google.com with SMTP id az3-20020a05600c600300b003e10bfcd160so281339wmb.6
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 00:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj7ME0Zls97ljpljDJh+52JR4W0iO9sdC4iOpN3awy4=;
        b=ongvNu4J3hJHPk3wqubPefYGggtbJmY+vjLu/cde5l6Skc291akNoJWBln/oXasOkP
         ZUQSMgtDrDKNH8NU4kCB6NAhhbYXYPhk+oOKGpbnI+GHe7wpmoXrs/HV81Z4yDL3gGyt
         BKUbuu1GWsSQacrpE8Ke8xQeTHW4rl8Sm7M5u83PVF6DG/y/2mXPNt9HN0G42gmb10mr
         I95LobyX6qGDsC2iyCDvUEoSxjNGuFLSs13eQFKJMoXF2345KFYnItyHYLAXGxjXNTAZ
         knY472RIFfgn3I9slJ+n+PgQARwc5jVlGYq9+erW3uknSqh9KVeBPikBAmNdlCYGqLVE
         xv/A==
X-Gm-Message-State: AO0yUKU6COGf1vtdTAlXNTvnhV31ZRt98rtKprE4yWX5D9ih2TKHoYsy
        nQGrA8XrGu0E90t9LZRQn/wppzDGOtTxJb8XPRp1nPaV4EDBY7Gvld7luDsxC3jLTesUbycHnoQ
        AB/9pIbiVaO4KGWfRNXMjq8U=
X-Received: by 2002:a05:600c:4d8a:b0:3e2:115f:4052 with SMTP id v10-20020a05600c4d8a00b003e2115f4052mr3403434wmp.17.1676623581799;
        Fri, 17 Feb 2023 00:46:21 -0800 (PST)
X-Google-Smtp-Source: AK7set9+hq4+2Bza33qEvtq4Ut8E7x8aQSr+iMyJJkN2Oiss1vlbpJK+6bKPo4cnPxZn5QWxBOW1Dw==
X-Received: by 2002:a05:600c:4d8a:b0:3e2:115f:4052 with SMTP id v10-20020a05600c4d8a00b003e2115f4052mr3403421wmp.17.1676623581539;
        Fri, 17 Feb 2023 00:46:21 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c1d9100b003e21dcccf9fsm2587825wms.16.2023.02.17.00.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 00:46:21 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        geoff@infradead.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 04/11] drivers/ps3: Read video= option with fb_get_option()
In-Reply-To: <20230209135509.7786-5-tzimmermann@suse.de>
References: <20230209135509.7786-1-tzimmermann@suse.de>
 <20230209135509.7786-5-tzimmermann@suse.de>
Date:   Fri, 17 Feb 2023 09:46:20 +0100
Message-ID: <871qmoy90j.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Get the kernel's global video= parameter with fb_get_option(). Done
> to unexport the internal fbdev state fb_mode_config. No functional
> changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier

