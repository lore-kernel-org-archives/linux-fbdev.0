Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1324FC7EE20
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Apr 2023 14:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241032AbjDZOmH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241449AbjDZOmG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Apr 2023 10:42:06 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4817280
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 07:42:02 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-b951f5e1b3fso5575836276.2
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 07:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682520122; x=1685112122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rK+iQZUdgtSnkZ6Lx2wX0WHKPwvzBDLIrvkOHQDhz8A=;
        b=TAUzBIUTSSs+Ny0jOvz0SkSHkzeQek5Qy6lsENXkMUe3WTZgck8zU1rwjpXMt/Hvcg
         aKoL8DiAKuBkYip+899+//zvI+vAovw/2NW3JCx4gUH7a0oCmWKRud8t1VY4MLEXpH9h
         bUEsYLk0Wu07/N+YALbf8DCMKgrSxcpIOxycrCKhnp+v1a9kUYuNpCHl73ttARj8s8/v
         2M0To8G1d3xRgPErIf2s4EzBlJFulhB3wOfobR1RQJJiL1LtaqUSEZ7z9fVyxoYyCvaH
         O3MkMkcEJPQRf6RTNVlko5oP/ekk60tvo5EiFLiusoWdEGrm3KA5zqYKGL6hnvrCC1k+
         rsgw==
X-Gm-Message-State: AAQBX9c5KuTdlznx6f/FH9iLWGEQiw0JKdssjuzo+AsDobV8UyJ8vsKP
        ZU540uqi8Dc5Yf+QGSAXM8p+DnxualYgZg==
X-Google-Smtp-Source: AKy350YITkbB0VFlN/TuGvwblMu9Jks9gn9XsCBYz47G+9zQy5Fgk+cyBWlNZoS992SZRz6fGKttuQ==
X-Received: by 2002:a25:cb92:0:b0:b96:cb0c:b904 with SMTP id b140-20020a25cb92000000b00b96cb0cb904mr17061565ybg.9.1682520121858;
        Wed, 26 Apr 2023 07:42:01 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id j4-20020a0dc704000000b00545a08184desm4211852ywd.110.2023.04.26.07.41.59
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 07:42:00 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5529f3b8623so55127687b3.2
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 07:41:59 -0700 (PDT)
X-Received: by 2002:a0d:db91:0:b0:501:611e:c6f8 with SMTP id
 d139-20020a0ddb91000000b00501611ec6f8mr13230025ywe.17.1682520119656; Wed, 26
 Apr 2023 07:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230425142846.730-1-tzimmermann@suse.de> <20230425142846.730-2-tzimmermann@suse.de>
In-Reply-To: <20230425142846.730-2-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Apr 2023 16:41:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUO3oC5+f9G=scwcySr17puO3ozrW746xcuhAkWGy8tg@mail.gmail.com>
Message-ID: <CAMuHMdUUO3oC5+f9G=scwcySr17puO3ozrW746xcuhAkWGy8tg@mail.gmail.com>
Subject: Re: [PATCH 1/6] fbdev: Return number of bytes read or written
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
> Always return the number of bytes read or written within the
> framebuffer. Only return an errno code if framebuffer memory
> was not touched. This is the semantics required by POSIX and
> makes fb_read() and fb_write() compatible with IGT tests. [1]
>
> This bug has been fixed for fb_write() long ago by
> commit 6a2a88668e90 ("[PATCH] fbdev: Fix return error of
> fb_write"). The code in fb_read() and the corresponding fb_sys_()
> helpers was forgotten.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Link: https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/fbdev.c # 1

Thanks for your patch!

> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -820,7 +820,7 @@ fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>
>         kfree(buffer);
>
> -       return (err) ? err : cnt;
> +       return cnt ? cnt : err;
>  }

Looks all good to me, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

However, shouldn't the copy_to_user() handling in fb_read() be fixed,
too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
