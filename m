From: Michal Januszewski <spock@gentoo.org>
Subject: Re: [announce 7/7] fbsplash - documentation
Date: Tue, 8 Mar 2005 23:37:29 +0100
Message-ID: <20050308223728.GA11065@spock.one.pl>
References: <20050308021706.GH26249@spock.one.pl> <200503080418.08804.arnd@arndb.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8nKa-0008MF-7v
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Mar 2005 14:37:36 -0800
Received: from ipp23-131.piekary.net ([80.48.23.131] helo=spock.one.pl)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D8nKY-0002w5-1J
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Mar 2005 14:37:36 -0800
Content-Disposition: inline
In-Reply-To: <200503080418.08804.arnd@arndb.de>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 08, 2005 at 04:18:07AM +0100, Arnd Bergmann wrote:

> It should probably just use its own hotplug agent instead of calling
> the helper directly.

I've just had a look at it, and it seems possible. From what I have seen
in the firmware_class.c code, it would require:
 - registering a class somewhere in the initializaton code
 - every time a request from fbcon is generated:
   - register the class device
   - create a timer
   - call kobject_hotplug() to send the event to userspace
   - unregister the device

This requests sent to userspace are generated while switching consoles
and resetting the graphics mode. This whole create device - send the
event - remove device thing seems a little long to me. Would it be
acceptable?
=20
> > +Splash protocol v1 specified an additional 'fbsplash mode' after the=
=20
> > +framebuffer number. Splash protocol v1 is deprecated and should not be=
 used.
> When you're submitting a patch for inclusion, the interface should really
> be stable. I'd completely drop all references to the old version and only
> support one interface here. Moreover, you should not do versioned interfa=
ces

The old one is already not supported. I mentioned v1 in the docs only so
that it would be clear where do the '2' in the helper's command line=20
arguments come from.=20

> unless you expect incompatible changes in future releases. As long as you
> still do, that is a sign that the patch is not ready for inclusion.

I don't do now, but who knows when changes will be made to fbcon in the
future? There's a possibility that things will change enough to justify
a new splash protocol.=20

On the other hand, if the hotplug way of calling userspace were to be
adopted in fbsplash, the whole splash interface with the versioning
scheme could be dropped, which, I guess, would be a good thing.

> > + When the userspace helper is called in an early phase of the boot pro=
cess
> > + (right after the initialization of fbcon), no filesystems will be mou=
nted.
> > + The helper program should mount sysfs and then create the appropriate=
=20
> > + framebuffer, fbsplash and tty0 devices (if they don't already exist) =
to get=20
> > + current display settings and to be able to communicate with the kerne=
l side.
> > + It should probably also mount the procfs to be able to parse the kern=
el=20
> > + command line parameters.
> Nothing about the init command seems really necessary. Why not just do=20
> that stuff from an /sbin/init script?

The reason for calling init in that place is the ability to use the
userspace helper to display a nice picture while the kernel is still
loading. Sure, you can just drop it and use the 'quiet' command line
option, but that will give you a black screen for a good few seconds.
And people who want eye-candy like fbsplash generally don't like that.=20

I'm currently using a setup that is a combination of both the 'quiet'
option and the 'init' command. I'm using the splash helper to switch to
a selected tty and display a full-screen image, while keeping the tty=20
in KD_TEXT. This looks pretty nice and lets me see the initial bitmap
for ca. 5 secs.
=20
> > +FB_SPLASH_IO_ORIG_KERNEL instructs fbsplash not to try to acquire the =
console
> > +semaphore. Not surprisingly, FB_SPLASH_IO_ORIG_USER instructs it to ac=
quire
> > +the console sem.
>=20
> That sounds really dangerous. Can you guarantee that nothing unexpected h=
appens
> when a malicious user calls the ioctls with FB_SPLASH_IO_ORIG_KERNEL from=
 a
> regular user process?

This is pretty nasty, right, but I just can't see a way around it. The
thing is, when the splash helper is called from the kernel, the console
semaphore is already held so we have to avoid trying to acquire it
again. And we can't just release it prior to calling the helper, as it
would break things badly.

To make sure no one uses fbsplash for malicious purposes, the
/dev/fbsplash device is used, which is kept root-writable only.

> > +Info on used structures:
> > +
> > +Definition of struct vc_splash can be found in linux/console_splash.h.=
 It's
> > +heavily commented. Note that the 'theme' field should point to a string
> Not that heavily documented, actually ;-).=20

Anything that needs some clearing-up?
=20
> > +no longer than FB_SPLASH_THEME_LEN. When FBIOSPLASH_GETCFG call is=20
> > +performed, the theme field should point to a char buffer of length
> > +FB_SPLASH_THEME_LEN.
> Then don't make it pointer but instead a field of that length. Pointers
> in ioctl arguments only cause trouble in mixed 32/64 bit environments.

That could be arranged, but this would require a separate structure for
communicating with userspace and with in-kernel data storage (currently
both these tasks are handled with struct vc_splash), or changing
vc_splash in vc_data to a pointer to a structure. The latter option
would be better I think.
=20
> > +Definition of struct fb_splash_iowrapper can be found in linux/fb.h.
> > +The fields in this struct have the following meaning:
> > +
> > +vc:=20
> > +Virtual console number.
> This should not be needed. I notice you are creating your own miscdevice
> for passing ioctl commands. That seems a little backwards since there
> already is a character device for the frame buffer. Can't you simply
> add your ioctl commands there?

I can, but:
- there are the previously-mentioned security reasons -- the user might
  wish to make the fb device writable to some less trusted people, while
  the fbsplash device should be kept protected,
- fbsplash calls aren't really related to a particular framebuffer
  device, they are related to a tty. And we can't do ioctls on ttys when
  answering a kernel request because to the console sem problems
  (opening a tty =3D a call to acquire_console_sem(), which we need to
  avoid).

> > +origin:=20
> > +Specifies if the ioctl is performed as a response to a kernel request.=
 The
> > +splash helper should set this field to FB_SPLASH_IO_ORIG_KERNEL, users=
pace
> > +programs should set it to FB_SPLASH_IO_ORIG_USER. This field is necess=
ary to
> > +avoid console semaphore deadlocks.
> As I mentioned, this means there is thinko in your locking scheme.

It's not my locking scheme, it's the scheme that is currently used in
the whole console subsystem. If someone can find a sane way to correct
the problem and avoid the whole FB_SPLASH_IO_ORIG* thing, I would be
very heppy to update fbsplash's code.
=20
> > +data:=20
> > +Pointer to a data structure appropriate for the performed ioctl. Type =
of
> > +the data struct is specified in the ioctls description.
> This is very wrong. Using ioctl() for anything is bad enough because it
> contains an indirection from a system call. Here, you add yet another
> indirection. Instead of this, you should at least have a single data
> structure for each ioctl number, without using pointers to other structur=
es.

The original idea behind this was to group the fields that are common to
all fbsplash ioctl calls (ie. vc and origin) in one place. Of course,
it can be changed to three differents structs, each containing the vc
and origin fields and an int/struct vc_splash/struct fb_image, if that
is the preferred way of doing things.

Live long and prosper.
--=20
Michal 'Spock' Januszewski                        Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl


--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD4DBQFCLikoaQ0HSaOUe+YRAgjvAJkBWgBFhZv83IJ435wHXla7Xb8z9gCY2zSG
scQ52uw/+IieQTex+V8E5g==
=BNxy
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
