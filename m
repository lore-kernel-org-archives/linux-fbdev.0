Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384F3C76196
	for <linux-fbdev@archiver.kernel.org>; Tue, 28 Mar 2023 12:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjC1MUN (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 28 Mar 2023 08:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjC1MUM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 28 Mar 2023 08:20:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC5E3ABF
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Mar 2023 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680006008; i=deller@gmx.de;
        bh=hAxrajVXBaUtN9HJQ5DY3rfiIP8VPQro+37qLEvimg4=;
        h=X-UI-Sender-Class:Date:From:To:Subject:References:In-Reply-To;
        b=O1TVduqROlFdGzhRg7Iudahuazdhia+cpbDPtXSYjDwM7WzdF4tjTNH0udPsP1ZLN
         fGfKKTJYSfdzQG9wsFkqw5y1ylvey+tT03sgTuu+wOokMrFSTcCBhC9kulUw78qPvE
         TOtRZGkb2+4csLerqcm/AXGlP75pyOvsEbbjokTAKRdsqvYCqLy8dvfgOHFIe+OxQW
         lFmPqCTdKebvUjCNy0SyDymnJFAvXcQbGz0sWlE5ip7UJXJT4Oc5v2Vyd43CmkluYD
         TOxE0qABC1kgZ/26wM3yw64bP7sG/P3LJs8j2hjIWbFG2nUkVftSYDb9uhVrCzUksP
         TP1ejE28xtpTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ls3530 ([94.134.150.147]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7Ka-1pa0UU06XK-00BfUF; Tue, 28
 Mar 2023 14:20:08 +0200
Date:   Tue, 28 Mar 2023 14:20:06 +0200
From:   Helge Deller <deller@gmx.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH fbtest] pnmtohex: Optionally use pkg-config for netpbm
Message-ID: <ZCLbduJjX0KS/kJx@ls3530>
References: <20230326104232.3099222-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326104232.3099222-1-geert@linux-m68k.org>
X-Provags-ID: V03:K1:1P1sD5HlADpUk/9WMzh8QR+smA0xC3tO69OX/9HjNQYul6Ysl6o
 xbuXhCoFtRQXZFOke7VK/BjoNzbHy4X9an1xbrERwnB9QV0NdK+3N+Tn+fV7fwcmR0es8zN
 JeMB2EJCNlzD8Ld6U3xcxsfK2Rho0oyNkgcGUBJ4cR2AGDdM7lv1I64KOI/MVR3q/ZprkSE
 IviY5PXOSpR+AulzQYuMQ==
UI-OutboundReport: notjunk:1;M01:P0:spO6BEic68Y=;/wE5p+lx304E9PQDAr/PUnBXikD
 9Hal0x78p157yJz3iGoihNI4+WYNKwFU8jLp86BFYvwK935Al7idy9ZdQdSD1OMsnOKrzCsdo
 R/QeGy9a0IvYo2/tpblrb16wv8ytxlTAXmnQ3ilmGQMVm6GUYTrfY3QsVdMUhP+nBKnGulpHz
 i0D7C7NoM1lKklmjQEZ3vjpDDvPkC7qxV6ahKbCDDBKzDYQPUEfrHeEgm6PbpwWHMtn+TDDxX
 Ne3dU+O5OCgg2cvlETQp8mnFWSgHjI9o4PnsH0pLpY+xkBTh6npkPDFj5scNmfBypxj/8Vgj0
 wPn2fQ3YllgbqtvYWQz9XcDEZAIE232zITJvfEJ/Q2HvPNoxQk7BrPrY+L1NNNnE+bDZ/IlK4
 /iwp6P/8mO7AwpGrHX8uiCTYIzwX3t3xraZGqAvcj80b9bSfaAfuInvsxOP6qmp4pMWw+yUA+
 AnRUWJZ6VMrKru+KohfyqhUyukc+X/SV/+7HI5rUEf5bpsmYVm33VSfQgu84XJLn4ke8HOQp3
 MeLeT4JktOKUVyWGgWiciAyE0q9zPxZ8cVw95YFpj7g3PYCkijdbh4j59/fGB3RsL75DUF+9S
 IT57FwDiy/rTFsqI2C+UzJAc1rzc66Z40nwL8XAgMzp8oEmnDFq+KLfPbcSiz/vfCNAM+iwUC
 owdg94zOPgqFAS29vSwqAHCY8lopoT4+edWG8D4hHIPcfNjsSGE/AatFG2GQmY+54xKuBqtv7
 kQ91dzHaJ4fYgLoEDmg2uRTnushQmUj+ikYkCcAAaBX0T6Rzot35ZHVZv0IaawV/suY+8rZwr
 5wZx3A20YO6p7BJFhCmx3At418sLcVnuMN8nORjRfuYXbtb6bLL6lcEFdpRo6t0NYk4+wJm5q
 x18CF1xL+DTceHMDbUPZlVfMIBdPAiv6iuRVcvo//MrWgMPuzNE95dWS6Os4rY6v14aPgtZ76
 8rV4cnDAj2a208FWtIWbJPTlSBM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

* Geert Uytterhoeven <geert@linux-m68k.org>:
> As of libnetpbm11 in Debian/Ubuntu, the netpbm header files are no
> longer located in the root include directory, but in a netbpm
> subdirectory.  Fortunately the same version added support for
> pkg-config.
>
> Support both old and new systems by using pkg-config, when available.
>
> Reported-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Helge: Does this fix the issue for you. I don't have a system with
>        libnetpbm11 handy yet.

Yes, thanks a lot!

That fixes the build on parisc on Debian 12.0 for me.
You may add:
Tested-by: Helge Deller <deller@gmx.de>

I tried on my Fedora 36/x86_64 as well, and there netpbm-devel
sadly comes without pkg-config. Nevertheless, based on top of
your patch by hacking in the include path fixed the issue there
as well.
Maybe you can consider applying below patch on top of yours as too?

Helge
=2D--------

[PATCH] Add netpbm to include search patch

Netpbm on Fedora 36 comes without pkg-config, so
manually add the include path.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--

diff --git a/pnmtohex/Makefile b/pnmtohex/Makefile
index 642a26f..d8925a9 100644
=2D-- a/pnmtohex/Makefile
+++ b/pnmtohex/Makefile
@@ -4,6 +4,7 @@ TOPDIR =3D ..
 HOST_TARGET =3D pnmtohex

 CFLAGS +=3D $(shell pkg-config --exists netpbm && pkg-config --cflags net=
pbm)
+CFLAGS +=3D -I/usr/include/netpbm

 # Modern distro's (e.g. Debian, Fedora Core) seem to have -lnetpbm only
 #LIBS +=3D -lnetpnm -lnetpbm -lnetpgm -lnetppm
