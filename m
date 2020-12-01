Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16743C83016
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 08:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF5D21D46
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 08:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aL0K95uF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgLAIsD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Dec 2020 03:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgLAIsD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 1 Dec 2020 03:48:03 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE012C0613CF
        for <linux-fbdev@vger.kernel.org>; Tue,  1 Dec 2020 00:47:22 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c198so1601800wmd.0
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Dec 2020 00:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W9tZXtjV5gZd9yQL3k71kPC77lVS3zwQx87dfhVC2Y0=;
        b=aL0K95uFWJ7uaTbCLsTWdDM5SOrx+owLJllv1IfR6wy1EtCzdNbQAzgRjcMEVoPDjK
         VL9GS/3eBAcqKeWwtgSuqD6ApVULZ6C1KClolU83fxc6OAiY3kdrfaH7LPPRsDNrr8so
         fzq5Oz1Im+db7Xmrg+pZ3wUVORHQEub9cEiP7lUanBcQ2+x4dqfKdlvXPZeQhWkG2Ntu
         FpCOAz6zKamUbAxno/JmkB5B0pZD4TnpUwdhVegpntsS5RUtYA0/YKVE8I9bMXwZ56OT
         2Ayl+L5MhTi4lXjLroG6Kr2CGhIsXEwgbMsHz0l95pjZ1Ql0kjrmVcx5hJV0p6erWTBO
         2ZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W9tZXtjV5gZd9yQL3k71kPC77lVS3zwQx87dfhVC2Y0=;
        b=as7jao6ve51RCDUEwst99WsbBULG0EuUiimol/Ngdm8bzNfKTMQ56oOy96Tpn1MGha
         zLHSIp3FhfJMS/0PVWqH+/1AwWYy7v6BTt737ERRvqw3COk+gPQcUa+RwAjgrl7gaw6i
         K6EZL2PqKpnQH98KUQybxIteuil+/M8wP0Kqc7y1WoquGLxjqqVUfTwnPLmMtbYpxsTX
         aLtpd/ryq3WlvWdyzIBg4O2UH8XSTynILEHpS6XKi18lG08jOfb77GWQ3D4evw8H8k1a
         49i8ifl5J1/qMB2oQvnQzag9VOd//aK2RtKA6rK8Ce/Keii/a5ABf8ItgOQlWr9dp2Ss
         Vjug==
X-Gm-Message-State: AOAM531LADP9p9y4mFkBAtXnPZRjmIceC5rt+WiFf/5Hnj552EOtRZA4
        1jjyA1Av3sVKphgDF9F9jETLaQ==
X-Google-Smtp-Source: ABdhPJylIAK+x6QT9XRKDB6QgkCHkbEGZBwv1vU+ri8O4FXofjLSukeW/8a5PnTnrNrXlCq9Ied3BQ==
X-Received: by 2002:a05:600c:211:: with SMTP id 17mr1600527wmi.84.1606812441276;
        Tue, 01 Dec 2020 00:47:21 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id u23sm1667281wmc.32.2020.12.01.00.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 00:47:20 -0800 (PST)
Date:   Tue, 1 Dec 2020 08:47:18 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Evgeny Novikov <novikov@ispras.ru>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Aditya Pakki <pakki001@umn.edu>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jason Yan <yanaijie@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        George Kennedy <george.kennedy@oracle.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 13/28] video: fbdev: riva: Fix kernel-doc and set but
 not used warnings
Message-ID: <20201201084718.GF4801@dell>
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-14-sam@ravnborg.org>
 <53f3e91e-d8da-bce6-878c-7842250a7a7c@suse.de>
 <20201130183549.GA1498572@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201130183549.GA1498572@ravnborg.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 30 Nov 2020, Sam Ravnborg wrote:

> On Mon, Nov 30, 2020 at 01:14:52PM +0100, Thomas Zimmermann wrote:
> > 
> > 
> > Am 28.11.20 um 23:40 schrieb Sam Ravnborg:
> > > Fix W=1 warnings:
> > > - Fix kernel-doc
> > > - Drop unused variables/code
> > > 
> > > v2:
> > >    - Updated subject (Lee)
> > > 
> > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Antonino Daplas <adaplas@gmail.com>
> > > Cc: linux-fbdev@vger.kernel.org
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >   drivers/video/fbdev/riva/fbdev.c   |  9 ++++-----
> > >   drivers/video/fbdev/riva/riva_hw.c | 28 ++++++++--------------------
> > >   2 files changed, 12 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
> > > index ce55b9d2e862..55554b0433cb 100644
> > > --- a/drivers/video/fbdev/riva/fbdev.c
> > > +++ b/drivers/video/fbdev/riva/fbdev.c
> > > @@ -464,7 +464,7 @@ static inline void reverse_order(u32 *l)
> > >   /**
> > >    * rivafb_load_cursor_image - load cursor image to hardware
> > > - * @data: address to monochrome bitmap (1 = foreground color, 0 = background)
> > > + * @data8: address to monochrome bitmap (1 = foreground color, 0 = background)
> > >    * @par:  pointer to private data
> > >    * @w:    width of cursor image in pixels
> > >    * @h:    height of cursor image in scanlines
> > > @@ -843,9 +843,9 @@ static void riva_update_var(struct fb_var_screeninfo *var,
> > >   /**
> > >    * rivafb_do_maximize -
> > >    * @info: pointer to fb_info object containing info for current riva board
> > > - * @var:
> > > - * @nom:
> > > - * @den:
> > > + * @var: standard kernel fb changeable data
> > > + * @nom: nom
> > > + * @den: den

Cop-out!

Do what I do and make something up (joke)! :'D

> > Well, it fixes the warning ;)
> 
> Yeah, I could not dig up anything useful to say here.
> Was tempted to just drop all the kernel-doc syntax but that
> was a larger change.

Did you trace it from it's origin down to it's final use?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
