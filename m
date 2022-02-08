Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A617EC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 13:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbiBHNqi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiBHNqh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 08:46:37 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E83C03FECE
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 05:46:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id o12so52389983eju.13
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 05:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=n+LaJyZileNVYfrYaX66cB1MBmYgBiVsCyxJAwLVUMM=;
        b=lI+BZuVcaX39tM3Hzn6AV7cMAOYQiuorb7ECkjKy19ZLPsqgt5HccWa6JVE5WSOUzf
         zkF5zK1pNUirlIF9c0I6rmjLcjRY61AIgt0gVX3PzKHHihcmAvkzPuyk6Vsiwh52MJlx
         nJbFdhibExMF4h5Vct0UMFUcQtBrt70JaaTJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=n+LaJyZileNVYfrYaX66cB1MBmYgBiVsCyxJAwLVUMM=;
        b=1/16UvKy1RrI6dgF5l5soP81rrXD97g+vDxXcC4zR9UY/ZCyz5ka55RkNrvsRDGKqT
         rFWB7VBHUah49K9y+5cEoj0W0pYda9VpZvbzMGYHue5dguaOR8nzm+y9JHvS9Gvb0bM1
         Zs5fzgf5WDs2v+gmtwYWe8vEAz+HuDJ7n7iBvodI2+Ln/Ews2tneur1OKdtmPReYbiG2
         5y2oG81j6S3pTM1Sl3LLV3RSZyNfPIlL3FE9GcEnN5ewYZQ7Oiij8lleaKtXgZ+r3zE3
         IPLL4GwfsE+NRHbrefL/x43AsHJ97CQkCFW1QXrpffcv2+/7ctikFvfHMoNPSiRAXQJ3
         poaw==
X-Gm-Message-State: AOAM5300Ttnbpqli5emPVZGBt1dAey7Yx1bHplyNrtHrxn1Mbf6utRK2
        qg94QrfjyuUp9p6fIkqgOuCokg==
X-Google-Smtp-Source: ABdhPJxVk+yKuksCrmEzucsFv8fLMfNwj3TQ4MGzWAZDuSk8mMV/chycYqMAJ3qCJ8UZgxkmkgB4aw==
X-Received: by 2002:a17:907:da3:: with SMTP id go35mr3771651ejc.456.1644327995333;
        Tue, 08 Feb 2022 05:46:35 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e7sm331032ejm.133.2022.02.08.05.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 05:46:34 -0800 (PST)
Date:   Tue, 8 Feb 2022 14:46:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 10/21] fb: Delete fb_info->queue
Message-ID: <YgJ0OQxt4KIPD9uz@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-11-daniel.vetter@ffwll.ch>
 <YfxJlH2NDnLk/GUw@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfxJlH2NDnLk/GUw@ravnborg.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Feb 03, 2022 at 10:31:00PM +0100, Sam Ravnborg wrote:
> On Mon, Jan 31, 2022 at 10:05:41PM +0100, Daniel Vetter wrote:
> > It was only used by fbcon, and that now switched to its own,
> > private work.
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: linux-fbdev@vger.kernel.org
> I would merge this with the patch that drops the usage

Yeah, but I like to split these out so that if this does break something,
it's much easier to revert. In case I overlooked something somewhere.

It's imo different if the cleanup is directly related to the preceeding
prep work, but this is a generic workqueue, and the cursor logic is rather
unrelated. And if I remember my history digging right, there were actually
other uses of this.
-Daniel

> 
> > ---
> >  include/linux/fb.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/include/linux/fb.h b/include/linux/fb.h
> > index 02f362c661c8..a8a00d2ba1f3 100644
> > --- a/include/linux/fb.h
> > +++ b/include/linux/fb.h
> > @@ -449,7 +449,6 @@ struct fb_info {
> >  	struct fb_var_screeninfo var;	/* Current var */
> >  	struct fb_fix_screeninfo fix;	/* Current fix */
> >  	struct fb_monspecs monspecs;	/* Current Monitor specs */
> > -	struct work_struct queue;	/* Framebuffer event queue */
> >  	struct fb_pixmap pixmap;	/* Image hardware mapper */
> >  	struct fb_pixmap sprite;	/* Cursor hardware mapper */
> >  	struct fb_cmap cmap;		/* Current cmap */
> > -- 
> > 2.33.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
