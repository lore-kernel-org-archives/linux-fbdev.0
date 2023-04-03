Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A059C761A6
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 Apr 2023 09:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDCJLk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 3 Apr 2023 05:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjDCJLj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 3 Apr 2023 05:11:39 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9667692
        for <linux-fbdev@vger.kernel.org>; Mon,  3 Apr 2023 02:11:38 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id p203so33854648ybb.13
        for <linux-fbdev@vger.kernel.org>; Mon, 03 Apr 2023 02:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680513098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZI0/oicn8lXf0Q9UzLqg2frlhxOUQe0sP4P2QRpVzMs=;
        b=Bqs+me2RBcN2seWWo3ykDAsuzZBjbapjt3DXuKXwDKcREQLc28JtVn5XMa5uWBPD2d
         MtHAb2x3JVQsO5FZI37zS2hFYt1K8uXYscY9N+6g/ZzYgedBvbs9soXRdiIZrnDo3bxi
         R7ABE9qG96DUbeZJFTpx++fFiRS17beEgN1qQlktTeJEnEwzlG/EdnaRBe+hWxvheC+3
         3wbONuY04D55BUEG+PnCXOM6OwDgBHY4QGVs8XIBugqRCLUSBL4MV5bMkMuscigTNopk
         AJUmhewaRd11I2w0zOY9nZXfr1Uh7HXAaQn1Mt3WkHmC4omFfQWS9j6JW5e6f33DuMtP
         UnxA==
X-Gm-Message-State: AAQBX9f/+Y1WhTcVEXro9/HUps9nMWJQrt6SNis26FBYrV1mZYwutwE0
        sjFmBAWY+HcsY1sE/H7038kqPBv3uCBj+4HN
X-Google-Smtp-Source: AKy350Z2hyCOPrtwg90ezhMCXO9EgCo1MSwWeZzIUlmOnu5FEY53FtevoaEPgrv2qL2RBn9s+jdD0g==
X-Received: by 2002:a25:2205:0:b0:b7d:d397:5c51 with SMTP id i5-20020a252205000000b00b7dd3975c51mr16216140ybi.17.1680513097861;
        Mon, 03 Apr 2023 02:11:37 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id e185-20020a81a7c2000000b00545a08184cesm2374332ywh.94.2023.04.03.02.11.37
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:11:37 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id j7so33926007ybg.4
        for <linux-fbdev@vger.kernel.org>; Mon, 03 Apr 2023 02:11:37 -0700 (PDT)
X-Received: by 2002:a25:2749:0:b0:a99:de9d:d504 with SMTP id
 n70-20020a252749000000b00a99de9dd504mr22689985ybn.12.1680513097268; Mon, 03
 Apr 2023 02:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230326104232.3099222-1-geert@linux-m68k.org> <ZCLbduJjX0KS/kJx@ls3530>
In-Reply-To: <ZCLbduJjX0KS/kJx@ls3530>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Apr 2023 11:11:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUJ_Prt-JeukNJSfKC7f7X_WTz1Wc+hR77vHPGqJ0quaw@mail.gmail.com>
Message-ID: <CAMuHMdUJ_Prt-JeukNJSfKC7f7X_WTz1Wc+hR77vHPGqJ0quaw@mail.gmail.com>
Subject: Re: [PATCH fbtest] pnmtohex: Optionally use pkg-config for netpbm
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Mar 28, 2023 at 2:20 PM Helge Deller <deller@gmx.de> wrote:
> * Geert Uytterhoeven <geert@linux-m68k.org>:
> > As of libnetpbm11 in Debian/Ubuntu, the netpbm header files are no
> > longer located in the root include directory, but in a netbpm
> > subdirectory.  Fortunately the same version added support for
> > pkg-config.
> >
> > Support both old and new systems by using pkg-config, when available.
> >
> > Reported-by: Helge Deller <deller@gmx.de>
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > Helge: Does this fix the issue for you. I don't have a system with
> >        libnetpbm11 handy yet.
>
> Yes, thanks a lot!
>
> That fixes the build on parisc on Debian 12.0 for me.
> You may add:
> Tested-by: Helge Deller <deller@gmx.de>
>
> I tried on my Fedora 36/x86_64 as well, and there netpbm-devel
> sadly comes without pkg-config. Nevertheless, based on top of
> your patch by hacking in the include path fixed the issue there
> as well.
> Maybe you can consider applying below patch on top of yours as too?
>
> Helge
> ---------
>
> [PATCH] Add netpbm to include search patch
>
> Netpbm on Fedora 36 comes without pkg-config, so
> manually add the include path.
>
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
and applying.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
