From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Current discussion about the future of free software graphics
Date: Thu, 13 May 2004 12:39:06 +0200
Sender: dri-devel-admin@lists.sourceforge.net
Message-ID: <1084444744.3032.93.camel@thor.asgaard.local>
References: <20040512033045.16034.qmail@web14921.mail.yahoo.com>
Reply-To: dri-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040512033045.16034.qmail@web14921.mail.yahoo.com>
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net

On Wed, 2004-05-12 at 05:30, Jon Smirl wrote:
> If everyone will please read Benh's original post describing this... Ben =
and I
> had been emailing on this topic before he wrote this.
>=20
> --- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > I agree with the idea of moving the EDID decoding & mode selection to
> > userland. In this regard, though, I beleive we should aim toward some
> > simple library that sits with the kernel, eventually distributed with
> > the kernel tree, to live in initramfs optionally since it may be
> > required to even get a console at boot (which is fine, initramfs is
> > available early). The video cards themselves have PCI drivers that can
> > "trigger" detection by the library via hotplug, the library could manage
> > things like persistent configuration, either separate desktops or
> > geometry of a complex desktop, etc... and eventually notification of
> > userland clients of mode changes.
> >=20
> > One reason for that is lots of monitors lie about their capabilities in
> > their EDID block, so we want "override" files.
> >=20
> > The kernel driver in this case doesn't need to be that much different
> > than the current fbdev's though, except that we want to move the HW
> > access for graphics commands to the kernel too, which basically turns
> > into merging the DRI driver and the fbdev. There is no need, I think, to
> > re-invent the wheel from scratch here, it would be a lot more realistic
> > to build on top of those existing pieces.
>=20
> What this is saying is that very early in the boot process the graphics d=
river
> will be initialized. At this point it will generate a hotplug event. This=
 event
> will be handled by an app and lib that live in initramfs.  This is not sa=
ying
> that mode-setting will be delayed until normal user space starts.

Sure, because Ben doesn't talk about moving mode-setting to userland at
all AFAICT. :)


> I've already built a very messy prototype by moving the existing fbdev=20
> code to user space and it works just fine.=20

Maybe if others could play with this prototype...


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=3D2562&alloc_id=3D6184&op=3Dclick
--
