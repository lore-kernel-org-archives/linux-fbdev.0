From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Optimizing bitblit.c / fb_pad_*
Date: Sat, 30 Jul 2005 20:43:42 +0200
Message-ID: <42EBCA5E.4030209@t-online.de>
References: <42EB46AB.1010005@t-online.de> <42EB7A10.4080601@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DywHo-0001x1-Ts
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 11:42:16 -0700
Received: from mailout09.sul.t-online.com ([194.25.134.84])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DywHo-00024Y-Lw
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 11:42:17 -0700
In-Reply-To: <42EB7A10.4080601@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi Antonino,

>> +                if (fast_8x16)
>> +                    for (i =3D 16; i--; ) {
>> +                        *dstp =3D src[15-i];
>> +                        dstp +=3D pitch;
>> +                    }
>
>
> why not make it to something like this?
>
>         for (i =3D cellsize; i--;) {
>             *dstp =3D src[cellsize-1-i];
>             dstp +=3D pitch;
>         }
>
> This way, it will work with any fontsize, as long as the width
> is a 8-bit size-aligned.  You can do the same with
> fb_pad_aligned_buffer(), so the rest can benefit too.
>
fb_pad_unaligned() could be optimized localy, there are other cases of
memcpy(), e.g. in softcursor, etc.

Well, this was nothing but a quick =B4n dirty hack, I tried to find out i=
f=20
there
is still potential for optimizations. If people agree that the gain in sp=
eed
justifies it, I will try to look at those parts of the kernel _after_ I h=
ave
submitted my cyberblade/i1 driver. I have to admit that I =B4m not famila=
r
(enough) with the layers above the hardware driver level right now.

> PS: Next time you submit a patch, add a Signed-off-line.

ack. btw, should a new driver first be presented in
linux-fbdev-devel@lists.sourceforge.net or lkml?

cu,
 Knut


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
