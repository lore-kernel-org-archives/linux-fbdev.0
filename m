From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: 2 more fbcon rotation bugs
Date: Sat, 19 Nov 2005 11:12:43 +0100
Message-ID: <437EFA9B.8090402@t-online.de>
References: <437DF1EA.7010906@t-online.de> <437E3856.9030509@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdPiB-0006m6-Rh
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Nov 2005 02:12:47 -0800
Received: from mailout06.sul.t-online.com ([194.25.134.19])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdPiA-0006vi-79
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Nov 2005 02:12:47 -0800
In-Reply-To: <437E3856.9030509@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas schrieb:

>>For rotation values of 1 and 3 in combination with unusual font heights
>>there are
>>serious cursor problems:
>>   =20
>>
>This one I cannot reproduce. Have you tried reproducing it with vesafb?
>Any message in the log, such as a kernel oops?  Your description sounds
>like a corruption of cursor->mask and cursor->image.data.
> =20
>

I tried to reproduce it with vesafb ... vesafb does not show this bug.=20
Reproducability with cyblafb
is 100%. But cyblafb does not provide cursor functions, so both really=20
should show the same
behaviour, shouldn=B4t they? No messages in the log, no oops, no side=20
effects. Screen is restored
to the correct display if the gpm mouse cursor or the normal cursor is=20
moved to the wrong character
cell.

New bug: Vesafb & rotation does show a bug that is not present using=20
cyblafb & rotation and the 16x30
bitstream font: When I start my favourite text editor sedt, the top row=20
is coloured and contains some
status information. Line two is in a different colour. Those areas of=20
line 1 drawn with the bitblit
functions are ok, but those areas drawn with the fillrect function are=20
not completely coloured, the last
(maybe the 2 last, don=B4t know) pixel rows of the area that should be=20
coloured are still black.

Additional bug: I am used to compile vesafb into the kernel and to load=20
and remove the cyblafb
module during the developement process, switching to and from vesafb=20
using con2fb. That=B4s still
possible with rotation =3D=3D 0, but it locks the computer if at least on=
e=20
framebuffer is set to rotation 1.
I have not tested that for rotation =3D=3D 2 or 3.

>
>You can also try enabling a non-blinking block cursor
>(Documentation/VGA-softcursor.txt) to isolate the problem. With a
>non-blinking block cursor, fbcon's cursor is disabled and vt.c's softcur=
sor
>takes over. =20
>
>You also said that the cursor becomes fixed.  You can comment out the ca=
ll
>to ops->cursor in fb_flashcursor in fbcon.c so you get a fixed cursor an=
d
>eliminate the cursor blink pathway from the debugging.
>
>Tony
>
> =20
>
As you cannot reproduce the cursor/delete bug, I=B4ll try to find the=20
cause and to fix it then. Please
have a look at the other bugs.

cu,
 Knut





-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
