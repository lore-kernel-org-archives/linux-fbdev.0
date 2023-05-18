Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DAAC77B7D
	for <linux-fbdev@archiver.kernel.org>; Thu, 18 May 2023 21:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjERVIa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 18 May 2023 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjERVIa (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 18 May 2023 17:08:30 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5235B10DF
        for <linux-fbdev@vger.kernel.org>; Thu, 18 May 2023 14:08:27 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3381de222c3so20462385ab.2
        for <linux-fbdev@vger.kernel.org>; Thu, 18 May 2023 14:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684444106; x=1687036106;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCJmZhikEGgvshSFtgr79kh24UyNzZUnmc8l6fNAyog=;
        b=O26aD1NUMZ2pNwJib4/WgOg4U2sXg2F3kJCubaAVEFGdY9cwiKxqmCL5I+jDYKS3Hq
         QJ/BhpoyFuIT/nAuC9vClh1cwK7VgV/OjhutnrzuUc0OO6QP+em4d+s9vU4NMV4HdbwU
         I4qCGNsd74IqXMBSaOXnWzVQDgbHn3iEz5mL1eZoQJnh7U2nqtg3H4CSq3joqt+rPwx1
         P87vx+s9VaE0um70jHhTtybN3UzfzyTbvygPunvzLWG7vqvSftkV+kI7jcgaowr+p4Zs
         Vlx2GKfoVG6O7irQO9/lkUKo+PiLPpGyFTIUYruI1/HEzmmjIax4DiX4MN5zCNHwyWkC
         3smA==
X-Gm-Message-State: AC+VfDwhUSs5ZCTFAnyPJQ1ApKjLsXLQuCBLfHPlgFSmoWMu46MP4tWG
        cfyBpG+nEgsW1e3ThGW3UzuAbNdy9Bje6kj/m3eN1B9VmR/4
X-Google-Smtp-Source: ACHHUZ6O+AwC9jQ6/HWx9bF4gsIW4ateeFT9tlEiAvl6X0cm+bMtLLafLfqIApH9fHqyJCPWOSItmHrhVXZe54RUpchQdppkkfQY
MIME-Version: 1.0
X-Received: by 2002:a02:93c7:0:b0:416:5d0f:f494 with SMTP id
 z65-20020a0293c7000000b004165d0ff494mr1952410jah.5.1684444106608; Thu, 18 May
 2023 14:08:26 -0700 (PDT)
Date:   Thu, 18 May 2023 14:08:26 -0700
In-Reply-To: <c7b8e69a-cabe-4e17-a511-66179259d1d7@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e5a1c05fbfe34c5@google.com>
Subject: Re: [syzbot] [fbdev?] [usb?] WARNING in dlfb_submit_urb/usb_submit_urb
 (2)
From:   syzbot <syzbot+0e22d63dcebb802b9bc8@syzkaller.appspotmail.com>
To:     bernie@plugable.com, deller@gmx.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0e22d63dcebb802b9bc8@syzkaller.appspotmail.com

Tested on:

commit:         a4422ff2 usb: typec: qcom: Add Qualcomm PMIC Type-C dr..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10b6b9a6280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2414a945e4542ec1
dashboard link: https://syzkaller.appspot.com/bug?extid=0e22d63dcebb802b9bc8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1374e5a6280000

Note: testing is done by a robot and is best-effort only.
