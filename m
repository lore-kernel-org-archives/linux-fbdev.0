Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ECEC433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 May 2022 06:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350280AbiELGXc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 12 May 2022 02:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350109AbiELGXa (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 12 May 2022 02:23:30 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F922590AE
        for <linux-fbdev@vger.kernel.org>; Wed, 11 May 2022 23:23:27 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id q10so5284226oia.9
        for <linux-fbdev@vger.kernel.org>; Wed, 11 May 2022 23:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=e3lMmzLEEo9uKNn+GEq/CC8Y3S70VLZ4rzRZ6Vhxax8=;
        b=AcV6S/7xzY8/8o4h54VXALSo/shWLG3oww8MEP9PGssn7ELQYftuYQUdiOZyRs0R0w
         jCHf0TClGN1WalShLaibVLoPPBjqkEnIucdASH8dTvUCocPmT52EvlYDlxtNYCMw86lo
         Ivuu2mH3n8LyBXo+EzfwJgGtvqELVvufW+jt5uvkZu8Nofl319WNepcuHHAYVbh3T1Eg
         n74mT+G9rK73Qz0PvFY6kmmQOHqrS7/ayPtF6VrsK+onSVVH/ZDeyZmWbkFcW154tzJh
         qf3jzLRy3j3sWZ5/39S0iuk85IQSGwWkFwpSgwOugVL5AA3CZentrJt85OWXCAxO/33X
         /cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=e3lMmzLEEo9uKNn+GEq/CC8Y3S70VLZ4rzRZ6Vhxax8=;
        b=5/HOWL1f22E4S88g29SddoKfLeYVf0Cw/R7UwMdZFzRjn2KUpbC4tePKZwF3cAoryz
         FHIpIKlNpkaRpgTHkQ74ImV4VSpZYFE3IBK48cAJj7EH2o1jbMc7mnJdq9TjWxi4c5OL
         w6YMOzkiP97o15QI6vSDUUYp1odI/Z3d0B5IvDzDRvJ3jhAE3R/qR9w9MgAbah/MvQhz
         5psk2uiXsLs1ujITl8zXqaQDjg2smVPV5w/WS30mww6ifODU1vL0mniRuJinwywNlhQ+
         8D43iuy3zHwnnwnpe0eC4CL3WrG1dIIVCkZ+1v+Q3z8t0e6cJlUPCGzUD4LPNgqoqkAI
         tfMw==
X-Gm-Message-State: AOAM531+l9mQybFHheSF1vtpk7O0le3Bk0Ed5Z6mYMoD2UScJvBmy+pl
        4s35jR1nmwjY6PKMRB63f0oYJkPUN218768T+C1iwIR5
X-Google-Smtp-Source: ABdhPJzOQaQ5Br/k+UDB2/KVFCykTN4kEL/HLQaRtK0cjeA7fbWIF2VeuYyQ+IC1IZEu+KMbYKNVGo0SnaJJbBzJ/r0=
X-Received: by 2002:a05:6808:1927:b0:326:9b99:abb6 with SMTP id
 bf39-20020a056808192700b003269b99abb6mr4446037oib.255.1652336606291; Wed, 11
 May 2022 23:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAGRSmLsJMZ1aO7E7vjOzHNXyNGXc9A39wVB9PEGkJ8m4eW7sTg@mail.gmail.com>
In-Reply-To: <CAGRSmLsJMZ1aO7E7vjOzHNXyNGXc9A39wVB9PEGkJ8m4eW7sTg@mail.gmail.com>
From:   "David F." <df7729@gmail.com>
Date:   Wed, 11 May 2022 23:23:15 -0700
Message-ID: <CAGRSmLtQ8HXvbTYQPxkwqk3E8EOyqMWedBM0KOsPp7NFQ6uh8g@mail.gmail.com>
Subject: Fwd: Waking from sleep results in no video?
To:     linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

I have a boot disk using framebuffer video.  If I put the system to
deep mem sleep via:

echo -n mem > /sys/power/state

Then the system wakes (either by having to press the power button or
keyboard or sometimes it just comes back on) and while I can use the
keyboard and type things I can tell are working, the video screen
stays black.  I tried on multiple systems with different video
adapters and even connectors, one using HDMI, another DVI, another old
VGA.  In no case does the video come back on.  The monitors just say
nothing detected.

Is there any trick to get the frame buffer video working again?

Is there any kernel config options I should be including in the build
for it to work with power management?

Thanks!!
