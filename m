Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0C2C7618A
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Mar 2023 10:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjCPKo0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Mar 2023 06:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCPKoZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Mar 2023 06:44:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B67A210A;
        Thu, 16 Mar 2023 03:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678963459; i=deller@gmx.de;
        bh=2s7QerBaS9X0wvTjyfDhJZktPqxrJpqluagPebLzD4g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=tSkdSMupbErjLZqs6kXKomVYdUMTSDQoxRbCxhQupHsGuF9XMXUc3oTqVDj1EAFv9
         b3Z+4M/x/+v0p8/2T8WHFNUttDtbn550SEmZFtX994GDy3vj5BFkT8VDBbZWZWP7gY
         5WV504aHCs0QhkR09Sop+U6I8lHoWOGJMZHiCRmJ2hnzAgEMGrTfse2F4vJQrYosJ4
         72GRm7FYkICICb171GnJjsoF7wGvkwTm9MgOH8PMhLgU7/y0wNvFeQ4Rzvxuad6ihI
         SUP1mbrJLhrOI9UVJH1uK6ECCsfnAU9Ok1VLkEm6qPrplzcj1ZloTk1i95bcjr1ZFi
         PBDzXqkYE6CuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ls3530.fritz.box ([94.134.149.95]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O6Y-1pfWFZ1z4g-003vtk; Thu, 16
 Mar 2023 11:44:19 +0100
From:   Helge Deller <deller@gmx.de>
To:     linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org
Cc:     deller@gmx.de
Subject: [PATCH] fbdev: stifb: Provide valid pixelclock and add fb_check_var() checks
Date:   Thu, 16 Mar 2023 11:44:18 +0100
Message-Id: <20230316104418.53585-1-deller@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SZEMMxgzeVuoP6yW3rfFeXc/EGD1kOyY4NRpxILCN6oU1Ov5qeR
 lXBTldT0pk5hIPssdiqyDqDSFryGmMQ38mLloB3wELUjrjk/QFRkNPPs3JyGpqRKqQ1/La+
 GSvNvyVuIlxVWnP3Er3aTRkhv5LCb9WN2GPtO0jjLFKnG6PHPdVzZEAGCccvMPh9+vBkLFC
 0Fev5wDrW82uzPmzCMkbA==
UI-OutboundReport: notjunk:1;M01:P0:ksDxpN3pcsI=;YJ0FGmywclJWPdQQFMlqBVLE962
 KRwHLSpXHtlZqsLkIn21S+Vwe+khP0Wf0cPDqLz21/mmHsEpD2WPosN9oZouPHW9WzxtGo9km
 siyok7H3PLorlEqcv2NUmuaNjYVw+R+fqEafOjwNUKu4fIDk5fEk2paefHT4WC1bR9hHsOyTc
 uclqhnkVCEp2aLljlSA4R/y9gbCo3VqyAgRBZ4MNfaM0JIh7bXrJDkFlMcC7ZPamIE+7qLMUs
 TjTWOjlFEvu1/Q56p0oa7vKSfWgsZTZUVJdVCraDR4F9A8snO0TRdHfuUv3e360tSXJdZJKm2
 wuujWprGWIhH5e2VDKKRV1rqwp4rX+Qs3GefopKdaWP+Moj6noZLNCW6WRN0ROE4soUEJBpT+
 cNh/0hMSsJl2RDUUtc01m07Nhr3ggU8YK9NuMsb/fEzPANqewnqOkqkIbtN78JSEFXNAF+Ah3
 lW9xq6d5NuW/OBXuG3HxyRyaf6M+AR1oXUnCPCZpRZ6TfQmkokCLePUx/gNWU/i6iaalMjAYu
 9HOMwHHBaPNyiC1IRoYvifszMNjAc5W3PLUHFvMgn3xDxVbUZTc2QmDatkWsYx56EL+CF9R41
 pRgsuDpT4Sfp3IkLmXHeG0Y79krgFpAtVeSw/GOnbyMUSz/FwrZvNiwlVnNKUf9fOWlGBNBAc
 HdokOSMAgTqVTpb4D81LuIcEmGXW/NXf6hcQJi8a6Pct6mIzXP9P/oAtkFuRBu+j8FXC9VIuP
 8dytKLVvYwQZpzLp0NoVOzQ3BJtBg8Acu7RRJC64Zy2pBWtGgOP5uC/A5DZQ6FnV3+gNhasdL
 nxoVHbCIWmETgDVmrTYWaQ8GFtXKlhoZxg79X9gbKZdvyrM9USgEQNVIXNgqnoxJZho61i4mi
 4yS8rQ+U6NSfkFn6cn9m96IR32m9QiJB1v496rsDsY+9adB9+qESe4LdpoMZc9ip2Q766a6Jd
 vto/HHTPJdlMuYSg4xSMeszSUoY=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Find a valid modeline depending on the machine graphic card
configuration and add the fb_check_var() function to validate
Xorg provided graphics settings.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org
=2D--
 drivers/video/fbdev/stifb.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index 3feb6e40d56d..cca88823df1f 100644
=2D-- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -921,6 +921,28 @@ SETUP_HCRX(struct stifb_info *fb)

 /* ------------------- driver specific functions ------------------------=
--- */

+static int
+stifb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct stifb_info *fb =3D container_of(info, struct stifb_info, info);
+
+	if (var->xres !=3D fb->info.var.xres ||
+	    var->yres !=3D fb->info.var.yres ||
+	    var->bits_per_pixel !=3D fb->info.var.bits_per_pixel)
+		return -EINVAL;
+
+	var->xres_virtual =3D var->xres;
+	var->yres_virtual =3D var->yres;
+	var->xoffset =3D 0;
+	var->yoffset =3D 0;
+	var->grayscale =3D fb->info.var.grayscale;
+	var->red.length =3D fb->info.var.red.length;
+	var->green.length =3D fb->info.var.green.length;
+	var->blue.length =3D fb->info.var.blue.length;
+
+	return 0;
+}
+
 static int
 stifb_setcolreg(u_int regno, u_int red, u_int green,
 	      u_int blue, u_int transp, struct fb_info *info)
@@ -1145,6 +1167,7 @@ stifb_init_display(struct stifb_info *fb)

 static const struct fb_ops stifb_ops =3D {
 	.owner		=3D THIS_MODULE,
+	.fb_check_var	=3D stifb_check_var,
 	.fb_setcolreg	=3D stifb_setcolreg,
 	.fb_blank	=3D stifb_blank,
 	.fb_fillrect	=3D stifb_fillrect,
@@ -1164,6 +1187,7 @@ static int __init stifb_init_fb(struct sti_struct *s=
ti, int bpp_pref)
 	struct stifb_info *fb;
 	struct fb_info *info;
 	unsigned long sti_rom_address;
+	char modestr[32];
 	char *dev_name;
 	int bpp, xres, yres;

@@ -1342,6 +1366,9 @@ static int __init stifb_init_fb(struct sti_struct *s=
ti, int bpp_pref)
 	info->flags =3D FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT;
 	info->pseudo_palette =3D &fb->pseudo_palette;

+	snprintf(modestr, sizeof(modestr), "%dx%d-%d", xres, yres, bpp);
+	fb_find_mode(&info->var, info, modestr, NULL, 0, NULL, bpp);
+
 	/* This has to be done !!! */
 	if (fb_alloc_cmap(&info->cmap, NR_PALETTE, 0))
 		goto out_err1;
=2D-
2.39.2

