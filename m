Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96646C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 10 May 2022 00:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiEJAR4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 May 2022 20:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiEJARz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 May 2022 20:17:55 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DD01EAF0
        for <linux-fbdev@vger.kernel.org>; Mon,  9 May 2022 17:13:59 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id g11-20020a9d648b000000b00605e4278793so11208887otl.7
        for <linux-fbdev@vger.kernel.org>; Mon, 09 May 2022 17:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=e3lMmzLEEo9uKNn+GEq/CC8Y3S70VLZ4rzRZ6Vhxax8=;
        b=B0hOBXHfedrPiamzT/HX+z9NZdjbxH3vguoW7TD6Gyb3i5W364HzVE5B9LpGUWbTJo
         XZk0iI4/nqnrjV5vXd60kXtPPslP6Cl2EZpnLtLatx88fVxzfibIUpG38XFeSil9IqbI
         NzBtZ+bpJmqOoAGSKvOcChe68ZaPOamSNgrMiyLCx/a99/HzbKgi9m5pdtqC9jTIEqyw
         Aykz/e3VDOD3/Fh4GiDcFc+MSw7tAjhCSSqibAp1Y1K9H0AtBKJDpklwuVUAiZchekXR
         kZ/V5C+WlAFOtP9j0oBKxHxp4KVtbCdfuVU9SqMV5tdUo8cLBrCMXqu2L7LoT5XSX03y
         Gj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=e3lMmzLEEo9uKNn+GEq/CC8Y3S70VLZ4rzRZ6Vhxax8=;
        b=Fn44stDGJVQBVoK6jcKVqMGRHtBxoV0tTQVtCoOt1Fbn+T/95UdUjct0bwC8DRA0km
         W5SslphgxkPrRt17g4QiMo2pNj4HTqtx0O7noBxMxfIyAWHRj2rB0eTtIvin/eFU0jw0
         D/ZT0Mg8eFLm46NQh86UmG8vgyZqXBQ4TOKG4/FjkiWH0cjym2wJqf26ObvGl+cbRPB5
         fkBbsdJ5kVNSdv0j0ZBB8o++mXVK/D3jf6zXceSwdUbzZRro/oG/8zA3VM5XFp5w8IYU
         RyCFfOlZkmSNFv/jAN8wSt0JCf0yeKxyJryHNkpS/R+0h265vZx37DXv7oYZ1JIFdnNu
         aKOw==
X-Gm-Message-State: AOAM532fgalimgkuHL4eTmA0qfSC0JZ3KcmeiZHhn4Qjl1++vko7Ci+H
        mq5lHt9leZVD/nCDotmToIBZwILRC+7H4qlDuTYpl6en
X-Google-Smtp-Source: ABdhPJxunTPaJCVln+69RsCyllw4IrnbJZmGX0WfSKyWwDTBw7s0MQU3aKvaP3SIcacL0nmuNPi6PHIRSZlJuxFaDIQ=
X-Received: by 2002:a05:6830:13c4:b0:606:1c11:742 with SMTP id
 e4-20020a05683013c400b006061c110742mr6973286otq.347.1652141638177; Mon, 09
 May 2022 17:13:58 -0700 (PDT)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Mon, 9 May 2022 17:13:47 -0700
Message-ID: <CAGRSmLsJMZ1aO7E7vjOzHNXyNGXc9A39wVB9PEGkJ8m4eW7sTg@mail.gmail.com>
Subject: Waking from sleep results in no video?
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
