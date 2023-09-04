Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7118EC88CB2
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Sep 2023 13:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjIDNZt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 4 Sep 2023 09:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjIDNZs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 4 Sep 2023 09:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AA5CF6
        for <linux-fbdev@vger.kernel.org>; Mon,  4 Sep 2023 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693833896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xPaq3CuDZRpQmuDqucr0HZhD9ZzK56uaUpku88i4nOk=;
        b=OQVg5s8TUYNUhczp7b+AX7o0osHbI7hvP83FPdfMdrUXxScedWqOVc5gYQVi9SM7Fi1syp
        JY32+6CzutwCS7qtkpupDrRs2FPj9ODHEKnIsw40+GC415HbEPP51bR1+B1wmtVfTmK1rH
        v5uOgJV7kXqewAW3Luk+DKeit2e0M4k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-RG6nhWW5O0qlniGZTVyQmg-1; Mon, 04 Sep 2023 09:24:54 -0400
X-MC-Unique: RG6nhWW5O0qlniGZTVyQmg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-401c19fc097so8953855e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Sep 2023 06:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693833893; x=1694438693;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPaq3CuDZRpQmuDqucr0HZhD9ZzK56uaUpku88i4nOk=;
        b=Vl/0m16JUvWx+u7x73Q+RzhxdUZYtZU4ttHiT2uRnJ2rYvhAu2kyjO2aVHlh9Ko8EK
         7zMPD2+ZzhmmpR7hLSLfA2Eq1s33/qV9vOHA0mcToQ2Hfwi+M7Xh6+UEIZDgUGDmTZk0
         nzjzzBAun1A33xjU9IExAFddgdvspq+OsHiJO0d8mVYdT+xW4y5cYVo3JqwIJOocecVX
         Y7KFHo4YSkt+Mxzsz0ijFQVDcTb7RLmBYhdiRhdV3jyAm8b5FYKYmqLyJdtbEs8rbXet
         PSgAcQzRyO40Yr3rgMRiEIWls9ZFaFLCsZHxHMD6BjD/0v3LzGI4APN9D87jNyickULq
         +R4g==
X-Gm-Message-State: AOJu0Yx2VzHzDMPxYYnUDxpdnqx5DQerg1cupJZaadcyQ9HQAM6B0y+m
        WNLBn/Fs8Rh/vrQbBjA3++5CskxRcWN5a0w0KOE/DvfI6XOw0nR1r0XJG9ReRnGzRlDMQ+eZOPi
        On6EKqh/nSPB9pVamkROd34w26lpEk9w=
X-Received: by 2002:a7b:ce18:0:b0:3fb:f0ef:4669 with SMTP id m24-20020a7bce18000000b003fbf0ef4669mr7620186wmc.17.1693833893703;
        Mon, 04 Sep 2023 06:24:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVceTFRRCJx3QEHC1v0Fwwk5gpR/JTxujmvjvpSbrcXuud5RQf6XSV8UmJ3S8NFK1PJ6NVpQ==
X-Received: by 2002:a7b:ce18:0:b0:3fb:f0ef:4669 with SMTP id m24-20020a7bce18000000b003fbf0ef4669mr7620172wmc.17.1693833893448;
        Mon, 04 Sep 2023 06:24:53 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bce0d000000b003fed630f560sm14111682wmc.36.2023.09.04.06.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:24:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 5/8] hid: Remove trailing whitespace
In-Reply-To: <20230828132131.29295-6-tzimmermann@suse.de>
References: <20230828132131.29295-1-tzimmermann@suse.de>
 <20230828132131.29295-6-tzimmermann@suse.de>
Date:   Mon, 04 Sep 2023 15:24:52 +0200
Message-ID: <87cyyycbq3.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix coding style in Kconfig. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

