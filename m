Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1ADEB8FB6
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Sep 2023 10:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbjIFKNb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 6 Sep 2023 06:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjIFKNa (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 6 Sep 2023 06:13:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D989E
        for <linux-fbdev@vger.kernel.org>; Wed,  6 Sep 2023 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693995161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xy4eWyuN+rU6FwER3ViJST19W+Gl/EjN/zwdPzrORYw=;
        b=ZaByALnCofLIpZxnbt0qsq+IHTzgJ5NjVpaIElOw7Gtv5MntuFMt8Su6y8p6gad5a2GZOP
        ZKK8AI0jL+gQApe+rYhDG7Ic0HcbvzhB8COTVAzLgyJriJV5J2UFlvJZQjPuvMcHXSQfMq
        eoPYpvsI9rHGE6AtGerP08DdMm6qiVs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-nzE9E2FZOim6TB3hcEVQsQ-1; Wed, 06 Sep 2023 06:12:39 -0400
X-MC-Unique: nzE9E2FZOim6TB3hcEVQsQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fef3606d8cso22277775e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 06 Sep 2023 03:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693995158; x=1694599958;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy4eWyuN+rU6FwER3ViJST19W+Gl/EjN/zwdPzrORYw=;
        b=Gzi0WkIg87Zhta47yKTMUR5W7X47qYPKjSHQDvLHYVAN0+8pCD/VT+YN/Vf2KI2Cna
         jI7jkieWO4JxglvnYTq3knOCryTCeFI2aC+gocb5oVaSFYHM3nmjpFHWHCaDFJq/DRu+
         WHn7nM3B2xKh47jB01O4+8TPLo2mhNgVIGMO3Qm7kikcmnaMR7ddrcuY13lWHreDye4O
         FgfZjP3TlUsqAtCIy2peLYUt+MrqPKLYBiw1EwibO5bVhHTyAEIlcdTW0jGrNu08jofV
         SXOiyFVNgBAskxv6tA3ukspX0WiIU3XZC6v6J/DllEvvd18dDpSIQjTFDK1sC0NyiM1z
         Yo0g==
X-Gm-Message-State: AOJu0YzQ1H5qQNL8utFuUPM6j+XZcEG1TzZlJL8HASWRHOehC6KKZfTE
        EpOfDlHQKEgnoLfpcBhz58WOCvJthdst3S3hEdg/JAW1uA2iJzprIW/kpoJtloOO41KstMZLI0U
        gtiht1gdDQQDh7KwmMzrqiAk=
X-Received: by 2002:a05:600c:21cd:b0:3fe:22a9:910 with SMTP id x13-20020a05600c21cd00b003fe22a90910mr1909280wmj.14.1693995158618;
        Wed, 06 Sep 2023 03:12:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcggVqQOJrShKfnNaPe4sc3f0Ds8yksigPQVjo0N6T3K/Fdg/hTediwZLUXkfmqjeXlqBpsQ==
X-Received: by 2002:a05:600c:21cd:b0:3fe:22a9:910 with SMTP id x13-20020a05600c21cd00b003fe22a90910mr1909265wmj.14.1693995158375;
        Wed, 06 Sep 2023 03:12:38 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d4b10000000b0031981c500aasm20073022wrq.25.2023.09.06.03.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:12:38 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 5/7] fbdev/core: Build fb_logo iff CONFIG_LOGO has been
 selected
In-Reply-To: <20230829142109.4521-6-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-6-tzimmermann@suse.de>
Date:   Wed, 06 Sep 2023 12:12:37 +0200
Message-ID: <87cyyv4nl6.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Only build fb_logo.c if CONFIG_LOGO has been selected. Otherwise
> provide empty implementations of the contained interfaces and avoid
> using the exported variables.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Ah! You are doing in this patch exactly what I mentioned in my previous
email :)

I would just squash this patch with #4, but up to you.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

