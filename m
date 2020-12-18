Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C754C4361B
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Dec 2020 15:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E6323B45
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Dec 2020 15:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgLRP2r (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Dec 2020 10:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLRP2r (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Dec 2020 10:28:47 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C19C0617A7
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Dec 2020 07:28:06 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id 2so1484845qtt.10
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Dec 2020 07:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3vBoddoAjf0IFyLATEzp2b+bWulu7D90uXUHegOXUg=;
        b=Si3oD44qeMyvjKcsH1+EDZWe5MQCPYs0WMqv6g7C6ZiGuj/z/vCP+x3cm/dPnUF2gw
         xz6pzCYoLKvC5uJBGAdDenkv029H1YsBVHcb4wDJVVQLlDYGrUPrciWoo/pb6jF22IN3
         v3hPs4FMysZym/YA71fhD38dRDVOJL7opsh2hIEIV2Qk5qGZyv/SP8+8065Ah230mK61
         T7RI1yQORhwXjgbifG0VISdHByeo6z1aW2vbFcFQZMufqjDPe4QHbRlEZExb0BbzaaEO
         2ncCXZgk2KfCkwTk9CuE5nTxRwKHDobAsHeb+XkBpCLb8BWEtmBZ7x4CbjTNQKC5Cz3+
         f//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3vBoddoAjf0IFyLATEzp2b+bWulu7D90uXUHegOXUg=;
        b=HpAk0P9o88xYVNbZIeVtYEV+5mGUVi2Yz4FXriBgr37cK1tfzn5tjiFv4Zgwb1vJnk
         r6VD2VSv+Zusccwvqq4n78Myk89tCeYQdqYWIYMJkHUluLFSa/YiEY4givimwI1zv8TZ
         pSO+/+KVuFJQsXK1lkMdffY4KlmPCwsitYZZPVrcsdDN3YPNYe6pT++ol+bsPeVLyH+B
         uSITZTacLN2LQnx/n0KXdU9DbhV+8E1cYQQiCch294LJa+DJ+1oPsbnrwXaeGUQcYLs/
         Sqw3HnC+LF9Ax/QrDp+FP7OpH/WlW1Ur9w2HZ5DjjIwUjzHUnnHvbJVSOIOvKbs2pB24
         sNXg==
X-Gm-Message-State: AOAM532Xv6ybR14UZGiYowZZRDk7b2w+zH0OMxmEyM9KBqOsrBYz7+Ae
        YthfmNM/r0bznXo2WPbxyYtcKoXUyQkbdnI6YqaPTQ==
X-Google-Smtp-Source: ABdhPJwW7m310B422NM+6uj5jd7lHxdtuQKuwhcqifNW0uu9yiOzNdR5vQRKoj3vZDABn1uaGcu1OlzjycvZ6jx9qzg=
X-Received: by 2002:ac8:4e1c:: with SMTP id c28mr4466988qtw.67.1608305285772;
 Fri, 18 Dec 2020 07:28:05 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b30cad05b0fc3d74@google.com> <000000000000fbf57305b6beb939@google.com>
In-Reply-To: <000000000000fbf57305b6beb939@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 18 Dec 2020 16:27:53 +0100
Message-ID: <CACT4Y+bgROPPaiah0S0N8Ju9cpj9xkeQ9FrMCfQeAuRdJy1Qqg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in cfb_imageblit
To:     syzbot <syzbot+dfd0b1c6705301cc4847@syzkaller.appspotmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        George Kennedy <george.kennedy@oracle.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Dec 18, 2020 at 4:26 PM syzbot
<syzbot+dfd0b1c6705301cc4847@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a49145acfb975d921464b84fe00279f99827d816
> Author: George Kennedy <george.kennedy@oracle.com>
> Date:   Tue Jul 7 19:26:03 2020 +0000
>
>     fbmem: add margin check to fb_check_caps()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1149f30f500000
> start commit:   22fbc037 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4e672827d2ffab1f
> dashboard link: https://syzkaller.appspot.com/bug?extid=dfd0b1c6705301cc4847
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ba9a5d900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cfd4af900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fbmem: add margin check to fb_check_caps()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: fbmem: add margin check to fb_check_caps()
