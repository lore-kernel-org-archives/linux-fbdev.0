Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C3BEB64DA
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Jul 2023 09:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjGEJce convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Jul 2023 05:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEJcd (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Jul 2023 05:32:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA38C1711
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Jul 2023 02:32:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qGysB-00082o-6E; Wed, 05 Jul 2023 11:32:31 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qGysA-00CEZi-Cn; Wed, 05 Jul 2023 11:32:30 +0200
Received: from pza by lupine with local (Exim 4.96)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qGysA-0003nS-0l;
        Wed, 05 Jul 2023 11:32:30 +0200
Message-ID: <edc39b273f3fb2f92d510f077ab766f02c5caad5.camel@pengutronix.de>
Subject: Re: [PATCH fbtest] Initialize ticks in benchmark()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>
Date:   Wed, 05 Jul 2023 11:32:30 +0200
In-Reply-To: <CAMuHMdXtkfWRZQ2yjoJJu12DaeZoENh0kr-2nOwXKTuKq3aajQ@mail.gmail.com>
References: <20230629082840.888110-1-p.zabel@pengutronix.de>
         <CAMuHMdXtkfWRZQ2yjoJJu12DaeZoENh0kr-2nOwXKTuKq3aajQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Geert,

On Mi, 2023-07-05 at 11:23 +0200, Geert Uytterhoeven wrote:
> Hi Philipp,
> 
> Thanks for your patch!
> 
> On Thu, Jun 29, 2023 at 10:28 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Fixes a build error with GCC 13:
> > 
> >   util.c: In function 'benchmark':
> >   util.c:177:17: error: 'ticks' may be used uninitialized [-Werror=maybe-uninitialized]
> >   util.c:161:14: note: 'ticks' was declared here
> 
> I believe this is a false positive?
> (unless your "long" type has only a single bit ;-)

Yes. I've clarified the commit message in v2.

> But as this is built with -Werror, I agree it is better to play it safe,
> and fix this.
> 
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> > --- a/util.c
> > +++ b/util.c
> > @@ -158,7 +158,7 @@ static uint64_t get_ticks(void)
> > 
> >  double benchmark(void (*func)(unsigned long n, void *data), void *data)
> >  {
> > -    uint64_t ticks;
> > +    uint64_t ticks = 0;
> 
> Wouldn't it be better to preinitialize this to 1 instead?
> Else an overzealous compiler might detect possible UB in the division
> below, and more hell might break loose...

Thanks, since we already are working around a confused compiler, this
seems like a good idea. Fixed in v2.

regards
Philipp
