From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Re: Radeon support (was Re: (no subject))
Date: Thu, 8 Aug 2002 09:02:22 -0400 (EDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33L2.0208080854160.5169-100000@memory.visualtech.com>
References: <Pine.LNX.4.33L2.0208072117190.4716-100000@memory.visualtech.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from memory.visualtech.com ([208.16.19.49])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cmvT-0003CC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 08 Aug 2002 06:02:03 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by memory.visualtech.com (Postfix) with ESMTP id 533DA4D04
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  8 Aug 2002 09:02:22 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.33L2.0208072117190.4716-100000@memory.visualtech.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net


Alright, so I did some more testing this morning...  I tried the exact
same modes, with the exact same monitor, first hooked up to the VGA port
and then hooked up to the DVI port of my Radeon 7500...  All but two of
the modes were taken from the fb.modes file supplied by the DirectFB
project.  *None* of the following modes (all at 16 bit) worked with the
VGA port:

640x480 75Hz
800x600 75Hz
1024x768 72Hz
1280x1024 60Hz
1600x1200 60Hz

All of the above worked (again, with the *same* monitor) hooked up to the
DVI port.

The two modes that *did* work with the VGA port were modes that I
specified to the kernel when booting (they were not taken from fb.modes):

1024x768 70Hz
640x480 60Hz

Also, it makes no difference if I use one of the unsupported modes from
the list of five above with fbset or when the kernel boots...  In both
situations, the display just blanks, as if it's either: A) getting no
signal, or B)  getting sent to a frequency it doesn't support.

Does *anyone* know what's going on and how to fix this?

Adam

On Wed, 7 Aug 2002, Adam K Kirchhoff wrote:

>
> Me again,
>
> =09So I think I might have a better idea of what's going on... I did
> some testing with the Radeon framebuffer tonight, and can only seem to ge=
t
> it to work with just two modes: 1024x768@70 and 640x480@60.  I've tried a
> number of others, which worked with the DVI output of my 7500, but don't
> seem to work with the VGA port of the card.
>
> =09Any ideas?
>
> Adam
>
> On Tue, 6 Aug 2002, Adam K Kirchhoff wrote:
>
> >
> > Ani and others :-)
> >
> > =09I was hoping you could lend me some insight :-)  I'm trying to do
> > some work with DirectFB, and I'm now running into a slight problem
> > concerning getting output on the VGA port.
> >
> > =09I've e-mailed the directfb-dev mailing list about it and had some
> > interesting conversations, but the end result was basically: "You shoul=
d
> > check with Ani Joshi about that, and maybe ask on the linux-fbdev-devel
> > mailing list".
> >
> > =09So now I'm asking here :-)  Below this I'm including the
> > description of the problem I'm seeing that I sent to the directfb-dev
> > mailing list.
> >
> > =09Can anyone help me out?  Thanks :-)
> >
> > Adam
> >
> > ---------- Forwarded message ----------
> > Date: Tue, 6 Aug 2002 12:51:24 -0400 (EDT)
> > From: Adam K Kirchhoff <adamk@voicenet.com>
> > To: "[iso-8859-1] Ville Syrj=E4l=E4" <syrjala@sci.fi>
> > Cc: directfb-devel <directfb-dev@directfb.org>
> > Subject: Re: [directfb-dev] Re: Radeon support...
> >
> >
> > > I'm getting really confused as to what's going on... What exactly hap=
pens
> > > when you run a DirectFB application?
> >
> > It took me a while to figure it out what I know so far, and I'm still n=
ot
> > 100% sure what's going on...
> >
> > If I run *any* DirectFB application, the screen blanks.  The system
> > doesn't lock.  I can ssh in and see the application listed in the proce=
ss
> > table.  For example, running df_fire, the screen blanks and, after a fe=
w
> > seconds, the monitor goes to sleep (as if it's no longer getting a
> > signal)...  Hitting the 'esc' key brings back the vt, just as usual whe=
n
> > runnin the application.
> >
> > Running dfbsee produces similar results.  However, with any video that =
I
> > play, I can hear the audio stream :-)  I just can't see anything...
> >
> > Now, when I first experienced this, I posted about it on either
> > directfb-dev or directfb-user.  A short while later, I figured out a
> > workaround :-)
> >
> > Instead of booting with my CRT plugged into the VGA port, I used a
> > DVI-to-VGA adapter (that came with my Radeon 7500), and plugged the
> > monitor into the DVI-A port.  Lo' and behold, DirectFB applications wer=
e
> > now showing up :-)
> >
> > Since then I've done some video card swapping and now have a "Powered B=
y
> > ATI" Radeon 8500 LE.  This card has both a VGA port and a DVI-D port, b=
ut
> > no adapter.  The old adapter doesn't work for this card because it's
> > designed for DVI-A as compared to DVI-D.
> >
> > I've encountered similar problems elsewhere, too.  For example, a hacke=
d
> > radeon 7500 driver for BeOS would only display on the DVI port, even if
> > the computer booted up fine with a monitor on the VGA port.
> >
> > Of course, I just don't know why this is the case :-)
> >
> > I've been poking around on-line looking for a DVI-D to VGA adapter, but
> > very few of the shops that sell them on-line clarify if it's DVI-A or
> > DVI-D :-)
> >
> > Adam
> >
> >
> >
> >
> >
> > -------------------------------------------------------
> > This sf.net email is sponsored by:ThinkGeek
> > Welcome to geek heaven.
> > http://thinkgeek.com/sf
> > _______________________________________________
> > Linux-fbdev-devel mailing list
> > Linux-fbdev-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> >
> >
>
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
