From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: SM501 framebuffer driver
Date: Fri, 6 Oct 2006 21:55:35 +0300
Message-ID: <20061006185535.GA7649@sci.fi>
References: <45268042.8050207@billgatliff.com> <452691A2.2020209@anagramm.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVurH-0002J2-14 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Oct 2006 11:55:44 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GVurF-0008NO-5c
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Oct 2006 11:55:43 -0700
Content-Disposition: inline
In-Reply-To: <452691A2.2020209@anagramm.de>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Robert Whaley <rwhaley@applieddata.net>

On Fri, Oct 06, 2006 at 07:25:54PM +0200, Clemens Koller wrote:
> Hello, Bill,
> =

> > Sorry about starting a new thread, but I was referred to this =

> > list/thread by a colleague just a few minutes ago.  (OT: it isn't in th=
e =

> > archives in SF, either!).
> =

> Okay, fine! I'll be glad to join the party because we are using the SM501
> on PCI of an MPC8540 embedded PowerPC.

I'm using an ARM board. The CPU is an Atmel AT91RM9200, and the SM501 is =

connected to it via a CPLD.

> > I hate to play "me too!", but I also have an SM501 framebuffer driver i=
n =

> > a partial state of development.  I'd love to collaborate with others to =

> > get a good version pushed upstream.
> =

> Great! Where shall we collect the code?
> I have some =

> =

> - a working fb driver kernel module
> 	(I did lots of code cleanup, but still needs a lot)

Me too here :) My changes to the original sm501 fb driver include:
 - Use dev_dbg instead of custom macro
 - video=3D command line parsing
 - Better checking in check_var
 - Started to implement setcolreg and panning, not finished
 - Removed duplicated code
 - Tried to make code more readable :)
 - Maybe something else (I didn't keep track

I also started to write an ALSA driver for the audio part. I wrote the =

basic driver skeleton, and my next step was going to be the 8051, but =

then I got distracted by other stuff. My plan was to start off with some =

very simple code for the 8051 which would just issue an interrupt at =

some interval so I could just see how the CPU<->8051 communication =

works. I'll try dig up the code in case someone wants to take a look.

Like I mentioned in the other thread I also wrote a DirectFB gfxdriver. =

It does basic blitting and filling for now. I tried to make it draw =

lines too but that caused the chip to lock up, and I tried to use alpha =

bleded blits but those seem to make the chip really sluggish to respond.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
