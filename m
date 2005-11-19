From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: 2 more fbcon rotation bugs
Date: Sat, 19 Nov 2005 18:48:15 +0800
Message-ID: <437F02EF.2010102@gmail.com>
References: <437DF1EA.7010906@t-online.de> <437E3856.9030509@gmail.com> <437EFA9B.8090402@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdQGx-0007pk-L3
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Nov 2005 02:48:43 -0800
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdQGw-0006WM-D4
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Nov 2005 02:48:43 -0800
Received: by zproxy.gmail.com with SMTP id r28so382557nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Nov 2005 02:48:41 -0800 (PST)
In-Reply-To: <437EFA9B.8090402@t-online.de>
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
Content-Type: text/plain; charset="iso-8859-1"
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Antonino A. Daplas schrieb:
>=20
>>> For rotation values of 1 and 3 in combination with unusual font heigh=
ts
>>> there are
>>> serious cursor problems:
>>>  =20
>> This one I cannot reproduce. Have you tried reproducing it with vesafb=
?
>> Any message in the log, such as a kernel oops?  Your description sound=
s
>> like a corruption of cursor->mask and cursor->image.data.
>> =20
>>
>=20
> I tried to reproduce it with vesafb ... vesafb does not show this bug.
> Reproducability with cyblafb
> is 100%. But cyblafb does not provide cursor functions, so both really
> should show the same
> behaviour, shouldn=B4t they?=20

soft_cursor is just a wrapper to fb_imageblit, so behavior will depend
on the drivers implementation.

No messages in the log, no oops, no side
> effects. Screen is restored
> to the correct display if the gpm mouse cursor or the normal cursor is
> moved to the wrong character
> cell.
>=20
> New bug: Vesafb & rotation does show a bug that is not present using
> cyblafb & rotation and the 16x30
> bitstream font: When I start my favourite text editor sedt, the top row
> is coloured and contains some
> status information. Line two is in a different colour. Those areas of
> line 1 drawn with the bitblit
> functions are ok, but those areas drawn with the fillrect function are
> not completely coloured, the last
> (maybe the 2 last, don=B4t know) pixel rows of the area that should be
> coloured are still black.

Yes, I think I mentioned this in the changelog, that there might be a=20
bug in the generic fillrect.  I haven't looked at it yet.

>=20
> Additional bug: I am used to compile vesafb into the kernel and to load
> and remove the cyblafb
> module during the developement process, switching to and from vesafb
> using con2fb. That=B4s still
> possible with rotation =3D=3D 0, but it locks the computer if at least =
one
> framebuffer is set to rotation 1.

Okay, will check on this.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
