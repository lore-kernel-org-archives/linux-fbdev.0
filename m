Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72528C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  7 Dec 2021 00:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348536AbhLGAYh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 6 Dec 2021 19:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378150AbhLGAYg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 6 Dec 2021 19:24:36 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921C6C061746
        for <linux-fbdev@vger.kernel.org>; Mon,  6 Dec 2021 16:21:07 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id j21so12018210ila.5
        for <linux-fbdev@vger.kernel.org>; Mon, 06 Dec 2021 16:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetfuse-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=OEQUVEa0On1ROZyo178VS8SIuI0aMzycc5+XI+5sljo=;
        b=EwLlaKoxdvgbwOrkZLIBPnC6fAkMhLIAERRHbWcHMQTpQseRL9lL8iVEkzhIvn4Ztb
         sGzon4371/F+BFhHn2tgwrp4C+yME+Ob4WV4sW9Ziz2UaDGHQpdnlo+/oh1OM85fYmjB
         ktfLxdaxguKdUDEXsziEBTH8RL5+1FtQi/AJ/rcvsmUYFLSdR+RzzLwjX/RcaqBQ7vun
         pPur+xMNprJIsUbMyM1GS1O05KDx5KX44j5HLmz6V/8ypV4ap07hZiRuBXhhJ0HrpDhD
         9CP7BYtWz/0L9bN4dAshSnaGNnrvWYa48nRxUlG3mCu/WyzITDXJHXeIyMpMI5waiife
         D3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=OEQUVEa0On1ROZyo178VS8SIuI0aMzycc5+XI+5sljo=;
        b=etv4Ff862Y1bt5DM8LyrJ33Gv7np0n5GJc3ZP08VKK0p6p8eomQM3EK4kV4KEfmNh9
         FsThxoYUXDH3FeUeJw2Th1v92zat0SgcmE9Ec34feq6tAJM1t/Xf54DZyT1F8RTv2Krj
         8LMcDF4k1Y4dlzDxFYRGZZoQCyW7iVWd7wRH9GlIzVr54JLtSgvAe4PaG2HK32FcKEYd
         CFfBO46Y1yxOAh14nWPtiVTB+sTNkT06CLI5Pnl8HR6dVvgdmw1g0qLu+egFtIIdgavX
         5CA+m3U0esfd+0Plz6LHkrUSLXwxpByLb7IxVq8uh8EymcWfpwseTPOwOzUEtHL8WLQT
         LVeA==
X-Gm-Message-State: AOAM53307O7HTbWxg2j6TfFntvSfGuUIKhWAQpeZb4KcPEDw9322aj7e
        Mf9lFJmCewjTwN4dL9Pk+Da63FCyNqcNhA==
X-Google-Smtp-Source: ABdhPJzJybdYG7+lMlmQbWMtPW+OOlSe+zP9KC9Tz+jZWspSGRY8bdGDoMvSKze/hFxYyW5Ap4H9JA==
X-Received: by 2002:a05:6e02:1749:: with SMTP id y9mr33878565ill.123.1638836466945;
        Mon, 06 Dec 2021 16:21:06 -0800 (PST)
Received: from [192.168.1.15] (174-082-179-210.res.spectrum.com. [174.82.179.210])
        by smtp.gmail.com with ESMTPSA id j21sm8468354ila.6.2021.12.06.16.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 16:21:06 -0800 (PST)
Message-ID: <8a27c986-4767-bd29-2073-6c4ffed49bba@jetfuse.net>
Date:   Mon, 6 Dec 2021 18:21:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     pjones@redhat.com
Cc:     linux-fbdev@vger.kernel.org
From:   Brandon Nielsen <nielsenb@jetfuse.net>
Subject: [Bug Report] Desktop monitor sleep regression
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Monitors no longer sleep properly on my system (dual monitor connected 
via DP->DVI, amdgpu, x86_64). The monitors slept properly on 5.14, but 
stopped during the 5.15 series. I have also filed this bug on the kernel 
bugzilla[0] and downstream[1].

I have performed a bisect, first "bad" commit to master is 
55285e21f04517939480966164a33898c34b2af2[1], the same change made it 
into the 5.15 branch as e3b39825ed0813f787cb3ebdc5ecaa5131623647. I have 
verified the issue exists in latest master 
(a51e3ac43ddbad891c2b1a4f3aa52371d6939570).


Steps to reproduce:

   1. Boot system (Fedora Workstation 35 in this case)
   2. Log in
   3. Lock screen (after a few seconds, monitors will enter power save 
"sleep" state with backlight off)
   4. Wait (usually no more than 30 seconds, sometimes up to a few minutes)
   5. Observe monitor leaving "sleep" state (backlight comes back on), 
but nothing is displayed


[0] - https://bugzilla.kernel.org/show_bug.cgi?id=215203
[1] - https://bugzilla.redhat.com/show_bug.cgi?id=2028613
