Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A057C433E6
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 13:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8917207C8
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 13:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhA0Np5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 08:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhA0NpV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 08:45:21 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C4AC061573;
        Wed, 27 Jan 2021 05:44:40 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w18so1209198pfu.9;
        Wed, 27 Jan 2021 05:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=F4yViBKvPcHMiCuhvR3TKpgz0BdKruFE9Fx6bKd/1bM=;
        b=CHLUaMBJaZD75tNWX0pYhho4I1Ko/XOezyGiwjHJRD/y5tG2WxtAiMTZDIKNoyON/r
         wPegeIsTtHmap5BNZQT+U1QmzHHRcX5aFviOx7ua7vjrKB00GOxcvjUXqPUavNB8V6Nq
         LjHvjw7Vxi8WHqE6hPOtkf6WyeIy+w3yuNUN3iR7I7gZSfW2hu4DPKLmMFw+j3fAzlg6
         exSldKNhyQAM8m/FYYyozDmrmrcSpHZRxsZsRTYC6MZBVyRex63xAISRGIZ5UOWWC+OD
         bcxX0CBfEnwKszKuCkvDCNwIRvMP7S2qs/C7XRa/yHQU2c+ZnLAjdvtgRIrEFCowM+eR
         5oHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=F4yViBKvPcHMiCuhvR3TKpgz0BdKruFE9Fx6bKd/1bM=;
        b=CjyXo8YZMG1UI/dxNyI+gWcmFvcrID3JV0Q0Ur0vxeanlP/d5TBthr/rTEXNfL2Rug
         uLqBteKyO63BzYGT5d12TjXTVouKBex5rog0m8xorjZCHrgz17+ZGY3VnLwo+rz2C8dj
         oTHChWlrF3FgsUtQde/D80iVVlecdOAJFMl7GMh6dxGfuMMZ3uutSL9Kq/LGFSlXfJid
         Bobca6J95cudzmCPbsMeiuYwGS9FrBj6XobfmHY2Fns163e/tBHdS93SJIOFcXUbX9it
         xYNPul4YF7sLt6h5uXHh+aUOUKJErJw/XftRqDl4yySkietPsOb2TRw+VxMuwsCA5cEJ
         8v0g==
X-Gm-Message-State: AOAM530NjkcwvZz/fH3UABeJ1Q8kH3REhsy1QuoV1q7FlxX2oouvCvFc
        MO0JOZ2puAVA7OcCtiBmS+Q=
X-Google-Smtp-Source: ABdhPJw7p+CSCxPecQ050cCLDkisjTb/wNpT/CIqIzh6zq8+qdjHeGwEONhLztOwMBpq/aL32wCVyA==
X-Received: by 2002:a63:450d:: with SMTP id s13mr11086715pga.443.1611755079856;
        Wed, 27 Jan 2021 05:44:39 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id o14sm2986305pgr.44.2021.01.27.05.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 05:44:39 -0800 (PST)
Date:   Wed, 27 Jan 2021 21:44:33 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        mh12gx2825@gmail.com, oliver.graute@kococonnector.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sbrivio@redhat.com, colin.king@canonical.com,
        zhangxuezhi1@yulong.com
Subject: Re: [PATCH v9] staging: fbtft: add tearing signal detect
Message-ID: <20210127214433.00005c15@gmail.com>
In-Reply-To: <YBFmg3yHlORg1mhf@kroah.com>
References: <1611752257-150851-1-git-send-email-zhangxuezhi3@gmail.com>
        <YBFmg3yHlORg1mhf@kroah.com>
Organization: Tyzmig-ryrjum-8kedto
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 27 Jan 2021 14:11:31 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Jan 27, 2021 at 08:57:37PM +0800, Carlis wrote:
> > From: zhangxuezhi <zhangxuezhi1@yulong.com>
> > 
> > For st7789v ic,add tearing signal detect to avoid screen tearing  
> 
> I need a much better changelog description here please.
> 
> > 
> > Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>
> > ---
> > v9: change pr_* to dev_*
> > ---  
> 
> What changed in all of your previous versions?  All of them should be
> listed here, right?
> 
> 
> 
> >  drivers/staging/fbtft/fb_st7789v.c | 132
> > ++++++++++++++++++++++++++++++++++++- drivers/staging/fbtft/fbtft.h
> >      |   1 + 2 files changed, 132 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/fbtft/fb_st7789v.c
> > b/drivers/staging/fbtft/fb_st7789v.c index 3a280cc..9aa2f36 100644
> > --- a/drivers/staging/fbtft/fb_st7789v.c
> > +++ b/drivers/staging/fbtft/fb_st7789v.c
> > @@ -9,9 +9,12 @@
> >  #include <linux/delay.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> > +#include <linux/mutex.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/completion.h>
> >  #include <linux/module.h>
> >  #include <video/mipi_display.h>
> > -
> > +#include <linux/gpio/consumer.h>
> >  #include "fbtft.h"
> >  
> >  #define DRVNAME "fb_st7789v"
> > @@ -66,6 +69,32 @@ enum st7789v_command {
> >  #define MADCTL_MX BIT(6) /* bitmask for column address order */
> >  #define MADCTL_MY BIT(7) /* bitmask for page address order */
> >  
> > +#define SPI_PANEL_TE_TIMEOUT	400  
> 
> What is the units here?  Where did this value come from?

hi,the units is msecs,and i got this value from a qcom mdp spi
drivers,and i will add the notes you need in the patch v10
> 
> > +static struct mutex te_mutex;/*mutex for tearing line*/  
> 
> Does that look correct???
> 
> thanks,
> 
> greg k-h

