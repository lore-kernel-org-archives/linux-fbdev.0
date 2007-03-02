From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: Matrox G550, dual head, 1680x1050
Date: Thu, 1 Mar 2007 20:49:55 -0500
Message-ID: <a728f9f90703011749t7f015c55tec91bb1eccd20c16@mail.gmail.com>
References: <200703020025.13174.hjk@linutronix.de>
	<a728f9f90703011529r1cb92c10y2fbe503f34693507@mail.gmail.com>
	<200703020049.55005.hjk@linutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMwuD-0008HB-QU for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 17:49:57 -0800
Received: from wx-out-0506.google.com ([66.249.82.233])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HMwuD-0000kV-Ha
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 17:49:57 -0800
Received: by wx-out-0506.google.com with SMTP id i30so988095wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 01 Mar 2007 17:49:56 -0800 (PST)
In-Reply-To: <200703020049.55005.hjk@linutronix.de>
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
To: =?ISO-8859-1?Q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 3/1/07, Hans-J=FCrgen Koch <hjk@linutronix.de> wrote:
> Am Freitag, 2. M=E4rz 2007 00:29 schrieb Alex Deucher:
> > On 3/1/07, Hans-J=FCrgen Koch <hjk@linutronix.de> wrote:
> > > Hi,
> > > I'm the proud owner of two NEC MultiSync 2070WNX monitors (1680x1050)=
 and
> > > a Matrox G550 dual DVI card. I'm now trying to set up a dual head
> > > configuration with this equipment.
> > >
> > > I'm booting with video=3Dmatroxfb:vesa:0x1BB, as there is no 1680x105=
0 vesa
> > > mode. This works, both monitors show the same and complain about the
> > > wrong resolution.
> > >
> > > Now I start my X server (xorg.conf below) and wish to get a xinerama
> > > setup. Monitor 1 switches to 1680x1050 and shows a nice clean screen.
> > > Monitor 2 seems to have problems, though. I guess the card still outp=
uts
> > > the 1280x1024 set up at boot time. Colours are correct, but the image=
 is
> > > heavily distorted. It looks like the X server thinks it's 1680x1050 b=
ut
> > > in fact it's still 1280x1024.
> > >
> > > I spent some time googling, but to no avail. Now my questions:
> > >
> > > Is this a known limitation of matroxfb?
> > > If yes, is it considered a bug? I could spend some time looking into =
the
> > > code. Do I have any chance to get this working in a reasonable dual h=
ead
> > > configuration? Any hints?
> >
> > IIRC, the current mga X server doesn't know how to deal with DVI
> > (single or dual ports).  DVI was only supported with matrox' binary
> > module.
> >
>
> Hi Alex,
> thanks for your fast reply.
> Currently, I've got both monitors connected with VGA cables. The card has=
 some
> proprietary 60-pin or so connector, and I've got an adapter caple from th=
at
> plug to 2xVGA. Both monitors show a stable picture, but only the picture =
on
> monitor #1 is usable. It really looks like the X server is trying to swit=
ch
> both channels to 1680x1050, but only succeeds with the first one.
>

you should probably ask on the xorg mailing list :)
Dualhead is a bit flakey in the xorg driver at the moment, although
work is being done to fix that.  IIRC, the ordering is wrong when
programming one of the PLLs.

Alex

> Hans
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
