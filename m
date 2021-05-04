Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D91C43460
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 May 2021 16:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72076613BC
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 May 2021 16:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhEDQ2l (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 May 2021 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhEDQ2k (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 May 2021 12:28:40 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838A6C061574
        for <linux-fbdev@vger.kernel.org>; Tue,  4 May 2021 09:27:44 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id d25so9329006oij.5
        for <linux-fbdev@vger.kernel.org>; Tue, 04 May 2021 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYF7uUe0NSSJCsH19h2K0ONCXMFGfdoSakxploOCV0I=;
        b=FfAikBWHjfuKkAeTPxwjl/w800FhqUT9u9QL2i2sOIzQ2uPv2fE9oUb/mDJSo6Ty+S
         oFL9pETzB/3ytHSJhV8ZcLDnRe5IUwtpTzOvPryHm4NzwxuebeQsBxxnvquIfA53MHqb
         9WeSY8YoyNqwsOZ6mpywqQOzm5RnM4Q704264=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYF7uUe0NSSJCsH19h2K0ONCXMFGfdoSakxploOCV0I=;
        b=fg6ARmsWz5mwzy71cNFvPHgUXJoTaZ7fqfkwma9Le0h59MaHgCV7tB/axSc0cvxqmD
         5dOxIhcL3PRPDiez2qYwdEEwPEmsLHcGpk7ysgPAb0UefqPncnRh4ltZrDP5OgBwTNdA
         E2uIsawPzhX0pmyHp5vijZKycxMExtdEjZ9zxzTnER8NURYBT3FFgQaeeDIUsWRGeqL4
         vxexiPa+O3Q45qWQeFnfyory5tSvpmi7yembzTBpggrZgwV44ZSIXh8e2NDrPbWAfsQm
         l27pLvji7LtPuUyjupJveSrORvrHXzTyNSi1QljRUBZVy0F2ADQsarVLo/R6MsP45abi
         IX2Q==
X-Gm-Message-State: AOAM530NYobbNfGRAff+CJr+5/hSwJFog+FlEfwiNnehHzeSOdGZrxuP
        cjX9zSJFJtY7gv/caNpavFOkqz8L/xHdFvKibxMaISc4iNw=
X-Google-Smtp-Source: ABdhPJzeyuzhzEF4gjzViZ7VOW+e0CqP6lg5U4itQk1v3xCNoIGcrH1flchbU+farzPUB+KtPOd05UmsfzRZLFXH+RI=
X-Received: by 2002:aca:2219:: with SMTP id b25mr3525216oic.14.1620145663881;
 Tue, 04 May 2021 09:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210504142910.2084722-1-linux@roeck-us.net>
In-Reply-To: <20210504142910.2084722-1-linux@roeck-us.net>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 4 May 2021 18:27:32 +0200
Message-ID: <CAKMK7uFNtE=hW75kn8tnSHpZveaUtavMwk6Libb9uUeonz853g@mail.gmail.com>
Subject: Re: [PATCH] fbmem: Mark proc_fb_seq_ops as __maybe_unused
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, May 4, 2021 at 4:29 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> With CONFIG_PROC_FS=n and -Werror, 0-day reports:
>
> drivers/video/fbdev/core/fbmem.c:736:36: error:
>         'proc_fb_seq_ops' defined but not used
>
> Mark it as __maybe_unused.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Queued up for -rc1 in drm-misc-next-fixes, thanks for the patch.
-Daniel

> ---
>  drivers/video/fbdev/core/fbmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 372b52a2befa..52c606c0f8a2 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -733,7 +733,7 @@ static int fb_seq_show(struct seq_file *m, void *v)
>         return 0;
>  }
>
> -static const struct seq_operations proc_fb_seq_ops = {
> +static const struct __maybe_unused seq_operations proc_fb_seq_ops = {
>         .start  = fb_seq_start,
>         .next   = fb_seq_next,
>         .stop   = fb_seq_stop,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
