Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F2CC27C76
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Jan 2023 17:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjA1RfP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Jan 2023 12:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjA1RfO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Jan 2023 12:35:14 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07E511EA9
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Jan 2023 09:35:13 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 88so7610755pjo.3
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Jan 2023 09:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PEaqdP9cme9MFeoPF3vVXIfI3BE4PbC1r2caSkdHCtU=;
        b=V5HZuO5/MV/xEYztSnDuPJaeh6CZf5vr95EZ6e8IH722JpKXWNdFEmyLH8m5blTLlJ
         GZkzJTYn62B/Nz7uCy0tg8V9ZWK4dXa61rnebyw7a6b2XDbq5zbL84RJ8yLXJ0rhctHh
         aqVblV1rh5PgNYpdtS/kS2MrYVLVq85EnKBC2xbDfH9Rzz9vPGKDdYNeu71pOD1N/cwW
         UAyLO0Wnm/4jVwCD1++H2CDR5/ghVxaxCBs1ezbkW9YaUqhrVTJdPrlLbdDhlhy58WdI
         38WefdFoxR4JA77H4bQNn/pXPVX7aG5qT7v0wR4zq09C5CwHDjUkVqEu9oZXlsMQ0EzQ
         +jJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEaqdP9cme9MFeoPF3vVXIfI3BE4PbC1r2caSkdHCtU=;
        b=0pDlk9KIGGNV4zOIGX84+jBuHxYxRbEEhQp5hD7u6OlN7Dcfz7QujH9ZIeZ65f1PMb
         9jcquiT+qYiVaYBMycZ1tG/ehAVDNGIGlLOVFVDa3V6ChPwizG+H/aCJn1vc343Txnrb
         GBy/BaIK0BeWZkSO3oo+kbbvzQ4ptb9ERsZ6E+dw6WqP/JGzqOiiWt8MqXZIFdHOJVwh
         owKkc+rY9XqwFJYBKhWyBtpG43DYITBYBV+1di2iKXalCb23+4VwyimmWr+/qITFyvqz
         +N8cpTUTK03ZkREasDk95EtukzVjhUaL09XhvHdqsu0GNhC/m3e96feLMQO8Qe5dfn2y
         /26g==
X-Gm-Message-State: AFqh2koSQfDm0tD7xo+qYEqlqUQRjjHZsumlVtSytREN/XfJQG4CgXja
        FuJr3ZgBxZXe4vHAawGiGBM=
X-Google-Smtp-Source: AMrXdXsBZgC4OsZfRAdd+o61RrFwkS63+pKp6RAqJW1R3pjkl/pzGUSFFWf97fw/gNnfHTzQNhQ/tw==
X-Received: by 2002:a05:6a20:e618:b0:b5:92e9:c6b3 with SMTP id my24-20020a056a20e61800b000b592e9c6b3mr46408496pzb.32.1674927313437;
        Sat, 28 Jan 2023 09:35:13 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id v71-20020a63894a000000b00478eb777d18sm4150169pgd.72.2023.01.28.09.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 09:35:13 -0800 (PST)
Date:   Sun, 29 Jan 2023 01:35:07 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee@kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] backlight: ktz8866: Convert to i2c's .probe_new()
Message-ID: <Y9Vcy/U1jbGtDQ7p@Gentoo>
References: <20230127152639.1347229-1-u.kleine-koenig@pengutronix.de>
 <Y9RuDM9VAMBzj4vd@Gentoo>
 <20230128133239.ndanz4gzm73wwaiv@pengutronix.de>
 <Y9Utsbi5PYZ26m9j@Gentoo>
 <20230128161613.zx24zhdqj66vxhcz@pengutronix.de>
 <Y9VQ7oEBtR6bA8fP@Gentoo>
 <20230128170708.om77umvc43bmskgv@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230128170708.om77umvc43bmskgv@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jan 28, 2023 at 06:07:08PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Sun, Jan 29, 2023 at 12:44:30AM +0800, Jianhua Lu wrote:
> > On Sat, Jan 28, 2023 at 05:16:13PM +0100, Uwe Kleine-König wrote:
> > > I don't want to squash the changes to the ktz8866 driver into the patch
> > > that modifies struct i2c_driver, as this needlessly clutters the commit,
> > > if it's that what you wanted. (There are more than 1000 i2c drivers and
> > > the others are not converted in a single lockstep, too.)
> > 
> > Do't squash this patch, I'd like you send a series patch instead of
> > a single patch.
> 
> This series was already sent before. However that happend based on a
> tree that didn't contain the ktz8866 backlight driver, so this patch
> came later (and I didn't resend the whole series for the two drivers
> that were added since then :-). See
> https://lore.kernel.org/lkml/20221118224540.619276-1-uwe@kleine-koenig.org.
> for the original post.
Thanks for explanation.
> 
> Letting this patch go in via the i2c tree together with the commit
> changing i2c_driver is fine for me, it won't be the only one.
I think so too.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


