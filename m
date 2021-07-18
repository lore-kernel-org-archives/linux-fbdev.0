Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA368C636CA
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Jul 2021 13:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB188610D1
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Jul 2021 13:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhGRNnD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 18 Jul 2021 09:43:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:56411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233888AbhGRNnD (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 18 Jul 2021 09:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626615586;
        bh=1HpwNTaa7/EOz5SUy/Y+rxrxigaB7TM0uOC1wehYCrg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=XMibZM4erFJb4DEiqrUJM6aUE++xgTCwLSt9gbtnCFTXlapvMb6C/X/Ej9DcWFBWE
         UPffHDxauTm2chsRSrjtJAeQd1bzRMvKuTzl4b3bWoq62dtDG88/TQS1eWSydXKe1v
         YKeY4TFTUlnG3zmZ4PY67jSASp5y2KOQ3OKbJSJE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MpDJX-1lKkFJ0T5L-00qhpO; Sun, 18 Jul 2021 15:39:46 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/fbtft: Remove all strcpy() uses
Date:   Sun, 18 Jul 2021 15:39:20 +0200
Message-Id: <20210718133920.15825-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HvTzj7KWNq6lSz5rqYyCxz1ImlYgklH3XUyeJLH414jVQCNGtlD
 H7cs5ERBdJ56v8O/OP3sv+soRp7147NkxxBubzDV+FcZ2KAi3NKUAetOG6G4RR3aaxIKG7r
 XTdfgl9+Amv2+X0EiqIlaozKA1rZwqSvHbGpNrBUd+BVU1/vIfNFjwv+jYxVxJyVr9+lODZ
 FF/eigpKaZGpE735rCNJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ErRWAeYtbLk=:FXoDg8bzIG7LnbErPnu/F4
 Ebd61X57ICWz1bIIviyeV7DXSv4+28BdSm5JY1EElzcEaA79ja+EVZiraGLGEaH2GOwvGNlTu
 AjATrZCxr8eDXFxPW9Jw+DjvE44mZTM3JUomg45LsVUk/Q+NUCff4F2GtDRfXsEKcDPeEQE8O
 BFF7Vabl+TOWoxO9JhzQw1CC9gHo3JNbxFZfZNtozDHnqtNW6gb/JGruFSfoQSsn4dHYjbNuL
 QeconA+Rg4pN6CgN2NMNluaX9vdLhWrhXc3KrCoc2ct7w01ggODgWXX0O6ae6H3ZEgR/bSir/
 OdSx0OArvBsQ7TYLmp6+i8Y5DGVtMUYf8iQ5P3Cui/F4ipIPX09g0rKbXDZqtJuRefah1mxZf
 /NtddXTo1bNhwB84h4lBLL7yaZqW/p41ciyzQmgQjfx4b/VDpf2qblULn7VmHZwaj3i05iCZf
 t3SG5Sm0T0edhKilXt2Zp2jZequwP409Q3hn+NlmCGn1/NiBUOGKtbBW6wldNxl+YbbYRa+bU
 Mr9dBVv9i/RiXTovKXFMPuWCr1sGuIpHDz6rgSXdtgI/ZqLYnoN2RzM5fafJSOVGNWQvbxr1d
 0K7l2Y2UbibOdPF2QXL+KJIT/ClxuSzQoJZrChAdFUdON7ulOiuBd7zeXJOCCmqh5LCunR5bc
 lRQ7Hkg9rmtuE5lcV6R9qz7cayJM83jsZpOUznwhzNd66u8NjLyJLLQ4qG8JDmdyBsB7Ck9Wo
 f0wh9MsqSBzf4Zo1u5oZAD1IxkZqc1vpdsqYAhdjty5SMIe7p+ALn4f27LX0Vf1nzxBHnhZHk
 nr9tJFJ64s5/iASUNtkOGElaNEW9mmWs39LNr772/1KT6J8CxFDbOGRxEHG6ZIFpWqmUAf00u
 bx/TQgALY1tnbIEpIyau3hoUuu7pIr3SdcxdH0B0knvQlQzu8/H4CKHsOJyDeWCBrqtGHN/DQ
 fNBM4bXr+q6pOaT8yKdZzxQsKYuXiRywYmiKFmajmfBJijGHK2yEQbQ4wndhVmClRXZ7AlSlU
 Jgki++0PRRhcDAHiXzHBkTPwhpYvPSrAwKgj/Y9EPIoVC5XWh2djhO+fB2dXmMe3MBkjGrPD7
 nQTbLWG3ywsCXzj3IcltbNm1q4BxhOx5Lkm
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy() but in
this case it is simpler to add NULL to the first position since we want
to empty the string.

This is a previous step in the path to remove the strcpy() function.

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/staging/fbtft/fbtft-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fb=
tft-core.c
index 3723269890d5..b8791806cb20 100644
=2D-- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -1037,7 +1037,7 @@ int fbtft_init_display(struct fbtft_par *par)
 		case -1:
 			i++;
 			/* make debug message */
-			strcpy(msg, "");
+			msg[0] =3D 0;
 			j =3D i + 1;
 			while (par->init_sequence[j] >=3D 0) {
 				sprintf(str, "0x%02X ", par->init_sequence[j]);
=2D-
2.25.1

