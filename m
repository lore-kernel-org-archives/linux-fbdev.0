Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F41EC83F2C
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Sep 2023 13:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbjIDN2Q (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 4 Sep 2023 09:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjIDN2N (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 4 Sep 2023 09:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9318E6A
        for <linux-fbdev@vger.kernel.org>; Mon,  4 Sep 2023 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693834031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxZkq0it8hCbAJaaXiECPzcax9Qu561b49DP/zFJ1B0=;
        b=Gg2/rTw+XSJPqQA5/o/52sRSPkFMP1K2Nz3DDkChf/2+7Bt7+m38Jm/fs56Ia2R6rAGSNM
        dG7fxWguT8LcT/3wB3UBYktZTDRXJ4vE5S7B/CnS1ZO5Qk1ov2UlwhN/Jb0OWI8+MW+HDF
        6oXM4Yggetwz39lUGP2LWrpJ6i2LQgM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-t7Ly2JdvNiGLgIQb8LeaCw-1; Mon, 04 Sep 2023 09:27:10 -0400
X-MC-Unique: t7Ly2JdvNiGLgIQb8LeaCw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31c5c55fd70so640921f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Sep 2023 06:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693834029; x=1694438829;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxZkq0it8hCbAJaaXiECPzcax9Qu561b49DP/zFJ1B0=;
        b=BHO4zoDohaz+7lT3DuSXVfJ6udPxDdI3U+NmPgyZ/TdHkjoZWG3JM1cnLgZfTly4JM
         BZSiTPPm/M25LEJx4osok/gbyJibnEx4PF45JQAnxbH0IvEXwJ3HsIxDAM0Ach14eVvh
         b5pZajDjIWk7t1zMTO7IYayiJ6SpXnY30liq/WIWfInP4o8tlU+BsNua63h7hgHmemP5
         eT5nQfedJvn2TlnLVBD09wPqsORV5gS6SmdXZINbjpZVFdyUp0VvtTypFSb+8rtOvtvj
         E5bSnF87JjzbAvxW3xiDzOt3mMz2MCtp+BwpvMelOzxN4XYYBVK+1uAcdyYE2mr+taWk
         pGeg==
X-Gm-Message-State: AOJu0Yx38VE0QHqJk1n7uDc+wR4WTFrDAWsNny0Z9ZNVWBYqPNCPVqcT
        8sCAblDz+vLRo0PHG/dXZSizRrT90Wy28AgKKlaUAqj4eu6/KmcNHVJWgRrTwNIaCsSuJNs5X6/
        1d/DSPiJTAGrv7sHi30RWIn8=
X-Received: by 2002:a5d:4612:0:b0:317:ce01:fe99 with SMTP id t18-20020a5d4612000000b00317ce01fe99mr7234101wrq.9.1693834029681;
        Mon, 04 Sep 2023 06:27:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaqwNGWlc6zhQO+ObluvLtHBcvGlX5RhgjUyBHLBy+K84UjEg1PZVnv6fvBEAk50QZ/mL+mA==
X-Received: by 2002:a5d:4612:0:b0:317:ce01:fe99 with SMTP id t18-20020a5d4612000000b00317ce01fe99mr7234089wrq.9.1693834029373;
        Mon, 04 Sep 2023 06:27:09 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y1-20020adff6c1000000b00317a29af4b2sm14399476wrp.68.2023.09.04.06.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:27:09 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bruno =?utf-8?Q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 6/8] hid/picolcd: Use fb_ops helpers for deferred I/O
In-Reply-To: <20230828132131.29295-7-tzimmermann@suse.de>
References: <20230828132131.29295-1-tzimmermann@suse.de>
 <20230828132131.29295-7-tzimmermann@suse.de>
Date:   Mon, 04 Sep 2023 15:27:08 +0200
Message-ID: <87a5u2cbmb.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Generate callback functions for struct fb_ops with the fbdev macro
> FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS(). Initialize struct fb_ops to
> the generated functions with an fbdev initializer macro.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: "Bruno Pr=C3=A9mont" <bonbons@linux-vserver.org>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

