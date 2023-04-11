Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA90C77B73
	for <linux-fbdev@archiver.kernel.org>; Tue, 11 Apr 2023 14:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDKOEP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 11 Apr 2023 10:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDKOEO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 11 Apr 2023 10:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA48A1FE2
        for <linux-fbdev@vger.kernel.org>; Tue, 11 Apr 2023 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681221810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CIGXauWS2Wr91Jq5IW+UgW4CSynzPp3COFUoOkdMkhA=;
        b=Iy58mzct9gy0k8dFpNLv0I8NkvCIck0GbdnZe8zHPiXrfTqynL63vpFXNLOXt2wUCyEbfa
        5bmTErlcKHNiuEWWElnHt0UcHKCKDcF8HsXQCprk1+Got/5p7/dxx/EhIq2bmbTLGck/F9
        Ie9I8XWlhqze3VPsbE7vRff8O8BsvR4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-NWmSO4cBN0uww76jgrcDTg-1; Tue, 11 Apr 2023 10:03:29 -0400
X-MC-Unique: NWmSO4cBN0uww76jgrcDTg-1
Received: by mail-wm1-f69.google.com with SMTP id u12-20020a05600c19cc00b003f07be0e96bso2728560wmq.7
        for <linux-fbdev@vger.kernel.org>; Tue, 11 Apr 2023 07:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681221808;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIGXauWS2Wr91Jq5IW+UgW4CSynzPp3COFUoOkdMkhA=;
        b=Znd8DQtkDF38+j3ZhlhgSx9fEEXQH40kt4ata0dZ6aB8idfJt8nalob9PJ4O3LzU4f
         8SZWTLQRIPRRbmHf+oN9S9UV3iIsHFe0uMriI/Lhgt3Phic2WSUn9wK2FW0hLVZ+JgkM
         hXu9xcux9Os12E+4+YTweOMwqqVlgkTP6igGdaZ0SHHbeW7Kc6b2b/8MgxN4qFDxblZP
         sYW6nErMTKkoEap3HPgOmclLyMMyVoWVExk1SX0Qr/THJlZQzMB7HVmi4UyQb6YmOx4c
         2Y6Wbl0TkJYhdwEMH5j22Bvo0NNHuz3oxntFpBGkrm5oVMj8kjeLjvTJVRYSh8+dIywC
         qWcQ==
X-Gm-Message-State: AAQBX9dMiJbYz91Sb/xIO0Uufwr7Xn8ZKIK9mJ9+5JO650UI0oQaLde9
        WNqtkeP7Eoj3It8MBqkm66G8pK15a5sEs9cP6bTjH0Q3NMYcGNqpt/vml5mBDiGKXq/sraJR7W2
        GSGcHzjwhg1ALzoYTTPCYzs4=
X-Received: by 2002:a05:600c:246:b0:3ef:62c6:9930 with SMTP id 6-20020a05600c024600b003ef62c69930mr2272899wmj.3.1681221808152;
        Tue, 11 Apr 2023 07:03:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350aKiEZG2/eTE3qgJobPobJFBtpp/GDgmMcutPCUe6o6pFTDe6EfUfpz+ooaKEyqriEN7AUpYw==
X-Received: by 2002:a05:600c:246:b0:3ef:62c6:9930 with SMTP id 6-20020a05600c024600b003ef62c69930mr2272867wmj.3.1681221807826;
        Tue, 11 Apr 2023 07:03:27 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003ee443bf0c7sm20919284wms.16.2023.04.11.07.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:03:27 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     linux-fbdev@vger.kernel.org, Shigeru Yoshida <syoshida@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        shlomo@fastmail.com, Nathan Chancellor <natechancellor@gmail.com>,
        stable@vger.kernel.org,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Peter Rosin <peda@axentia.se>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: Re: [PATCH] fbmem: Reject FB_ACTIVATE_KD_TEXT from userspace
In-Reply-To: <20230404193934.472457-1-daniel.vetter@ffwll.ch>
References: <20230404193934.472457-1-daniel.vetter@ffwll.ch>
Date:   Tue, 11 Apr 2023 16:03:24 +0200
Message-ID: <874jpmtt1v.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Daniel Vetter <daniel.vetter@ffwll.ch> writes:

> This is an oversight from dc5bdb68b5b3 ("drm/fb-helper: Fix vt
> restore") - I failed to realize that nasty userspace could set this.
>
> It's not pretty to mix up kernel-internal and userspace uapi flags
> like this, but since the entire fb_var_screeninfo structure is uapi
> we'd need to either add a new parameter to the ->fb_set_par callback
> and fb_set_par() function, which has a _lot_ of users. Or some other
> fairly ugly side-channel int fb_info. Neither is a pretty prospect.
>
> Instead just correct the issue at hand by filtering out this
> kernel-internal flag in the ioctl handling code.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Fixes: dc5bdb68b5b3 ("drm/fb-helper: Fix vt restore")

[..]

> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 875541ff185b..3fd95a79e4c3 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1116,6 +1116,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  	case FBIOPUT_VSCREENINFO:
>  		if (copy_from_user(&var, argp, sizeof(var)))
>  			return -EFAULT;
> +		/* only for kernel-internal use */
> +		var.activate &= ~FB_ACTIVATE_KD_TEXT;
>  		console_lock();

I don't have a better idea on how to fix this and as you said the whole
struct fb_var_screeninfo is an uAPI anyways...

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

