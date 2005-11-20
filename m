From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: 2 more fbcon rotation bugs
Date: Mon, 21 Nov 2005 06:04:23 +0800
Message-ID: <4380F2E7.4040101@gmail.com>
References: <437DF1EA.7010906@t-online.de> <437E3856.9030509@gmail.com> <437EFA9B.8090402@t-online.de> <437FF1F8.9020307@gmail.com> <43803BD4.7080403@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdxKs-00087l-Ny
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Nov 2005 14:06:58 -0800
Received: from zproxy.gmail.com ([64.233.162.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdxKs-0004yH-Gk
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Nov 2005 14:06:58 -0800
Received: by zproxy.gmail.com with SMTP id r28so602670nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 20 Nov 2005 14:06:58 -0800 (PST)
In-Reply-To: <43803BD4.7080403@t-online.de>
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
>=20
>> It seems that cfbfillrect and cfbcopyarea were written in a big-endian
>> machine (if I'm not mistaken, by Geert on m68k?) as unaligned access i=
n
>> little endian produces this bug.
>>
>> =20
>>
> That patch set fixes my problems with vesafb. For the tested subset of
> possible
> font dimensions and rotation values everything seems to be ok now. But
> maybe
> someone with a  big-endian machine should also verify the code.

In big-endian, the original code gets compiled, so there would be no
regressions.  But does the original code work on them? I don't know yet.

>=20
> Isn=B4t it amazing that code as old as this still contains undetected b=
ugs?

It's quite hard to trigger this bug in an unrotated display because the
usual combination of fontwidths and bpp's typically results in 32-bit
aligned access. And even if the bug is triggered, it is very difficult to
detect as the result will be random pixels at the end of a row of text
which the cursor will overwrite eventually anyway.

Tony

PS: Someone did report before that cfbcopyarea and cfbfillrect does not w=
ork
correctly at bpp of 24, but I did not look into it then as I was too lazy
to create a test :-).




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
