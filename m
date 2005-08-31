From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/1 2.6.13] framebuffer: bit_putcs() optimization for
 8x* fonts
Date: Wed, 31 Aug 2005 09:14:34 +0800
Message-ID: <4315047A.4040907@gmail.com>
References: <43148610.70406@t-online.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932313AbVHaBPI@vger.kernel.org>
In-Reply-To: <43148610.70406@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Jochen Hein <jochen@jochen.org>

Knut Petersen wrote:
> This trivial patch gives a performance boost to the framebuffer conso=
le
>=20
> Constructing the bitmaps that are given to the bitblit functions of t=
he
> framebuffer
> drivers is time consuming. Here we avoide a call to the slow
> fb_pad_aligned_buffer().
> The patch replaces that call with a simple but much more efficient
> bytewise copy.
>=20
> The kernel spends a significant time at this place if you use 8x* fon=
ts.
> Every
> pixel displayed on your screen is prepared here.
>=20
> Some benchmark results:
>=20
> Displaying a file of 2000 lines with 160 characters each takes 889 ms
> system
> time using  cyblafb on my system  (I=B4m using a 1280x1024 video mode=
,
> resulting in a 160x64 character console)
>=20
> Displaying the same file with the enclosed patch applied to 2.6.13 on=
ly
> takes
> 760 ms system time, saving 129 ms or 14.5%.

Where did this 14.5% come from?  Is it bit_putcs alone or is more
real world, such as 'time cat text_file'? If I'm to guess, a large
percent of the improvement is caused by the inlining of the code.

I'm not against the patch, it will benefit drivers with very fast
imageblits.  However, since most drivers have imageblits done in softwa=
re,
a large proportion of the processing time will go to the imageblit itse=
lf,
so I don't think you'll get that high a number (I get only a 4%
improvement, and this is in a driver with accelerated blits, and it wil=
l
probably be lower, ie, in vesafb).

Anyway, with the addition of your patch, bit_putcs has now reached an
'ugliness threshhold' for a revamp.

Tony
