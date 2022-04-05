Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DDFC4332F
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Apr 2022 01:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352977AbiDFA7a (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386363AbiDEVuf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 5 Apr 2022 17:50:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB712137008
        for <linux-fbdev@vger.kernel.org>; Tue,  5 Apr 2022 13:54:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k23so287205wrd.8
        for <linux-fbdev@vger.kernel.org>; Tue, 05 Apr 2022 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9NHEHnuZ3EwIt6oRfVHzwUDeTZ1Be9ZvXyD0BUY2xlM=;
        b=dMIxaOA+PwGmGbUBgSF+BtNgTUc4RKGxiEJxcOGGW41WPS35KSWlB4hv7i4DbpxOGC
         ZH1S+U4+vSggXY1XAGmMMGqiGDAAFbM1TiIfR+O950jkhP22hrN5zpqEUFn8ZJUif7W1
         UT9mutnETTYpsxdjQi923ezsNRj0CTq+AgkAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9NHEHnuZ3EwIt6oRfVHzwUDeTZ1Be9ZvXyD0BUY2xlM=;
        b=j3K3OgbLL/epOepOZ8cmg9fqk40QB6KHw5TsE6TYX3927858nv6n1awqphy78Speq6
         aXUN/66R8LjrYu+luulMqImleX2y3Yx8tHx22kIKASP41Y1wzOSe+aTmaWuFuerr7vMk
         ClWrG72VEHC47lrHGLpgD1zFXlPukzhTS1ogc7w1yBcOo1mfq441F+KWGBpOVgMMmByS
         SaKOikqVCqa5wCi81+zo5THLlyHPR8YrP+a45xPlBI5zFeKdNdGEp8fgZRMC8H+uug4U
         KYTpMqvQ4Zy8quon8rp40mm6drVluR2ZDEejqHkr/sod2zp2z14XLXXL2crquCrdQdhy
         tOPg==
X-Gm-Message-State: AOAM5315gRGr1dUSF/1Tau26HR+/TCB61cebG3UN8u0Aea4X2kCeYK3w
        ka5bHyPXRvtLwCGjogDjYt2f2Q==
X-Google-Smtp-Source: ABdhPJyhXpgIjQQcv0SKxB4ADopYBn4Ma33nCG5hGhtlwq04P9w9qJQ0mEskhuSP+q2j89By5mUeGg==
X-Received: by 2002:adf:f24d:0:b0:206:96b:4ea1 with SMTP id b13-20020adff24d000000b00206096b4ea1mr4059467wrp.694.1649192093853;
        Tue, 05 Apr 2022 13:54:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id s1-20020adfb781000000b002060d4a8bd9sm8008923wre.17.2022.04.05.13.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 13:54:53 -0700 (PDT)
Date:   Tue, 5 Apr 2022 22:54:51 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Claudio Suarez <cssk@net-c.es>, Du Cheng <ducheng2@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 06/19] fbcon: Use delayed work for cursor
Message-ID: <Ykysm3EJd3XLrzyr@phenom.ffwll.local>
Mail-Followup-To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Claudio Suarez <cssk@net-c.es>, Du Cheng <ducheng2@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
 <20220208210824.2238981-7-daniel.vetter@ffwll.ch>
 <7f6d61f4-042f-8c9d-23ed-da6f1dcb20d0@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f6d61f4-042f-8c9d-23ed-da6f1dcb20d0@I-love.SAKURA.ne.jp>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Feb 10, 2022 at 08:43:36PM +0900, Tetsuo Handa wrote:
> On 2022/02/09 6:08, Daniel Vetter wrote:
> > @@ -714,6 +700,8 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
> >  		ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
> >  		if (!ops)
> >  			err = -ENOMEM;
> > +
> > +		INIT_DELAYED_WORK(&ops->cursor_work, fb_flashcursor);
> >  	}
> >  
> >  	if (!err) {
> 
> Memory allocation fault injection will hit NULL pointer dereference.

The error handling here is convoluted and I got this wrong, but a later
patch to extract an fbcon_open() helper fixes it. I'll fix this small
bisect issue for v3 anyway, thanks for taking a look at the patches.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
