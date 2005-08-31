From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
Date: Wed, 31 Aug 2005 21:19:40 +0200
Message-ID: <431602CC.1030008@t-online.de>
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be> <43149E5B.7040006@t-online.de> <Pine.LNX.4.61.0508302039160.3743@scrub.home> <4314DD2E.7060901@t-online.de> <Pine.LNX.4.61.0508310159290.3728@scrub.home> <4315A6AB.5090108@t-online.de> <Pine.LNX.4.61.0508311750140.3728@scrub.home>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932531AbVHaTQm@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508311750140.3728@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="ks_c_5601-1987"; format="flowed"
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Jochen Hein <jochen@jochen.org>, Geert Uytterhoeven <geert@linux-m68k.org>

  Hi Roman!

>>+static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 =
*src, +
>>u32 s_pitch, u32 height)
>>+{
>>+	int i, j;
>>+
>>+	if (likely(s_pitch=3D=3D1))
>>+		for(i=3D0; i < height; i++)
>>+			dst[d_pitch*i] =3D src[i];
>>   =20
>>

I added the multiply back because gcc (v. 3.3.4) does generate the=20
fastest code
if I write it this way. I compiled, inspected the generated assembly an=
d=20
benchmarked
about a  dozend variations of the code (benchmark as previously describ=
ed).

The special case for s_pitch =3D=3D 1 saves about 10 ms system time (77=
0 ms=20
-> 760 ms)

The special case for s_pitch =3D=3D 2 saves about 270 ms system time (2=
120=20
-> 1850ms)
with a 16x30 font.

The third case is for even bigger fonts ... I believe that it will not=20
often be used but
something like that must be present.

>You have now 3 slightly different variants of the same, which isn't re=
ally=20
>an improvement. In my example I showed you how to generate the first a=
nd=20
>last version from the same source.
>
The first version will only be generated when gcc can be sure that=20
s_pitch is 1.
Therefore you had to explicitly call __fb_pad_aligned_buffer with that=20
value:

	if (likely(idx =3D=3D 1))
		__fb_pad_aligned_buffer(dst, pitch, src, 1, image.height);
	else
		fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);
=20
With the version I propose it=B4s enough to write

		__fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);

instead, and you will get good performance for all cases. If the value =
of
idx/s_pitch is know at compile time, the compiler can and will ignore t=
he
other cases.

>If you also want to optimize for other sizes, you might want to always=
=20
>inline the function, if the function call overhead is the largest part=
=20
>anyway, the special case for 2 bytes might not be needed anymore.
> =20
>
fb_pad_aligned_buffer() is  usefull to save some space in cases like=20
softcursor.
It=B4s also used by some  drivers (nvidia and riva), but the authors of=
=20
those drivers
have to decide if they prefer the inlined version or the version fixed=20
in fbmem.

>BTW this version saves another condition:
>
>static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *s=
rc, u32 s_pitch, u32 height)
>{
>	int i, j;
>
>	d_pitch -=3D s_pitch;
>	i =3D height;
>	do {
>		/* s_pitch is a few bytes at the most, memcpy is suboptimal */
>		j =3D s_pitch;
>		do
>			*dst++ =3D *src++;
>		while (--j > 0);
>		dst +=3D d_pitch;
>	} while (--i > 0);
>}
>
I tested that code, together with the followig code in but_putcs():

             if(idx=3D=3D1)
                    __fb_pad_aligned_buffer(dst, pitch, src, 1,=20
image.height);
             else if (idx=3D=3D2)
                    __fb_pad_aligned_buffer(dst, pitch, src, 2,=20
image.height);
             else
                    fb_pad_aligned_buffer(dst, pitch, src, idx,=20
image.height);
             dst +=3D width;

It=B4s as fast/slow as your previous version, the measurements are almo=
st=20
identical.

Let=B4s summarize:

Your version of __fb_pad_aligned_buffer looks much better, but it needs=
=20
not so nice
conditionals when used. My version looks bad, but it is easier to use=20
and it is
_faster_.

cu,
 knut
