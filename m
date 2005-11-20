From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: 2 more fbcon rotation bugs
Date: Sun, 20 Nov 2005 10:03:16 +0100
Message-ID: <43803BD4.7080403@t-online.de>
References: <437DF1EA.7010906@t-online.de> <437E3856.9030509@gmail.com> <437EFA9B.8090402@t-online.de> <437FF1F8.9020307@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Edl6Q-0003WO-0b
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Nov 2005 01:03:14 -0800
Received: from mailout06.sul.t-online.com ([194.25.134.19])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Edl6O-0001Ax-OK
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Nov 2005 01:03:14 -0800
In-Reply-To: <437FF1F8.9020307@gmail.com>
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


>It seems that cfbfillrect and cfbcopyarea were written in a big-endian
>machine (if I'm not mistaken, by Geert on m68k?) as unaligned access in
>little endian produces this bug.
>
> =20
>
That patch set fixes my problems with vesafb. For the tested subset of=20
possible
font dimensions and rotation values everything seems to be ok now. But ma=
ybe
someone with a  big-endian machine should also verify the code.

Isn=B4t it amazing that code as old as this still contains undetected bug=
s?

Is there anything like a framebuffer test suite that could be used for a=20
quick verification
of especially the seldom used features?

btw: my favourite text editor sedt fails if the number of lines exceeds=20
an internal
limit hit by rotation =3D=3D 1 or 3 and small fonts, but it complains tha=
t=20
it cannot read
its perfectly readable initialization file in that case ...  I wonder if=20
there are more
applications like that.

cu,
 Knut



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
