Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEF1C54E94
	for <linux-fbdev@archiver.kernel.org>; Tue, 24 Jan 2023 17:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjAXRXx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjAXRXw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 24 Jan 2023 12:23:52 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFDE4A1CD
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Jan 2023 09:23:51 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 207so11670707pfv.5
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Jan 2023 09:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+0nNRfjCiY62cIhTLLxOILNdEmv43GkeGwDLJSgq+54=;
        b=KERHFJmysDcwQBNOAlN+gp+2jnAw1CcO6J+pAe7fa0lKM6lW7VtVXnn4RZvxq0fiS0
         0rtGgZP32STP5sXxbA2Vsy/jF1jcF1aDH0vWlP3WvE90aQyvLVtiAMo7Pzrx8osxm7fk
         9JRWfI+N4FVB3ogvKeivLJbrht/WgeO13d93xTmHNm3vXsBQIN3cYlOQXjcI1zBIBUvT
         p3cis2Kf8ytsKJgZhjlBRTSbLxhw4qBIPgIgfTtNi9Ncs0b/zOaAWatfRhggXrydj5sg
         1JB7vPwGLEyY/OzQb+3nbtuNVKo6qamJNPS6Zj3QrVHUd5DTQg6DkWgF20IONQk12qM0
         L6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0nNRfjCiY62cIhTLLxOILNdEmv43GkeGwDLJSgq+54=;
        b=uNMj4kQJ0RfxDTT/1xdbHaJw5Lm7UsOkZ70uwqS8JstIHMhcNvv6z/9g/Oxx7E0x5D
         sae+D/RAzoZkAqKCvIJJeIwzvHxYusiRt4QotylDtAKYaB5bJ4V85zpal6OTCh688AkF
         /rl6TfcxeXLpEtkPxFr8IzIkpme8Mr/2r19S+FFa5MPpyldT36eyBFRNg7KlA41Awnji
         dqstUq4WMZtDqx/2ZrTu5lQCmLfHmB4ja9NFLwgU7d8jXgIQyJQpv5yW4bz/6atSIoqd
         EU2W5C9Z53RzNM6fj+dwd4NVrAtMKzOz0RfkuX2CeqsARsPSLuf4E8e2oaYz6a1g6LD4
         snfA==
X-Gm-Message-State: AFqh2kon9tKB/jC/Aew5aLPQjI7BLXRAuRFvDjrHjC22QTMed5GvWXjU
        zTx+kG4/FCa6ggAMq9bLX/s5Fa4WxnmFd2fhQZQ=
X-Received: by 2002:a05:6a00:b96:b0:58d:b8f6:6f6d with SMTP id
 g22-20020a056a000b9600b0058db8f66f6dmt4962857pfj.32.1674581031297; Tue, 24
 Jan 2023 09:23:51 -0800 (PST)
MIME-Version: 1.0
From:   novenary <streetwalkermc@gmail.com>
Date:   Tue, 24 Jan 2023 19:23:40 +0200
Message-ID: <CANnEQ3Ef5-XRSVL=RCBuKKhR0oZF+SO2BSSiBigZOyjMeQ7f_g@mail.gmail.com>
Subject: fbcon font is reset after GPU is loaded
Cc:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

This appears to be a pretty common problem. systemd includes a udev
rule[1] which loads a console font from userspace, using setfont from
the kbd package, when a vtcon device is added. According to udev debug
logs, this event only fires once.

This actually works fine all the way until the GPU driver is loaded,
after which the console is reverted to the default kernel font. My
understanding from skimming the code in fbcon.c is that fonts should
be persisted from one instance to the next.

I can reproduce this on both of my machines, one with an AMD Polaris
GPU, and one with Intel integrated graphics (Kaby Lake R).

As discussed in [2], it seems the only reliable way to change the
console font at the moment is to ensure that the graphics driver is
loaded before udev starts, but I don't believe this is an acceptable
or even correct solution.

Am I missing something? It would be really helpful if someone could
shed light on why this is happening.

[1] https://github.com/systemd/systemd/blob/main/rules.d/90-vconsole.rules.in
[2] https://github.com/NixOS/nixpkgs/issues/202846

Thanks in advance,
novenary
