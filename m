From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [announce 7/7] fbsplash - documentation
Date: Wed, 9 Mar 2005 01:17:11 +0100
Message-ID: <200503090117.12755.arnd@arndb.de>
References: <20050308021706.GH26249@spock.one.pl> <200503080418.08804.arnd@arndb.de> <20050308223728.GA11065@spock.one.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20050308223728.GA11065@spock.one.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Michal Januszewski <spock@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Dinsdag 08 M=C3=A4rz 2005 23:37, Michal Januszewski wrote:
> On Tue, Mar 08, 2005 at 04:18:07AM +0100, Arnd Bergmann wrote:
>=20
> > It should probably just use its own hotplug agent instead of callin=
g
> > the helper directly.
>=20
> I've just had a look at it, and it seems possible. From what I have s=
een
> in the firmware_class.c code, it would require:
>  - registering a class somewhere in the initializaton code
>  - every time a request from fbcon is generated:
>    - register the class device
>    - create a timer
>    - call kobject_hotplug() to send the event to userspace
>    - unregister the device
>=20
> This requests sent to userspace are generated while switching console=
s
> and resetting the graphics mode. This whole create device - send the
> event - remove device thing seems a little long to me. Would it be
> acceptable?

Sorry, I had forgotten about the recent changes to the kernel side of t=
he
hotplug interface, i.e. that it now needs a kobject to work.
It used to be possible to just call_usermodehelper() with hotplug_path
as its argv[0], but that is currently being phased out.

You also shouldn't create a class device every time you want to call
kobject_hotplug. Note that every character device already has a class
device associated with it, so you might be able to just use that to cal=
l=20
kobject_hotplug on it.

If there is no obvious way to do that, just leave the code as it is
for calling the helper.

> > > + When the userspace helper is called in an early phase of the bo=
ot process
> > > + (right after the initialization of fbcon), no filesystems will =
be mounted.
> > > + The helper program should mount sysfs and then create the appro=
priate=20
> > > + framebuffer, fbsplash and tty0 devices (if they don't already e=
xist) to get=20
> > > + current display settings and to be able to communicate with the=
 kernel side.
> > > + It should probably also mount the procfs to be able to parse th=
e kernel=20
> > > + command line parameters.
> > Nothing about the init command seems really necessary. Why not just=
 do=20
> > that stuff from an /sbin/init script?
>=20
> The reason for calling init in that place is the ability to use the
> userspace helper to display a nice picture while the kernel is still
> loading. Sure, you can just drop it and use the 'quiet' command line
> option, but that will give you a black screen for a good few seconds.
> And people who want eye-candy like fbsplash generally don't like that=
=2E=20

Ok, understood. I think you should make that an extra patch and complet=
ely
remove that feature from the base patchset in order to make it less
controversial.

> > > +FB_SPLASH_IO_ORIG_KERNEL instructs fbsplash not to try to acquir=
e the console
> > > +semaphore. Not surprisingly, FB_SPLASH_IO_ORIG_USER instructs it=
 to acquire
> > > +the console sem.
> >=20
> > That sounds really dangerous. Can you guarantee that nothing unexpe=
cted happens
> > when a malicious user calls the ioctls with FB_SPLASH_IO_ORIG_KERNE=
L from a
> > regular user process?
>=20
> This is pretty nasty, right, but I just can't see a way around it. Th=
e
> thing is, when the splash helper is called from the kernel, the conso=
le
> semaphore is already held so we have to avoid trying to acquire it
> again. And we can't just release it prior to calling the helper, as i=
t
> would break things badly.

I don't understand. Does the kernel code need to wait for the helper
to finish while holding the semaphore? AFAICS, the helper is completely
asynchronous, so it can simply do its job when the kernel has given
up the semaphore.

> > > +Info on used structures:
> > > +
> > > +Definition of struct vc_splash can be found in linux/console_spl=
ash.h. It's
> > > +heavily commented. Note that the 'theme' field should point to a=
 string
> > Not that heavily documented, actually ;-).=20
>=20
> Anything that needs some clearing-up?

No, probably not. Maybe just remove that sentence from the text.

> > > +no longer than FB_SPLASH_THEME_LEN. When FBIOSPLASH_GETCFG call =
is=20
> > > +performed, the theme field should point to a char buffer of leng=
th
> > > +FB_SPLASH_THEME_LEN.
> > Then don't make it pointer but instead a field of that length. Poin=
ters
> > in ioctl arguments only cause trouble in mixed 32/64 bit environmen=
ts.
>=20
> That could be arranged, but this would require a separate structure f=
or
> communicating with userspace and with in-kernel data storage (current=
ly
> both these tasks are handled with struct vc_splash), or changing
> vc_splash in vc_data to a pointer to a structure. The latter option
> would be better I think.

Yes, that makes sense.

> - fbsplash calls aren't really related to a particular framebuffer
>   device, they are related to a tty.=20

ok.

>                                       And we can't do ioctls on ttys =
when=20
>   answering a kernel request because to the console sem problems
>   (opening a tty =3D a call to acquire_console_sem(), which we need t=
o
>   avoid).

Hmm. One of us has misunderstood the interaction between=20
call_usermodehelper() and acquire_console_sem(). If I'm the one
who's wrong, please tell me where that semaphore is held.

> The original idea behind this was to group the fields that are common=
 to
> all fbsplash ioctl calls (ie. vc and origin) in one place. Of course,
> it can be changed to three differents structs, each containing the vc
> and origin fields and an int/struct vc_splash/struct fb_image, if tha=
t
> is the preferred way of doing things.

It definitely is. Actually, it would be preferred to have only a single
value as ioctl argument (or even better, no ioctl at all), but if you
need to pass an aggregate data type, it should at least have an identic=
al
layout for all architectures. That means every member should be natural=
ly
aligned and you can't use pointers or other types that have sizeof(x)
=3D=3D sizeof(long).

 Arnd <><
