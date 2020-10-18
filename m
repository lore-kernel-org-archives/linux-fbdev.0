Return-Path: <SRS0=OfnY=DZ=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8B0C433E7
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Oct 2020 20:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E8A2227F
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Oct 2020 20:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+O1SkRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgJRUpH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 18 Oct 2020 16:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgJRUpH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 18 Oct 2020 16:45:07 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6F1C061755;
        Sun, 18 Oct 2020 13:45:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v12so3933637ply.12;
        Sun, 18 Oct 2020 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=knFTAfIPNfK0zMG6Crewi1ksambWz4eNn+ixDl4AQuk=;
        b=K+O1SkRwxCl1CIvmSz86ET2rIzrCAAEEw3mxrHscAYc/V3UDUtFL0ZG3UZ+X1D8O+U
         FpHqvbDS8cpKWnCryE0nSxtw9jToBsLQX2pvHR1T1SG75TKAP3YfnjZblbf+qN4lyfN9
         ek2RBUIdceP7nSyBBX0vsbafvg2JvmP8neUPQFdgVB5bJyGkRGX7q7EAULP+khK0n7fo
         besSDZbrVdffWplXDW2T0/RzXsWHMHqILfhI0bYDhLOGQPM1+gVa6Krue3QPLjV5zdRf
         YQAJSi5NMjJdjpF3eN5eKAEy+K5sSv8MC8GH0k1Hxnlqe4iIFPcGHUVYdYLkXKuZGsEK
         MaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=knFTAfIPNfK0zMG6Crewi1ksambWz4eNn+ixDl4AQuk=;
        b=UBDfp/apafw9EeC5PibhvoDYziIMAIUxNwOCYN4mJ2Ezi7Ukm23QBLaxw98JGT4Y/L
         R/F2EEMNjMnhmOzAd/p59o+P45g69+FwWkTidMfXNroDOZx9wVWcG84Adqi97BDEDl1C
         fSuJyvUxlWeE4fVQg8OI8gDwOK+cjIlbXFAgQhTCU6pewWpi/7C5D8TfZ5WZO100ZxX9
         xczqY2OIyyPUyak8Zdx3qVhJozZPbWLCqxTqdU1ongEta1ImRPS14AgE+Z8KvSKBUkaQ
         3iUgypmEA/Kic6nbols+L/SS3X+R3hONvGwhSymVTYyCmFIeIoiNTYf9stL3VAnJh56s
         JKOA==
X-Gm-Message-State: AOAM533G53VZUUWccI+ScLYBah9jeRPrF4fvNg4mS4A933PcNx/0tGiX
        WhYY7YJkT5fhhM0KyPnR8A==
X-Google-Smtp-Source: ABdhPJwko5Q7XjO6YbrUJ+jWW0NWV3X1Jtv2FRCBiG7hzcQpdIYwm3jPq1Yk6OTo6LcyC22+U5oNRw==
X-Received: by 2002:a17:902:6b07:b029:d3:ebaa:d028 with SMTP id o7-20020a1709026b07b02900d3ebaad028mr14299830plk.11.1603053905596;
        Sun, 18 Oct 2020 13:45:05 -0700 (PDT)
Received: from PWN ([161.117.80.159])
        by smtp.gmail.com with ESMTPSA id gd14sm9656624pjb.31.2020.10.18.13.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 13:45:04 -0700 (PDT)
Date:   Sun, 18 Oct 2020 16:44:56 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sven Schneider <s.schneider@arkona-technologies.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Fonts: Support FONT_EXTRA_WORDS macros for font_6x8
Message-ID: <20201018204456.GA697766@PWN>
References: <20200820082137.5907-1-s.hauer@pengutronix.de>
 <926453876c92caac34cba8545716a491754d04d5.1603037079.git.yepeilin.cs@gmail.com>
 <CAKMK7uF9E24P=vzKt28=1_iaFTYD7obHs+tEPwwZPNMhh7DBrg@mail.gmail.com>
 <20201018201811.GA697615@PWN>
 <CAKMK7uFEmNnBdpoHYqvCUYS=nxh99gKs6P1-1pgp-ouvTSioGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFEmNnBdpoHYqvCUYS=nxh99gKs6P1-1pgp-ouvTSioGw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
Message-ID: <20201018204456.l3046Id9YwWNWgvKog1Mo22aQ634Ztvblqhiv0XDBC8@z>

On Sun, Oct 18, 2020 at 10:33:11PM +0200, Daniel Vetter wrote:
> On Sun, Oct 18, 2020 at 10:18 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> > 2/2 is just updating the fb documentation:
> >
> > [PATCH 2/2] docs: fb: Add font_6x8 to available built-in fonts
> > https://lore.kernel.org/lkml/717bb41dda8e2ed615f3faadfbc3e215de726d38.1603037079.git.yepeilin.cs@gmail.com/
> >
> > I did `git format-patch -2 --thread=deep`, did I do something wrong when
> > sending it?
> 
> No idea, it just didn't arrive anywhere I could find. And I did get
> your previous patch series. Maybe just try again with dri-devel
> included and hope it works then?

I'm confused, I see it on LKML in the link above. Sure I'll resend soon.

Peilin Ye

