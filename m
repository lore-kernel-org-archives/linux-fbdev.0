Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91926C432BE
	for <linux-fbdev@archiver.kernel.org>; Thu,  2 Sep 2021 06:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C9F60FDC
	for <linux-fbdev@archiver.kernel.org>; Thu,  2 Sep 2021 06:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhIBGHT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 2 Sep 2021 02:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhIBGHS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 2 Sep 2021 02:07:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA649C061575;
        Wed,  1 Sep 2021 23:06:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i21so1688076ejd.2;
        Wed, 01 Sep 2021 23:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whTkJ6zC7O+D+IeTOzd/hrZqqXkNOkHj9zN0Rud1rlU=;
        b=QByrQJYeYenX851WILof2vh1HOu3BNn5jOF+A5FaXZn2QGhg1jbvFqDtWm5q9AsFak
         NuQbh/nlGXh+Kn7gg7ZGGfLr32tXSyQQXxvRItHQ/FTWSBRhJZNJJv2oW4/I8xvQ14up
         1nmzO8yayF9rNNCSa3MvNqnIUuSjIDiOXvvy9MyNEAN6sg2RW8e3w8pwmdL7Q38QjByg
         2xa5wQ/wYwkADgZZ242Xx6ZlqfIwhpTpTkr/gwihWaHkV6NaHomH6zJNVHccy3FWxzcb
         w+SytK3PE5kK+3dba9ILNoEVaIUS/pZDQUWh+fsXrMC9fnjpEZUTx0lxUJGyK0s/yPC+
         GyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whTkJ6zC7O+D+IeTOzd/hrZqqXkNOkHj9zN0Rud1rlU=;
        b=cSbYkXzHfvhI63kZVbI2XDGmUdhANbiHv4mUSjZIywJc3TTDzNwUsJ5CgL2QcopBfX
         qrnR5ZwPyoDdDBEkVV06vAzX1nJ1CUzc0Jz0ucqkfEfDxD7ieqqEK/IBf/IL373RVA0S
         Y4HxLsJHIDsF9pvVN1ZleSXpCbiUtmyIE/0yeB9rlNfX1w2D8u+CXu+jSxDd/Dzt0Uky
         37IVxuc9MLfvfLJppTyIjuqoFKwPMWCoehT/VQeOy1gi+LQ0jKhvFkuNAt3yR5q/Smnp
         27+L84SBVoqGGWzidJM9sU4m6ea1uIwODKCTwpVNAtNHiy0EtTIE08lFZX2VopOzXe6+
         2DCw==
X-Gm-Message-State: AOAM5313IzoWG0t+u4W8iVsrYcwqPw7NtcqPMCEh8wg43JmHGh2dnIsR
        5c2tH7XNP8tPbbWP/zeVyiNY670b7scnIrhIamLsUEkR7rn7FHQC
X-Google-Smtp-Source: ABdhPJwEHZRxfRsnNHsnFH8N+CevlheXR4BPBxMjgPoc8wp1dSZlIGfBjTim029/qcTHMYtX+/UNLC6istu70rdugns=
X-Received: by 2002:a17:906:31ca:: with SMTP id f10mr2027189ejf.73.1630562779255;
 Wed, 01 Sep 2021 23:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210902060213.1702544-1-mudongliangabcd@gmail.com>
In-Reply-To: <20210902060213.1702544-1-mudongliangabcd@gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 2 Sep 2021 14:05:52 +0800
Message-ID: <CAD-N9QVXXNg9zSy7Q_8hLMv8nUX57UwkqJXqAdpc_QM4E2ikUw@mail.gmail.com>
Subject: Re: [PATCH 4.19] fbmem: add margin check to fb_check_caps()
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Sep 2, 2021 at 2:02 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> [ Upstream commit a49145acfb975d921464b84fe00279f99827d816 ]
>
> A fb_ioctl() FBIOPUT_VSCREENINFO call with invalid xres setting
> or yres setting in struct fb_var_screeninfo will result in a
> KASAN: vmalloc-out-of-bounds failure in bitfill_aligned() as
> the margins are being cleared. The margins are cleared in
> chunks and if the xres setting or yres setting is a value of
> zero upto the chunk size, the failure will occur.
>
> Add a margin check to validate xres and yres settings.
>
> Note that, this patch needs special handling to backport it to linux
> kernel 4.19, 4.14, 4.9, 4.4.

I have tested that, this patch can be applied to the branches:
linux-4.19.y/linux-4.14.y/linux-4.9.y/linux-4.4.y.

>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> Reported-by: syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Dhaval Giani <dhaval.giani@oracle.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/1594149963-13801-1-git-send-email-george.kennedy@oracle.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/video/fbdev/core/fbmem.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 84845275dbef..de04c097d67c 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -991,6 +991,10 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>                         goto done;
>                 }
>
> +               /* bitfill_aligned() assumes that it's at least 8x8 */
> +               if (var->xres < 8 || var->yres < 8)
> +                       return -EINVAL;
> +
>                 ret = info->fbops->fb_check_var(var, info);
>
>                 if (ret)
> --
> 2.25.1
>
