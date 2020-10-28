Return-Path: <SRS0=thug=EE=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C00AC4363A
	for <linux-fbdev@archiver.kernel.org>; Thu, 29 Oct 2020 01:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E59DF20829
	for <linux-fbdev@archiver.kernel.org>; Thu, 29 Oct 2020 01:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kf71SoUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgJ2BxG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgJ1V5i (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 28 Oct 2020 17:57:38 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7094BC0613CF;
        Wed, 28 Oct 2020 14:57:37 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id k27so1130681oij.11;
        Wed, 28 Oct 2020 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o3LdnC6Ytf9c4DWqirvo5UI8m31/cCv50Msd5N5b88E=;
        b=Kf71SoURoZbPK+PTfpdvnSb2QDHbMtDUocxpU73Xm5V5jGamSBODV0w6lYIVnGP0nV
         DZ9Gdjd5BFLVfw5kKlCaR03dC5cXa8EhN79hBIChP81o6QIvCt3WeTJ6Z36GHc0sK8as
         5VJGnPsXbHwajZqU3QZfdcaACxkdjVqQJrKLGa9SfKw5RFFspZAmZoqSHmkX/kLiBgKz
         EABafBm1gpst3U19AYutktoYC/VVn1aIk+uU147O2FzwNnThNMnyL8Mm5/HfWdxMpdFq
         9CX3CfnmQZJbrmns0KcGq5/u0bTWswbBbqF5CUIduXQm+0DpA1rB7M758jtPjYrpaPdl
         53JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o3LdnC6Ytf9c4DWqirvo5UI8m31/cCv50Msd5N5b88E=;
        b=kcjA2Y8dl7sHLtKB48B6uhEuCFv0vvWaKjJBfCqdxY4pyPz9nMTjYPRT92n2nifxhQ
         daTwAZLgSiQvyYPn/P6Pv4+E9BpGwokZaBxEQxvi+2CTk3IQ4Sodl1SGIR1UAKJ4YL88
         cxgYcHJocz/2Y4wbECpCtHthsD/93uCqOvglYKDrtWO33NASR3uP/ph6kDnIRc1+yL+9
         uRxbK5tQK1BHEdWTdeu4pKkhgfN4yzaLRwurhbGHpJa530aOQRJkI4FuMBMmzn5rUL1Q
         CZrMZ/JzP9Hyi4oSpUAJYOnpgQL/eTkS8D/7xMmoEu6fckZ0+EdQgkY6LhtxiQxAgASa
         v33w==
X-Gm-Message-State: AOAM533REwJUezSx/xjwCiiNere5r3p4DlYHsNsXLwI50JNCP1oVsHYN
        sn2wjWbKxLqIatT6FxpQAIZXiyi7YFpE
X-Google-Smtp-Source: ABdhPJyMeXkxKEBeQiHyAtviwtfq3kqG2WHDNhJ1R5euCg8w4YtLIcQ7PkGZIvhWiAeQxnrwQKGzPg==
X-Received: by 2002:a17:90b:4a4f:: with SMTP id lb15mr1916524pjb.103.1603863270836;
        Tue, 27 Oct 2020 22:34:30 -0700 (PDT)
Received: from PWN (n11212042025.netvigator.com. [112.120.42.25])
        by smtp.gmail.com with ESMTPSA id j20sm3771189pgl.40.2020.10.27.22.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 22:34:30 -0700 (PDT)
Date:   Wed, 28 Oct 2020 01:34:23 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Following up
Message-ID: <20201028053423.GA1205528@PWN>
References: <cover.1603788511.git.yepeilin.cs@gmail.com>
 <20201027165021.GA1178130@PWN>
 <CAKMK7uH9L9WHBndEnUhAMMh0KsKUcz2zfKdi250gVqJGEG6usQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uH9L9WHBndEnUhAMMh0KsKUcz2zfKdi250gVqJGEG6usQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Oct 27, 2020 at 07:36:54PM +0100, Daniel Vetter wrote:
> On Tue, Oct 27, 2020 at 5:50 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> >     ...you mentioned code search, where & what should we look at, in order
> >     to confirm it's safe to remove them?
> 
> Way back there was google's code search, which was awesome. Now I just
> put the structure name/ioctl #define/number into
> google/bing/duckduckgo and see if anything turns up. Plus check how
> it's used in fb tools (although I just recently learned that fb-test
> pretty much disappeared from the internet, very hard to find the
> original).
> 
> If you're unsure, we can merge a patch, then wait about 1 year for any
> users to show up with problems. If that's not the case, assume they're
> all gone, or it was never used and just implemented because it was
> copied from somewhere else, or "just in case". There's lots of dead
> uapi around.

I see, it will be my next thing to do. Hopefully this will remove a lot
of console_font occurrences.

Peilin

