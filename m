Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D3FC6FD18
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Apr 2023 16:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjDYQsP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjDYQsO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Apr 2023 12:48:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F30A16F1A
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682441251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CUYVoYgihNiWk8z2Sv79/ruxO339axDQR6J4y/OWdcA=;
        b=dZ9rC6pfPrgI3Kc1u07+WJavIODCa6uBGKwGx84vL3W4cvkLNucP9OJ8YdXVPxs9Nxl0CH
        YPyicn/HCHfv5kTkj9sg5F5JEVg+vIrXaGq+Q8bq2zFK0DkChHYJd/QigyGsnINs6WSC2O
        SOY7MksMm/PrCttUl6j8/iBTmv6SmA0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-j_s52PlXMtKelcX6zzgXMQ-1; Tue, 25 Apr 2023 12:47:29 -0400
X-MC-Unique: j_s52PlXMtKelcX6zzgXMQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f08901fed3so36242655e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 09:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682441248; x=1685033248;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUYVoYgihNiWk8z2Sv79/ruxO339axDQR6J4y/OWdcA=;
        b=C0hOf4pz1IklMbnqFT1edq3i/jzWkXelMlvYJutO6xqUWteiqIcsOqv/n5M75oQBuq
         XtLd1kvM0q4nEEdeX5YQIzvTy7PvtIHlwmRoc1VNHQlvQUVU3HNKsiPsUUKB5Cu8oVvi
         ffA4tV8WLXVRNjuFwHEsuYPesjB6Ol/n/1H8I9bp4uZo8d/+gh5e0hj1HtwummZbpl1R
         Q3kL43l9ARuWUj5HDUu8R2vygfs4CXI4bMzF8G4EWR3BI6/yD+1APh8pfAVvapqusV1G
         kHERMM/Scrdy49CUqVsGzD+RyqiH8QRa+f82SHJze2LBjatcverv49Eg6DfGN54jP4ad
         Ldsw==
X-Gm-Message-State: AAQBX9duIyFUP4/NTsNzhXyMStz299IIzxEDxvRBDed05uSCPAbX2ziz
        6EIEkyjSGNJSmmCv2JWiTvttbMwC+ipPaucApZmozmzkYNq9pggR6WUcHAhbOECcivH5NcSpJQf
        OAjaBr9R3znEDQoBLss3M2S8=
X-Received: by 2002:a1c:7310:0:b0:3f1:8af9:55ae with SMTP id d16-20020a1c7310000000b003f18af955aemr11827252wmb.18.1682441248394;
        Tue, 25 Apr 2023 09:47:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350ap3hB79kNxuIe8gJOkpVZj6XwdRmtAykbm9wMpx1kLVHGn9VQ09MhidQrGjJ27teef0EJLZQ==
X-Received: by 2002:a1c:7310:0:b0:3f1:8af9:55ae with SMTP id d16-20020a1c7310000000b003f18af955aemr11827232wmb.18.1682441248086;
        Tue, 25 Apr 2023 09:47:28 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t12-20020a5d690c000000b002f74578f494sm13534510wru.41.2023.04.25.09.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:47:27 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 5/6] fbdev: Move CFB read and write code into helper
 functions
In-Reply-To: <20230425142846.730-6-tzimmermann@suse.de>
References: <20230425142846.730-1-tzimmermann@suse.de>
 <20230425142846.730-6-tzimmermann@suse.de>
Date:   Tue, 25 Apr 2023 18:47:27 +0200
Message-ID: <871qk7j4dc.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Move the existing CFB read and write code for I/O memory into
> the new helpers fb_cfb_read() and fb_cfb_write(). Make them the
> default fp_ops. No functional changes.
>

It would be nice to get an explanation here about why moving these
make sense. I guess you are doing this because is going to be used
in DRM but still would be good to explain it in the commit message.

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

