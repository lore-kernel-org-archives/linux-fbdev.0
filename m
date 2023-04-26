Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D714C77B78
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Apr 2023 14:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDZOuL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbjDZOuK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Apr 2023 10:50:10 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6044EF3
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 07:50:09 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-54f8e823e47so82136187b3.2
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 07:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682520608; x=1685112608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWcjXDUPKLzWemqJDhq5l62EqMdBCWgt6RFaH5quzXc=;
        b=WUcCtj1rG6pHWR4eEpgOBXvz1/5fA1AG4uQtzBJa9fmm2ydtkmKuP6SNnXp1wmSIr7
         CJbaLkR2LxgvetWP164+Xgbvb41VGVuIvRCTNTuBF+FQri7YPZPgwp2BNW0FFhVtl51p
         EiE63Rak5syMPieXp/SuBaiCOMK7NVOBWauUQBnhAcSuELSnS9UrqHo5c/YcIcXCEr2R
         I+iEJzM7kcTZGkOVuU6VLl1OILZ5o1wXKo7QZ1RHY+PM9IQ/GtnNDaPgkfNw1BobYiqY
         k+a/JsHiTDvxjFByDOq74roK7XHuhSBykzqu23Xwp1RUoAg8iHQTKS5eFEKDOO31gkoC
         dfhg==
X-Gm-Message-State: AAQBX9ceysOcKAAB9b/lun163NAVQyNsb6zIggPBK/G/XF0YtV4MLxYV
        nvgm2SmHyCVq8KsgKYMhk0eCsCPNk9kJWQ==
X-Google-Smtp-Source: AKy350bFdV5FpnoGvDdk1hNIHc/iw//JopDFoDN41ZrhlTqu7LEOjNHQfsI+h+n3l52tr9Hgkza+5w==
X-Received: by 2002:a0d:cc83:0:b0:54f:bec1:c118 with SMTP id o125-20020a0dcc83000000b0054fbec1c118mr14166210ywd.38.1682520608260;
        Wed, 26 Apr 2023 07:50:08 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id i66-20020a0df845000000b0054601bc6ce2sm4240383ywf.118.2023.04.26.07.50.06
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 07:50:07 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-b99e10f1c4cso4220853276.2
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 07:50:06 -0700 (PDT)
X-Received: by 2002:a81:6c0d:0:b0:556:1070:7c60 with SMTP id
 h13-20020a816c0d000000b0055610707c60mr13905263ywc.18.1682520606754; Wed, 26
 Apr 2023 07:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230425142846.730-1-tzimmermann@suse.de> <20230425142846.730-4-tzimmermann@suse.de>
In-Reply-To: <20230425142846.730-4-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Apr 2023 16:49:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmPHge3jXxx4_OMAjfvnk70C=TZzxOUGceFOimj7fG=A@mail.gmail.com>
Message-ID: <CAMuHMdWmPHge3jXxx4_OMAjfvnk70C=TZzxOUGceFOimj7fG=A@mail.gmail.com>
Subject: Re: [PATCH 3/6] fbdev: Don't re-validate info->state in fb_ops implementations
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
> The file-op entry points fb_read() and fb_write() verify that
> info->state has been set to FBINFO_STATE_RUNNING. Remove the same
> test from the implementations of struct fb_ops.{fb_read,fb_write}.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

>  drivers/video/fbdev/core/fb_sys_fops.c | 6 ------
>  drivers/video/fbdev/sm712fb.c          | 6 ------

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

But there are several other fbdev drivers to fix:
drivers/media/pci/ivtv/ivtvfb.c
drivers/video/fbdev/broadsheetfb.c
drivers/video/fbdev/hecubafb.c
drivers/video/fbdev/metronomefb.c

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
