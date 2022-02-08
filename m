Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ADAC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 13:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348721AbiBHNsh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244671AbiBHNse (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 08:48:34 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95056C03FED0
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 05:48:33 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i14so1210742wrc.10
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 05:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=nslAfgWjfqYp0waeOKiDWtWcAv4ct0cP72o0N9rmy7Q=;
        b=RVIn/c29r62kMCw+PwceylGcVE56vaOTYXBMo7yGwFYmI8E/MTom7AJHaMcxowN+sf
         rpC298MEwoj91lA8w//3v+cDFu7X5dyGZYyd3MLAQTNU8RUeQAdbDz8LzlZMp2QrHCFs
         oDG6vKBMITYf8mcdxmktG34fLsh6fvX9XHqVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nslAfgWjfqYp0waeOKiDWtWcAv4ct0cP72o0N9rmy7Q=;
        b=mpJzFueplGxVF4m/VV+0yrT2mHiOJZ8FkJ1K3NboRplju9QotdwEUl1V0UO8FKQkzT
         F1pOOgySeAwWsLASXvpWWUrAMtT7T2f9g5jRZbdW1OewU1qVKcr42WuCKqh2MRsjunf7
         M0H3OiLUPP6bIG7LqZonGoHRfOUUooLu/uIvAboIxmnTK+XVWxSjAYX74kxlvGpSGFH2
         1MqqBSrmcNSU5MD0iR0lHcjw0ig9YopDzdu0OWc/ggFPo+ZwD5WjZlNvHYkFQ1DJ0/tg
         JXAdtETysOuV2QsWifdQUd7dV4kXsijZH5T+llVLv3SGEAWM2bpaQLzgANZWnKIYr62y
         FSjw==
X-Gm-Message-State: AOAM533jAznlNyIsufgbJ6WgVOPbs41YemSvF5jKy7ut1IoSHLQVRvEx
        BtwgxEf7KCFqQ1ST64yUQj/zog==
X-Google-Smtp-Source: ABdhPJw7G5oiEdPQQHMsx5o7YqF02G82AktiOMw1OdSWIr3bQc7+i+V4qkXnq0ZbIMa6QMBDktOQiQ==
X-Received: by 2002:a5d:6d4b:: with SMTP id k11mr3503996wri.623.1644328112201;
        Tue, 08 Feb 2022 05:48:32 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f25sm2097908wml.16.2022.02.08.05.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 05:48:31 -0800 (PST)
Date:   Tue, 8 Feb 2022 14:48:29 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 11/21] fbcon: Extract fbcon_open/release helpers
Message-ID: <YgJ0relUFpnxRvhg@phenom.ffwll.local>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfxF4jq7BLX5rJe5@ravnborg.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Feb 03, 2022 at 10:15:14PM +0100, Sam Ravnborg wrote:
> Hi Daniel,
> 
> On Mon, Jan 31, 2022 at 10:05:42PM +0100, Daniel Vetter wrote:
> > There's two minor behaviour changes in here:
> > - in error paths we now consistently call fb_ops->fb_release
> > - fb_release really can't fail (fbmem.c ignores it too) and there's no
> >   reasonable cleanup we can do anyway.
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Claudio Suarez <cssk@net-c.es>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Cc: Du Cheng <ducheng2@gmail.com>
> > ---
> >  drivers/video/fbdev/core/fbcon.c | 107 +++++++++++++++----------------
> >  1 file changed, 53 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > index fa30e1909164..eea2ee14b64c 100644
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -680,19 +680,37 @@ static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
> >  
> >  #endif /* CONFIG_MISC_TILEBLITTING */
> >  
> > +static int fbcon_open(struct fb_info *info)
> > +{
> > +	if (!try_module_get(info->fbops->owner))
> > +		return -ENODEV;
> > +
> > +	if (info->fbops->fb_open &&
> > +	    info->fbops->fb_open(info, 0)) {
> > +		module_put(info->fbops->owner);
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void fbcon_release(struct fb_info *info)
> > +{
> > +	if (info->fbops->fb_release)
> > +		info->fbops->fb_release(info, 0);
> > +
> > +	module_put(info->fbops->owner);
> > +}
> >  
> >  static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
> >  				  int unit, int oldidx)
> >  {
> >  	struct fbcon_ops *ops = NULL;
> > -	int err = 0;
> > -
> > -	if (!try_module_get(info->fbops->owner))
> > -		err = -ENODEV;
> > +	int err;
> >  
> > -	if (!err && info->fbops->fb_open &&
> > -	    info->fbops->fb_open(info, 0))
> > -		err = -ENODEV;
> > +	err = fbcon_open(info);
> > +	if (err)
> > +		return err;
> >  
> >  	if (!err) {
> >  		ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
> > @@ -713,7 +731,7 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
> >  
> >  	if (err) {
> >  		con2fb_map[unit] = oldidx;
> > -		module_put(info->fbops->owner);
> > +		fbcon_release(info);
> >  	}
> >  
> >  	return err;
> > @@ -724,45 +742,34 @@ static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
> >  				  int oldidx, int found)
> >  {
> >  	struct fbcon_ops *ops = oldinfo->fbcon_par;
> > -	int err = 0, ret;
> > +	int ret;
> >  
> > -	if (oldinfo->fbops->fb_release &&
> > -	    oldinfo->fbops->fb_release(oldinfo, 0)) {
> > -		con2fb_map[unit] = oldidx;
> The old code assigns con2fb_map[unit] before is calls
> newinfo->fbops->fb_release).
> I wonder if there can be any callback to fbcon where the value
> of con2fb_map[unit] matters?

It's all protected by console_lock, so other threads cannot see the
inconsistent state.

Essentially everything in fbcon.c is protected by console_lock().

Do you want me to hammer this in somewhere (maybe in the commit message),
or good enough for your ack?
-Daniel

> 
> 
> > -		if (!found && newinfo->fbops->fb_release)
> > -			newinfo->fbops->fb_release(newinfo, 0);
> > -		if (!found)
> > -			module_put(newinfo->fbops->owner);
> > -		err = -ENODEV;
> > -	}
> > +	fbcon_release(oldinfo);
> >  
> > -	if (!err) {
> > -		fbcon_del_cursor_work(oldinfo);
> > -		kfree(ops->cursor_state.mask);
> > -		kfree(ops->cursor_data);
> > -		kfree(ops->cursor_src);
> > -		kfree(ops->fontbuffer);
> > -		kfree(oldinfo->fbcon_par);
> > -		oldinfo->fbcon_par = NULL;
> > -		module_put(oldinfo->fbops->owner);
> > -		/*
> > -		  If oldinfo and newinfo are driving the same hardware,
> > -		  the fb_release() method of oldinfo may attempt to
> > -		  restore the hardware state.  This will leave the
> > -		  newinfo in an undefined state. Thus, a call to
> > -		  fb_set_par() may be needed for the newinfo.
> > -		*/
> > -		if (newinfo && newinfo->fbops->fb_set_par) {
> > -			ret = newinfo->fbops->fb_set_par(newinfo);
> > +	fbcon_del_cursor_work(oldinfo);
> 
> 
> > +	kfree(ops->cursor_state.mask);
> > +	kfree(ops->cursor_data);
> > +	kfree(ops->cursor_src);
> > +	kfree(ops->fontbuffer);
> > +	kfree(oldinfo->fbcon_par);
> > +	oldinfo->fbcon_par = NULL;
> These all look like candidates to stuff into fbcon_release()
> That would drop the nice symmetry but make it more consistent.
> 
> I think we miss freeing ops->cursor_data in fbcon_exit(),
> but I did not follow all the code.
> 
> With my ramblings considered the patch is
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> 	Sam
> 
> > +	/*
> > +	  If oldinfo and newinfo are driving the same hardware,
> > +	  the fb_release() method of oldinfo may attempt to
> > +	  restore the hardware state.  This will leave the
> > +	  newinfo in an undefined state. Thus, a call to
> > +	  fb_set_par() may be needed for the newinfo.
> > +	*/
> > +	if (newinfo && newinfo->fbops->fb_set_par) {
> > +		ret = newinfo->fbops->fb_set_par(newinfo);
> >  
> > -			if (ret)
> > -				printk(KERN_ERR "con2fb_release_oldinfo: "
> > -					"detected unhandled fb_set_par error, "
> > -					"error code %d\n", ret);
> > -		}
> > +		if (ret)
> > +			printk(KERN_ERR "con2fb_release_oldinfo: "
> > +				"detected unhandled fb_set_par error, "
> > +				"error code %d\n", ret);
> >  	}
> >  
> > -	return err;
> > +	return 0;
> >  }
> >  
> >  static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
> > @@ -917,7 +924,6 @@ static const char *fbcon_startup(void)
> >  	struct fbcon_display *p = &fb_display[fg_console];
> >  	struct vc_data *vc = vc_cons[fg_console].d;
> >  	const struct font_desc *font = NULL;
> > -	struct module *owner;
> >  	struct fb_info *info = NULL;
> >  	struct fbcon_ops *ops;
> >  	int rows, cols;
> > @@ -936,17 +942,12 @@ static const char *fbcon_startup(void)
> >  	if (!info)
> >  		return NULL;
> >  	
> > -	owner = info->fbops->owner;
> > -	if (!try_module_get(owner))
> > +	if (fbcon_open(info))
> >  		return NULL;
> > -	if (info->fbops->fb_open && info->fbops->fb_open(info, 0)) {
> > -		module_put(owner);
> > -		return NULL;
> > -	}
> >  
> >  	ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
> >  	if (!ops) {
> > -		module_put(owner);
> > +		fbcon_release(info);
> >  		return NULL;
> >  	}
> >  
> > @@ -3331,10 +3332,6 @@ static void fbcon_exit(void)
> >  		}
> >  
> >  		if (mapped) {
> > -			if (info->fbops->fb_release)
> > -				info->fbops->fb_release(info, 0);
> > -			module_put(info->fbops->owner);
> > -
> >  			if (info->fbcon_par) {
> >  				struct fbcon_ops *ops = info->fbcon_par;
> >  
> > @@ -3344,6 +3341,8 @@ static void fbcon_exit(void)
> >  				kfree(info->fbcon_par);
> >  				info->fbcon_par = NULL;
> >  			}
> > +
> > +			fbcon_release(info);
> >  		}
> >  	}
> >  }
> > -- 
> > 2.33.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
