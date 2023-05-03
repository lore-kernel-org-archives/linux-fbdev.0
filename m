Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7513C77B75
	for <linux-fbdev@archiver.kernel.org>; Wed,  3 May 2023 09:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjECJxE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 3 May 2023 05:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjECJwR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 3 May 2023 05:52:17 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EECA5B97
        for <linux-fbdev@vger.kernel.org>; Wed,  3 May 2023 02:51:25 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-55a64f0053fso43330957b3.3
        for <linux-fbdev@vger.kernel.org>; Wed, 03 May 2023 02:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683107484; x=1685699484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkwA2SG4jNMgczQ03V/PwVcxgOK6BA7kr8exPJlpnkE=;
        b=a501mlZUInYwOGHoIyzDR81cMFGG+4vZOHVhmQwep09M1DKpC5be9RbxPluYaAT1C4
         jgSil8B7/8GAkABn8LlVQ7M/kXZ9j1bCLvw7qNlL4jLj/SaLXxSy9I5xiTxpcjgXHUcI
         mowu3Yxw6yOJ03ENND5meE48oHWHVYtbVmb5nZ253vfjgz1xaWWWkLx2FkZ8aDajIlMn
         FduyZyAtGLLDXYcDbOA0O/lFMQcf6RdqIbVEil9iX8hBKrkMdIZSHh+tAt4aWGJdPzEi
         FuvbmkwqnGmSVWDrGg31TuA6ViHXlNQ57r28hcOf7GViXVwaNLfv7ZQcFzJMIr5OmjDL
         cIiQ==
X-Gm-Message-State: AC+VfDxyuB1BaoE0OyZTuraDHMv8SJA6II4Xlk5+/CLjb1uHQrxqrmEj
        /a98gIOVBsQKschtUo9Flt3o3SidEdy79w==
X-Google-Smtp-Source: ACHHUZ5funMPPdWU7kUDVZCZoTLGM8XIA8LHcThQe/lNqoXymVmzdiaBt/nw4AW+QRvguhH/Pl2hDg==
X-Received: by 2002:a0d:d5c5:0:b0:55a:a1dd:3f04 with SMTP id x188-20020a0dd5c5000000b0055aa1dd3f04mr4297872ywd.30.1683107483989;
        Wed, 03 May 2023 02:51:23 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id h1-20020a81b401000000b0054f80928ea4sm8444540ywi.140.2023.05.03.02.51.22
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 02:51:23 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-b9d8730fe5aso7223500276.1
        for <linux-fbdev@vger.kernel.org>; Wed, 03 May 2023 02:51:22 -0700 (PDT)
X-Received: by 2002:a25:4c84:0:b0:b9e:5006:42af with SMTP id
 z126-20020a254c84000000b00b9e500642afmr5825920yba.58.1683107482458; Wed, 03
 May 2023 02:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230428122452.4856-1-tzimmermann@suse.de> <20230428122452.4856-18-tzimmermann@suse.de>
In-Reply-To: <20230428122452.4856-18-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 May 2023 11:51:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUgsUsNaCvSA+jUNrOvZU3O2xF0b=MnA_GyL-HvAeZy5Q@mail.gmail.com>
Message-ID: <CAMuHMdUgsUsNaCvSA+jUNrOvZU3O2xF0b=MnA_GyL-HvAeZy5Q@mail.gmail.com>
Subject: Re: [PATCH v2 17/19] fbdev: Validate info->screen_{base,buffer} in
 fb_ops implementations
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        deller@gmx.de, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, Sui Jingfeng <suijingfeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Apr 28, 2023 at 2:26 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Push the test for info->screen_base from fb_read() and fb_write() into
> the implementations of struct fb_ops.{fb_read,fb_write}. In cases where
> the driver operates on info->screen_buffer, test this field instead.
>
> While bothi fields, screen_base and screen_buffer, are stored in the

both

> same location, they refer to different address spaces. For correctness,
> we want to test each field in exactly the code that uses it.

Not a direct comment for this patch: and later the union can be split
in two separate fields, to protect against misuse?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
