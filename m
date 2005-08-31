From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
Date: Wed, 31 Aug 2005 21:34:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0508312125360.3743@scrub.home>
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be>
 <43149E5B.7040006@t-online.de> <Pine.LNX.4.61.0508302039160.3743@scrub.home>
 <4314DD2E.7060901@t-online.de> <Pine.LNX.4.61.0508310159290.3728@scrub.home>
 <4315A6AB.5090108@t-online.de> <Pine.LNX.4.61.0508311750140.3728@scrub.home>
 <431602CC.1030008@t-online.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-903893405-1125516856=:3743"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750973AbVHaTeo@vger.kernel.org>
In-Reply-To: <431602CC.1030008@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Jochen Hein <jochen@jochen.org>, Geert Uytterhoeven <geert@linux-m68k.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811837-903893405-1125516856=:3743
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 31 Aug 2005, Knut Petersen wrote:

> I added the multiply back because gcc (v. 3.3.4) does generate the fastes=
t
> code
> if I write it this way.

The multiply is not generally faster, so your version may be the fastest,=
=20
but in other situations it will be a lot slower. My version is generally=20
fast.

> The special case for s_pitch =3D=3D 2 saves about 270 ms system time (212=
0 ->
> 1850ms)
> with a 16x30 font.

Compared to what? How much is the function call overhead?

> It=B4s as fast/slow as your previous version, the measurements are almost
> identical.

The generated code is a bit smaller, so it mostly depends on the icache to=
=20
see a difference.

bye, Roman
---1463811837-903893405-1125516856=:3743--
