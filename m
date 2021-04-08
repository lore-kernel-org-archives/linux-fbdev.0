Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2458C433ED
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 16:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5AA610D1
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 16:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhDHQq0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhDHQqZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 8 Apr 2021 12:46:25 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F8CC061760
        for <linux-fbdev@vger.kernel.org>; Thu,  8 Apr 2021 09:46:14 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q3so2824322qkq.12
        for <linux-fbdev@vger.kernel.org>; Thu, 08 Apr 2021 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P9Dutpry47e9G1LsI+esYplVO+0VII6tEqAJFfWkRFs=;
        b=YgqR7clyk2k4fwdMNax1iDXb2sF/XnKNGxf0wo1TO8GFWHr9fn3olwvZRTnhLiG401
         Mg74Akp1RiWZym/qucXFCGV+PA7tE9GSB1FxRXUa12JWocy5RCT3AKfLOF0rPbKAp8zK
         QDz77Rezb71XzcRKjk67GImEAzjs/v2nKZ80axmwHu/PYnVK5lGGWeP6MQm0qGM8cjbc
         CePlxVevLaG+j2FEa/lmwKvJRXnHCFMMOtqfpLtAmxzzonEYQ4xP8e4P3F42nXwP39SP
         QBVuP3x8MHGGhx7X6YmAx60QXV9mNcADixygvhUrdhGe5SJSv9lS4wXFKSFMCma9xIw7
         TuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P9Dutpry47e9G1LsI+esYplVO+0VII6tEqAJFfWkRFs=;
        b=MW7eNs4oh9NQHHPY06aWIr88JikmS8BWy6b1v2yUxlHLU+WHXS9V/5iVo3QXZ1+eV5
         cSisnDEJ0b7SDe0f5bcNBmiEaPQ+wtDQmMBvgDgYGjCwb72h2MULVYCXTu+X6HHp9f//
         RsCltcRQUW3BQlZhbHhkxE0aZwtowOdazjwqhzbIO28JpqtEeKd6sw6RjCmq76zUxZkh
         JzqAyIgLUdYiAVrjFJ+RrXqZ7EFj2KgKtUTT+mO06sf6v0ajD3ACcyrnKPIyj7VrEWrE
         v8vrZIMzcILsYi3C1fGQRnVTZa4ve1jjkJE5foJD+tmkDHR8q+ak84XKTrIwOnxDnfba
         Y+VA==
X-Gm-Message-State: AOAM531G85aHMsrOSX3/gBj2RSpCA5oE6P28lIIqRS8s3VhP3kGbgi0b
        lrtiqGv9x8skQ9mp/JloWvERtQ==
X-Google-Smtp-Source: ABdhPJzbDYutSfn+FmJJZIAbAHyE8DAfowirb1kwOsQfAUvjL2fOsMnXGxO5fiM2OyXlWuyJctyzMw==
X-Received: by 2002:a37:6c01:: with SMTP id h1mr9726497qkc.182.1617900373391;
        Thu, 08 Apr 2021 09:46:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id p5sm21412244qkj.35.2021.04.08.09.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 09:46:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lUXnI-002nMT-BD; Thu, 08 Apr 2021 13:46:12 -0300
Date:   Thu, 8 Apr 2021 13:46:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Joel Stanley <joel@jms.id.au>,
        David Airlie <airlied@linux.ie>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
Message-ID: <20210408164612.GD227011@ziepe.ca>
References: <20210408092011.52763-1-david@redhat.com>
 <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
 <YG7rKfJkTDJorqvY@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG7rKfJkTDJorqvY@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 08, 2021 at 01:38:17PM +0200, Daniel Vetter wrote:

> If you want to change this, we need automatic conflict resolution like apt
> and other package managers have, with suggestions how to fix the config if
> you want to enable a driver, but some of its requirements are missing. The
> current approach of hiding driver symbols complete if any of their
> dependencies are off is really not great.

+1 to this.. 

Though Kconfig is basically already unusuable unless you have hours to
carefully craft the kconfig you need to get out.

I'm not sure trying to optimize this by abusing the existing language
rules is such a good idea.

I gave a very half hearted go at a simple heuristic solution solve for
kconfig a while ago. It is good enough to sometimes automate a kconfig
task, but it is not so nice.

I use it to do things like "turn on all RDMA drivers" which is quite
a hard to do by hand.

It looks liked heursitics need a lot of fine tuning as the
conditionals are complex enough that it is hard to guess which branch
is going to yield a success.

Jason
