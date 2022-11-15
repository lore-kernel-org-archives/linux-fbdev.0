Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7B1C433FE
	for <linux-fbdev@archiver.kernel.org>; Tue, 15 Nov 2022 22:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiKOWix (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 15 Nov 2022 17:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiKOWiw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 15 Nov 2022 17:38:52 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DD1DEA4
        for <linux-fbdev@vger.kernel.org>; Tue, 15 Nov 2022 14:38:51 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id y14so39851072ejd.9
        for <linux-fbdev@vger.kernel.org>; Tue, 15 Nov 2022 14:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gnqA11iiuLChaY0HRtUDGCUom8icxowvJYIl0Uu61BU=;
        b=KUa84NfcB3wa5RH7Ijr6DhXn9S4M4Yu6VK5rgQFNJaxzb45HZXfQJkcT/JKfr5m4HA
         vR8iKUxqmDcHsYouRnG4SHZ0SQ0wn3FHjAwyUR24oo03KoJQhMZnR6EYUyKrzdgSMIZm
         donZugFRmoc/s0tRlNMlP0qO1ZmTXfOORMORHlRwJVcW0m2LyzZJYZyk6/2Vkwl/nH/P
         iaFq0V6yfxkq6dp7aLtN4mvmBJVbUH3RVat9KdZyDMafGST+FUuUtWiX0bATJwAcBhyG
         R2g0CuscFeIT9onflw1jPdGOGLlQtGIPapz1DpBUxH0uEpcRfzGbpkW5Pe5Cle5/CfNW
         p7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnqA11iiuLChaY0HRtUDGCUom8icxowvJYIl0Uu61BU=;
        b=ySXRpKUhrVnmb2VfnVnpaonvd4vZ2Jowz6PBbbdqw9Y94AsfI6chhIwMLcYws/Yap3
         htPBipC1LUhA26FW7/wWyCAaf6rL0v0wT6tDS+gwhPY+/NFWdsimLV8bfxGmfHL7KBPK
         NU4a5u/vJNxvjZYk7LvfLOg+mqZ4zuVlLeIR15UUAXDk4OdYbWlZNqS10TrQZCpy+H5m
         6pbEeZhQwI20YiiUSZaHadEC/1LkMmQt1izI5/1ugayuNw8GH1HCbFva7T4oXmobx3Fp
         +pbLZ2MBwdgGUz4k3yhebN1tZOx/JorD8daQoxIeqCRcTyWtLAExPOHvOC5DIxvLXwZi
         bKrA==
X-Gm-Message-State: ANoB5plMgGa3AYH43Umjk6NAd+4VWKcV1CyKCS13wI3J2ZUG4kYr1lR+
        hwLJJkhxQz3t2BPeszuAsIZdMbduaC4/ikhLqMOQmFWRuLn+yw==
X-Google-Smtp-Source: AA0mqf5EeAiVuVsx1/ZVEl14H7nvzS8uJh40s5dJvvg/CqzIlqLlEzzTNJdcNDX71dA75G/RnQUjXgSEUKZJciYRlSQ=
X-Received: by 2002:a17:906:ae43:b0:73f:40a9:62ff with SMTP id
 lf3-20020a170906ae4300b0073f40a962ffmr15632388ejb.678.1668551930113; Tue, 15
 Nov 2022 14:38:50 -0800 (PST)
MIME-Version: 1.0
References: <CAEYL+X9qahvtsi71thrOzzqdtq_mpdTyV1ZCqc-TvMH--7HqdQ@mail.gmail.com>
 <09b7b91c-4bae-0bba-7701-cb1f8c58c00b@gmx.de>
In-Reply-To: <09b7b91c-4bae-0bba-7701-cb1f8c58c00b@gmx.de>
From:   Zopolis0 <creatorsmithmdt@gmail.com>
Date:   Wed, 16 Nov 2022 09:38:38 +1100
Message-ID: <CAEYL+X9mM_m9HvdW-dMWDNWkyaY=Y7Y0TeZP3w3K7RA066RNJA@mail.gmail.com>
Subject: Re: [PATCH] Add framebuffer device driver for gamecube/wii,
 incorporating Farter's work.
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

I'm not too familiar with DRM, unfortunately, so I can't give you a
great answer.

My current aim is just to get this and the other gc-linux patches into
upstream before they begin to rot.

But, I'd be happy to look into porting this to DRM after it's merged though.

On Wed, Nov 16, 2022 at 4:05 AM Helge Deller <deller@gmx.de> wrote:
>
> On 11/15/22 11:05, Zopolis0 wrote:
> > Just upstreaming the gc/wii framebuffer driver from gc-linux, and
> > incorporates Farter's patch to solve the color issue. See
> > https://fartersoft.com/blog/2011/06/22/hacking-up-an-rgb-framebuffer-driver-for-wii-linux/
> > and https://fartersoft.com/blog/2011/07/31/hacking-up-an-rgb-framebuffer-driver-for-wii-linux-take-two/.
>
> Just for the record:
> Is there a reason why it wasn't (or can't be) ported to DRM ?
> Looking at the patch (and the hardware behind it) I do see various reasons,
> but I'd like to hear it from you...
>
> Helge
