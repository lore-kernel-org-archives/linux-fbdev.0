From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Choosing the correct framebuffer
	configuration
Date: Sun, 07 Aug 2005 12:32:29 -0400
Message-ID: <1123432349.3978.335.camel@localhost>
References: <9e473391050805184756f055ea@mail.gmail.com>
	 <Pine.LNX.4.62.0508071145100.31010@gorilla.sonytel.be>
	 <9e473391050807083327b190f9@mail.gmail.com>
	 <1123430435.3848.332.camel@localhost>  <1123431300.30257.116.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1o4o-00049y-Qx
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 09:32:42 -0700
Received: from darkcity.gna.ch ([195.226.6.9])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1o4n-0007Ax-HP
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 09:32:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by darkcity.gna.ch (Postfix) with ESMTP id CC0921CED0D
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  7 Aug 2005 18:32:34 +0200 (CEST)
Received: from unknown by localhost (amavisd-new, unix socket)
 id client-XXijgn45 for <linux-fbdev-devel@lists.sourceforge.net>;
 Sun,  7 Aug 2005 18:32:33 +0200 (CEST)
Received: from localhost (CPE001124084852-CM014500006147.cpe.net.cable.rogers.com [65.48.154.37])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by darkcity.gna.ch (Postfix) with ESMTP id D4C7A1CECDD
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  7 Aug 2005 18:32:31 +0200 (CEST)
Received: from daenzer by localhost with local (Exim 4.52)
	id 1E1o4c-0005dW-20
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 12:32:30 -0400
In-Reply-To: <1123431300.30257.116.camel@gaston>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Sun, 2005-08-07 at 18:14 +0200, Benjamin Herrenschmidt wrote:
> > > The problem is that the radeonfb driver sees bpp =3D 32 and then sets
> > > rgbt =3D 8/8/8/8. It stomps rgbt without looking at it.
> >=20
> > Looks like a radeonfb bug.
>=20
> It's not a bug :) radeonfb doesn't support anything but that format for
> now.

According to Geert's rules, it should fail instead of rounding down
r/g/b.


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
