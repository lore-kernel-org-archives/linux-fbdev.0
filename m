Return-Path: <SRS0=wnYw=ED=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69844C55179
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Oct 2020 23:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121CB207DE
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Oct 2020 23:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY7NJazs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387927AbgJ1XoH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388023AbgJ1XoH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 28 Oct 2020 19:44:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6220CC0613CF;
        Wed, 28 Oct 2020 16:44:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o3so808217pgr.11;
        Wed, 28 Oct 2020 16:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jfk3J2HWTP8PctuzhKYdTIaLNJsr6tS1vv/WAefJOL0=;
        b=MY7NJazs/V1vUwMi4z64c6d2TDVii3D2bzDs+hYBOL3KCq+kyeids1ajNncKl+6S4U
         SUpT3/5hpVoT6fVwbwdNMsXA67mDufbWhNjqKj2UJ7pxXVp2jQBLY9uvFaQ+8PalmjKD
         RDNsTp/LvRReFmAdZT64QpwonfJm8PKXyflUxC2nuwlrUcMPWDHJ+OEOe4Lf/Jcuz1Zd
         2NyLCT2ef+4C2hcHL1iJw+IeJ874gHWVmKPpS1ffWMVq+F9r2C9NTTMOCNMeQJgTahE8
         LINwUu5dTDzMSdMC/UaN8kSzEuv/w5BBA9nEmfcFXdiRgseBVErEk9DUyp9wz4AoJLPf
         sbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jfk3J2HWTP8PctuzhKYdTIaLNJsr6tS1vv/WAefJOL0=;
        b=CWqllSM5wfLx+dnIO/Symn03hl+VWOvBdqgo+31k/tjA5ggmijeSMudSQfHvkutoFJ
         H8D5d1e6wjGOA9ehCVyJG/rj9YSCP2a9BSoV84wL+l1PpAxQrOi67jyECLuY5+r9RzXw
         iGD1ZWbgoGnESxtoLH/4K4ZiQYq/GZxIimpEVLMhBCG4bP52f+pummJf15Nmgxlt3Sd4
         ecHtlLw2LCvUKaJCuOFg6K33NfQ92iwjzXZ2xoMTFGygu728zA+lYFyjSE50ZUPy0ayE
         cnViHn2op6ZsNSvi/3YsXSEZHTHJk1CaaGLDa1WB94ROpSk6raO8fGm5rQ0LQza5j4EY
         Yh8w==
X-Gm-Message-State: AOAM530noToKHDc7J7wf9ek1gUkWN7jUoF1ptqnjfsIbNkxXEBq6YJhz
        8vWjPcDscrkODyu8NPYuCk2XG88R295B
X-Google-Smtp-Source: ABdhPJzl3xHaVJZAUQPn41OZaKgSP6iI7ParKyNDpI0aA7iG1PjFKK7B+EOvYd02InEBSYnve9JMkQ==
X-Received: by 2002:a17:902:b113:b029:d3:c5c2:e667 with SMTP id q19-20020a170902b113b02900d3c5c2e667mr5709126plr.35.1603865470392;
        Tue, 27 Oct 2020 23:11:10 -0700 (PDT)
Received: from PWN (n11212042025.netvigator.com. [112.120.42.25])
        by smtp.gmail.com with ESMTPSA id t10sm3819423pjr.37.2020.10.27.23.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 23:11:09 -0700 (PDT)
Date:   Wed, 28 Oct 2020 02:11:03 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sven Schneider <s.schneider@arkona-technologies.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] Fonts: Add charcount field to font_desc
Message-ID: <20201028061103.GA1206440@PWN>
References: <cover.1603788511.git.yepeilin.cs@gmail.com>
 <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
 <54f7d42e07eca2a2f13669575a9de88023ebc1ac.1603788512.git.yepeilin.cs@gmail.com>
 <6c28279a10dbe7a7e5ac3e3a8dd7c67f8d63a9f2.1603788512.git.yepeilin.cs@gmail.com>
 <20201027185935.GN401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027185935.GN401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Oct 27, 2020 at 07:59:35PM +0100, Daniel Vetter wrote:
> On Tue, Oct 27, 2020 at 12:34:26PM -0400, Peilin Ye wrote:
> > Subsystems are assuming the number of characters of our built-in fonts.
> > Include that information in our kernel font descriptor, `struct
> > font_desc`.
> > 
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> atm can't merge this because we need a backmerge of maybe -rc2 into
> drm-misc-next first. Please remind me if this doesn't land next week.

Sure, thanks for reviewing these!

Peilin

