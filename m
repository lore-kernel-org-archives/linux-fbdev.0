Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F686C05027
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Feb 2023 08:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjBQIqE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Feb 2023 03:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBQIqC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Feb 2023 03:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C7D5F839
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 00:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676623516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OWPvyQo5Di8DnoAQZc3ZeTCHhUwyb2tH6aRDiwDRUPc=;
        b=MVeGxsM4tX/q8LwZI/5ATyTS0oeogyPcFsBxiYHjlfHjK28gTVp7WbNRvTmamHMmEnUw4H
        IzFYoqCpibN+7FaSw2UO7NuQtrighUHtaAi+gl00UaqN0YntpjQIv2yaNg72uOOrXViRjz
        vFqy6yTdn5m6Abf6fEcvo6Yw2rdX7s8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-39-2N_i2wU_N-Of90o-bqzGLg-1; Fri, 17 Feb 2023 03:45:07 -0500
X-MC-Unique: 2N_i2wU_N-Of90o-bqzGLg-1
Received: by mail-wm1-f72.google.com with SMTP id l36-20020a05600c1d2400b003dfe223de49so418224wms.5
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 00:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWPvyQo5Di8DnoAQZc3ZeTCHhUwyb2tH6aRDiwDRUPc=;
        b=Vb4GtNmY0Xo+q7cBVn/f3T2AUb84uVJ+uZ/6XsBEyk0IQzwqkvqcxk5l8d7i8hp2GC
         63BNKHAOnNmMw26Fbkyuya+Yd7aoYoGBl2vr+ZqkVlwa2LOtI9wajYcEvt9Ep+1Z3V90
         g8dHrRtSquXqA7wCiGZnapwtfX8VtIw9LI4d6tMGcRRZuJAliiPxN0qCv4nzMyWEPwk+
         Vyx0L+QIDI/ej5jiA2Umm3hokx36A2Y66Y/450A3pFzM6HvDtCzAkP3AKFrl8geAvOXq
         yGZDJ9f99Iz59qMWNFT8mZSCZG3VfXgxcbOTsGmbPHU4l1yxWehuQB4hmNVM9+KBCKT0
         mzrA==
X-Gm-Message-State: AO0yUKXDyFYgEolDkyP5IuvG3B3h9iiPXs8jJzIJpOe/bBdV+zfhmuE/
        tFQVfEXUsS9nRtJRjCp3MSVakpH2K9WnD99vMpO6m+s/7OESDIs8l7VU/8/eNBB6EcFjfKNQ17n
        qnys+hoM8Ol7zYqRPTgG10cg=
X-Received: by 2002:adf:f78c:0:b0:2c5:48b9:72ff with SMTP id q12-20020adff78c000000b002c548b972ffmr6450610wrp.27.1676623506496;
        Fri, 17 Feb 2023 00:45:06 -0800 (PST)
X-Google-Smtp-Source: AK7set+ur2aLbFCoXfxBM8gyiXnFXtYx7YTDiuItlpgrcu7ssIQYB1jqId9yQOYwAKFhH5jVOwxbag==
X-Received: by 2002:adf:f78c:0:b0:2c5:48b9:72ff with SMTP id q12-20020adff78c000000b002c548b972ffmr6450601wrp.27.1676623506241;
        Fri, 17 Feb 2023 00:45:06 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v6-20020adfedc6000000b002c5544b3a69sm3552710wro.89.2023.02.17.00.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 00:45:05 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        geoff@infradead.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 03/11] fbdev: Support NULL for name in option-string lookup
In-Reply-To: <20230209135509.7786-4-tzimmermann@suse.de>
References: <20230209135509.7786-1-tzimmermann@suse.de>
 <20230209135509.7786-4-tzimmermann@suse.de>
Date:   Fri, 17 Feb 2023 09:45:05 +0100
Message-ID: <874jrky92m.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Ignore the per-driver video options if no driver name has been
> specified to fb_get_option(). Return the global options in this
> case.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

I think you need to update the kernel-doc as well to mention that
@name could be NULL ?

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier

