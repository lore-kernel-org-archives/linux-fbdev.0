Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44673C4338F
	for <linux-fbdev@archiver.kernel.org>; Sat, 24 Jul 2021 15:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0D160EB0
	for <linux-fbdev@archiver.kernel.org>; Sat, 24 Jul 2021 15:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhGXOeP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 24 Jul 2021 10:34:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:54725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhGXOeO (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 24 Jul 2021 10:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627139666;
        bh=4noc/sQzclIW/kkrihBjzzi6QwizoNZ8djRM4lvM73g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lWuupqZvPp60MW1gvccIpZbpV3BV0Y2OPov5Sl7JQNykMOhs0y4XHb1aDQI+3W1EK
         72fg87aV0FYCm4bkVOA9evD72G4d/VsyO/Ht1TCD87QWTwuK9Kb+Dc5okPtIpoAa47
         j3MOZRZoXmKxy9/DfQEYjAA37pXuK+eszRe+JCto=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N0oBr-1lBVhf04W5-00wpiS; Sat, 24 Jul 2021 17:14:26 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Remove all strcpy() uses
Date:   Sat, 24 Jul 2021 17:14:08 +0200
Message-Id: <20210724151411.9531-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CF3KTYSkqaOEngOglxyMd9EaNlUb1/dUGyEAN5GU0u03js5doC/
 EM/4b9OWhbjKSd8ru2UsL197JEJVkoJ01uJW+UCo8Ib0nVE/Kjg6/LwqUCSKrPRwG8tshkb
 nYwzaM44pjBoeFei5eLsV4sr1WCEw82bY3EGORYXF2KyoMTwfX22dqSBeoZuYNPF0q7qS3e
 FkZkqVqZaZAfI7lSgoHtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RqDB3YaQbQo=:uDk5LDovtG0+MYOzDQ8jE0
 XYwmMu2BOsBt4QV3A+LIE5bBK1CCjII05VUvqKg/Mq+SnYY15OFAcCDoU4oqr6KG4l9/SduzR
 oMVr2yCtPStMkFyLWSc6iLgDOCYNWC3f1Asi/OrmeHPzY29i79LYyxQMCqs/qwgp/iCo7MFwz
 qxBwtbbssO9Eo3VEfBuBJ7eQQ4JNYj5pf9ZWfz8+Rai4TmVKqaSidvF1DODPSaQ+G7sASDqiq
 yUATZhIyeyvq/syvBrhP0838+PavDK5tAmwoJOTLY4uXKjXG/p0koYD7JY/778lej8wa+FIOB
 tVeV20NTaqxbXR7N0EXRASQPsbEWGWIq4NbZUD4Xs84Hyp3X2dwBjrTJW7wr77Si/tAigRzT5
 GEEV2vSGQ1EkakyTcgQ8p8cGXPvFK4cZ+Rg4g5h2b+Zu9CgO/Xcf9WLLVmbvHprjqdBh6jX8L
 fGJ9Yq0urLwgLy2KFQ06TCCtxNSmM9ImwRO7SkR19l0jyCbI8vPTA+Ptd+gjPcSnc3W12LtId
 8m0vRazFbAKbllGDQIpdm1AEJbdRHHYg3TG1KPqXB04cInnWMAyFKf53abFuOzOZ5oWMHaNCV
 Q0nw+vpdAhASPyViMtyrZCnGw4DIzD0DYpqPHf/F0JMaMKcFXzZULFk2DukSMOIrTXfAl61uJ
 6AHTitFA+GghNqzceTrTtPf9kU/TC946QIMGpLYUDpa3pLGddyamwITInCUAok2uuC6JMUVO3
 Y42G7fIfR94JzSAhrE4+eoMthLKzr6Lu2n/LXhK99VIKhQ6Vo7cB8ZEXwMf1wPLRKp9fXjxd+
 u3ldvZgzvpDxNDU2jn9GjlBJLbUfnbJ8bzEDA5yB2E9Bgzp+IGTLM5TwBYni4miJMaX/KUFRE
 ZXb7/6smxzV5yy5fXMhBUOqvpLuv6JndVpdmSkNtt5HAFhubtaqrlxr/lUK7RAuUm/9tL4BxF
 Uq3mrkPa7MmCoEXO5hih8fo7AKMFHzLazw9tJdlU2SVZaKDCX0+Gjnm5yDDK28cAXkoMxG1qS
 ZG/vDRP9unJ2v4wiNdCU4v0D+PWjeXJJ53wfspsATd9hFnYnK6Qs7LFdFU0f8wOmy4ZmxnpEo
 w8RBvQq3A2+RAHE6Q4cl4G8Q3dJoN1P6UY2
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. So, this serie removes all strcpy uses
from the "staging/fbtft" subsystem.

Also, refactor the code a bit to follow the kernel coding-style and
avoid unnecessary variable initialization.

Changelog v1 -> v2
- Add two new commits to clean the code.
- Use the "%*ph" format specifier instead of strscpy() function (Geert
  Uytterhoeven)

Len Baker (3):
  staging/fbtft: Remove all strcpy() uses
  staging/fbtft: Remove unnecessary variable initialization
  staging/fbtft: Fix braces coding style

 drivers/staging/fbtft/fbtft-core.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

=2D-
2.25.1

