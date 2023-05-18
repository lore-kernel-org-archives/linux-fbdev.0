Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FD8C77B7A
	for <linux-fbdev@archiver.kernel.org>; Thu, 18 May 2023 07:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjERHkl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 18 May 2023 03:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjERHkk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 18 May 2023 03:40:40 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A7EEE
        for <linux-fbdev@vger.kernel.org>; Thu, 18 May 2023 00:40:39 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-76c6ba5fc22so78058639f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 18 May 2023 00:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684395638; x=1686987638;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdaBrx490s8k6dX8A9bwP75JHCsfXxu79WG1YDEQ+kU=;
        b=kShaaKK83u1q6paWnh7CzeF/g2y60mzkSIw41H+XxXRK9IVA0P4UYnSfjFl8StIjh6
         4lX8Y5suaXTU1DGVfsYVqwlXXhNPNLmyNjsp6E0ryL0Jsll2vZsQMPy1ZKbVZv+xvh4C
         ET/RdF+CMG59ZF+F1JlvZLcvA3HBE5LxbSsBLfbPiH5ue8u6vY5Iyb55n3pFFt+rd6u+
         IcFgisH1GtHHCTDpCogdMOvMwvKfAD2mmN6tIko8nJjbGU7lkgCCZQCE+5mZUXDEj9j4
         C/A1xW/Ok+Gu372HLjJOeZvFuQ4YmInJHpeBDR8/RvT6TvMClsKx0opuM9SetiE7WmAO
         N/QA==
X-Gm-Message-State: AC+VfDwKFhdN+Y9TpN+zmhWmCEjGZ0rlqZmdJ7kHEqxrYds95FSdLAO2
        D6poGCUsQquj7ls9pmmUdZOaUEJgDaA6gV2/h+D2Z0EXcO7D
X-Google-Smtp-Source: ACHHUZ5BSeJHwBlPAtnaWhHK6T9xhV3CzN1B/t33fjNEVVmiVfyZvhdq2Z74TG5jGUaYrDwcTXUEVGJx1XKuD6JL9ZzR1kLPfSI0
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3713:b0:40f:8f07:e28e with SMTP id
 k19-20020a056638371300b0040f8f07e28emr790444jav.1.1684395638617; Thu, 18 May
 2023 00:40:38 -0700 (PDT)
Date:   Thu, 18 May 2023 00:40:38 -0700
In-Reply-To: <ZGXVANMhn5j/jObU@ls3530>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3803905fbf2eb97@google.com>
Subject: Re: [syzbot] [fbdev?] [usb?] WARNING in dlfb_submit_urb/usb_submit_urb
 (2)
From:   syzbot <syzbot+0e22d63dcebb802b9bc8@syzkaller.appspotmail.com>
To:     bernie@plugable.com, deller@gmx.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/usb/core/urb.c
patch: **** unexpected end of file in patch



Tested on:

commit:         a4422ff2 usb: typec: qcom: Add Qualcomm PMIC Type-C dr..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
dashboard link: https://syzkaller.appspot.com/bug?extid=0e22d63dcebb802b9bc8
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1524090e280000

