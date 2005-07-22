From: jurriaan <thunder7@xs4all.nl>
Subject: Re: ghosting with nvidia framebuffer (pci-e 6600), 1600x1200 and 12x22 font
Date: Fri, 22 Jul 2005 15:29:54 +0200
Message-ID: <20050722132954.GA2363@amd64.of.nowhere>
References: <20050706190456.GA20251@amd64.of.nowhere> <200507221203.31810.adaplas@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dvxbu-0001aY-Av
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Jul 2005 06:30:42 -0700
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dvxbs-00076Q-DH
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Jul 2005 06:30:42 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-vbr13.xs4all.nl (8.13.3/8.13.3) with ESMTP id j6MDUYKY063945
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 22 Jul 2005 15:30:38 +0200 (CEST)
	(envelope-from jurriaan@rivierenland.xs4all.nl)
Content-Disposition: inline
In-Reply-To: <200507221203.31810.adaplas@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

From: Antonino A. Daplas <adaplas@gmail.com>
Date: Fri, Jul 22, 2005 at 12:03:31PM +0800
> On Thursday 07 July 2005 03:04, jurriaan wrote:
> > I've bought myself a fine new s939 motherboard, which meant another
> > videocard as well. Since I couldn't get an Ati X600 running reliably
> > under X.org (#@#$*$ FIFO timed out errors are very frustrating, and t=
he
> > only solution I found was to shut down all acceleration, which didn't
> > make me happy), I'm now running an Nvidia 6600.
> >
> > Kernel command line: root=3D/dev/hda1 video=3Dnvidiafb:1600x1200-32@8=
5
> > atkbd.softrepeat=3D1
> >
> > nvidiafb: nVidia device/chipset 10DE0141
> > nvidiafb: PCI device 10de:0141 (nVidia Corporation)
> > nvidiafb: CRTC0 found
> > nvidiafb: CRTC1 found
> > nvidiafb: CRTC 0 appears to have a CRT attached
> > nvidiafb: Using CRT on CRTC 0
> > nvidiafb: MTRR set to ON
> > Console: switching to colour frame buffer device 133x54
> > nvidiafb: PCI nVidia NV14 framebuffer (64MB @ 0xC0000000)
> >
> > I'm running at 1600x1200 resolution with the 12x22 font, and a
> > 2.6.13-rc1-mm1 kernel.
> >
> > A strange effect is noticeable: often characters from the left of the
> > screen are ghosted on the right of the screen. Not all of the pixels
> > that form a character, but enough to be visible. To my best knowledge=
,
> > the ghosting starts at column 85, and 85 * 12 =3D 1020, which may mea=
n
> > some sort of erroneous wrap-around at pixel 1024 is taking place?
> >
>=20
> It looks like a timings problem.  Are the effects still present if you =
try to
> change modes?
>=20
> Based on the dmesg snippet, I don't think the driver was able to grab t=
he
> edid.  Which means that the mode 1600x1200 was taken from the default m=
odedb
> which may not be correct for your hardware.
>=20
> If you can, grab X's modeline using xvidtune, then convert it into a fb
> compatible modeline, enter it in /etc/fb.modes then use fbset to change=
 your
> video mode.
>=20

First of all, I've discovered there's two types of corruption.
There's the ghosting, and there's a spurious underlining at the end of
lines.

For the ghosting, see

http://www.xs4all.nl/~thunder7/nvidia_ghosting1.jpg
http://www.xs4all.nl/~thunder7/nvidia_ghosting2.jpg

Especially in the second picture, see how pixels from the left half of
the screen are repeated, starting at column 1024 (in pixels) on the
right half of the screen.

For the underlining, see

http://www.xs4all.nl/~thunder7/nvidia_underline1.jpg
http://www.xs4all.nl/~thunder7/nvidia_underline2.jpg

In the first picture, check the second mail from the bottom, there's
underlining below '.c' at the end. In the second picture, there's
underlining at the end of rec.games.roguelike.adom,
rec.games.roguelike.announce, rec.games.roguelike.development and
rec.games.roguelike.misc.

Now my table:

resolution        | fontsize | ghosting | underlining
------------------+----------+----------+------------
1600x1200-32      |  10x18   |  X       |  X

1600x1200-32      |  12x22   |  X       |  X
1600x1200-16      |  12x22   |  -       |  X
1600x1200-8       |  12x22   |  -       |  -
1600x1200-32      |  8x16    |  X       |  X
1600x1200-16      |  8x16    |  -       |  -
1600x1200-8       |  8x16    |  -       |  -

1280x1024-32      |  12x22   |  -       |  X
1280x1024-16      |  12x22   |  -       |  X
1280x1024-8       |  12x22   |  -       |  -
1280x1024-32      |  8x16    |  -       |  X
1280x1024-16      |  8x16    |  -       |  X
1280x1024-8       |  8x16    |  -       |  -

My conclusion  would be the ghosting only happens at 1600x1200-32, and
the underling happens in more than 8-bit deep displays. And it has
something to do with acceleration, if I boot like this, nothing is
corrupted:

Bootdata ok (command line is root=3D/dev/md0 video=3Dnvidiafb:1600x1200-3=
2@85,noaccel atkbd.softrepeat=3D1)
Linux version 2.6.13-rc3-mm1 (jurriaan@middle) (gcc version 4.0.1 (Debian=
 4.0.1-2)) #28 Fri Jul 22 15:23:32 CEST 2005

Here's a piece of X.org's log:

