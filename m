Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3250C433EF
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Oct 2021 20:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827C66058D
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Oct 2021 20:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhJaUmd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 31 Oct 2021 16:42:33 -0400
Received: from outbound5i.eu.mailhop.org ([35.156.234.212]:39175 "EHLO
        outbound5i.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhJaUmd (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 31 Oct 2021 16:42:33 -0400
X-Greylist: delayed 2702 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Oct 2021 16:42:32 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1635710036; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=NSph1UgDN2DifLzUFG2fVS3UIinm10v9nn7B+8yKQOicL/awEfp6I7i87obPZyVRwd7z7qBVDmrdZ
         yG0Ct+sbWtgWG2kxnVv/cUIjnjvHBe3HiajAzZ+lhuKmDORhaoolM+HwepffpU2AjWm8GXFNo6Qjhn
         uKjTjDXRDfCvHjMf06KWW4Bo3YWoyPUN9DqKIR+b8QX85PtNnsYyhmV2FO3VnMkddogw0a2iADWRoT
         XOQRVuuun4+UXXiZSiEyhdp7p2F0ohM9qqlj8JoAPZVQVeykstwRRI2q+TNvlZYzAV9aUruAXiUErX
         S1RAyEc36LiiELgGDRyx8srjvrmL3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         dkim-signature:dkim-signature:from;
        bh=JSLleUslv7HoqXJDmhfVsKtdTf2NrFmAB/s5mK0A9ZI=;
        b=QJ4J8ePbbUcmnCaFwu/PGy7cdtucYOh6rAZKVgrKgva7AnyYoRkEVruDXDWOSjyk5s+RBUcsCsZV2
         wcJcifrKwWnKODoSeHcWzzXXvrwQRGIaspee/7uUu1uD6sZ7tUkX1FjCVg98q1eILFWNPjgUHoMTaJ
         8HHtm5/2bb183+d5TwAHDtGXJk4FOur6m1+WemgzHtKxMCvDFSQ/D/kg4zJ613boXwVcbha99jvzGa
         C7Z+yQMtk55CCcW4vaQNW8CPWqh0QNylY4Wind7PNAPLHwglL8gWrRqj1p4Svwrboh+kSPp38OuEUX
         1i9NYCItJbGuln/mZ/7mz63FhL0zPnw==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
        spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=91.207.61.48;
        dmarc=none header.from=stackframe.org;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackframe.org; s=duo-1634547266507-560c42ae;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=JSLleUslv7HoqXJDmhfVsKtdTf2NrFmAB/s5mK0A9ZI=;
        b=RbTIrK2zDujsFPuj3+lLwA3DXfj63YKZgio+PAo2+uNyUcRo4iNyAkENZV1CA13XLid8H/Z+tuoPP
         JIvxw9eYBZ9pgx16EqnAp5LgPjNJeu2zIOzShPPkAwVjjHcUMmQzEMeN8c2uRo4Fzvpu2dd4cwfXd0
         i9mQdyR7rd/PJ5ko=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=JSLleUslv7HoqXJDmhfVsKtdTf2NrFmAB/s5mK0A9ZI=;
        b=VHmIM/PGCeGuASnE5YdhQsumH6S+/lvS5b3Cz3ub9OQnnpETOuaI/No1BbeuGvokV/nNspc8AS8xc
         rCwrP9klXFFwtrRoLXuGFIImHE1jpsRVJhZjBzBoK2GbW+ODKfi/7ZJTnVZejLKYFdcViS/NGFebcd
         asUgy2BiyxruLT/FbwHLJz/5qrgZTX5i1aD3FbRsiYJXSaR9QFWBewvGvegVr0Jnspoe2lNuOas3v0
         4IwWR6d5yt1zz7tAj46u88s62rN3dXot8qZwrhpsoS9Ozs7ryHJQzXhFJt8b2r73FCmEgnUmTjCrW6
         Ws0tCyW9Ep3Fu/kbr7/Z35eApmey3NQ==
X-Originating-IP: 91.207.61.48
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 46945188-3a84-11ec-a070-973b52397bcb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (propper.duncanthrax.net [91.207.61.48])
        by outbound2.eu.mailhop.org (Halon) with ESMTPSA
        id 46945188-3a84-11ec-a070-973b52397bcb;
        Sun, 31 Oct 2021 19:53:54 +0000 (UTC)
Received: from hsi-kbw-109-193-149-228.hsi7.kabel-badenwuerttemberg.de ([109.193.149.228] helo=x1.stackframe.org)
        by mail.duncanthrax.net with esmtpa (Exim 4.93)
        (envelope-from <svens@stackframe.org>)
        id 1mhGtt-00DEaN-0A; Sun, 31 Oct 2021 21:53:53 +0200
From:   Sven Schnelle <svens@stackframe.org>
To:     parisc-linux@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>
Subject: [PATCH/RFT] fbdev driver for HP Visualize FX cards
Date:   Sun, 31 Oct 2021 20:53:46 +0100
Message-Id: <20211031195347.13754-1-svens@stackframe.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi List(s),

i wrote a fbdev driver for the HP Visualize FX cards used some of the
PA-RISC workstations. It utilizes some of the 2D acceleration features
present in the card.

What is working right now:

- modesetting (tested all VESA modes between 640x480 - 1600x1200).
- hardware cursor
- 2D acceleration like imageblit and fillrect.

What is not (fully) working:

- X11 with fbdev. xinit + mwm looks almost ok, except some corruption
where the text cursor was drawn when it is moved.
- more advanced X11 programs. xfce4-session doesn't really show much.

I would be most interested if people could test this driver with their FX
cards and report. I know that Visualize FXe doesn't work because it uses
completely different register addresses. For FX10 i would hope that they
share the same register set as they are based on the same architecture.
Note that you have to disable the sticon driver, otherwhise that one would
hog the PCI card and visualizefx would never be probed.

Not sure about FX2/4/6. Might be different, might be not.

I obtained all the knowledge about the registers by watching what STI and the HP-UX
X Server writes into the card. So the register names might be called different
compared to what HP has written in their data books.

Sven.

