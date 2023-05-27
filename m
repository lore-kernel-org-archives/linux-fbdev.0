Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D87C77B7C
	for <linux-fbdev@archiver.kernel.org>; Sat, 27 May 2023 09:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjE0JjI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 27 May 2023 05:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjE0JjI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 27 May 2023 05:39:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D331DE3
        for <linux-fbdev@vger.kernel.org>; Sat, 27 May 2023 02:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1685180342; i=deller@gmx.de;
        bh=R9RX/dwotnnh7v3zQFXOlRjv2fsImL0ckXxAGe4BPxI=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=I7u5RVu7XL4PrNPrcgdeVeWEQy8gW1kRcxw1KjSLNcwnen5CcvTMxvrsOqZcYl2TC
         mNOi50x0TsMJy7S8yMhQBbtDWyaIEWk9bTRySGbJfAyahfl+GAtj7p23MLz8qomVB3
         H7Tg3DU5h5+nSxzsnbLHwFnB6oh+jK8hEP5xjtwzfoNiK5GnUZGMWy/E4ONns1GM+L
         ePEiu5JbaoxHNVcb7gr+c8LP7R9BmXSkpuxQS7IfTMn8G8+eVFWOmG/FXWWoLa84AP
         qEmLgt9oe+XniuOgQrMK41dVhB9TFbZfoBLFfZUArenIt4Sh6LByuyIFQt7ZCTGoiJ
         DbQuJ/bmXi9mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ls3530.fritz.box ([94.134.159.182]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4axg-1q4UHQ1FaQ-001jbn; Sat, 27
 May 2023 11:39:02 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] fbdev: imsttfb: Fix error path of imsttfb_probe()
Date:   Sat, 27 May 2023 11:39:01 +0200
Message-Id: <20230527093901.487483-1-deller@gmx.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HbCP5ui6rhvfxxfYGzrxBDTt/tfEDORI3+wHMZffEPk8DonkymS
 IsQh+zGRDs5V/TkGpOQnxDOQie104hKrNIb/ONpOkabHvtIkHlaDQ/TxAxnCyyfGwY7Peby
 KFXI7P2HKMOLL9W7zwsDrxXHYF22McPzUrD24HCh36LkJZY+D/OujX0Ej2VXV/qEZCn0oRt
 HXOyrsyikjTOm/tDmhIbA==
UI-OutboundReport: notjunk:1;M01:P0:+zBvTWCIjcQ=;h/5p0EkhWplg/royKpxq00Hv+nE
 AnhdghfOOZxfZcOaE5cr33UW0yPfQFd0LrszQkTxR2g8zIk07/I8z+YAbLSM4j/txM0ExxM6+
 B+cMMTYiY22kqz+nDVFjgDFdkLoNlcZj+5b7LF/IVRnWxmFncf0arFmBJvPPqZZmh9n86EoKN
 Nrf54UNt0QC0CbK5Ja7sSmBakY3SDnxvL+ProUOatohWGmwrHJfBXqb4Nyl/gAHKxZM4eAjJl
 +Uo325+MJu6WKqWxZXn6tEMaEsFUmFp47jAVdWtnaS3wpJB3whUR4LJDl1dR7MByH6HSBDQ/B
 cDxQyaC6IDBy1We8CtojngZVbwQi3rYTLSV8S0DXmaYa8yBbZ3ZQ0qzdL8IoF/Z/Q8I8gyVZo
 saDoLU6t3NYQpYPQJyEKGix9s442RGXGlT7Krt2ZVFpmOBJLw1htyRz9kn6+AT4fsCTZFIwSz
 souDbWceFe65KHIzfrFO8DbuJvMoEG56VwXziIl7bpPXMvAm4Zf37eacdYNcR+c72vQ8mucEr
 bugVwQhwPvptIPZHru8nNbItGJHsYqKhYCJG2LNH/CiVN8o2sXxn5j84txIPUNHhhv2EpIRF9
 SA9TGPbiU1hJ3fsw4X12Z3wC+Wqz8SURw4KGwyT8YZOgtPZZ3k6ISUxlkhgc3OUlrDdDREAK8
 04LLRuavn5GJFlK5cH9cz8ehaCfnpG0CoKf/+2KW1MBkR8CKWWDjxLRPlnCViUNFyxRK6qUU9
 dlC7VGOBSY9MnDkaP7dP9nRUdNiSUhEdJWUVaiWFcl6szvbxoxc+fcm7VFlVOZofS2BJQdOCq
 nz4ISqbK8zsZ+6/aKyNQa0kN077fWpqoNfPkZqVXdIZzQwoNWYFnMYn/nIrLTyLlkv6tXugpB
 6pXimI8kcOQgHgseuYXjvN0FuWZBpa0HZfPP1XsDVxTynwJ2RhKx1nu+25PcjruS/XG46kbF/
 vpwTUDguPMJhqPMheH/KRuwXyQk=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Release ressources when init_imstt() returns failure.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 drivers/video/fbdev/imsttfb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 075f11991281..ee7d01ad1406 100644
=2D-- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1535,8 +1535,10 @@ static int imsttfb_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
 		goto error;
 	info->pseudo_palette =3D par->palette;
 	ret =3D init_imstt(info);
-	if (!ret)
-		pci_set_drvdata(pdev, info);
+	if (ret)
+		goto error;
+
+	pci_set_drvdata(pdev, info);
 	return ret;

 error:
=2D-
2.40.1

