Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A59C433DB
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Mar 2021 09:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DD961A45
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Mar 2021 09:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCZJ5u (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 26 Mar 2021 05:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhCZJ5S (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 26 Mar 2021 05:57:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEE1C0613AA;
        Fri, 26 Mar 2021 02:57:17 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o2so657471plg.1;
        Fri, 26 Mar 2021 02:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IV75pZ2r/lTsGbcVB2HXKVQUuEN280uU9C5RzK68fYU=;
        b=Q3rWXH4gNK6ohJquLwTkSl66Qdoxp6MTOgiXSDiftgNaBe/5H+stw2V/iZ+pl35nVc
         B/QZKZFVXGmObWTqMrfutIeevZt2Ht5zWHTPj6WFFw3kQwdVuoEU3e1fsIyiSJYjHHHg
         HC9nhqFM9YOuRLJZVNqydWrEVjC6spa5H8BcN1P0Rhee5XzSeEFEUn+U7SC9wUpf+Ny7
         YvRfaMgXAHZ+NluNeUtlO9mlqL/2AKFSkMLRW4v+sz9OfgJkfXjbILveGHRMY/aFSz4f
         9m0hEJ8tssrD4d2h73/PlM0qWRwIE3Ac4aBKsZw11/ygsZhBGJPgP8L3829shuktto1J
         f+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IV75pZ2r/lTsGbcVB2HXKVQUuEN280uU9C5RzK68fYU=;
        b=XdE4LpZKwJDaLhRS5llRF8qwtk0b+anMItUjOPG++gyJvFmXvCQJ6ofr+KyN+9QTts
         CvIuj4q+oxTKbRAZcZ/KzUwDndETNnH0QbkDc+oRi0f/YAvIoyCV8vlaDrW6Z9z6Yi93
         AYKpVzEZeiicq4A7z6jba4OJ5Cm/QWoPzxilNBwpi6Py9tV6t7fFHCFyHJGcgRCgoqEQ
         rymOEFfXGhkzAmNbLrbQDMrOtCENhcSXmVHMGIGg0xgAg3honYtmlkNgDz6aJP7z6Odd
         y8PiRhhyUmuCN8NPZm/J7UvDuwdGnB1ocBFVupvKXJpQqdKKewDn4opVtSdLJ245I7lg
         C6Cw==
X-Gm-Message-State: AOAM532QzdqfZ8ILrZs5GmAcU6PCa4ChGSDbghfnRMR88R3+Iml4w85s
        fopwXCKTbVyV8jf46/tWOs/ov32y6ZDSNMK9
X-Google-Smtp-Source: ABdhPJwwEZXFzZ/RNYveH7mefeJwagBObcPX98zYirGFuzA6NDif9CDcB1Ouvm7REbJkongZ1JDlZQ==
X-Received: by 2002:a17:90a:a414:: with SMTP id y20mr12906128pjp.77.1616752637305;
        Fri, 26 Mar 2021 02:57:17 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id n5sm8997971pfq.44.2021.03.26.02.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:57:16 -0700 (PDT)
Date:   Fri, 26 Mar 2021 17:57:11 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zhangxuezhi1@yulong.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix a typo
Message-ID: <20210326175711.0000684f@gmail.com>
In-Reply-To: <YF2qhUD1lz3LbEhC@kroah.com>
References: <1616745915-194644-1-git-send-email-zhangxuezhi3@gmail.com>
        <YF2dXIxMOUyLzfnQ@kroah.com>
        <20210326171634.000011f5@gmail.com>
        <YF2qhUD1lz3LbEhC@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 26 Mar 2021 10:33:57 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Mar 26, 2021 at 05:16:34PM +0800, carlis wrote:
> > On Fri, 26 Mar 2021 09:37:48 +0100
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >   
> > > On Fri, Mar 26, 2021 at 04:05:15PM +0800, Carlis wrote:  
> > > > From: "Carlis" <zhangxuezhi1@yulong.com>
> > > > 
> > > > Change 'tft' to 'TFT'    
> > > 
> > > Why?  What is wrong with "tft"?
> > >   
> > I think abbreviations should be capitalized.  
> 
> Why?  What requires this?
Many people use capital letters for abbreviations in comments, which I
think is a good practice
> 
> thanks,
> 
> greg k-h

thanks,
Xuezhi Zhang
