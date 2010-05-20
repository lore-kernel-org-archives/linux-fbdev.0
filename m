From: Frank Pan <frankpzh@gmail.com>
Date: Thu, 20 May 2010 01:56:25 +0000
Subject: Comments of fbcon_cw.c made a mistake
Message-Id: <AANLkTilhnzVtLsWqyllH5vhFIwDaUKllnkfxSyqKC6hv@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Greetings.

Recently I'm reading linux kernel and I've found this tiny problem.

=A0 =A0 The comment at top of fbcon_cw.c annonced it is fbcon_ud.c.

I'm strongly interested in linux kernel and wish to learn the
community. Although this problem is really not a big deal, but maybe
it's a good start, good chance to learn.

If I did anything unregular, please tell me. Thank you.

Here is my patch:

diff --git a/drivers/video/console/fbcon_cw.c b/drivers/video/console/fbcon=
_cw.c
index 126110f..2f51a51 100644
--- a/drivers/video/console/fbcon_cw.c
+++ b/drivers/video/console/fbcon_cw.c
@@ -1,5 +1,5 @@
/*
- * =A0linux/drivers/video/console/fbcon_ud.c -- Software Rotation - 90 deg=
rees
+ * =A0linux/drivers/video/console/fbcon_cw.c -- Software Rotation - 90 deg=
rees
=A0*
=A0* =A0 =A0 =A0Copyright (C) 2005 Antonino Daplas <adaplas @pol.net>
=A0*
