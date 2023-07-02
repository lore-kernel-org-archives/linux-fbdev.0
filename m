Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DC0EB64D9
	for <linux-fbdev@archiver.kernel.org>; Sun,  2 Jul 2023 10:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGBKU3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 2 Jul 2023 06:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBKU2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 2 Jul 2023 06:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AB71B0
        for <linux-fbdev@vger.kernel.org>; Sun,  2 Jul 2023 03:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688293181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CgQxeEa8jqCYUVhkKmhV5tOhyTakZG82kmCOFjxpLGQ=;
        b=SkWg1D5dfiGEhAnSVwSZu09k94bf9idMiK0beh+uQPdvM2L+utnPsybmkZASYFfWUfrd9V
        cfJ2rKZS7+LOQ+h05706cfS3PrCVHc1cDuGfZbgFDTNJ8u3qC0xFDmaFUaoU5IFMzGQhRK
        H1gG9jvAVm18rIHJPtLZ++/RQMcKRN8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-09CF0lVJPwqXfTSJXbK4MA-1; Sun, 02 Jul 2023 06:19:39 -0400
X-MC-Unique: 09CF0lVJPwqXfTSJXbK4MA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fb40d90456so14259925e9.0
        for <linux-fbdev@vger.kernel.org>; Sun, 02 Jul 2023 03:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688293179; x=1690885179;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgQxeEa8jqCYUVhkKmhV5tOhyTakZG82kmCOFjxpLGQ=;
        b=dAM6VPX08QPUo9zEJfAWKVVIOjZL9e0qK+HzoL43nTsUQCynKVBh95oKnZSyCH11Mt
         3NV8xD/ErFXQbxUIHpffp6SHxMn/1Pflbn7F+HEynCX4yZh6bY/g+8BGTIlGZ3rEK8Iq
         KMNuJ9tdSuv1Hb9zD6H1RbpbQv0cf/QHbJvjTX98oKzMBOfb0G3wM8iDXav/IT4h9WS+
         psuLaRijRSgcZa/g9h5WPiU5nV2HKZl9UxCrTfcIGIWw+xtuuszdlxtngyuh6d4Nlnn8
         ytbxe4yvFwIvrtUJxuoWS++KZNcllq99fqN5aUyg0cgiIcGp6YUFtx12EBkvbdiucYne
         Kq4w==
X-Gm-Message-State: ABy/qLZqVjYjSYQTCXbj9smbtXNyFA8YCS2Cl6SPa+vzA/XFDpjM2K0A
        S89602MgHM+ZDRJ+Yv/R0u9sJWQGTDv6z9Z7QDPRRJbEmP3VThT90Lwev1E1RBpK8UCKAzP15eK
        YphOr+6gHsAVHfs6gd2MwGB0=
X-Received: by 2002:a5d:6305:0:b0:314:c16:56a2 with SMTP id i5-20020a5d6305000000b003140c1656a2mr6649482wru.14.1688293178961;
        Sun, 02 Jul 2023 03:19:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlED9UAI+pN01OyAZSNkgl/k6bHCO5vXZ3hF4y0fd+CA4fhHoSTFMuvvTrZSJH9GgAxVfKoLzg==
X-Received: by 2002:a5d:6305:0:b0:314:c16:56a2 with SMTP id i5-20020a5d6305000000b003140c1656a2mr6649462wru.14.1688293178713;
        Sun, 02 Jul 2023 03:19:38 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d4111000000b003142eb75724sm2766867wrp.24.2023.07.02.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 03:19:38 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 1/2] fbdev: Split frame buffer support in FB and
 FB_CORE symbols
In-Reply-To: <CAMuHMdWLRBePox24kBHBMhzKWZX2ncXCD_8JBZrWcbwo0eBZ1Q@mail.gmail.com>
References: <20230701214503.550549-1-javierm@redhat.com>
 <20230701214503.550549-2-javierm@redhat.com>
 <393ca142-5226-4779-a963-c34fb0464c59@app.fastmail.com>
 <CAMuHMdWLRBePox24kBHBMhzKWZX2ncXCD_8JBZrWcbwo0eBZ1Q@mail.gmail.com>
Date:   Sun, 02 Jul 2023 12:19:37 +0200
Message-ID: <87pm5aaa4m.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Arnd,
>

[...]

>>
>> That would leave CONFIG_FB_DEVICE as the only user visible option
>> for DRM-only configs, which is slightly odd for the menuconfig,
>> so I still wonder if that could be done differently.
>>
>> Is there actually a point in configurations for kernels with FB=y,
>> DRM=n and FB_DEVICE=n? If we don't expect that to be a useful
>> configuration, an easier way would be to have CONFIG_FB turn it
>> on implicitly and instead have a user-visible Kconfig option
>> below CONFIG_DRM_FBDEV_EMULATION that allows controlling the
>> creation of /dev/fb*.
>
> Such a combination would allow the user to still have a text console
> on a legacy fbdev, while not having to worry about possible security
> ramifications of providing fbdev userspace access.
>

Exactly, it may be a possible combination. Not sure how useful what would
be in practice but we shouldn't restrict that IMO.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

