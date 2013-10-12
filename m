From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Sat, 12 Oct 2013 13:08:52 +0000
Subject: Re: [PATCH 2/2] framebuffer: Remove pmag-aa-fb
Message-Id: <alpine.LFD.2.03.1310121308310.10951@linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c94f3e342947923f20d4c12932f382aa5200511b.1379641901.git.joe@perches.com>         <6f500d88eb23fd9a4cfc5583f5ca17bc5f58fe24.1379641901.git.joe@perches.com>         <CAMuHMdW6R5qTJ0uvsUUaYBZAqFcNshPsXeMbz5hwqq5UOkJr-g@mail.gmail.com>        
 <alpine.LFD.2.03.1309201907380.8379@linux-mips.org> <1379702587.2301.12.camel@joe-AO722> <alpine.LFD.2.03.1309201946430.8379@linux-mips.org>
In-Reply-To: <alpine.LFD.2.03.1309201946430.8379@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Joe Perches <joe@perches.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>

Joe,

 Just a quick update.

On Sun, 22 Sep 2013, Maciej W. Rozycki wrote:

>  As to the PMAG-AA board itself -- well, this is indeed a very rare item,=
=20
> but I happen to have a specimen.  To support it properly I'll first have =

> to wire it to a monitor somehow though; signalling is standard, 1.0 Vpp=20
> composite monochrome, but what looks to me like a type F connector is use=
d=20
> for video output, quite unusually for a graphics card (and for DEC itself=
=20
> too as 3W3 was their usual video socket).  It looks to me like converting=
=20
> it to BNC and then a standard DE-15 VGA connector (via the green line)=20
> will be the easiest way to get image produced by the adapter on a=20
> contemporary monitor (sync-on-green required of course, but with LCD=20
> devices being the norm now that seems less of a problem these days).

 So more weirdly even that's actually a TNC connector rather than a type F =

one.  I've got a suitable TNC->BNC adapter now (although regrettably such=20
adapters seem to be available as 50=D9 parts only; hopefully any distortion=
=20
won't be too significant or maybe my digital monitor will even be able to=20
compensate it, but at =A31.76 (~$2.64) per item it's certainly worth trying=
=20
before resorting to the original DEC TNC->BNC cable still apparently=20
available from second-hand part suppliers at ~=A380/$120 per a mere 1ft=20
part) and a BNC->DE-15 cable is on the way.

> > --- a/drivers/video/pmag-aa-fb.c
> > +++ b/drivers/video/pmag-aa-fb.c
> > @@ -459,7 +459,7 @@ static int __init init_one(int slot)
> >  		return -EINVAL;
> > =20
> >  	printk(KERN_INFO "fb%d: %s frame buffer in TC slot %d\n",
> > -	       GET_FB_IDX(ip->info.node), ip->info.modename, slot);
> > +	       ip->info.node, ip->info.modename, slot);
> > =20
> >  	return 0;
> >  }
>=20
>  Thanks, but the changes required are actually much more than that -- the=
=20
> driver has never been converted to the modern TURBOchannel API.  I have=20
> now dug out an old patch I was working on back in 2006 to convert this=20
> driver as well as drivers/video/maxinefb.c.  I'll try to complete the two=
=20
> drivers as soon as possible (unfortunately I can't test the latter at all=
;=20
> it's for an onboard graphics adapter of another DECstation model),=20
> although I now remember the main reason I didn't complete them back then =

> was they used an old internal API that was removed and no suitable=20
> replacement provided.  I need to investigate again what that actually was=
=20
> though (hw cursor probably).

 So I think I've got all the basic stuff covered now, including a change=20
similar to your proposal as well as a conversion to the driver model/new=20
TURBOchannel support infrastructure.  But what I remembered is actually=20
right, the issue is wiring hardware cursor support into fbcon.  The driver =

uses its own display_switch structure with its own aafbcon_cursor handler=20
to use the twin onboard Bt431 chips for cursor generation (there's also=20
aafbcon_set_font that pokes at the Bt431s for cursor dimension changes). =20
I need to figure out what the best way will be to make the fbcon subsystem =

support such an arrangement and that'll take me a little bit yet, so=20
please be patient.

 Note that the board is weird enough to have a 1-bit (true monochrome)=20
graphics plane, however the Bt455 used by the MX graphics adapter for=20
screen image generation is a 4-bit grey-scale video RAMDAC (only the LSB=20
inputs of its pixel port are wired to the graphics plane) and the twin=20
Bt431s use the overlay plane to produce a 2-bit grey-scale cursor.  So we=20
do want to use the hardware cursor to be able to make it prominent among=20
the characters displayed throughout the screen and a software-generated=20
cursor cannot really substitute what hardware provides.

  Maciej
