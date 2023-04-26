Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428D7C77B78
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Apr 2023 15:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241226AbjDZPBr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbjDZPBm (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Apr 2023 11:01:42 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07B419BF
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 08:01:40 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-54fbee69fc4so83065377b3.1
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 08:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682521300; x=1685113300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InRK/SXUr8n9eTPGJfhjR3lsiyg7RVplSp0EEYbdwVU=;
        b=jacVlgvyq2Efk+1BjkHa6625qjVV2bKvv7Zh1OY2tTSl/jfeUlg8bsq3mQJWNxV/w1
         dhMRpQk5QUzXimngRlXqEoW8AJPgnYFLfySUZGqIo/cN4jBm2wLbLP/aMOM07trNL5Ef
         RbzZrmfcAIiSZ7QsvE5vRIvSXUYKPiQ7PrjZSZfzf4uHhMag4j/wkUol8oHmEqGWoDMD
         O5S739871Mama0Pcfl3YC6sMEmgbVAik1zG4+Gp51fUA8zK5ILWMG/vwCjCbQBAPuuP8
         t0xNYee0qDpzyBFaNtsWAyXcTFXOTGaiGQYDNBGE5RNKSIbArMdmuhQW4dtf+R5YjGQ9
         VQhw==
X-Gm-Message-State: AAQBX9fccocGZaxCPGTlvm/dGRm1wCu6DDjz9rodVRWKSruY2cRk0Naq
        LND1mb9lfjDC57iG/LSOUwNV977yA6Phvg==
X-Google-Smtp-Source: AKy350bJJkThPL5rB9hsCOgmhTobO+vIhfzqFEzNPBadbFgsTcmijMxqun69wPgyZWgIpKNutJCeig==
X-Received: by 2002:a81:4e8d:0:b0:540:c99d:efc1 with SMTP id c135-20020a814e8d000000b00540c99defc1mr13191349ywb.35.1682521299606;
        Wed, 26 Apr 2023 08:01:39 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id b129-20020a816787000000b0054fb2ab8782sm4248412ywc.50.2023.04.26.08.01.38
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 08:01:38 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-555c8a12b26so83551317b3.0
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 08:01:38 -0700 (PDT)
X-Received: by 2002:a81:7104:0:b0:54f:b6af:ac15 with SMTP id
 m4-20020a817104000000b0054fb6afac15mr11853502ywc.51.1682521298213; Wed, 26
 Apr 2023 08:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230425142846.730-1-tzimmermann@suse.de> <20230425142846.730-6-tzimmermann@suse.de>
In-Reply-To: <20230425142846.730-6-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Apr 2023 17:01:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU-_w9yQHYhOCD3cz4CEY6ag-dTXjuHSLnzty0hAMBbXw@mail.gmail.com>
Message-ID: <CAMuHMdU-_w9yQHYhOCD3cz4CEY6ag-dTXjuHSLnzty0hAMBbXw@mail.gmail.com>
Subject: Re: [PATCH 5/6] fbdev: Move CFB read and write code into helper functions
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
> Move the existing CFB read and write code for I/O memory into
> the new helpers fb_cfb_read() and fb_cfb_write(). Make them the
> default fp_ops. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/fbdev/core/Makefile      |   2 +-
>  drivers/video/fbdev/core/fb_cfb_fops.c | 126 +++++++++++++++++++++++++
>  drivers/video/fbdev/core/fbmem.c       | 113 +---------------------
>  include/linux/fb.h                     |  10 ++
>  4 files changed, 139 insertions(+), 112 deletions(-)
>  create mode 100644 drivers/video/fbdev/core/fb_cfb_fops.c

While the general idea is fine, please do not call any of this "cfb",
as it is not related to chunky color frame buffer formats.
All of these operate on the raw frame buffer contents.

> --- /dev/null
> +++ b/drivers/video/fbdev/core/fb_cfb_fops.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/fb.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +
> +ssize_t fb_cfb_read(struct fb_info *info, char __user *buf, size_t count, loff_t *ppos)
> +{

[...]

> +       while (count) {
> +               c  = (count > PAGE_SIZE) ? PAGE_SIZE : count;
> +               dst = buffer;
> +               fb_memcpy_fromfb(dst, src, c);
> +               dst += c;
> +               src += c;
> +
> +               if (copy_to_user(buf, buffer, c)) {

So here's still the buggy copy_to_user() handling, copied from fb_read().

> +                       err = -EFAULT;
> +                       break;
> +               }
> +               *ppos += c;
> +               buf += c;
> +               cnt += c;
> +               count -= c;
> +       }
> +
> +       kfree(buffer);
> +
> +       return cnt ? cnt : err;
> +}
> +EXPORT_SYMBOL(fb_cfb_read);
> +
> +ssize_t fb_cfb_write(struct fb_info *info, const char __user *buf, size_t count, loff_t *ppos)
> +{

[...]

> +       while (count) {
> +               c = (count > PAGE_SIZE) ? PAGE_SIZE : count;
> +               src = buffer;
> +
> +               if (copy_from_user(src, buf, c)) {

And copy_from_user(), too...

> +                       err = -EFAULT;
> +                       break;
> +               }
> +
> +               fb_memcpy_tofb(dst, src, c);
> +               dst += c;
> +               src += c;
> +               *ppos += c;
> +               buf += c;
> +               cnt += c;
> +               count -= c;
> +       }
> +
> +       kfree(buffer);
> +
> +       return (cnt) ? cnt : err;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
