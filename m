Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C9EC4320A
	for <linux-fbdev@archiver.kernel.org>; Thu,  2 Sep 2021 14:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DACF60BD3
	for <linux-fbdev@archiver.kernel.org>; Thu,  2 Sep 2021 14:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345492AbhIBOcH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 2 Sep 2021 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345450AbhIBOcG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 2 Sep 2021 10:32:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710F0C061575
        for <linux-fbdev@vger.kernel.org>; Thu,  2 Sep 2021 07:31:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i6so3283453wrv.2
        for <linux-fbdev@vger.kernel.org>; Thu, 02 Sep 2021 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9hkBk7sDsjjBAe7AUgCdS1m+mzXVFS6kHPRELfYsC1c=;
        b=Y8s+NJiGqgx8TszOhrhN5R6tvbQ7OHnBDyaDgw6+AHEg2rkX66x3Eo/nHE/GhXLryx
         FbQUh7PMIldTWufZmHktHyoYa9nBOPtA/s+X3D8V/zBTco6SXapOdpzOu19bHY1XLrza
         rNkak6BgIt+mGk19F7UnVzexpNRxSt+wWtTLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9hkBk7sDsjjBAe7AUgCdS1m+mzXVFS6kHPRELfYsC1c=;
        b=F0SdrS8R+G/jIdwqbGLDRkeb9JXzvlbxOPjPmXx1r7zhbqc1tlaQ2q8eVpHxrR8Wq8
         iM1RW632cQxKMYd4JilYYjCuZdqX6qiOSli4YHni6dQprb6HiBQGTe+iFZi/zFmqtwQ/
         DQxNIcWCMM7whpbpFURAmHr4MUvmL2Vu5aJj6fcmPRM++XlSkY27f91dhxDiDHimT/7o
         z18l3R0BAU05F3fvrRB79L7KjEpSTbva8x39xKVzNAQilhFZ0DT5eqPaRblwhTspKcCG
         gjeHHBxukmRXp5iwxITzswrdZOzoeR84q5dg2GY72hDCIZzkA9hkzeE4I0xRysWN41i+
         Fwpg==
X-Gm-Message-State: AOAM532sgE0iLl4MNlQRZkgNy6R5gNZMPHYIz0HVsjgxVmsJcNlYq3aD
        Jrtvjhrhzf5rpTGiHRwnmQUBcQ==
X-Google-Smtp-Source: ABdhPJxDISoWhPmKGT3+Q/iYvIAPQ+5R6ghnjptaueBqR4FsG1+SlZZK1g+D/kr9jqMd27RZBQKuPA==
X-Received: by 2002:a05:6000:1623:: with SMTP id v3mr4235895wrb.288.1630593065981;
        Thu, 02 Sep 2021 07:31:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m4sm1874978wml.28.2021.09.02.07.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 07:31:05 -0700 (PDT)
Date:   Thu, 2 Sep 2021 16:31:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [RFC PATCH 0/4] Allow to use DRM fbdev emulation layer with
 CONFIG_FB disabled
Message-ID: <YTDgJzhOHEQ5ov3x@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <mripard@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>
References: <20210827100027.1577561-1-javierm@redhat.com>
 <bb5d045c-c9de-b6df-cf45-32b1a866264a@suse.de>
 <YSlI+ryYqoRxM7aB@phenom.ffwll.local>
 <a7395626-f022-5c89-07cd-c30d0d52d3dd@redhat.com>
 <YS4iIR689bAZ4QT9@phenom.ffwll.local>
 <b6ba8f6b-4f0c-53cc-e384-ecea3af78410@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6ba8f6b-4f0c-53cc-e384-ecea3af78410@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Sep 01, 2021 at 11:08:10AM +0200, Javier Martinez Canillas wrote:
> On 8/31/21 2:35 PM, Daniel Vetter wrote:
> > On Sat, Aug 28, 2021 at 12:02:21AM +0200, Javier Martinez Canillas wrote:
> 
> [snip]
> 
> >>
> >> We talked about a drmcon with Peter Robinson as well but then decided that a
> >> way to disable CONFIG_FB but still having the DRM fbdev emulation could be a
> >> intermediary step, hence these RFC patches.
> >>
> >> But yes, I agree that a drmcon would be the proper approach for this, to not
> >> need any fbdev support at all. We will just keep the explicit disable for the
> >> fbdev drivers then in the meantime.
> > 
> > I think the only intermediate step would be to disable the fbdev uapi
> > (char node and anything in sysfs), while still registering against the
> > fbcon layer so you have a console.
> >
> 
> Right, $subject disabled the sysfs interface but left the fbdev chardev. I can
> try to do a v2 that also disables that interface but just keep the fbcon part.
>  
> > But looking at the things syzbot finds the really problematic code is all
> > in the fbcon and console layer in general, and /dev/fb0 seems pretty
> > solid.
> >
> 
> Yes, but still would be an improvement in the sense that no legacy fbdev uAPI
> will be exposed and so user-space would only depend on the DRM/KMS interface.
> 
> > I think for a substantial improvement here in robustness what you really
> > want is
> > - kmscon in userspace
> > - disable FB layer
> > - ideally also disable console/vt layer in the kernel
> 
> Earlier in the thread it was mentioned that an in-kernel drmcon could be used
> instead. My worry with kmscon is that moving something as critical as console
> output to user-space might make harder to troubleshoot early booting issues.
> 
> And also that will require user-space changes. An in-kernel drmcon could be a
> drop-in replacement though.

The drmcon wouldn't be a full console, but just an emergency log renderer.
See Sam's reply, he found the series again.

The real attack surface reduction is in getting rid of the console/vt uapi
implementation from the kernel.
-Daniel

> > - have a minimal emergency/boot-up log thing in drm, patches for that
> >   floated around a few times
> >
> 
> Interesting. Do you have any pointers for this? My search-fu failed me when
> trying to find these patches.
> 
> Best regards,
> -- 
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
