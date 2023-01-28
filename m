Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06806C38142
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Jan 2023 16:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjA1Qol (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Jan 2023 11:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjA1Qok (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Jan 2023 11:44:40 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7CB2A17A
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Jan 2023 08:44:38 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id jl3so7773297plb.8
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Jan 2023 08:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lRK+a9egMMuJj/YCMLvcukUA2pHrW9lACkwnEGsjQY4=;
        b=YLrrqdUISs2hunWzunrU1MpYYFQg5exQUtgL3sO2kpCvi+48qq5qlvJPAPfoNsaX2V
         PQaBG3WeSjiGi4sQOgyGvgWIjVOcHLbEmCqIEeGNyacEdbDR77YRFApsQTghWafHlhUy
         PmELuCkics7xnM3gmp/rl5r1n3cVQEeRaGWwt1HBGXS0Vw0ZLGFWeYAnXDQFsLlk4bnk
         HeaT/CbKtTp0B5A0MFlRhP73u1+XmrwNWkgajzSCsE21yuPWKEgayflpb0Gb54Gvq8R6
         e9316wm0PV8Vgz/JcK9MnpREHwquoZmOzp5JGLa56FKmfiKlBGPgMa0Ho/pOhYzAoiry
         mVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRK+a9egMMuJj/YCMLvcukUA2pHrW9lACkwnEGsjQY4=;
        b=S8CiviZNoTUOumVu43bxlzz9anvqmHAHF4ma54+Q6cxpMvVHu165sHjKTL2Uwv0FeT
         OCOH63gWqR03lRe/BnoYYFFwUqWqyckvNg07KDLDJJOT59CFFIdJ0FXc9vQM39jRh/sL
         VQ4NP0OF9qXodk8wQ7iJJZkHUnTtapiS/pdDr6bnilpyITydgPGkTqQamcNgMyxZqxv+
         s/ZfwiiwQKZAH4m9Acfa1B94GnKJbCaI8KmalqqONviehKxO0hKe/A93P4WMjnn+N38Y
         tDurH8Pa1kTbrhjEaRElE5IE1vfCiogxTFrWTz3IwDdz/c4vm9UqholZTAFbKXNdupmM
         GwXQ==
X-Gm-Message-State: AO0yUKV+7YubgR+paOskgy8VrHaOuI4bVjN60JgV8bQ+YrbHgXpl7Kcf
        ClVGn6laFUisQ0pbb+qfOxM=
X-Google-Smtp-Source: AK7set8ZauZpaYA13Y/eLaymM/mLxLKM8DLhC6keL2/YDiewfzJ9wRRSDfFO07TsDPXR/CpR4Bj/kg==
X-Received: by 2002:a05:6a20:1442:b0:bc:4369:f72 with SMTP id a2-20020a056a20144200b000bc43690f72mr7905391pzi.9.1674924277682;
        Sat, 28 Jan 2023 08:44:37 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id h6-20020a62b406000000b0056d7cc80ea4sm4505795pfn.110.2023.01.28.08.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 08:44:37 -0800 (PST)
Date:   Sun, 29 Jan 2023 00:44:30 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee@kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] backlight: ktz8866: Convert to i2c's .probe_new()
Message-ID: <Y9VQ7oEBtR6bA8fP@Gentoo>
References: <20230127152639.1347229-1-u.kleine-koenig@pengutronix.de>
 <Y9RuDM9VAMBzj4vd@Gentoo>
 <20230128133239.ndanz4gzm73wwaiv@pengutronix.de>
 <Y9Utsbi5PYZ26m9j@Gentoo>
 <20230128161613.zx24zhdqj66vxhcz@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230128161613.zx24zhdqj66vxhcz@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jan 28, 2023 at 05:16:13PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Sat, Jan 28, 2023 at 10:14:09PM +0800, Jianhua Lu wrote:
> > On Sat, Jan 28, 2023 at 02:32:39PM +0100, Uwe Kleine-König wrote:
> > > On Sat, Jan 28, 2023 at 08:36:28AM +0800, Jianhua Lu wrote:
> > > > I prefer that you pack this commit to the i2c-tree commit that drops
> > > > old .probe(). 
> > > 
> > > That's fine for me. Can I interpret this as an Ack for this patch?
> > 
> > Yes, but can't get my A-b directly, this patch should be ignored and 
> > resend it within the i2c-tree patch series or split it to two patch
> > series.
> 
> I'm not sure if I understand you correctly. Up to know I though you want
> the patch as is go in together with the patch that modifies struct
> i2c_driver such that the PR has in two separate commits:
> 
> 	i2c: Modify .probe() to not take an id parameter
> 	backlight: ktz8866: Convert to i2c's .probe_new()
This is case 1, the case 2 should be:
	Patch 1: i2c: Modify .probe() to not take an id parameter
	Patch 2: backlight: ktz8866: Convert to i2c's .probe_new()
					 'subsystem': 'i2c driver name': Convert to i2c's .probe_new()
					 ...
> 
> Did I understand that right?
> 
> In that case an Ack by you would be fine and welcome.
> 
> I don't want to squash the changes to the ktz8866 driver into the patch
> that modifies struct i2c_driver, as this needlessly clutters the commit,
> if it's that what you wanted. (There are more than 1000 i2c drivers and
> the others are not converted in a single lockstep, too.)
Do't squash this patch, I'd like you send a series patch instead of
a single patch.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


