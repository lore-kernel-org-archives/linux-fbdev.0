Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F46C433E9
	for <linux-fbdev@archiver.kernel.org>; Mon, 18 Jan 2021 20:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFE822D6F
	for <linux-fbdev@archiver.kernel.org>; Mon, 18 Jan 2021 20:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388448AbhARKod (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 18 Jan 2021 05:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388674AbhARJac (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 18 Jan 2021 04:30:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CC8C0613CF
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Jan 2021 01:29:38 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q18so15747191wrn.1
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Jan 2021 01:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=CTgLJUEqtetOUnV2zas5KqZ4EY9oOOP8M49JHcOPywA=;
        b=I+4oFB0MgkgBjVm5Jj+c26yE7J3Obn5Uivn2n9Fp/Criu/5WvR9jSF+6l5Mftrkyl0
         LywxDJBSpWgUWo+Waeuq7vjxe7019LkJvKBZ9uv52xIojUEC5UNPNBiDsYwwfcZqtttt
         tPWp9hSxYCsHc8M4d3gCPY9KSWXKYYLIS378E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=CTgLJUEqtetOUnV2zas5KqZ4EY9oOOP8M49JHcOPywA=;
        b=lrU8hnRSArV3gGiMSIC4w80HOy34SZ2b0eOP1CC/1oOUUfDbXF52AUPo5EmeNag3Dg
         KeTq+VlFJFufrKYwSVXIvtNUftP5HSmeTTmpEAMX1oBroKqSPq/kxe+yukzXXtRYg6lY
         wveDXk5QJwEDRSyghk1VJKA14J0KOD17p3ceLgy9c9MAYyDqwLTOhYpqsElu4xhjRC5T
         S07Bkb6sTCxo8a89Y+zI9Rs5/po16Kkx2YiW54wSwf4j/Oz+Xzc5YxhBl3EZnlmc+Y7L
         KVk5VTZ/STINKJeWHgx0Ds9HBJ5uF6XKv5CnYMquzEmuu3yaOfe1+iZBDgcNh/VzuV5+
         uz5g==
X-Gm-Message-State: AOAM532HMCeHchZzLVjNzPnH58BvpxOqzn/7mxN1IrtWL8DTxRoWnMmr
        H1VndruiiJah65wJIx5HMq3FRw==
X-Google-Smtp-Source: ABdhPJwZD2NhTSuMUUe1JnXazKkGPQJ8zIJYw38ZA8GsmaChXIwZBv1OUFyczb0noJoTAULMPt4RQQ==
X-Received: by 2002:adf:dd09:: with SMTP id a9mr24721347wrm.90.1610962176960;
        Mon, 18 Jan 2021 01:29:36 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d7sm17087960wmb.47.2021.01.18.01.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 01:29:36 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:29:34 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     syzbot <syzbot+b67aaae8d3a927f68d20@syzkaller.appspotmail.com>
Cc:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        daniel.vetter@intel.com, dri-devel@lists.freedesktop.org,
        george.kennedy@oracle.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, melissa.srw@gmail.com,
        natechancellor@gmail.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de,
        yepeilin.cs@gmail.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 fbcon_cursor
Message-ID: <YAVU/vIwsqAzC7Qm@phenom.ffwll.local>
Mail-Followup-To: syzbot <syzbot+b67aaae8d3a927f68d20@syzkaller.appspotmail.com>,
        b.zolnierkie@samsung.com, daniel.vetter@intel.com,
        dri-devel@lists.freedesktop.org, george.kennedy@oracle.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        melissa.srw@gmail.com, natechancellor@gmail.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de,
        yepeilin.cs@gmail.com
References: <00000000000091111005b435456e@google.com>
 <000000000000c37b3a05b916e95a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c37b3a05b916e95a@google.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Jan 17, 2021 at 03:29:05AM -0800, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit ea40d7857d5250e5400f38c69ef9e17321e9c4a2
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date:   Fri Oct 9 23:21:56 2020 +0000
> 
>     drm/vkms: fbdev emulation support

Not sure you want to annotate this, but this just makes the bug
reproducible on vkms. It's a preexisting issue (probably a few decades
old) of the fbcon code afaict. It might also be that you can only repro
this when you have multiple fbcon drivers (vkms plus whatever your virtual
machine has I guess).
-Daniel

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148e2748d00000
> start commit:   b3a3cbde Add linux-next specific files for 20210115
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=168e2748d00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=128e2748d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6ea08dae6aab586f
> dashboard link: https://syzkaller.appspot.com/bug?extid=b67aaae8d3a927f68d20
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cd8fe0d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17af5258d00000
> 
> Reported-by: syzbot+b67aaae8d3a927f68d20@syzkaller.appspotmail.com
> Fixes: ea40d7857d52 ("drm/vkms: fbdev emulation support")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
