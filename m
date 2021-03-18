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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4012C433E0
	for <linux-fbdev@archiver.kernel.org>; Thu, 18 Mar 2021 02:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA0764E33
	for <linux-fbdev@archiver.kernel.org>; Thu, 18 Mar 2021 02:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhCRCsb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 17 Mar 2021 22:48:31 -0400
Received: from m12-17.163.com ([220.181.12.17]:57084 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhCRCsU (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 17 Mar 2021 22:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=ZDE7T
        kpNw2HAyd5WKd7F2ZaXSySBRfBW4yjJ09EgjKQ=; b=kSr253wgxZTcZIzg9t/sT
        AdA6BqkuAqCIRhq65VfY4Tk37A2wHDuCASMeHxoRVb1t265dJtG2b4MBfXebQ0wT
        MowRyF07NARpO+IwX/ECqUsEA1/0vrAFDoTv87xzAfz8AHNP8YnVa2OuvJHlwHBi
        y3kxMEjWVZzio8/TjYvlik=
Received: from localhost (unknown [218.94.48.178])
        by smtp13 (Coremail) with SMTP id EcCowAC3tLE3v1JgeOlcqg--.1500S2;
        Thu, 18 Mar 2021 10:47:19 +0800 (CST)
Date:   Thu, 18 Mar 2021 10:47:18 +0800
From:   Chunyou Tang <tangchunyou@163.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     gustavoars@kernel.org, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangchunyou@yulong.com
Subject: Re: [PATCH] drivers/video/fbdev:modify 0 to NULL
Message-ID: <20210318104718.00005767@163.com>
In-Reply-To: <20f1664e-df4c-d085-cb25-1d05e8a793a3@embeddedor.com>
References: <20210318023329.488-1-tangchunyou@163.com>
        <20f1664e-df4c-d085-cb25-1d05e8a793a3@embeddedor.com>
Organization: yulong
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: EcCowAC3tLE3v1JgeOlcqg--.1500S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw1kXw1UJF1kXF47uF4DArb_yoWDZrX_Zr
        4DZrsrWrZ0yr1SvFn7ArZavr98tw4DZws7ZFnFqr93Gry3Arn5Wr1jvrn2vw4xGF47GrZr
        WrnFvFWIyr1S9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbhFx5UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbiHhdZUVSItUPMzQAAsq
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

HI,Gustavo

On Wed, 17 Mar 2021 20:41:15 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> On 3/17/21 21:33, ChunyouTang wrote:
> > From: tangchunyou <tangchunyou@yulong.com>
> > 
> > modify 0 to NULL,info is a pointer,it should be
> > 
> > compared with NULL,not 0
> > 
> > Signed-off-by: tangchunyou <tangchunyou@yulong.com>
> > ---
> >  drivers/video/fbdev/offb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
> > index 4501e84..cd1042f 100644
> > --- a/drivers/video/fbdev/offb.c
> > +++ b/drivers/video/fbdev/offb.c
> > @@ -412,7 +412,7 @@ static void __init offb_init_fb(const char
> > *name, 
> >  	info = framebuffer_alloc(sizeof(u32) * 16, NULL);
> >  
> > -	if (info == 0) {
> > +	if (info == NULL) {  
> 
> if (!info) is better.
> 
> --
> Gustavo
> 
> >  		release_mem_region(res_start, res_size);
> >  		return;
> >  	}
> >   

I think "if (info == NULL)" is more intuitive,and there have many
compare likes "if (info == NULL)" in this file.

--
ChunyouTang

