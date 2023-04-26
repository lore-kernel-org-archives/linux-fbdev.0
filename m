Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DC3C7618E
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Apr 2023 15:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjDZPPn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240843AbjDZPPm (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Apr 2023 11:15:42 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994D55B9C
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 08:15:36 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-b95c3b869dcso25949898276.1
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 08:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682522135; x=1685114135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEbIcZJtfd2cyasYqmk3KyrhQ3V2aqqNCk4M1P2Bd3w=;
        b=g30IPym0yTLttSqC6OcKxnzdP8TDJGMeO3dMk9ZoHmhP6DxhLPLLyWm5RpOf3glEc2
         ouYgf0GCJct/LScOxpAfGRC577YqAFHUGq/QOJ4xJovw61VK8m6F3AJbJL1oKny8lOPe
         4BwUMWuBWu5xTQAnN+b4Gsa+HPQlmwY7RKYSee7ZtNHSwH/+G347xXCwRvGb4PxQwzOV
         wUk6KKMYj37idwP+d0DJpzHpIaBMRXT6xBa9QM6pOf/GCDAQKjCDVn0a2NIdA65PyYI1
         AAVi97uEZT6nXVZPxYrT6qxgl4k/7YvG0JVNhHfBSxft8gYMTPgHB8gJN5NUoIsqf12N
         /Ecw==
X-Gm-Message-State: AC+VfDx7gscD28ChqjhgoiaZuqDZhJKWXRCCnNwE1KxtyzlK8sPKrCJj
        S2g96jrEx23lcWQEgbGOufXOhqPnbV2dqw==
X-Google-Smtp-Source: ACHHUZ6Ca4bjL+TEJ1sINbSbapHl++Xil9BPz2yBpe4GQn1iRvCdZtR+NHyRaNg3pEuoKjkClW2Www==
X-Received: by 2002:a81:f4b:0:b0:552:a4af:da with SMTP id 72-20020a810f4b000000b00552a4af00damr1909021ywp.10.1682522135289;
        Wed, 26 Apr 2023 08:15:35 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id h190-20020a0dc5c7000000b00545a08184f8sm4247148ywd.136.2023.04.26.08.15.34
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 08:15:34 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-b992ed878ebso23922138276.0
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 08:15:34 -0700 (PDT)
X-Received: by 2002:a81:19cf:0:b0:54f:6aa3:f167 with SMTP id
 198-20020a8119cf000000b0054f6aa3f167mr1846583ywz.12.1682522134174; Wed, 26
 Apr 2023 08:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230425142846.730-1-tzimmermann@suse.de> <20230425142846.730-7-tzimmermann@suse.de>
In-Reply-To: <20230425142846.730-7-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Apr 2023 17:15:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDRB8kyLb39rku2FJ3uKid__O=jmBXJ_85cct1zFkaYA@mail.gmail.com>
Message-ID: <CAMuHMdWDRB8kyLb39rku2FJ3uKid__O=jmBXJ_85cct1zFkaYA@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/fb-helper: Use fb_{cfb,sys}_{read, write}()
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
> Implement DRM fbdev helpers for reading and writing framebuffer
> memory with the respective fbdev functions. Removes duplicate
> code.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c

> @@ -816,21 +727,10 @@ static ssize_t drm_fb_helper_read_screen_buffer(struct fb_info *info, char __use
>  ssize_t drm_fb_helper_sys_read(struct fb_info *info, char __user *buf,
>                                size_t count, loff_t *ppos)
>  {
> -       return __drm_fb_helper_read(info, buf, count, ppos, drm_fb_helper_read_screen_buffer);
> +       return fb_sys_read(info, buf, count, ppos);
>  }
>  EXPORT_SYMBOL(drm_fb_helper_sys_read);

I guess drm_fb_helper_sys_read() can just be removed?

> @@ -849,7 +749,7 @@ ssize_t drm_fb_helper_sys_write(struct fb_info *info, const char __user *buf,
>         ssize_t ret;
>         struct drm_rect damage_area;
>
> -       ret = __drm_fb_helper_write(info, buf, count, ppos, drm_fb_helper_write_screen_buffer);
> +       ret = fb_sys_write(info, buf, count, ppos);
>         if (ret <= 0)
>                 return ret;
>

drm_fb_helper_sys_write() cannot be removed yet, because it does damage
handling below.  If the fb_ops.fb_sync() callback would be enhanced to pass
a region, drm_fb_helper could implement .fb_sync() instead of .fb_write().

Likewise for the "cfb" (which is a misnomer) variants below.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
