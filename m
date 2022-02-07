Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7392AC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Feb 2022 16:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiBGQS4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 7 Feb 2022 11:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442652AbiBGQEn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 7 Feb 2022 11:04:43 -0500
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 08:04:42 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38203C0401CC
        for <linux-fbdev@vger.kernel.org>; Mon,  7 Feb 2022 08:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644249880;
        bh=PusMMyGB9j5DK/8vXLrKOspyncNsqPE/lT4eYDsczGg=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=lJKFskM6AGe4THXEIMPOxI8hMzywdQX1TtmVHjslgLFnbQGq05OzRAtFr4lXG4wN5
         rFf+GoST8fSl5c9nrFsspne3btc8ORyHxWqdKSBiSYPAJ7Cj8WEHyuCz5QIl50FlmM
         YAMTJ+4sPwy9PAmL+hBlOn2esBGMrbfqhMdfMtn8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.138.144]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE6L-1nb7Jn3lyV-00Kkth; Mon, 07
 Feb 2022 16:59:32 +0100
Date:   Mon, 7 Feb 2022 16:59:31 +0100
From:   Helge Deller <deller@gmx.de>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] fbcon: Avoid 'cap' set but not used warning
Message-ID: <YgFB4xqI+As196FR@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:7yeZODKsx7xdHU5ifkxOE+5vb8a+10rpbvvIunOEeGsYcBNTQpz
 vg+w4W1qpadTKmjuV1H3Y1zr4TYIdaSFxAD/KEjbe+BD+oucJAwrd/uunj5UB1FsBRH55C+
 Ud+78k6ASXaCSuP2tAgCWe9g2MqmRSWnKOfQ75pYJEUVHaQIVhi+sRFmIXJTPed++EjWe8o
 KZvddRQwfZ9SyO6EVmFCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OzJc0WFtCu8=:J60mVPXFasi+VfcNYYg+B/
 wG7JNHs4CGQgVBG0Z9gJSLVn2EeYAz5nNpsYOce4/RiAbfPbwlAHPdbkF2iWKqVw0OFsARAZV
 L6134xrZQbdryJfnwVIdXpcY1fcM3TDH2zCKHil/gUFXPeBfvLDfXy4hW7yHANVlIlXfEliHo
 EPI8GJwGoEDhidLPEepNIn0TuZp98V2kkE6avlFU+A2F3wWy7gcIkL0JzZqZVI2G1xOJmOA0U
 5mjMLckMkFuurN0segPMVgm3P8sHi8pH7PP30xrjC7gvWcCEwFrAwF5XelwLXVUPIPS5Q0+Pt
 xnPD+AwbLJk07yFaqZAOY2XTh29D072APgyYJ2IV+LNUrhfynWOqCXMakNDYiX5r9ecsL60vd
 3VD4tfCnSrwlsfwDSAGtY+JuavwkAaMuq5L6jTTf2p2oLO0lL11yn18Nc/4IlWe7HveR86Rrh
 rUur5Sj36c9U+QKrHwWMUz1Z4AoFouULsb8q/CoVDHHc3lP0HNyGvCnKcpNDePMoNDAQqT0f/
 Gb4h9u0KoWXIEZygvh9fuQUnChgSqWBr8vbaiILwH4tqkUD7dDy2gel+BV4Gsjo/kkvjdT8TP
 g+0MhqDf7157WOcBM5I/EdD/O059dvuQRPdqXKb5LrOhtDjqyw5JnpBcoGjfrjYQIagYo2TSr
 85CR25Eo7ImNWQB3Ao47hSc0WfNKEuFV5vs4tGcTxCP5ZwNMq2Ev+OGIVTxY1/I/XYVllMIFL
 S5rTC3+ZuSxTGameEhPEQ7T6EVS2k2i2bp557KTCq0U98tqvo9eana1/ihMzFUAZcNaSFdyfh
 LACVp6HbyMk9OX5Fl2EA81bZoO/D4iBWGy3oDKHazoTZdJvcY6rmcpaIk3KN0Ff0FzcvnoZlp
 BNUCMx63sCmZ8tf0rjPF4s+0mq9yjEdB6oZBXp2jGgCU5K10Tdfvbs6vu3hWw0cO9ucZMTzAC
 Dd5a6v7ionI17NXys8C/s9ZGdFOg1caiKYpVkvhtGBL+4Z6RZcKA2aud64IA8mekz4Osdj706
 EE435mIDlUT5Y8H4/jYzXDb/oO93/JHRhZgiw5puY0E/NG6C6YMuUz3DHhsR1ZbaAu33DWKbS
 27HwoEJs/55F0c=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix this kernel test robot warning:

  drivers/video/fbdev/core/fbcon.c: In function 'fbcon_init':
  drivers/video/fbdev/core/fbcon.c:1028:6: warning: variable 'cap' set but=
 not used [-Wunused-but-set-variable]

The cap variable is only used when CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCEL=
ERATION
is enabled. Drop the temporary variable and use info->flags instead.

Fixes: 87ab9f6b7417 ("Revert "fbcon: Disable accelerated scrolling")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/f=
bcon.c
index f36829eeb5a9..2fc1b80a26ad 100644
=2D-- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1025,7 +1025,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 	struct vc_data *svc =3D *default_mode;
 	struct fbcon_display *t, *p =3D &fb_display[vc->vc_num];
 	int logo =3D 1, new_rows, new_cols, rows, cols;
-	int cap, ret;
+	int ret;

 	if (WARN_ON(info_idx =3D=3D -1))
 	    return;
@@ -1034,7 +1034,6 @@ static void fbcon_init(struct vc_data *vc, int init)
 		con2fb_map[vc->vc_num] =3D info_idx;

 	info =3D registered_fb[con2fb_map[vc->vc_num]];
-	cap =3D info->flags;

 	if (logo_shown < 0 && console_loglevel <=3D CONSOLE_LOGLEVEL_QUIET)
 		logo_shown =3D FBCON_LOGO_DONTSHOW;
@@ -1137,8 +1136,8 @@ static void fbcon_init(struct vc_data *vc, int init)
 	ops->graphics =3D 0;

 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
-	if ((cap & FBINFO_HWACCEL_COPYAREA) &&
-	    !(cap & FBINFO_HWACCEL_DISABLED))
+	if ((info->flags & FBINFO_HWACCEL_COPYAREA) &&
+	    !(info->flags & FBINFO_HWACCEL_DISABLED))
 		p->scrollmode =3D SCROLL_MOVE;
 	else /* default to something safe */
 		p->scrollmode =3D SCROLL_REDRAW;
