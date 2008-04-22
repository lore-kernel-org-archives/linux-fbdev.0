From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: deprecating fix->mmio_start and smem_start
Date: Tue, 22 Apr 2008 21:41:41 +0300
Message-ID: <20080422184141.GI16619@sci.fi>
References: <1208827046.9640.73.camel@pasglop>
	<Pine.LNX.4.64.0804220951380.14102@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JoNRE-0002Zk-JE for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 11:41:56 -0700
Received: from smtp6.pp.htv.fi ([213.243.153.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JoNR4-0007ox-7Y
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 11:41:50 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0804220951380.14102@anakin>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>

On Tue, Apr 22, 2008 at 10:00:10AM +0200, Geert Uytterhoeven wrote:
> On Tue, 22 Apr 2008, Benjamin Herrenschmidt wrote:
> > We currently have a problem with those two members of struct
> > fb_fix_screeninfo. The struct contains an "unsigned long" which means
> > that:
> > =

> > - 64 bits kernels with 32 bits userspace can't pass a complete address
> > - 32 bits machines with 64 bits resource_size_t can't pass a complete
> > address
> > - The structure isn't even properly padded to be 32/64 bits neutral in
> > the first place.
> > =

> > We could define new versions of the struct with new get/set ioctls,
> > or we could try to just deprecate those fields. What do you guys think ?
> =

> As userspace doesn't really need those fields[1], we can easily deprecate=
 them.

DirectFB uses both.

smem_start is used to get the physical address of the frambuffer for v4l
capture purposes at least. It's also used by several of the hw specific
gfxdrivers for various reasons. For example the matrox driver uses it to
figure out the offset from the beginning of the video memory to the
portion allocated for CRTC2 by matroxfb. This only applies when matroxfb
is left in control of CRTC2. I doubt may people use DirectFB this way
since DirectFB can drive CRTC2+TVout itself and manage the full memory
for both heads. But the support is still there in the code FWIW. I'm
not actually sure what the other gfxdrivers use it for but I see several
references when I grep for it.

mmio_start is used to figure out where the registers actually lie within
the mmapped MMIO area. atyfb is the only fb driver that I know to need
this. The problem is that with new chips the aux register aperture is
used and the registers are at the beginning of that aperture but when the
aux register aperture is not used the registers occupy the last 2K
of the framebuffer. That means an offset of 2K on typical systems.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