X Window System Version 6.8.2 (Debian 6.8.2.dfsg.1-3 20050719223829 Frede=
rik Sch=C3=BCler <fschueler@gmx.net>)
Release Date: 9 February 2005
X Protocol Version 11, Revision 0, Release 6.8.2
Build Operating System: Linux 2.6.12-1-amd64-k8 x86_64 [ELF]=20
Current Operating System: Linux middle 2.6.13-rc3-mm1 #25 Fri Jul 22 13:5=
2:51 CEST 2005 x86_64
Build Date: 20 July 2005
(II) Primary Device is: PCI 01:00:0
(--) Chipset GeForce 6600 found
(II) Setting vga for screen 0.
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
(II) NV(0): Initializing int10
(WW) NV(0): Bad V_BIOS checksum
(II) NV(0): Primary V_BIOS segment is: 0xc000
(--) NV(0): Chipset: "GeForce 6600"
(**) NV(0): Depth 24, (--) framebuffer bpp 32
(=3D=3D) NV(0): RGB weight 888
(=3D=3D) NV(0): Default visual is TrueColor
(II) LoadModule: "ddc"
(II) Reloading /usr/X11R6/lib/modules/libddc.a
(II) NV(0): I2C bus "DDC" initialized.
(II) NV(0): Probing for analog device on output A...
(--) NV(0):   ...found one
(II) NV(0): Probing for analog device on output B...
(--) NV(0):   ...found one
(II) NV(0): Probing for EDID on I2C bus A...
(II) NV(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) NV(0): I2C device "DDC:ddc2" removed.
(II) NV(0):   ... none found
(II) NV(0): Probing for EDID on I2C bus B...
(II) NV(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) NV(0): I2C device "DDC:ddc2" removed.
(--) NV(0): DDC detected a CRT:
(II) NV(0): Manufacturer: ENC  Model: 1630  Serial#: 1181904914
(II) NV(0): Year: 2002  Week: 4
(II) NV(0): EDID Version: 1.2
(II) NV(0): Analog Display Input,  Input Voltage Level: 0.700/0.300 V
(II) NV(0): Sync:  Separate  Composite  SyncOnGreen
(II) NV(0): Max H-Image Size [cm]: horiz.: 41  vert.: 30
(II) NV(0): Gamma: 1.80
(II) NV(0): DPMS capabilities: StandBy Suspend Off; RGB/Color Display
(II) NV(0): First detailed timing is preferred mode
(II) NV(0): redX: 0.625 redY: 0.340   greenX: 0.281 greenY: 0.602
(II) NV(0): blueX: 0.150 blueY: 0.065   whiteX: 0.283 whiteY: 0.297
(II) NV(0): Supported VESA Video Modes:
(II) NV(0): 720x400@70Hz
(II) NV(0): 720x400@88Hz
(II) NV(0): 640x480@60Hz
(II) NV(0): 640x480@67Hz
(II) NV(0): 640x480@72Hz
(II) NV(0): 640x480@75Hz
(II) NV(0): 800x600@56Hz
(II) NV(0): 800x600@60Hz
(II) NV(0): 800x600@72Hz
(II) NV(0): 800x600@75Hz
(II) NV(0): 832x624@75Hz
(II) NV(0): 1024x768@87Hz (interlaced)
(II) NV(0): 1024x768@60Hz
(II) NV(0): 1024x768@70Hz
(II) NV(0): 1024x768@75Hz
(II) NV(0): 1280x1024@75Hz
(II) NV(0): 1152x870@75Hz
(II) NV(0): Manufacturer's mask: 0
(II) NV(0): Supported Future Video Modes:
(II) NV(0): #0: hsize: 1024  vsize 768  refresh: 85  vid: 22881
(II) NV(0): #1: hsize: 1024  vsize 768  refresh: 100  vid: 26721
(II) NV(0): #2: hsize: 1152  vsize 864  refresh: 85  vid: 22897
(II) NV(0): #3: hsize: 1280  vsize 1024  refresh: 85  vid: 39297
(II) NV(0): #4: hsize: 1600  vsize 1200  refresh: 85  vid: 22953
(II) NV(0): #5: hsize: 2048  vsize 1536  refresh: 75  vid: 20449
(II) NV(0): #6: hsize: 1856  vsize 1392  refresh: 85  vid: 22985
(II) NV(0): #7: hsize: 1920  vsize 1440  refresh: 85  vid: 22993
(II) NV(0): Supported additional Video Mode:
(II) NV(0): clock: 230.0 MHz   Image Size:  392 x 294 mm
(II) NV(0): h_active: 1600  h_sync: 1664  h_sync_end 1856 h_blank_end 216=
0 h_border: 0
(II) NV(0): v_active: 1200  v_sync: 1201  v_sync_end 1204 v_blanking: 125=
0 v_border: 0
(II) NV(0): Serial No: 46727012
(II) NV(0): Ranges: V min: 50  V max: 160 Hz, H min: 30  H max: 130 kHz, =
PixClock max 350 MHz
(II) NV(0): Monitor name: F931
(--) NV(0): CRTC 0 appears to have a CRT attached
(II) NV(0): Using CRT on CRTC 0
(--) NV(0): VideoRAM: 262144 kBytes

I really hope you can find out something about this. Do you have
compatible hardware? If not, contact me and I'll try to make a deal with
you - a 1600x1200-32 accelerated framebuffer is something I really like,
and since Ati cards don't work correctly in the pci-express system (give
all kind of fifo timeouts in X), I don't have any other choice, so
NVidia working is important to me.

Kind regards,
Jurriaan
--=20
Everybody need to deviate from the norm
   Rush - Vital Signs
Debian (Unstable) GNU/Linux 2.6.13-rc3-mm1 5149 bogomips load 0.10


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
