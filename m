From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] pm2fb: fb_sync added
Date: Tue, 08 May 2007 15:05:17 +0200
Message-ID: <4640758d62f82@wp.pl>
References: <464026127324d@wp.pl> <1178627547.4953.5.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlPNb-0007LG-K2 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 06:05:23 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HlPNY-0001s8-Oc
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 06:05:22 -0700
In-reply-to: <464026127324d@wp.pl> <1178627547.4953.5.camel@daplas>
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

Dnia 8-05-2007 o godz. 14:32 Antonino A. Daplas napisa=B3(a):
> On Tue, 2007-05-08 at 09:26 +0200, Krzysztof Helt wrote:

> > Current testing shows that fb_sync is not
> > required

> =

> Actually, creating an fb_sync() method would be better in terms of
> maximizing the thoroughput of the GPU in comparison with
indiscriminate
> calls to sync waits. =



I was not clear in the first email. The pm2fb_sync is required to
avoid corruption of display (to define it as fb_sync) during
scrolling. It is not required to be called inside the
pm2fb_block_op() explicitly.

The change is to remove the sync call from the pm2fb_block_op().

> It would have been better if imageblit is also
> hardware assisted.
> =


I know, but I have only as much time as my work and family allow
 (there was plenty of it last week =3D holiday).

I see a major problem with using copyarea acceleration comparing
to redraw function. The copyarea always moves the whole
framebuffer (milions of pixels) while the redraw works very smart
to redraw only things which has to be redrawn. I am working to
use something smarter for copyarea. No success yet.

Regards,
Krzysztof

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
