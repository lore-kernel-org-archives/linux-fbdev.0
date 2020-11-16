Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216C3C2D0A3
	for <linux-fbdev@archiver.kernel.org>; Mon, 16 Nov 2020 19:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B698520780
	for <linux-fbdev@archiver.kernel.org>; Mon, 16 Nov 2020 19:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cq7nQaf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgKPTnr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 16 Nov 2020 14:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgKPTnq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 16 Nov 2020 14:43:46 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859D3C0613CF
        for <linux-fbdev@vger.kernel.org>; Mon, 16 Nov 2020 11:43:46 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b6so20094240wrt.4
        for <linux-fbdev@vger.kernel.org>; Mon, 16 Nov 2020 11:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=T3bQsgj6/TdWyaR1j/y5LeOnUCmki2zEPh5MGH2qIZI=;
        b=cq7nQaf4tCgFGEJgMtaGf0UnLrWyEvgcD/PbOLhv94FymY97OT2tyyLmYgWLmR7Z3p
         j5tb+7NxPIOjMpw5PuG/PMn0/6Sf5DZYwKbsIjHJNeL7y18Tm3Nhpt59FH7x7aIIb7Gp
         d2F5kmF7Xdi3JsoMFlw8RLMVWcRpIBm7i8OhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=T3bQsgj6/TdWyaR1j/y5LeOnUCmki2zEPh5MGH2qIZI=;
        b=bRUnIs1+QG7F8XQ5fDnBCLla2kjgVHCn2FKW08yDRpI++osfHaIHI6ksAnWltSA19M
         35oIWn89z/Kp/TXGBmQukcvFaZVgiZ8OCD42jtsAVbxyP24p2v7JBHuvcCrLAvoJ0IT/
         jGZefdkIdh8lO0VEXqeAQ7F6xKyWEfdv0umLJgaq0v9ejyZSjV2E3/kZNi8E9ElLoWU5
         NeVdX96gVehwa1TS0nv3vGjDTX1vtfzZqqdMkJYhWm4uBF88s9E7eupUArWbqeCIe6F4
         4SDRpNOW8qDO9SaE0YmmRm5/8AYuitbSZi1vvifyb8rEOvIbIBO3vHJzgxnXwahWKWqh
         vt4A==
X-Gm-Message-State: AOAM532cqbWPImWFn8mmP59XxKXgNXvUVbXT4TlKsROorZGP6ApFo7pq
        el+T8RJZMuIxgg/NzZGGuARkEA==
X-Google-Smtp-Source: ABdhPJwKERkzMl0LaPFGiAEbmO0JIhahjV99lnngXah18p5ORSHJ7NHB9nGBIQOsW67X2oo2SrIEMg==
X-Received: by 2002:adf:ea03:: with SMTP id q3mr20016106wrm.141.1605555823876;
        Mon, 16 Nov 2020 11:43:43 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t11sm355613wmf.35.2020.11.16.11.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 11:43:43 -0800 (PST)
Date:   Mon, 16 Nov 2020 20:43:41 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernard Zhao <bernard@vivo.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/27] video: fix some kernel-doc markups
Message-ID: <20201116194341.GE401619@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernard Zhao <bernard@vivo.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
 <21661aed9892a1bacc7ef76a5dc9f5c7b37f5d8f.1605521731.git.mchehab+huawei@kernel.org>
 <20201116153606.GC401619@phenom.ffwll.local>
 <20201116173804.7d64f55f@coco.lan>
 <20201116172404.GD401619@phenom.ffwll.local>
 <20201116181112.GA103421@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116181112.GA103421@ravnborg.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Nov 16, 2020 at 07:11:12PM +0100, Sam Ravnborg wrote:
> Hi Daniel
> > > Feel free to just merge it via your tree. Patches here are pretty
> > > much independent ;-)
> > 
> > Ok I put it into drm-misc-next. I kinda assumed since there's also a huge
> > effort going on to shut up warnings, plus I think kerneldoc issues are
> > reported by a bunch of build bots nowadays. So assumed you pile this all
> > up.
> 
> Any reason "drm: fix some kernel-doc markups" was not applied?

Oh somehow I thought that one was only for i915 issues. I guess I'll take
a look.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
