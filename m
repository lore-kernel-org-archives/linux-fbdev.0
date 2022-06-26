Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6677CCA47C
	for <linux-fbdev@archiver.kernel.org>; Sun, 26 Jun 2022 10:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiFZK3B (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 26 Jun 2022 06:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiFZK3A (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 26 Jun 2022 06:29:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692D11C1F
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Jun 2022 03:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656239334;
        bh=j6RW8ENNf5nsY/5nr46mKXkS2nQvtyKcQa5Jw27h/EY=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=gdC7CsUxlJWA4JVIObkzh6DyRIu4/gbv2MvLkvMnECxKyCnDYF8tVcurK4Auh1gbF
         SuYYPM/jiOet8g8AQbRdcDlCHkFCnw3kj28NLuZpivwnqeFpDuYfvIWm2dqgXretAS
         K1e0jlJnSvaatGdPzoYe2eISxeB01ExcKJcXCsMc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.135.166]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU9j-1nSlF71viF-00egyi; Sun, 26
 Jun 2022 12:28:54 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel.vetter@ffwll.ch
Subject: [PATCH v6 2/4] fbmem: Prevent invalid virtual screen sizes
Date:   Sun, 26 Jun 2022 12:28:51 +0200
Message-Id: <20220626102853.124108-3-deller@gmx.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220626102853.124108-1-deller@gmx.de>
References: <20220626102853.124108-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n5URlIHOFY7d2NEdKov4I9Kd6OV7R+J8BJVzbPUlME0OTNKYRH4
 hPNdYn0EIERu7zSTAcno9eGSCqHmuqG+/JLi/EXlz9MVMMALyEQWQUtDvoLvKZsgROLPqui
 XEFmS6ggtGqtGm/0Bayfed06WVuGk7mzz6LDwUighkkzKClseUlBmB+ksQv7wHTblUMRvcj
 WY7r3t9WBpy1EQntiGERg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OwgMb80HTNE=:rc4lA6kA80/hFrHtJAKOfq
 Erbotzd+0RQd6nqYPIFm6ize8Hv/9tiz/PtKgxDdnQjfb8w2jDK3ty2WoSJqIHgyTeSeh1JKM
 AHGj6ZdXUtrAUEybqwiBaxB2iVsIduSL0cLDPsXkbg9O7zReQ8bl3KU/MfDEdiVWY3gaMVw5k
 T5XAhFRCZD7C+QhdRrceXbF5jh0KlAarT53NmyhSW1MKOTRRTeYRw0012LpZrAmKxm2yy2uNn
 jAJYPKCh7Ub7RE2ETfOnUdME7RYGE+oycjDRbWxsPIms7BhnX3DAOBENsm6zu2JPQLK7haxo1
 oIbdh8pUN60k5ps27PmKSio7DCKEJnbEE3MIlaXMk8R1nQUJZ3KbSm6pHkPh18lyoThadGpep
 xPjYFlnXf6dHH05+GdWusJQscOCriZuUnFrQc+Cb5ahJFNAZwoAm/86Qa8GNEiHqz/xU66k2w
 DpqDF1PI4KEjMY74fdcgwHvfKfFoMc+U4EmXKbrma3NzNi11Zj97i/cYUq4Hcxrgc/GcQvwE/
 iqvlUt4P61PxLyb5PQ+wGRA+z+WX2WsU5LWrwEQahIOqZcmTzk5oid7jHy8ca3TxVWxlYa9B7
 9fK6NtceCdHYVrWuyKmwYVbc47u6riH8FZw9IG52s1Ect14ygDVb8Rl1uReNtvsihs7xGWaQL
 MNGi091doEresePyXhze5XNmZyLBsYWXs1NN5TCTSrBVxPr4nbfQhfvX4Jn15H+18CEDjsYvn
 KGDzu63UWFMObkCaLHFY3JaEjl5nZ4LnYfdsqHrGTNMpyV8pmn5KiRZD8FHDm2xws3VO7ezNa
 W0XLaUmlKl5WiSIDXFPl9InK6UeZY0xPF10Wl4KPsDg3z63v+BtfGiQwbBTNpyu3fuOQQOaNa
 1L2BBprqEEQy4qXy8oAhF144BNNCVgO01Wl2JINAmFLrSwgnHEjhNhGKPe1sYXQW4mFXxID1g
 WkowOwWb/uVLZRZqYQd7D4HHOOfs5dKt5qxGap30EjqsNZHMQqjTr0FuPAIlWbJbyuAHRAXRN
 /MZ1ZASikZueVEDj0RnbxD02EZ1fANoFLk2WjIb/RPA9WjerV2A2Io9xviPbuZMA9lps4uX1n
 Gso+mo4ogrm9B4vANqNPnLuloiMhLC/VTCJWqdHm2+VHWd9dLd+noQ72Q==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Prevent that drivers or the user sets the virtual screen resolution
smaller than the physical screen resolution.  This is important, because
otherwise we may access memory outside of the graphics memory area.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: stable@vger.kernel.org # v5.4+
=2D--
 drivers/video/fbdev/core/fbmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/f=
bmem.c
index afa2863670f3..5dfa4bbee642 100644
=2D-- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1006,6 +1006,12 @@ fb_set_var(struct fb_info *info, struct fb_var_scre=
eninfo *var)
 	if (var->xres < 8 || var->yres < 8)
 		return -EINVAL;

+	/* make sure virtual resolution >=3D physical resolution */
+	if (var->xres_virtual < var->xres)
+		return -EINVAL;
+	if (var->yres_virtual < var->yres)
+		return -EINVAL;
+
 	/* Too huge resolution causes multiplication overflow. */
 	if (check_mul_overflow(var->xres, var->yres, &unused) ||
 	    check_mul_overflow(var->xres_virtual, var->yres_virtual, &unused))
=2D-
2.35.3

