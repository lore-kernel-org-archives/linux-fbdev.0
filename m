Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7923AC77B75
	for <linux-fbdev@archiver.kernel.org>; Mon, 22 May 2023 14:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbjEVOEQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 22 May 2023 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbjEVOD5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 22 May 2023 10:03:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3271BD
        for <linux-fbdev@vger.kernel.org>; Mon, 22 May 2023 07:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684764216; i=deller@gmx.de;
        bh=Gj6SxtCLT4XjmrbpvARgY0QD61pClNlc9rMn1U4PyGc=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=EArW85OMcWLX9kc1H4a4P6SnQ0iWqGf4D5cyzgN6O5bYOV8aKtzqhbIivgvhnXMJN
         yIXsQ4K6slaCmXxpZua7cpMTKHsHotbwEfGWY6e2Gu3Ys3MEBjTSIj1LEZQM6Fe1L9
         2zVh0i9AlcOFqUqbupKjwLOiOlWdzl3krJEcBrBvu98tiQkhkdWCWiCBqUagZAkmjc
         Tv75iezLIVQvMZvTxnNyJVxvHELQYieVEGFTTcLiOZg+JrxBU6QWxGTvkEw7DF/R2E
         2sRxVz3fukfrH2BTrfD2qY6OyznkWww1V69FY5j9Wqk/1hVT836yg4qhTySVQeCmvG
         vchZG2qk0h/fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ls3530.fritz.box ([94.134.144.112]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvL5-1pbPsz1oqD-00Rnto; Mon, 22
 May 2023 15:58:16 +0200
From:   Helge Deller <deller@gmx.de>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 0/2] Fix STI console on 64-bit parisc machines
Date:   Mon, 22 May 2023 15:58:13 +0200
Message-Id: <20230522135815.38949-1-deller@gmx.de>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MIxYWhnQw2JFYElt10g/LYCbfVYDhiADUTPTk7DhWrrcAcAqEGk
 YwBE2YafL1ATw767rfGip6Z+fMzBtDNSEPMj6fdRGuHh9ocbGXQl+yKdGpVFR4gXAEL8Gpr
 fJ98P6VRYmhwu0R+e3EHwNpU62737xv+yQkc20G1IfxSex8XCfo7kekF/NxF9oM3xf1DCza
 XbJQsxu/caTS7EBpyoKwQ==
UI-OutboundReport: notjunk:1;M01:P0:c0EYAp3+O1E=;LTWYWTTIRmIvMMIPxZvRfbWpi95
 /jR8P7nTtKR+Z6IN3NKU9F8LkEICqEOYVYX+ChM5rH2IGC+pyH8+ey2gIm0neJDCzo3/3McEf
 90vQHUEkUZnyo64uO+bkPgyJkAb2EzakzcadwKeN5aW6467Ar0+YcIOauiLgBXIhvZB1huwne
 LZjwfrpYg33vsc3uT/sYe67acoRjqXUM3BXPftsKRO4SCKguapTUz2diFn9aOdzQBgsJrof4m
 hkBiKh4adrqXds4E5D1TB2gooYem6QEnHNGzU14q0ZFsBywE2/AKOvhVF6eRUEZLY+Lbwx4TB
 W//zdzhhSNgK2G/qV7H9LQ+LOJxUm5TeaG97HZLDhPshvKSaV49Ej4EntTt52B6w0Nq8Eq6Pq
 d0z3sGrJM1OITFiKzqwrQZq56CvB8bHyZqY7kUJAnjPuKXJCwjVCG1CSMhAdeAjcdKI8b9wHC
 x4aKKV3WC4FWVXBLsyZqy/pU0qmmVu8vKldJa6Ay5eQEXj/36a/l35uOskk/5Kf8knueVK/6v
 NLgCFrKhiYlz3kdiLyxQl6KnoA+/qAjUy1jU1zSJHcdw8COJBOp0zPU625UEqDDFoGN7G8T7g
 181cjMegLpy7FGNi+jAJGqCw2WpJoMKpoAxY8arPVRqJvyK3V/56y1HC3nQxCGbxVUQpaU/E8
 uoLS8MSCObKee9MGSzgCqWwx/Vg+//n2LQUil47Xk1asG/6U/2Ldyhq5X3yFgnn3/auxMxCic
 eD8fgkObZjvxxq8OxbT8EUnkGFKZ7EH1UIiW2NAgMMJKHdujWQOy6OronYe8m4HsIApQknHjN
 FfWz4irtmkWtIQYsli4cknYytgsWLJwzQTZ7+zDUtuj9m3ng6CLxqeNiLXE/RBzfLu0mafiXz
 2DrvnfUKu16IVpmZ61NKqyxEY4ULU2VvH5ed6IMHdPkUzTXTvl2GLsA794c27alIq3VF3559H
 oDbaXQ==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Two patches to fix the STI text console on parisc machines.

Helge Deller (2):
  sticon/parisc: Allow 64-bit STI calls in PDC firmware abstration
  sticon/parisc: Fix STI console on 64-bit only machines

 arch/parisc/include/asm/pdc.h |   4 +-
 arch/parisc/kernel/firmware.c |  21 +++--
 drivers/video/fbdev/stifb.c   |   4 +-
 drivers/video/sticore.c       | 159 ++++++++++++++++++++++------------
 include/video/sticore.h       |  42 ++++-----
 5 files changed, 143 insertions(+), 87 deletions(-)

=2D-
2.40.1

