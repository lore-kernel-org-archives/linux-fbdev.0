From: "Parag Warudkar" <parag.warudkar@wipro.com>
Subject: RE: 2.5.70 - Blank Screen with VESA VGA Framebuffer
Date: Fri, 13 Jun 2003 14:06:56 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <0BCBFEACE44CF0469CF5EBF7F6B612534468DE@chn-snr-msg.wipro.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from wiprom2mx1.wipro.com ([203.197.164.41])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Qk5D-00081J-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 13 Jun 2003 01:39:00 -0700
Received: from m2vwall5.wipro.com (m2vwall5.wipro.com [10.115.50.5])
	by wiprom2mx1.wipro.com (8.11.3/8.11.3) with SMTP id h5D8b1C18882
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 13 Jun 2003 14:07:02 +0530 (IST)
content-class: urn:content-classes:message
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

No. Atyfb hasn't worked for me in 2.4.20. If I use video=3Datyfb, I get =
a
corrupted white screen which is beyond my capabilities to describe!! :)

The graphics chip is ATI RAGE Mobility M1(LT) AGP2X - a MACH64 Derivate
with 8Mb RAM..  For X, 3D acceleration (DRI, direct rendering) works
with a Mach64 branch of XFree86.
(http://dri.sourceforge.net/snapshots/bleeding-edge/mach64*-*)

-----Original Message-----
From: Geert Uytterhoeven [mailto:geert@linux-m68k.org]=20
Sent: Friday, June 13, 2003 1:37 PM
To: Parag Warudkar
Cc: James Simmons; Linux Frame Buffer Device Development
Subject: RE: [Linux-fbdev-devel] 2.5.70 - Blank Screen with VESA VGA
Framebuffer

On Fri, 13 Jun 2003, Parag Warudkar wrote:
> Thanx for your reply. I have attached my config file. I have tried all
> possible configurations (desparation ;) but it hasn't worked so far.=20
> (Same problem sometimes white screen (atyfb) and sometimes blank
> (vga=3D788)).
> If you need more info or want me to try out something, please let me
> know.

Does atyfb in 2.4.20 work for you? You may have the Mobility M1 that
doesn't
work (yet) with atyfb, but we're getting closer...

> -----Original Message-----
> From:   James Simmons [mailto:jsimmons@infradead.org]
> Sent:   Fri 6/13/2003 00:27
> To:     Parag Warudkar
> Cc:     linux-fbdev-devel@lists.sourceforge.net
> Subject:        Re: [Linux-fbdev-devel] 2.5.70 - Blank Screen with
VESA
> VGA Framebuffer
>=20
>=20
> > I have a Sony VAIO laptop with ATI Mobility M1 AGP chip. I can use
> > XFree86 on 2.4.x if I enable VESA VGA Frame buffer and enable
vga=3D788
> on
> > kernel command line. With Kernel 2.5.70 after enabling VESA VGA
> > Framebuffer console and specifying vga=3D commandline, I just get a
blank
> > screen just after the boot process starts and X doesn't work.
(Garbled
> > screen). Without the vga=3D commandline, I get normal boot screen =
but
X
> > needs the vga=3D option and doesn't work.
> >
> > I have tried everything but to no avail. Does anyone know what do I
> need
> > to do in order to get kernel 2.5.X working with Framebuffer console
> > (VESA VGA or atyfb) and vga=3D788? I tried video=3Datyfb but that =
too
> > doesn't work..
>=20
> What does your config file look like. Did you enable both Framebuffer
> support and framebuffer console support?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker.
But
when I'm talking to journalists I just say "programmer" or something
like that.
							    -- Linus
Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
