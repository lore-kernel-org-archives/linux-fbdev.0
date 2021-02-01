Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1255C433E0
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Feb 2021 17:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47DE64DCC
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Feb 2021 17:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhBARlW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhBARlS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 1 Feb 2021 12:41:18 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EE6C061573;
        Mon,  1 Feb 2021 09:40:38 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e9so10412728plh.3;
        Mon, 01 Feb 2021 09:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GTMtuxP7iEoUqiDSP2dht+ZCnCmYXbJy1K3YoeV/SmU=;
        b=MDGJWNwJ35gvKBo5NLN7kGZe+ApEGYNEz82zcPwbM4tWvcYrjTo4TAYaPXMoEFK+8u
         1x/oEJhAO4bMA06NTZ5IGC4fRw1CPtoWCY+7O3vErExC0MWqP2OsjWOAAi+aPJoT9zp/
         qVejQXXi2R8y3ngoZHbnpSFo1rxY0P9rYO077gAjHPQYXV7HH34KFJ7sNvKSolvrYOoO
         nIWncGjfwmIiYQvSkdCLiis9c+spsUZz0Mnb2kWPvwbFT1Ko5Fneqw1BzH3kxJ8SH1Sp
         +yOQcj2IPKZSfYtQLww4HhIBNbJOzE8Zjf04DWqD0eYqIBcy8SYWitY5fPl04b3WKE8G
         /naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTMtuxP7iEoUqiDSP2dht+ZCnCmYXbJy1K3YoeV/SmU=;
        b=ePhr8hUCMN1w9o9fzjT5w3IwXsYBbNFPJb570ct9tZUQzi85avSMDgNrGHxhUonItj
         vTgt4zKkvht6/iIZHBjhlQ9XI12bmfImAuS7pTkydm9Q0Da2d5swPWzIc2urNc1mkm1v
         UkSpZ3FtJwlq3bdBBo5pwd/Lur66/x+Wm36EY2+c84d2fBHla8hx6fvbwQ2iIP0BMRia
         MGx8rrv0D1oby7/48e+WyHfo3Vk0PSPG/eriicB2/yGzpfIVzLHGxDQ3wgUgsyaAfEl6
         tWnx1DU3gJEHwXfFXuK9qLvVWTiVN+WDtxbt/zldvkCaPqVpa6ulVSZGzAjuCpQp3etU
         nuRg==
X-Gm-Message-State: AOAM532jnqP3xy+izCCmbqP+MpRDIVWzBpeDqGXBzemDIedv/CWsBmwg
        LA1WZRgGjqujzU3dv2ifVYzZV7aabL8eHwlGQ70=
X-Google-Smtp-Source: ABdhPJzsf/mGYBUXGJkiBfEdfymx5WNNIChE3ZG2ug5Z0AG7OF70uy77dHN6ipEiQgy2rF+Pjpv6HrFP20KM9qiJSp8=
X-Received: by 2002:a17:902:7b96:b029:de:7ae6:b8db with SMTP id
 w22-20020a1709027b96b02900de7ae6b8dbmr18507825pll.0.1612201237868; Mon, 01
 Feb 2021 09:40:37 -0800 (PST)
MIME-Version: 1.0
References: <1611838435-151774-1-git-send-email-zhangxuezhi3@gmail.com>
 <CAHp75Vd=ijxnamuSYuxNLeyhGMCod=HaXWrQ0W0+3QCsQAychg@mail.gmail.com>
 <20210129130110.00003bb1@gmail.com> <CAHp75Vdi4H_zY3+QPSq_wmdf20B9xPeqsOT10JHfMLJESX77gA@mail.gmail.com>
 <20210129215638.000047b0@gmail.com> <CAHp75VcdOibSRuSBZYhFtEcVxuammYMfcnrUQGvS6ttArFxj6g@mail.gmail.com>
 <20210130143924.00005432@gmail.com>
In-Reply-To: <20210130143924.00005432@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Feb 2021 19:40:21 +0200
Message-ID: <CAHp75VenJVOSbAXryGK_BWytRJF=T1zwk5xDimRQOTojoXbMFQ@mail.gmail.com>
Subject: Re: [PATCH v12] staging: fbtft: add tearing signal detect
To:     carlis <zhangxuezhi3@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin King <colin.king@canonical.com>,
        oliver.graute@kococonnector.com, zhangxuezhi1@yulong.com,
        Deepak R Varma <mh12gx2825@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jan 30, 2021 at 8:39 AM carlis <zhangxuezhi3@gmail.com> wrote:
> On Fri, 29 Jan 2021 16:26:12 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Fri, Jan 29, 2021 at 3:56 PM carlis <zhangxuezhi3@gmail.com> wrote:
> > > On Fri, 29 Jan 2021 12:23:08 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> > > Hi, I apologize for what I said in the previous two emails. I missed
> > > one email you sent before, and now I probably understand what you
> > > meant. Here is a version I modified according to your suggestion:

I have realized that you are mocking stuff in the generic fbtft
structure for all drivers while only a single one is going to use
that. Consider moving everything to the driver in question.


-- 
With Best Regards,
Andy Shevchenko
