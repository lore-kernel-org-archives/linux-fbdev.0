Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434D6C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 17 Jan 2022 04:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiAQEdq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 16 Jan 2022 23:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiAQEdq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 16 Jan 2022 23:33:46 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E59C061574
        for <linux-fbdev@vger.kernel.org>; Sun, 16 Jan 2022 20:33:45 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g22so13784910edu.1
        for <linux-fbdev@vger.kernel.org>; Sun, 16 Jan 2022 20:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7jrKjyT1kUm6YgYqjVjGNp13+22Ic721iKzftS1kH20=;
        b=JHCBzpxZO0qDrU3BMMl1rhqj69ppdwRjuS+PkPO9ZkTDdHFBPcx/CtuYLr3cXB6HYx
         pm0L+DGXBsrNR41zE5UgmfDxVI8wvQo8NUJ4yGog5vvaO5AeuJ9ZKbwTVKVdokvQda0Q
         9ke31ZMGpJy9T9e4TAO8pxV8x5sJTk+wdB15Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jrKjyT1kUm6YgYqjVjGNp13+22Ic721iKzftS1kH20=;
        b=FK2h8edvgvqzGvXEGx1YGfI2kt4Tvu7hmKVTdt4IGqW7or2X6ZN8Vypa8rNt9YkitI
         ninQpGkypx61nyQVp7+0UFIcI/Z4LNEl58RCMuXHVgmV/8pw0/qg95k80du8znngAM0P
         qZJsdlRhuBFNvDly5ENAvghJYa0xuqz24fNsG0Gpw6BkdAoZYxXnFl11Mp35ej/B4zeA
         D7fjR6Pbr8ejKsPcmP6iHYpqk6eh2nM6mjjZzHxO2lxTKa97en+nMnYWl3dzl31pI9hJ
         wplNiWaOkXEqtgsS9kR/IRVW0io7bdofs8Iys36JlndFU+0Mc5q1ZRBNMP7sbcET6srY
         1O8A==
X-Gm-Message-State: AOAM530IkuWAHzqcW8uYQ3tyTfuL26J4sBcRXvCcHQ/4EfDFCrhcXb+c
        rYbHA7qWU577V3nWO12Q+wqoSFiAR8EcBWaW
X-Google-Smtp-Source: ABdhPJxEc5z3aVDsMJ7JqZYM+3w1tGBuqqzqTEw9HUVf9JRL2RbJ9L7yK8YNT9SsBpWNJHy0dRlVeQ==
X-Received: by 2002:a17:906:9f01:: with SMTP id fy1mr15197671ejc.475.1642394023771;
        Sun, 16 Jan 2022 20:33:43 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id g17sm3972437eja.165.2022.01.16.20.33.42
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 20:33:42 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id o7-20020a05600c510700b00347e10f66d1so7104345wms.0
        for <linux-fbdev@vger.kernel.org>; Sun, 16 Jan 2022 20:33:42 -0800 (PST)
X-Received: by 2002:a05:600c:2253:: with SMTP id a19mr4527780wmm.8.1642394022326;
 Sun, 16 Jan 2022 20:33:42 -0800 (PST)
MIME-Version: 1.0
References: <YeRyfaesC2kxkgZC@ls3530>
In-Reply-To: <YeRyfaesC2kxkgZC@ls3530>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jan 2022 06:33:26 +0200
X-Gmail-Original-Message-ID: <CAHk-=whE5gmEKLt+rtEn2MV=BN8p+QTU56VaPdSD_kmxkx7smQ@mail.gmail.com>
Message-ID: <CAHk-=whE5gmEKLt+rtEn2MV=BN8p+QTU56VaPdSD_kmxkx7smQ@mail.gmail.com>
Subject: Re: [GIT PULL] fbdev updates for v5.17-rc1
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Jan 16, 2022 at 9:32 PM Helge Deller <deller@gmx.de> wrote:
>
> This pull request contains only one single initial patch which adds
> myself to the MAINTAINERS file for the FRAMBUFFER LAYER.

I'll pull this (as my test builds for other things complete), but this
is just a note to say that this pull request email was marked as spam
for me, with gmail saying something along the lines of "lots of emails
from gmx.de have been marked as spam"

I see nothing odd in the email itself, and it has proper SPF and DKIM,
but it's possible that you end up sharing a subnet (or an ISP) with
spammers...

Or maybe it was a random one-off. We'll see. I check spam filters
enough that I _usually_ tend to catch these things.

                Linus
