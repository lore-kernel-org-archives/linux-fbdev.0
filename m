From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: FB model basic issues (WAS: radeon,
 apertures & memory mapping)
Date: Tue, 15 Mar 2005 09:51:40 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0503150946180.30569@numbat.sonytel.be>
References: <1110677744.19810.80.camel@gaston> <9e47339105031219223e606a52@mail.gmail.com>
 <1110696189.5787.100.camel@gaston> <1110774523.4003.511.camel@localhost>
 <1110784327.5787.288.camel@gaston> <1110817205.4004.527.camel@localhost>
 <1110837171.5863.16.camel@gaston> <1110838356.4003.548.camel@localhost>
 <1110839873.5673.41.camel@gaston> <1110862777.4044.592.camel@localhost>
 <20050315060138.GA13064@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584334533-432997379-1110876700=:30569"
In-Reply-To: <20050315060138.GA13064@sci.fi>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org, Jon Smirl <jonsmirl@yahoo.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584334533-432997379-1110876700=:30569
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by witte.sonytel.be id j2F8pqGU024271

On Tue, 15 Mar 2005, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
> I think that making the assumption that all memory is preserved when th=
e=20
> memory layout (virtual resolution and depth) doesn't change is perfectl=
y=20
> valid too. That would allow X to do it's Ctrl-Alt-+ and - things withou=
t=20
> repainting the whole screen.

Indeed. The `geometry' part of the screen isn't changed, only the `timing=
s'
part (cfr. the split of fb_var_screeninfo parameters I did in fbutils (wh=
ich
BTW wasn't ever finished).

> If radeonfb will allocate the buffer for the second head from the top o=
f=20
> the memory users would basically have to guess it's location. matroxfb=20
> simply cuts the memory in two pieces and allocates the buffers from the=
=20
> start of each piece. I don't really like that approach. Adding a simple=
=20
> byte_offset field to fb_var_screeninfo would solve the problem quite=20
> nicely but I don't know if such API changes are acceptable at this stag=
e.

You wouldn't have to guess its location, look at fix.smem_start.

I once did a similar thing for an embedded prototype: take a fixed amount=
 of
memory for both frame buffers (this was a UMA system), fb0 starts from th=
e top,
fb1 starts from the bottom. You can enlarge each frame buffer, until you =
read
the memory of the other. Each fix.smem_{start,len} corresponds exactly to=
 the
memory allocated to each frame buffer.

Of course, if you also want off-screen memory (i.e. memory beyond
xres_virtual*yres_virtual*bpp/8), things get more complicated, since curr=
ently
there's no way for the application to ask for a minimum amount of off-scr=
een
memory. Perhaps a new field in fb_var_screeninfo (and zero means `I don't
care', for backwards compatibility).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds
---584334533-432997379-1110876700=:30569--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
