Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2185C77B7C
	for <linux-fbdev@archiver.kernel.org>; Fri, 12 May 2023 07:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239930AbjELHoa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 12 May 2023 03:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240029AbjELHo3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 12 May 2023 03:44:29 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0D16A76
        for <linux-fbdev@vger.kernel.org>; Fri, 12 May 2023 00:44:25 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-55c939fb24dso89394557b3.2
        for <linux-fbdev@vger.kernel.org>; Fri, 12 May 2023 00:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683877465; x=1686469465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVUms8yStwCeZDJHHNJSmq1pOQB/QF2y9dUkoR2Z9pA=;
        b=EuX3VstAgo3CCHnlZ/O4rfhCbcv0GP3w/o+g0gh1rMqje+yLC+pBzZuR6/oFAbyBlH
         VrYmnt2xiuKgofYXjGrQ8pX85rWrciFED6Hci2DdGpWV68+2KlqAGmpBB7xNV1Mlrv69
         xTnQjuPVxY0y2YRhx6WSG4yqC5GocpHTmwBSEcELz0z6i+IyQHCBrA4X5qg5VytXugxo
         LSLGfhjYgOzRPIExkQiiXRYnmvACdX5/myldP26/Z1DY9sw6EBl/onsP3M5aeU0OxZ12
         RREDRalzXt4c5bHKuUVJ/a2q71zQ0LUE3iRtWWchXNYAvBL8XQ3Em4klqGQjXZIC6ZwQ
         /MJg==
X-Gm-Message-State: AC+VfDy36J0h3/OIAUsLKh9AnO1TOe2HrG49ddbG1jBC1vXSX3LHoapY
        DYn/GMm6Ov5Mgdawdd9Eo0o64g0qReESGGjZ
X-Google-Smtp-Source: ACHHUZ5X307XSYf7/U3+S4TNuEkjXZnwZf75hfIRNtdfdZjbUwUtlZw6p91p3XIT2J53Rz3LgyWPFg==
X-Received: by 2002:a81:4602:0:b0:55a:c42:406d with SMTP id t2-20020a814602000000b0055a0c42406dmr23143700ywa.3.1683877464717;
        Fri, 12 May 2023 00:44:24 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id s66-20020a817745000000b0055aaccfa2c7sm5505869ywc.91.2023.05.12.00.44.24
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 00:44:24 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-55a8019379fso89549357b3.0
        for <linux-fbdev@vger.kernel.org>; Fri, 12 May 2023 00:44:24 -0700 (PDT)
X-Received: by 2002:a81:bf52:0:b0:549:2623:6f65 with SMTP id
 s18-20020a81bf52000000b0054926236f65mr24267248ywk.33.1683877464030; Fri, 12
 May 2023 00:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <ZERQiub7tuTxHCUy@p100>
In-Reply-To: <ZERQiub7tuTxHCUy@p100>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 May 2023 09:44:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXZuqj=vwTmHmnBHgZ975dD_m_Gk6Q1=CsGCqzcfcMbsA@mail.gmail.com>
Message-ID: <CAMuHMdXZuqj=vwTmHmnBHgZ975dD_m_Gk6Q1=CsGCqzcfcMbsA@mail.gmail.com>
Subject: Re: [PATCH] fbdev: modedb: Add a 1920x1080 at 60 Hz video mode
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

On Sat, Apr 22, 2023 at 11:27 PM Helge Deller <deller@gmx.de> wrote:
> Add typical resolution for Full-HD monitors.
>
> Signed-off-by: Helge Deller <deller@gmx.de>

> --- a/drivers/video/fbdev/core/modedb.c
> +++ b/drivers/video/fbdev/core/modedb.c
> @@ -257,6 +257,10 @@ static const struct fb_videomode modedb[] = {
>         { NULL, 72, 480, 300, 33386, 40, 24, 11, 19, 80, 3, 0,
>                 FB_VMODE_DOUBLE },
>
> +       /* 1920x1080 @ 60 Hz, 67.3 kHz hsync */
> +       { NULL, 60, 1920, 1080, 6734, 148, 88, 63, 4, 44, 5, 0,
> +               FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT },

This matches [1], except for the "63", which looks like a typo for "36"
(total number of lines should be 1125, not 1152).

> +
>         /* 1920x1200 @ 60 Hz, 74.5 Khz hsync */
>         { NULL, 60, 1920, 1200, 5177, 128, 336, 1, 38, 208, 3,
>                 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,

[1] https://projectf.io/posts/video-timings-vga-720p-1080p/#hd-1920x1080-60-hz

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
