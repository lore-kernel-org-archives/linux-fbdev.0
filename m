From: "Chintakuntla, Radha" <Radha.Chintakuntla@cavium.com>
Date: Sun, 12 Jun 2016 05:05:27 +0000
Subject: RE: [PATCH] fbcon: warn on invalid cursor blink intervals
Message-Id: <BLUPR0701MB1620B3F8C64E2CF5723B8FDCF0520@BLUPR0701MB1620.namprd07.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <ed8fa4ca-49e0-3ff4-5499-fc5250dd8ae2@caviumnetworks.com>
 <alpine.DEB.2.10.1605182252230.12118@laptop>
 <573DE2D0.1050402@caviumnetworks.com>
 <alpine.DEB.2.10.1605191708400.15396@laptop>
 <alpine.DEB.2.10.1605191726030.15478@laptop>
 <CACVXFVM77CaHGE9kwhaxoa-fuNxZrDDzpCdHfnRno857pQANZQ@mail.gmail.com>
 <573E75CD.6050202@ozlabs.org>
 <CACVXFVPRiOShXHNCQsDe_0AoC++wQAfix3OTjyKC4spu1r9LvQ@mail.gmail.com>
 <573E9AE5.1020206@ozlabs.org> <alpine.DEB.2.10.1605200937330.18587@laptop>
 <20160528114846.GC13329@khazad-dum.debian.net>
In-Reply-To: <20160528114846.GC13329@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Scot Doyle <lkml14@scotdoyle.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeremy Kerr <jk@ozlabs.org>, Ming Lei <ming.lei@canonical.com>, "Daney, David" <David.Daney@cavium.com>, Dann Frazier <dann.frazier@canonical.com>, Peter Hurley <peter@hurleysoftware.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Liu <net147@gmail.com>, Alistair Popple <alistair@popple.id.au>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Jiri Slaby <jslaby@suse.com>, David Airlie <airlied@linux.ie>, David Daney <ddaney.cavm@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, "Chintakuntla, Radha" <Radha.Chintakuntla@cavium.com>


> -----Original Message-----
> From: Henrique de Moraes Holschuh [mailto:hmh@hmh.eng.br]
> Sent: Saturday, May 28, 2016 4:49 AM
> To: Scot Doyle <lkml14@scotdoyle.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>; Jean-Christophe Plagniol-
> Villard <plagnioj@jcrosoft.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Jeremy Kerr <jk@ozlabs.org>; Ming Lei
> <ming.lei@canonical.com>; Daney, David <David.Daney@cavium.com>;
> Dann Frazier <dann.frazier@canonical.com>; Peter Hurley
> <peter@hurleysoftware.com>; Pavel Machek <pavel@ucw.cz>; Jonathan Liu
> <net147@gmail.com>; Alistair Popple <alistair@popple.id.au>; Jean-Philippe
> Brucker <jean-philippe.brucker@arm.com>; Chintakuntla, Radha
> <Radha.Chintakuntla@cavium.com>; Jiri Slaby <jslaby@suse.com>; David
> Airlie <airlied@linux.ie>; David Daney <ddaney.cavm@gmail.com>; dri-
> devel@lists.freedesktop.org; linux-fbdev@vger.kernel.org; Linux Kernel
> Mailing List <linux-kernel@vger.kernel.org>; stable
> <stable@vger.kernel.org>
> Subject: Re: [PATCH] fbcon: warn on invalid cursor blink intervals
> 
> On Fri, 20 May 2016, Scot Doyle wrote:
> > On Fri, 20 May 2016, Jeremy Kerr wrote:
> > > >Then looks there are two fix patches acked & tested:
> > > >
> > > > - the patch in this thread
> > > > - another one "[PATCH] tty: vt: Fix soft lockup in fbcon cursor
> > > >blink timer."
> > > > https://lkml.org/lkml/2016/5/17/455
> > > >
> > > >So which one will be pushed to linus?
> > >
> > > Not that it's my call, but we may want both; the first as a safety
> > > measure to prevent an invalid cur_blink_jiffies ever being set, and the
> > > second one to actually fix the initialisation of vc_cur_blink_ms (and
> > > address the warning introduced by the first).
> >
> > Tomi / Greg,
> >
> > I'd suggest
> > - applying "tty: vt: Fix soft lockup in fbcon cursor blink timer." to 4.7 and
> stable[4.2]
> > - applying "fbcon: warn on invalid cursor blink intervals" to 4.7
> > - ignoring "fbcon: use default if cursor blink interval is not valid"
> >
> > Note: the patches don't depend on each other
> 
> I applied both recommended patches on top of 4.4.11 for testing, and they
> made things a lot better here.
> 
> I suggest the second patch should be backported to stable too, might as well
> fix this thing for good *and keep the door closed*.

Is this patch available on some tree so that I can point to ?
And hope it will make it to linux-next soon ?

> 
> --
>   "One disk to rule them all, One disk to find them. One disk to bring
>   them all and in the darkness grind them. In the Land of Redmond
>   where the shadows lie." -- The Silicon Valley Tarot
>   Henrique Holschuh
