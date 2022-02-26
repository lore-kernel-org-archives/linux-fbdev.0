Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0092BC433EF
	for <linux-fbdev@archiver.kernel.org>; Sat, 26 Feb 2022 12:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiBZMpT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 26 Feb 2022 07:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiBZMpT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 26 Feb 2022 07:45:19 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392421E376D;
        Sat, 26 Feb 2022 04:44:45 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z16so7039843pfh.3;
        Sat, 26 Feb 2022 04:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Sn/z8nvM161fdH6pWEKCkPPFVvsowaWegFT2G61xxdw=;
        b=EhMLDaNjtyW/hlVkocLTA0AAr0EdD+vS7deyFf2QCBdw6Qt7WDODTALdL7nkPdsKHq
         fL3fhkiafWtGq/bybIKmQkjkMdd+6CrK1io3dGiOMOaLRDTC/RHu9n3rP6GD5HheKbqR
         xTzWeZPLboOns2VrxG7nVV78ouXZP3zlebPpdenHzxG7zHb+hjx1T3GmXRiZqeIjBOdL
         WD4pb9WXKfqKp8GTuruR3VURHlt85wj2iLGxzr1QSUEAJkfTdj+By0zdjGpLYUE3ubEi
         /GGaKUY2rDcyX7IRuoXRcopVir/27Q1anA61orf3WfSD+jgRLUWW9rYr5vwefsTLjKLX
         bCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Sn/z8nvM161fdH6pWEKCkPPFVvsowaWegFT2G61xxdw=;
        b=js2HXinDFykwVh11CGFyd04BFnVxqyTIYyVGb2EtPss3u36swXu9vncljXbUIc6357
         24M/Wcq6flSvgltjIdAds3ax/bCvtEVpNz/uKycRG9VHAZCffRpdyMIPsnXtRfS7XKaN
         swEJpQFMsLRPoMfGYPv2lNhwXzOSoawa3XP7g9naiLOFNH0Gw9H23rEh+X8v58pp/tEp
         Oyx2nSAGD7pkl/QGHbvRUYuQMaa3HlCQqv6VeesqC8Mm5otinq1NiwUWcR1TjgzF8JzQ
         3E0ao+aCw8IIabH5rjtVlEQAJyRrLJtQB7Pu2arvZ/l8GeiQ7AxM2uh8Sp79GICZixmV
         SVVA==
X-Gm-Message-State: AOAM5311+zEQpImGWIbPb/f5FWVar1YLh+dG4leufcG08jRat6B3jVTw
        65Tjf+3hFIaez56ky11DD+SG2E5XF46uhcWavQ==
X-Google-Smtp-Source: ABdhPJwS3wcSDYAdmHpH2aX2ySuYxUZzrV58f1pG5p33jYqqYGekq0LtiJfVEM6dmLuNgLbfXP5CWjhh1NWxw5TWeS0=
X-Received: by 2002:a05:6a00:1991:b0:4e1:a7dd:96e5 with SMTP id
 d17-20020a056a00199100b004e1a7dd96e5mr12734448pfl.2.1645879484788; Sat, 26
 Feb 2022 04:44:44 -0800 (PST)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sat, 26 Feb 2022 20:44:33 +0800
Message-ID: <CAMhUBjmetJqbERvQ8513b-wHuV68hqLTuUVWiORyJyXP26gO7Q@mail.gmail.com>
Subject: [BUG] fbdev: sm712fb: Page fault in smtcfb_read
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

I found a minor in the smtcfb_read() function of the driver sm712fb.

This read function can not handle the case that the size of the
buffer is 3 and does not check for it, which may cause a page fault.

Here is a simple PoC:

#include <endian.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

int main(void)
{
    char buf[10];

    int fd = open("/dev/fb0", O_RDWR);
    read(fd, buf, 3);

    return 0;
}

The following log reveals it:

[ 2432.614490] BUG: unable to handle page fault for address: ffffc90001ffffff
[ 2432.618474] RIP: 0010:smtcfb_read+0x230/0x3e0
[ 2432.626551] Call Trace:
[ 2432.626770]  <TASK>
[ 2432.626950]  vfs_read+0x198/0xa00
[ 2432.627225]  ? do_sys_openat2+0x27d/0x350
[ 2432.627552]  ? __fget_light+0x54/0x340
[ 2432.627871]  ksys_read+0xce/0x190
[ 2432.628143]  do_syscall_64+0x43/0x90

Regards,
Zheyu Ma
