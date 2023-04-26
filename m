Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A21BC77B7C
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Apr 2023 14:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbjDZO4c convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240791AbjDZO4a (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Apr 2023 10:56:30 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0698830FC
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 07:56:30 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-552d64d1d2eso87632357b3.1
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 07:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682520989; x=1685112989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XCTcDbpPB/liGF983vey6mh6nUAjd3zqT7KMY+SE1g=;
        b=Z46MhZ7S8dri6g9jPJ5ZdnKt2kAFr/OX57YxfUjEDE1jw60cFSXBGGS+ch48+xUlMN
         1AezBp/fno+MLOvwFweX1j/M14qvwNDaLuH5Suum2RwY7rkGr0B0KRGdf3XzffNDHN7O
         IeSjTNoznD4xEf3B+MkZDu7CUYKe63c34Rzujd8aHLHuJi7CG4MILzLIS5k02Dg0w/H5
         D7kCBMguyWBPN5M4qvXa3uu8b+jEUTE/oajTPHvVg7DPOzEn9EcbyFQWYMgXXZqO7t5I
         EWMmwuFsiWlW93kXKwZwvPEz/nh4bLr7tRVJpwMiFe31rcjAG4UG5CWVK9paSTefw7CB
         41hA==
X-Gm-Message-State: AAQBX9ffSgUeRJ2dJvCHg5adGWlDGh5sP/le9I38ZtL5ftmsMPi3bzLF
        qYweXW9LN4Zi9gdvmTMAoZqN2jdZQuDbNw==
X-Google-Smtp-Source: AKy350ZyasFjkeWTDX9aze4wBqgKVBRMJAB31Zya1pHKUPoL0AEIYAEBF+I9lG2cxKdQVC3PfXoo7g==
X-Received: by 2002:a0d:d84a:0:b0:54f:8c00:58e7 with SMTP id a71-20020a0dd84a000000b0054f8c0058e7mr11950143ywe.48.1682520988526;
        Wed, 26 Apr 2023 07:56:28 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id d79-20020a0ddb52000000b0054fa1fbda6fsm4187554ywe.25.2023.04.26.07.56.27
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 07:56:27 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-54f9b37c634so87509977b3.2
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 07:56:27 -0700 (PDT)
X-Received: by 2002:a0d:fc46:0:b0:54f:b133:b2d with SMTP id
 m67-20020a0dfc46000000b0054fb1330b2dmr14383489ywf.26.1682520986826; Wed, 26
 Apr 2023 07:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230425142846.730-1-tzimmermann@suse.de> <20230425142846.730-5-tzimmermann@suse.de>
In-Reply-To: <20230425142846.730-5-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Apr 2023 16:56:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX8A_5Kd_D4qQfmYLbECekLWHFzrcK-xMTeyBaz=T_a-A@mail.gmail.com>
Message-ID: <CAMuHMdX8A_5Kd_D4qQfmYLbECekLWHFzrcK-xMTeyBaz=T_a-A@mail.gmail.com>
Subject: Re: [PATCH 4/6] fbdev: Validate info->screen_{base,buffer} in fb_ops implementations
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        deller@gmx.de, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,


On Tue, Apr 25, 2023 at 4:28 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Push the test for info->screen_base from fb_read() and fb_write() into
> the implementations of struct fb_ops.{fb_read,fb_write}. In cases where
> the driver operates on info->screen_buffer, test this field instead.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!
You forgot to mention why it is a good idea to duplicate this in all
the implementations, instead of doing it once in the core?

>  drivers/video/fbdev/cobalt_lcdfb.c     |  6 ++++++
>  drivers/video/fbdev/core/fb_sys_fops.c |  6 ++++++
>  drivers/video/fbdev/core/fbmem.c       | 10 ++++++++--
>  drivers/video/fbdev/sm712fb.c          |  4 ++--
>  4 files changed, 22 insertions(+), 4 deletions(-)

Aren't there more fbdev drivers to fix, before you can move the checks
in drivers/video/fbdev/core/fbmem.c?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
