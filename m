From: Ondrej Zary <linux@rainbow-software.org>
Date: Sun, 21 Aug 2011 21:07:31 +0000
Subject: fbtest 24bpp bug?
Message-Id: <201108212307.34480.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hello,
I have problems testing "new" driver (i740fb) with fbtest. 8bpp, 16bpp and
32bpp modes work fine. But 24bpp does not. In test003, colors are completely
wrong - I get 1- or 2-pixel wide vertical lines instead of color bars.
The same problem appears with matroxfb but not with aty128fb (see below).

cfb_fill_rect() in drawops/cfb.c tries to do some magic to speed things up.
But it seems that it does it wrong. I replaced that code with this:
    int i,j;
    for (i =3D y; i < y+height; i++) {
        for (j =3D x; j < x+width; j++) {
                fb[(j + i*1280)*3 + 0] =3D pixel & 0xff;
                fb[(j + i*1280)*3 + 1] =3D (pixel & 0xff00) >> 8;
                fb[(j + i*1280)*3 + 2] =3D (pixel & 0xff0000) >> 16;
        }
    }
(testing at 1280x1024)
and it works fine! So next thing: dump fb contents (for the first blue bar)
in both cases and compare:

original code resulted in this:
cfb_fill_rect x=3D0 y=3D0 w=80 h=1024, pixel=3D0xaa, bpp$, next_line840
pat=3D0xaa00
00aa00 000000 aa00aa 0000aa 00aa00 000000 aa00aa 0000aa ...... (by pixels)
00aa0000 0000aa00 aa0000aa 00aa0000 0000aa00 aa0000aa ........ (by patterns)

my code:
cfb_fill_rect x=3D0 y=3D0 w=80 h=1024, pixel=3D0xaa, bpp$, next_line840
aa0000 aa0000 aa0000 aa0000 aa0000 aa0000 aa0000 aa0000 ...... (by pixels)
aa0000aa 0000aa00 00aa0000 aa0000aa 0000aa00 00aa0000 ........ (by patterns)

So the first pattern is wrong? And seems to rotate the wrong way too?


aty128fb seems to use some HW palette?:
cfb_fill_rect x=3D0 y=3D0 w=80 h=1024, pixel=3D0x10101, bpp$, next_line840
pat=3D0x1010101
010101 010101 010101 010101 010101 010101 010101 010101 ...... (by pixels)
01010101 01010101 01010101 01010101 01010101 01010101 ........ (by patterns)

No matter how you rotate that, it will be always ok!

--=20
Ondrej Zary
