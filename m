From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] pm3fb: preliminary support for
	2.6	kernel
Date: Tue, 08 May 2007 08:15:57 +0200
Message-ID: <4640159dce83b@wp.pl>
References: <1hxqxt8.1dr1xgy136212oM%romain@dolbeau.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlIzW-0005wI-Ja for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 23:16:16 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1HlIzR-0001O6-W8
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 23:16:04 -0700
In-reply-to: <1hxqxt8.1dr1xgy136212oM%romain@dolbeau.org>
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
To: romain@dolbeau.org
Cc: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

Dnia 7-05-2007 o godz. 14:08 romain@dolbeau.org (Romain Dolbeau)
napisa=B3(a):
> Krzysztof Helt <krzysztof.h1@wp.pl> wrote:
> =

> > This is a basic port from 2.4 kernel to 2.6. Acceleration is lost
> > and big endian support probably too. The driver works in 8, 16
> > and 32 bit mode.
> =

> > - *  CHANGELOG:
> > - *  Mon Feb 11 10:35:48 MET 2002, v 1.4.11B: Cosmetic update.
> =

> There was a 1.4.11C, which I believe was included in 2.4.26-pre2 .

I noticed it after I started this port.  Anyway, this driver is
very basic comparing to the 2.4 version. I'll try update the
driver if time will allow, I learned I cannot promise finishing
drivers because real life always steps up in the most unexpected
moment.

I welcome any help to fix big endian (PPC) support for this
driver as I do not have hardware to do this.

> =

> And if my IRISA e-mail address is still in the source, it's
probably
> best to update it to <romain@dolbeau.org>.
> =


I hope, that Antonio can do this in order to avoid resend of this
big patch.

Best regards,
Krzysztof

----------------------------------------------------
Ekstraliga =BFu=BFlowa - sprawd=BC koniecznie kolejne rozgrywki! Kliknij:
http://klik.wp.pl/?adr=3Dwww.ekstraliga.wp.pl&sid=3D1129



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
