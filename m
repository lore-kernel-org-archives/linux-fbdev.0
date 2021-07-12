Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A960C07E99
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Jul 2021 14:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF56A61156
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Jul 2021 14:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhGLOkl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 12 Jul 2021 10:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbhGLOkk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 12 Jul 2021 10:40:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADB8C0613E5
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jul 2021 07:37:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so14593601wmb.3
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jul 2021 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5MvsjY4pTEd5k29K3lYAodvANPB7dCwy0fDdN4Dc+OU=;
        b=DL95kZw7btL3htFTaW94KekmngiAohubrwxs52d8zHcU2Pbn5FIq7Y1SsbA7R09BqS
         eFcpL7PqpCyuTqLIAzpNm23Z04Gqg/XOiVnaxa2X0FlakC/xkAJkHizc8EUURhyOzF/s
         RLdM1aY0/8HeyoOOqmiWLFcb9UmOz8UikBLp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5MvsjY4pTEd5k29K3lYAodvANPB7dCwy0fDdN4Dc+OU=;
        b=sGHWYiVJ2nK0Gv3rCboa+3EGXbE4nSTOwcgQcCBRFZtHYj8NHz5JNQNjk+QhLccuzX
         cIUsZ+c0ZN8e+pg9i7QUEe/B/nJocyGxusP6mS5HQBv/HGFTV8jpKMH2J6A6xYwe3wnB
         zJSzUr/3n4npQGQPxY+P7WzyB06Rrvq2lMH/icKHvXRBzuGxLd2BpUQWsne7H8fQAHtB
         Nt1u6bZZ3yBhsBRvARdcGxFV/BBpqi7AJN5F0Hafywb/6/Fkvdz+kVE0iQ0si2mlaJ/j
         N9IcUR+NE5rUfB/Nflx/UEXbLKfgRKpeGDxW/zbo+BVH1vMOh2IIY/lwHyTxOJkh/JPD
         5W4g==
X-Gm-Message-State: AOAM532vBojham+fHB7yJDhfDokY0WA4rss81ulWuke+tRtD97BWLs6I
        5dWRAHPpXkIlY1QOScPIfzJHDw==
X-Google-Smtp-Source: ABdhPJxQay/+e0GLtdI0ff33EQHMLSIiRe5WWhtjGOPQLPgpU8vOTCjIMVM1pdQ7c3u9d0Pa7Ymgqw==
X-Received: by 2002:a05:600c:1d1f:: with SMTP id l31mr3197939wms.26.1626100670687;
        Mon, 12 Jul 2021 07:37:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l20sm13057801wmq.3.2021.07.12.07.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 07:37:49 -0700 (PDT)
Date:   Mon, 12 Jul 2021 16:37:48 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 1/1] fbmem: Do not delete the mode that is still in use
Message-ID: <YOxTvOayYYCro+qh@phenom.ffwll.local>
Mail-Followup-To: Zhen Lei <thunder.leizhen@huawei.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20210712085544.2828-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712085544.2828-1-thunder.leizhen@huawei.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jul 12, 2021 at 04:55:44PM +0800, Zhen Lei wrote:
> The execution of fb_delete_videomode() is not based on the result of the
> previous fbcon_mode_deleted(). As a result, the mode is directly deleted,
> regardless of whether it is still in use, which may cause UAF.
> 
> ==================================================================
> BUG: KASAN: use-after-free in fb_mode_is_equal+0x36e/0x5e0 \
> drivers/video/fbdev/core/modedb.c:924
> Read of size 4 at addr ffff88807e0ddb1c by task syz-executor.0/18962
> 
> CPU: 2 PID: 18962 Comm: syz-executor.0 Not tainted 5.10.45-rc1+ #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ...
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x137/0x1be lib/dump_stack.c:118
>  print_address_description+0x6c/0x640 mm/kasan/report.c:385
>  __kasan_report mm/kasan/report.c:545 [inline]
>  kasan_report+0x13d/0x1e0 mm/kasan/report.c:562
>  fb_mode_is_equal+0x36e/0x5e0 drivers/video/fbdev/core/modedb.c:924
>  fbcon_mode_deleted+0x16a/0x220 drivers/video/fbdev/core/fbcon.c:2746
>  fb_set_var+0x1e1/0xdb0 drivers/video/fbdev/core/fbmem.c:975
>  do_fb_ioctl+0x4d9/0x6e0 drivers/video/fbdev/core/fbmem.c:1108
>  vfs_ioctl fs/ioctl.c:48 [inline]
>  __do_sys_ioctl fs/ioctl.c:753 [inline]
>  __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:739
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Freed by task 18960:
>  kasan_save_stack mm/kasan/common.c:48 [inline]
>  kasan_set_track+0x3d/0x70 mm/kasan/common.c:56
>  kasan_set_free_info+0x17/0x30 mm/kasan/generic.c:355
>  __kasan_slab_free+0x108/0x140 mm/kasan/common.c:422
>  slab_free_hook mm/slub.c:1541 [inline]
>  slab_free_freelist_hook+0xd6/0x1a0 mm/slub.c:1574
>  slab_free mm/slub.c:3139 [inline]
>  kfree+0xca/0x3d0 mm/slub.c:4121
>  fb_delete_videomode+0x56a/0x820 drivers/video/fbdev/core/modedb.c:1104
>  fb_set_var+0x1f3/0xdb0 drivers/video/fbdev/core/fbmem.c:978
>  do_fb_ioctl+0x4d9/0x6e0 drivers/video/fbdev/core/fbmem.c:1108
>  vfs_ioctl fs/ioctl.c:48 [inline]
>  __do_sys_ioctl fs/ioctl.c:753 [inline]
>  __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:739
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Fixes: 13ff178ccd6d ("fbcon: Call fbcon_mode_deleted/new_modelist directly")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Nice catch, that indeed got lost.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: <stable@vger.kernel.org> # v5.3+

Needs to be applied to drm-misc-fixes, but the tree isn't ready yet.
-Daniel

> ---
>  drivers/video/fbdev/core/fbmem.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 98f193078c05..1c855145711b 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -970,13 +970,11 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>  		fb_var_to_videomode(&mode2, &info->var);
>  		/* make sure we don't delete the videomode of current var */
>  		ret = fb_mode_is_equal(&mode1, &mode2);
> -
> -		if (!ret)
> -			fbcon_mode_deleted(info, &mode1);
> -
> -		if (!ret)
> -			fb_delete_videomode(&mode1, &info->modelist);
> -
> +		if (!ret) {
> +			ret = fbcon_mode_deleted(info, &mode1);
> +			if (!ret)
> +				fb_delete_videomode(&mode1, &info->modelist);
> +		}
>  
>  		return ret ? -EINVAL : 0;
>  	}
> -- 
> 2.25.1
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
