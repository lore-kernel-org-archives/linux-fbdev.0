Return-Path: <SRS0=n/V2=EH=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EF2C2D0A3
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 10:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310C1206DC
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 10:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OROkIMsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgKAKJP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 1 Nov 2020 05:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgKAKJO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 1 Nov 2020 05:09:14 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D9BC0617A6
        for <linux-fbdev@vger.kernel.org>; Sun,  1 Nov 2020 02:09:14 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id r3so5306924plo.1
        for <linux-fbdev@vger.kernel.org>; Sun, 01 Nov 2020 02:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rcjsrZy5DvOmULvnDe/f1f5jQvmOo2+zzfQSCPFkXZ0=;
        b=OROkIMsal9iMd6fpIBZ3qC0gIW7sdOUmQOxNHUza4XEnFyery9969Pkq8Ov1Wmc2hf
         aDkhoVuP+JqC4mD+gZWdbS5UosJ/Sdd2jE1I43avVmtxBQ/hUvf1Erbohv+4ZzD1dJYe
         ZYGcTs7BWklwX/XWTI74P+vuxKs5A0F/h+A6raMbocpUkrt7ArsTXbcZHBnXOXly/59/
         d4l/1L9demdLD3Mf2QjV8NWt42dGlzb3Kv8vuuiVgSL76vD55TM6oAx/z/y5eLxiK+Vm
         4SZ6Zlt2wOIXS8FTeEUgTOBYTL3wVLGpXHuh88y95eWRWMFaA/leLZi0uY4gkYuawuXg
         Zttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rcjsrZy5DvOmULvnDe/f1f5jQvmOo2+zzfQSCPFkXZ0=;
        b=oZxMsB2bJjLllGlVj4rCXkl5sxVIrfnMig65dXEb9z4swGUrb7FhtWl5zlR8i7y+AC
         PlrBaf6zizZLRlq7Nt0YynrV73gViUgf6MU1ftvBipuVU61p/8rGfIXuznZHkxo7kSB6
         AKYHsVhM4+FJbgbfOlnBZjTyx5sNOWlHbRr+gFoJpT9Wo2dOwLQTPTOHRTLdF4hDAEmK
         V7Jts5CO0PvFU54gih3XHzGWqPoEkr5uXvkBdQqvmXWMauQUl1UDpnfzfCjaLoNbkCh1
         geWCQk9sBqgdSyyeln/iR3cGvuNlf/eoLH9XWprtkzpMk9Jf37TDOr0YHBz0ubRrNmn4
         McNw==
X-Gm-Message-State: AOAM531FG/Efz8abqEq8f47X0zkqDVpIS/UjBtE3WrAogwyFlfMlUOzK
        hHTT3X5+F1CGyBBzfcsihg==
X-Google-Smtp-Source: ABdhPJwaE9pIQksZGkIW6q7+j7mvxEDqZDHZlnOoKRMjX1g2qc74NloSsMaiwoZbYzqFRg39ZlB37g==
X-Received: by 2002:a17:902:9a4c:b029:d6:a250:ab9f with SMTP id x12-20020a1709029a4cb02900d6a250ab9fmr10026293plv.20.1604225354084;
        Sun, 01 Nov 2020 02:09:14 -0800 (PST)
Received: from PWN (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id f5sm10041071pgi.86.2020.11.01.02.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 02:09:13 -0800 (PST)
Date:   Sun, 1 Nov 2020 05:09:05 -0500
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        b.zolnierkie@samsung.com, jirislaby@kernel.org,
        gustavoars@kernel.org, peda@axentia.se, jingxiangfeng@huawei.com,
        natechancellor@gmail.com, george.kennedy@oracle.com,
        yepeilin.cs@gmail.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video/fbdev/core: Mark debug-only variable as
 __maybe_unused
Message-ID: <20201101100905.GA1504836@PWN>
References: <20201021121512.17774-1-tzimmermann@suse.de>
 <20201101094718.GD1166694@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101094718.GD1166694@ravnborg.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Sam,

On Sun, Nov 01, 2020 at 10:47:18AM +0100, Sam Ravnborg wrote:
> Hi Thomas.
> 
> On Wed, Oct 21, 2020 at 02:15:12PM +0200, Thomas Zimmermann wrote:
> > Compiling fbcon.c gives
> > 
> > ../drivers/video/fbdev/core/fbcon.c: In function 'fbcon_exit':
> > ../drivers/video/fbdev/core/fbcon.c:3358:7: warning: variable 'pending' set but not used [-Wunused-but-set-variable]
> >  3358 |   int pending = 0;
> >       |       ^~~~~~~
> > 
> > The variable pending is only used for fbcon debugging. It's unused
> > otherwise. Mark it accordingly.
> > 
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> A better fix would be to replace the few uses of DPRINTK() with
> pr_dbg(). pr_info() is alread in use.
> 
> ofc, the next step would be to replace all prink() with their pr_
> counterparts.
> 
> Peilin, maybe this is one for your nice cleanups in fbcon?

Sure, I will send a patch replacing all printk() except DPRINTK(). Thank
you for the suggestion!

Peilin

