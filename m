From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: Blitter speed tests (was: smart
 blitterusage for scr olling)
Date: Fri, 11 May 2007 08:00:32 +0200
Message-ID: <46440680635cb@wp.pl>
References: <46434cdea1ce4@wp.pl> <1178828675.4662.4.camel@daplas>
	<1178829389.4662.13.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HmOBB-0003sw-D6 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 May 2007 23:00:43 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HmOB9-0003fl-SA
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 May 2007 23:00:37 -0700
In-reply-to: <46434cdea1ce4@wp.pl> <1178828675.4662.4.camel@daplas>
	<1178829389.4662.13.camel@daplas>
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

Dnia 10-05-2007 o godz. 22:36 Antonino A. Daplas napisa=B3(a):
> On Fri, 2007-05-11 at 04:24 +0800, Antonino A. Daplas wrote:
> > If you do, it might even be wise to change the default from
> > SCROLL_REDRAW to SCROLL_MOVE...?
> > =

> Come to think of it we'll probably just let the driver choose
the scroll
> method.
> =

> SCROLL_MOVE is faster at lower bit depths because the bitmap
preparation
> for the putcs method slows down SCROLL_REDRAW.  But as the bit
depth
> goes up, the amount of data moved by bmove goes up but at a
higher rate
> than the data moved by putcs. Thus SCROLL_MOVE loses its edge
at 16-32
> bpp. At what point these lines intersect we really don't know as it
> depends on the hardware and the driver's imageblit/copyarea
> implementation.
> =


If you want really complicated solution one can switch
FB_READS_FAST flag depending on the bit depth inside each driver ;-)

I think that a simple solution is to leave everything untouched
except tdfxfb and nvidiafb drivers. These two should add
FB_READS_FAST flag permanently to use  blitter for scrolling.

Take into account that the faster machine may speed up the redraw
operation, because it is faster, while blitting will have the
same speed. =


On the other hand, most cards I have cannot even closely compare
their on-board memory bandwidth to the one on newer cards like
Geforce or Radeon (so blitting should be much faster on the newer
cards). The blitting merge can help these cards (no hardware to
tests).

Regards,
Krzysztof

----------------------------------------------------
Wczoraj chodzi=B3o o honor. Dzisiaj - o sprawiedliwo=B6=E6.
Mark Wahlberg i Danny Glover w pe=B3nym akcji filmie =

"STRZELEC" - w kinach od 11 maja.
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fstrzelec.htm=
l&sid=3D1134



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
