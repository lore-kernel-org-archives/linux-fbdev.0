Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F418BC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 22:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386537AbiBHWXl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386245AbiBHTvM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 14:51:12 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67100C0612C0
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 11:51:09 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h6so249030wrb.9
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=BvBYtnROK0NJX3e3ojisBGf1paUJFvCP5ALRDikwoCo=;
        b=TWDZjxkf7M6rgIp4JfZtaKW4Sjca9LqbZMy9b+5DrAZaJ2rDVB9YJtodNNsdrAJlf4
         WYG9TGJZgkRvaXASeEw7DPJThBOR1JCHe7M4V1UyHCI0s7YkznBYBFAF4r8yIE5My8rD
         nzSIuGCwjR9kuhafqLbUr25bqyY6ReIBIOcSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=BvBYtnROK0NJX3e3ojisBGf1paUJFvCP5ALRDikwoCo=;
        b=zARgolbktNUoFxVPK1jJuK9xJNd06bj+EE2H8TVmcVHerIWU3jgjlJ+tnsqLt2a4ZJ
         5AXvLgXCRHYP9k4b2bpZ9f6BD+11pZg40P+ZpFcbIvXkditk//Oxk32QMmmOAxaRBxSm
         fus5ssmOP5dzL7YEkzLi6QHV9eEOU7AxJO5DfUiIkYfgI/mQIUtUKtL+fwixjTrMoqWy
         0qelRTcjxPSY4/om07A2dH5EaEmSsd9VQQflBjW6sbX2X334XYp3ilSI7iyS0z3d57DN
         QgvGSDGmrBAtH41voCkDqpNoyfOr93cnEU8LambldsNBqLPBbKgUO3O7ry2Bf7Vo6DF5
         JVMA==
X-Gm-Message-State: AOAM532iYRRl8xdYLbYcRSlQiG/azkJq6ZrkKkkFn7qjJrNj/g7SR0Ko
        AsG+zg+YP7mR/KHZL86W6r1ysQ==
X-Google-Smtp-Source: ABdhPJx3tBpO0LLVvJvdPoySy41lhcsT/t4WBAmc1/sxYixWb4kanChwoDH9nrVUpWQo3RbB0d6VVg==
X-Received: by 2002:a05:6000:178d:: with SMTP id e13mr4611824wrg.317.1644349867919;
        Tue, 08 Feb 2022 11:51:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n126sm1930000wmn.27.2022.02.08.11.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:51:07 -0800 (PST)
Date:   Tue, 8 Feb 2022 20:51:05 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [Intel-gfx] [PATCH 11/21] fbcon: Extract fbcon_open/release
 helpers
Message-ID: <YgLJqeRX0BWF4j29@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-12-daniel.vetter@ffwll.ch>
 <YfxF4jq7BLX5rJe5@ravnborg.org>
 <YgJ0relUFpnxRvhg@phenom.ffwll.local>
 <YgK1Qz6eIKD9wHre@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgK1Qz6eIKD9wHre@ravnborg.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Feb 08, 2022 at 07:24:03PM +0100, Sam Ravnborg wrote:
> Hi Daniel,
> 
> On Tue, Feb 08, 2022 at 02:48:29PM +0100, Daniel Vetter wrote:
> > On Thu, Feb 03, 2022 at 10:15:14PM +0100, Sam Ravnborg wrote:
> > > Hi Daniel,
> > > 
> > > On Mon, Jan 31, 2022 at 10:05:42PM +0100, Daniel Vetter wrote:
> > > > There's two minor behaviour changes in here:
> > > > - in error paths we now consistently call fb_ops->fb_release
> > > > - fb_release really can't fail (fbmem.c ignores it too) and there's no
> > > >   reasonable cleanup we can do anyway.
> > > > 
> > > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > Cc: Claudio Suarez <cssk@net-c.es>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > > Cc: Du Cheng <ducheng2@gmail.com>
> > > > ---
> > > >  drivers/video/fbdev/core/fbcon.c | 107 +++++++++++++++----------------
> > > >  1 file changed, 53 insertions(+), 54 deletions(-)
> > > > 
> > > > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > > > index fa30e1909164..eea2ee14b64c 100644
> > > > --- a/drivers/video/fbdev/core/fbcon.c
> > > > +++ b/drivers/video/fbdev/core/fbcon.c
> > > > @@ -680,19 +680,37 @@ static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
> > > >  
> > > >  #endif /* CONFIG_MISC_TILEBLITTING */
> > > >  
> > > > +static int fbcon_open(struct fb_info *info)
> > > > +{
> > > > +	if (!try_module_get(info->fbops->owner))
> > > > +		return -ENODEV;
> > > > +
> > > > +	if (info->fbops->fb_open &&
> > > > +	    info->fbops->fb_open(info, 0)) {
> > > > +		module_put(info->fbops->owner);
> > > > +		return -ENODEV;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void fbcon_release(struct fb_info *info)
> > > > +{
> > > > +	if (info->fbops->fb_release)
> > > > +		info->fbops->fb_release(info, 0);
> > > > +
> > > > +	module_put(info->fbops->owner);
> > > > +}
> > > >  
> > > >  static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
> > > >  				  int unit, int oldidx)
> > > >  {
> > > >  	struct fbcon_ops *ops = NULL;
> > > > -	int err = 0;
> > > > -
> > > > -	if (!try_module_get(info->fbops->owner))
> > > > -		err = -ENODEV;
> > > > +	int err;
> > > >  
> > > > -	if (!err && info->fbops->fb_open &&
> > > > -	    info->fbops->fb_open(info, 0))
> > > > -		err = -ENODEV;
> > > > +	err = fbcon_open(info);
> > > > +	if (err)
> > > > +		return err;
> > > >  
> > > >  	if (!err) {
> > > >  		ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
> > > > @@ -713,7 +731,7 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
> > > >  
> > > >  	if (err) {
> > > >  		con2fb_map[unit] = oldidx;
> > > > -		module_put(info->fbops->owner);
> > > > +		fbcon_release(info);
> > > >  	}
> > > >  
> > > >  	return err;
> > > > @@ -724,45 +742,34 @@ static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
> > > >  				  int oldidx, int found)
> > > >  {
> > > >  	struct fbcon_ops *ops = oldinfo->fbcon_par;
> > > > -	int err = 0, ret;
> > > > +	int ret;
> > > >  
> > > > -	if (oldinfo->fbops->fb_release &&
> > > > -	    oldinfo->fbops->fb_release(oldinfo, 0)) {
> > > > -		con2fb_map[unit] = oldidx;
> > > The old code assigns con2fb_map[unit] before is calls
> > > newinfo->fbops->fb_release).
> > > I wonder if there can be any callback to fbcon where the value
> > > of con2fb_map[unit] matters?
> > 
> > It's all protected by console_lock, so other threads cannot see the
> > inconsistent state.
> > 
> > Essentially everything in fbcon.c is protected by console_lock().
> > 
> > Do you want me to hammer this in somewhere (maybe in the commit message),
> > or good enough for your ack?
> 
> No need to spell it out more.

I think this was a very good question, since I had to spend a few minutes
figuring out what exactly and why I've done it too.

So I'll add this explainer, it really should have been in the commit
message!

> Add my a-b and apply it.

Well I need to resend, since there was a minor change due to rebasing on
top of Helge's fbcon scrolling patches instead of mine.

Thanks for your review
-Daniel
> 
> 	Sam

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
