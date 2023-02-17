Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F247BC636D4
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Feb 2023 08:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBQIsb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Feb 2023 03:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjBQIs0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Feb 2023 03:48:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B56604DD
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 00:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676623656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zj7ME0Zls97ljpljDJh+52JR4W0iO9sdC4iOpN3awy4=;
        b=ZzQYK9n5pP4juXboaZxeHK4Z3yFuZac8vHWD5SWjpJrDVSdDN2Z1GPMN66Q4a5/JGcncWH
        zM8IdEGjbhLFr1pdfu7yJLpCeH+wnjEs8HTxdgm3cQw04y7aEX0rajv08kioTji8RWRA9s
        pZVv5OqLNjlEHQXMm7MXezjAMM2TB/s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-140-xHt0CBqlO7CTVgyc3MYiTw-1; Fri, 17 Feb 2023 03:47:35 -0500
X-MC-Unique: xHt0CBqlO7CTVgyc3MYiTw-1
Received: by mail-wm1-f69.google.com with SMTP id o26-20020a05600c511a00b003dfeeaa8143so391678wms.6
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 00:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj7ME0Zls97ljpljDJh+52JR4W0iO9sdC4iOpN3awy4=;
        b=30IgfLMBkAvBvhpWZWKAgUjzW9p9MgGIdrSS5EsX4mZ6UDuZro3VZGKckyHZTeSzw9
         fno1j3wNoi8p0igWbwkkhZckt5twUuFGUwT53nH4gs0mSj1CB9jPXRKkDhIHKsjZjWKL
         /rEahZ+FMf0hX4VAx40zoKTkEXh5eWzJr3YymwML50bykN5IKmvD/glkjzX2E2ezcwqk
         HFagpkd+Gm9NJMVlp0EroP2zzangGPE7hJXMPfjPG3Xmq7RW8pl4hrzjqeWcz/GMwbaC
         RHyC4i9K2OINDWYWApa040rk7AqJ4it2ubbosvGqgOLBcpBD+VeLBqjG3iJDqo1t3Bob
         iapw==
X-Gm-Message-State: AO0yUKULYWp2roOmMCEJn6MGcMi9UYyHuw8pdW9Ob/4+4GRvHesw643p
        qgZ3pkH7M2rofohlq5YKGiMBYYNg4jDWgWaFfXvaO5xMAuLc4EMMc3RED5rud0y4WiqikTk7h9z
        22q6LBaIVboNbfU/vaU2f5hk=
X-Received: by 2002:a05:600c:1f06:b0:3dc:3b29:7a4 with SMTP id bd6-20020a05600c1f0600b003dc3b2907a4mr3949707wmb.0.1676623654732;
        Fri, 17 Feb 2023 00:47:34 -0800 (PST)
X-Google-Smtp-Source: AK7set8S21a9xd9g881WvJoZPdWpHm1HFt5AhnZt79SXVbCgeie8WxKuAJO0erg8jgYguXWLyobjnA==
X-Received: by 2002:a05:600c:1f06:b0:3dc:3b29:7a4 with SMTP id bd6-20020a05600c1f0600b003dc3b2907a4mr3949692wmb.0.1676623654489;
        Fri, 17 Feb 2023 00:47:34 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bh25-20020a05600c3d1900b003dc5b59ed7asm4471660wmb.11.2023.02.17.00.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 00:47:34 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        geoff@infradead.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 05/11] fbdev: Read video= option with fb_get_option() in
 modedb
In-Reply-To: <20230209135509.7786-6-tzimmermann@suse.de>
References: <20230209135509.7786-1-tzimmermann@suse.de>
 <20230209135509.7786-6-tzimmermann@suse.de>
Date:   Fri, 17 Feb 2023 09:47:33 +0100
Message-ID: <87y1owwue2.fsf@minerva.mail-host-address-is-not-set>
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

