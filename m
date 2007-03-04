From: =?iso-8859-15?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: Matrox G550, dual head, 1680x1050
Date: Sun, 4 Mar 2007 22:47:21 +0100
Message-ID: <200703042247.21590.hjk@linutronix.de>
References: <200703021053.00955.hjk@linutronix.de>
	<200703021610.58188.hjk@linutronix.de>
	<20070302152414.GC907@code-monkey.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <20070302152414.GC907@code-monkey.de>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
To: xorg@lists.freedesktop.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Am Freitag, 2. M=E4rz 2007 16:24 schrieb Tilman Sauerbeck:
> Hans-J=FCrgen Koch [2007-03-02 16:10]:
> > Am Freitag 02 M=E4rz 2007 15:39 schrieb Tilman Sauerbeck:
> > > Hans-J=FCrgen Koch [2007-03-02 10:53]:
> > > > I'm the proud owner of two NEC MultiSync 2070WNX monitors (1680x105=
0)
> > > > and a Matrox G550 dual DVI card. I'm now trying to set up a dual he=
ad
> > > > configuration with this equipment.
> > > >
> > > > [snip]
> > > >
> > > > Is this a known limitation of matroxfb? Or a X server bug?
> > >
> > > AFAIK matroxfb doesn't support the G550 dual DVI card. The mga X driv=
er
> > > certainly doesn't support it yet.
> >
> > Well, at the moment I'm using the VGA outputs. Current status is:
>
> I believe/suspect the hardware doesn't care whether you use the 2VGA
> cable or the 2DVI cable. Unfortunately, I only have the dual-dvi cable
> so I cannot be sure. Last time I had a close look at dual-dvi was around
> christmas and I don't remember all the details ;)
>
> > * Without X (boot, VT) I get clean 1280x1024 on both monitors. The
> > monitors interpolate that to their native resolution, both show the same
> > image.

Meanwhile, I managed to get 1680x1050 to work with matroxfb. Here's proof t=
hat=20
both monitors really work:

http://www.hjk-az.de/temp/g550-dualhead-fbcon-small.jpg

The left monitor is the primary head (/dev/fb0) and shows text on a VT. The=
re=20
I issued a command "fbi -d /dev/fb1 image.jpg" that shows a JPEG image on t=
he=20
second monitor. Note that there is no X running (The black-on-white text is=
=20
due to a small patch I usually apply to vt.c).


>
> > * With a xinerama configuration, X starts without any (EE) errors.
> > Monitor1 shows a clean 1680x1050 image, Monitor2 a distorted image. I c=
an
> > move the mouse or windows from one monitor to the other. The reason for
> > the distortion on monitor2 is most probably that the card is still
> > configured for 1280x1024 while the X server thinks it's 1680x1050.

Meanwhile I doubt this explanation. Here's what fbset has to say:

$ fbset -fb /dev/fb1 --show

mode "1680x1050-60"
    # D: 135.501 MHz, H: 65.396 kHz, V: 59.997 Hz
    geometry 1680 1050 1680 1050 32
    timings 7380 32 224 32 4 136 4
    rgba 8/16,8/8,8/0,8/24
endmode

So, even fbset thinks it's 1680x1050. But where does the distortion come=20
from???

>
> I'm curious, can you describe the distortion in more detail/take a
> photo?

Yes, now I've got one:

http://www.hjk-az.de/temp/g550-xinerama-error-small.jpg

This shows a KDE login screen. Note that KDE scaled the background image wi=
th=20
the Debian logo to cover both screens. The right screen is distorted,=20
but "working": If I move a window over to the second screen, I see changes=
=20
there.

Conclusion:

@matroxfb developers: Thanks a lot, guys! Well done! Most people I asked ab=
out=20
having a dual-head framebuffer console at 1680x1050 thought it would be=20
impossible.

@mga xorg developers: Well... Can you tell me why the kernel guys can=20
initialize and use the second head and you can't? If you can give me hints=
=20
where in the source I can start to look for the bug, I'm willing to spend=20
some time there. Is there something I could try in my configuration?

Any hints?

Thanks,
Hans
