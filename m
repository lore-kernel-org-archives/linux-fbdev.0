From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 0/4] Cell SPE logos
Date: Tue, 10 Jul 2007 14:27:02 +0200
Message-ID: <20070710122702.765654000@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755501AbXGJMgd@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="utf-8"
To: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org

The Cell Broadband Engine contains a 64-bit PowerPC core with 2 hardwar=
e
threads (called PPEs) and 8 Synergistic Processing Engines (called SPEs=
).
When booting Linux, 2 penguins logos are shown on the graphical console=
 by
the standard frame buffer console logo code.

To emphasize the existence of the SPEs (which can be used under Linux),=
 we
added a second row of (smaller) helper penguin logos, one for each SPE.

A sample screenshot can be found at
http://www.kernel.org/pub/linux/kernel/people/geoff/cell/debian-penguin=
-shot.png
(or on the ps3linux T-shirts we wore at OLS :-)

Summaries:
  [1] fbdev: extract fb_show_logo_line()
  [2] fbdev: Add fb_append_extra_logo()
  [3] fbdev: SPE helper penguin logo
  [4] Cell: Draw SPE helper penguin logos

Thanks for applying!

With kind regards,
=20
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village =C2=B7 Da Vincilaan 7-D1 =C2=B7 B-1935 Zaventem =C2=
=B7 Belgium
=20
Phone:    +32 (0)2 700 8453=09
=46ax:      +32 (0)2 700 8622=09
E-mail:   Geert.Uytterhoeven@sonycom.com=09
Internet: http://www.sony-europe.com/
 =09
Sony Network and Software Technology Center Europe=09
A division of Sony Service Centre (Europe) N.V.=09
Registered office: Technologielaan 7 =C2=B7 B-1840 Londerzeel =C2=B7 Be=
lgium=09
VAT BE 0413.825.160 =C2=B7 RPR Brussels=09
=46ortis Bank Zaventem =C2=B7 Swift GEBABEBB08A =C2=B7 IBAN BE390013823=
58619
