From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [announce 7/7] fbsplash - documentation
Date: Tue, 8 Mar 2005 04:18:07 +0100
Message-ID: <200503080418.08804.arnd@arndb.de>
References: <20050308021706.GH26249@spock.one.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20050308021706.GH26249@spock.one.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Michal Januszewski <spock@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Dinsdag 08 M=E4rz 2005 03:17, Michal Januszewski wrote:

> +It's possible to set path to the splash helper by writing it to=20
> +/proc/sys/kernel/fbsplash.

It should probably just use its own hotplug agent instead of calling
the helper directly.

> +Splash protocol v1 specified an additional 'fbsplash mode' after the=
=20
> +framebuffer number. Splash protocol v1 is deprecated and should not =
be used.

When you're submitting a patch for inclusion, the interface should real=
ly
be stable. I'd completely drop all references to the old version and on=
ly
support one interface here. Moreover, you should not do versioned inter=
faces
unless you expect incompatible changes in future releases. As long as y=
ou
still do, that is a sign that the patch is not ready for inclusion.

> +Splash protocol v2 specifies the following commands:
> +
> +getpic
> +------
> + The kernel issues this command to request image data. It's up to th=
e userspace
> + helper to find a background image appropriate for the specified the=
me and the=20
> + current resolution. The userspace helper should respond by issuing =
the
> + FBIOSPLASH_SETPIC ioctl.
> +
> +init
> +----
> + The kernel issues this command after the fbsplash device is created=
 and
> + the fbsplash interface is initialized. Upon receiving 'init', the u=
serspace=20
> + helper should parse the kernel command line (/proc/cmdline) or othe=
rwise
> + decide whether fbsplash is to be activated.=20
> +
> + To activate fbsplash on the first console the helper should issue t=
he
> + FBIOSPLASH_SETCFG, FBIOSPLASH_SETPIC and FBIOSPLASH_SETSTATE comman=
ds,
> + in the above-mentioned order.
> +
> + When the userspace helper is called in an early phase of the boot p=
rocess
> + (right after the initialization of fbcon), no filesystems will be m=
ounted.
> + The helper program should mount sysfs and then create the appropria=
te=20
> + framebuffer, fbsplash and tty0 devices (if they don't already exist=
) to get=20
> + current display settings and to be able to communicate with the ker=
nel side.
> + It should probably also mount the procfs to be able to parse the ke=
rnel=20
> + command line parameters.

Nothing about the init command seems really necessary. Why not just do=20
that stuff from an /sbin/init script?

> +modechange
> +----------
> + The kernel issues this command on a mode change. The helper's respo=
nse should
> + be similar to the response to the 'init' command. Note that this ti=
me the
> + console sem is held and all ioctls must be performed with origin se=
t to
> + FB_SPLASH_IO_ORIG_KERNEL.
>
> +FB_SPLASH_IO_ORIG_KERNEL instructs fbsplash not to try to acquire th=
e console
> +semaphore. Not surprisingly, FB_SPLASH_IO_ORIG_USER instructs it to =
acquire
> +the console sem.

That sounds really dangerous. Can you guarantee that nothing unexpected=
 happens
when a malicious user calls the ioctls with FB_SPLASH_IO_ORIG_KERNEL fr=
om a
regular user process?

> +Info on used structures:
> +
> +Definition of struct vc_splash can be found in linux/console_splash.=
h. It's
> +heavily commented. Note that the 'theme' field should point to a str=
ing

Not that heavily documented, actually ;-).=20

> +no longer than FB_SPLASH_THEME_LEN. When FBIOSPLASH_GETCFG call is=20
> +performed, the theme field should point to a char buffer of length
> +FB_SPLASH_THEME_LEN.

Then don't make it pointer but instead a field of that length. Pointers
in ioctl arguments only cause trouble in mixed 32/64 bit environments.

> +Definition of struct fb_splash_iowrapper can be found in linux/fb.h.
> +The fields in this struct have the following meaning:
> +
> +vc:=20
> +Virtual console number.

This should not be needed. I notice you are creating your own miscdevic=
e
for passing ioctl commands. That seems a little backwards since there
already is a character device for the frame buffer. Can't you simply
add your ioctl commands there?

> +origin:=20
> +Specifies if the ioctl is performed as a response to a kernel reques=
t. The
> +splash helper should set this field to FB_SPLASH_IO_ORIG_KERNEL, use=
rspace
> +programs should set it to FB_SPLASH_IO_ORIG_USER. This field is nece=
ssary to
> +avoid console semaphore deadlocks.

As I mentioned, this means there is thinko in your locking scheme.

> +data:=20
> +Pointer to a data structure appropriate for the performed ioctl. Typ=
e of
> +the data struct is specified in the ioctls description.

This is very wrong. Using ioctl() for anything is bad enough because it
contains an indirection from a system call. Here, you add yet another
indirection. Instead of this, you should at least have a single data
structure for each ioctl number, without using pointers to other struct=
ures.

 Arnd <><
