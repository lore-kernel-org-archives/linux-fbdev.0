From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] smart blitter usage for
	scrolling(cleaned)
Date: Sat, 12 May 2007 08:06:47 +0200
Message-ID: <46455977350ef@wp.pl>
References: <4644106cacb67@wp.pl> <1178912517.5017.3.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hmkko-0007bR-FX for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 May 2007 23:06:54 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hmkkl-00069u-VQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 May 2007 23:06:54 -0700
In-reply-to: <4644106cacb67@wp.pl> <1178912517.5017.3.camel@daplas>
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


Dnia 11-05-2007 o godz. 21:41 Antonino A. Daplas napisa=B3(a):
> =

> #####
> > +			if (attr !=3D (c & 0xff00)) {
> > +				attr =3D c & 0xff00;
> > +				if (s > start) {
> > +					ops->bmove(vc, info, line + ycount, x, =

line, x, 1, s-start);
> > +					x +=3D s - start;
> > +					start =3D s;
> > +				}
> > +			}
> #####
> =

> The code block above is probably not needed. It just checks if =

the
> attribute of the character (ie the color) has changed.  This is =

required
> for putcs, but is unnecessary for bmove.
> =



Please remove it from the patch. It may only speed up scrolling =

by blitter.

Regards,
Krzysztof =


----------------------------------------------------
Zn=F3w dosta=B3e=B6 du=BFo spamu?! Masz ju=BF tego do=B6=E6..?
Twoje dane s=B1 zagro=BFone..?
mks_vir 2k7 -  program antywirusowy i antyszpiegowski
http://klik.wp.pl/?adr=3Dwww.mks.com.pl&sid=3D1137



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
