Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BABFC433B4
	for <linux-fbdev@archiver.kernel.org>; Wed, 12 May 2021 12:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AEB1613EB
	for <linux-fbdev@archiver.kernel.org>; Wed, 12 May 2021 12:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhELMEd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 12 May 2021 08:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhELMEc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 12 May 2021 08:04:32 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328C9C06174A
        for <linux-fbdev@vger.kernel.org>; Wed, 12 May 2021 05:03:24 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:1174:b9bd:23c9:ffce])
        by andre.telenet-ops.be with bizsmtp
        id 3o3M2500C0HTjNG01o3Mco; Wed, 12 May 2021 14:03:21 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lgnaC-0053Um-Nc; Wed, 12 May 2021 14:03:20 +0200
Date:   Wed, 12 May 2021 14:03:20 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Yiyuan GUO <yguoaz@gmail.com>
cc:     Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] video/logo: protect against divide by zero when reading
 image
In-Reply-To: <20210512054843.54883-1-yguoaz@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2105121353530.1204552@ramsan.of.borg>
References: <20210512054843.54883-1-yguoaz@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

 	Hi Yiyuan,

CC dri-devel, linux-fbdev

On Wed, 12 May 2021, Yiyuan GUO wrote:
> In video/logo/pnmtologo.c, the function read_image can read from the
> image file an integer 0 and pass it to function get_number255, leading
> to a divide by zero problem.
>
> Signed-off-by: Yiyuan GUO <yguoaz@gmail.com>

Thanks for your patch!

> --- a/drivers/video/logo/pnmtologo.c
> +++ b/drivers/video/logo/pnmtologo.c
> @@ -118,7 +118,12 @@ static unsigned int get_number(FILE *fp)
>
> static unsigned int get_number255(FILE *fp, unsigned int maxval)
> {
> -    unsigned int val = get_number(fp);
> +    unsigned int val;
> +
> +    if (!maxval)
> +	die("Corrupted maxval\n");

Please be consistent with other places reporting errors, e.g.

     die("%s: invalid maxval zero\n", filename);

This looks like a strange place to check the validity of maxval.
What about checking if right after its assignment?
To avoid duplicating code, you can create a helper:

     static unsigned int get_maxval(FILE *fp)
     {
 	unsigned int maxval = get_number(fp);

 	if (!maxval)
 	    die("%s: invalid maxval zero\n", filename);

 	return maxval;
     }

and:

     /* Plain PGM */
-   maxval = get_number(fp);
+   maxval = get_maxval(fp);

and:

     /* Plain PPM */
-   maxval = get_number(fp);
+   maxval = get_maxval(fp);

> +
> +    val = get_number(fp);
>     return (255*val+maxval/2)/maxval;
> }

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
