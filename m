From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] pm2fb: accelerated fillrect
	andcopyarea
Date: Tue, 01 May 2007 12:11:59 +0200
Message-ID: <4637126fec42e@wp.pl>
References: <46363c001f8a0@wp.pl> <1177968109.4372.4.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HipL4-00056G-TR for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 May 2007 03:12:14 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1HipL3-0001jW-7p
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 May 2007 03:12:06 -0700
In-reply-to: <46363c001f8a0@wp.pl> <1177968109.4372.4.camel@daplas>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: "Antonino A.Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>




Dnia 30-04-2007 o godz. 23:21 Antonino A. Daplas napisa=B3(a):

> For the best scrolling mode, you would want to advertise the =

driver's
> capability with:
> =

> info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
> FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT;
> =

> I'll add this myself.
> =


Thank you. I am quite new to fbdev and I still learn.

Regards,
Krzysztof  =


----------------------------------------------------
Zobacz, jak=B1 walk=EA stoczy superbohater, by ocali=E6 siebie
i swych bliskich. A najwi=EAksza bitwa rozegra si=EA w jego duszy.
SPIDER-MAN 3 w kinach od 4 maja.
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fspiderman3.h=
tml&sid=3D1122



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
