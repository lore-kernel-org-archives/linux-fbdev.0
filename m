From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [announce 7/7] fbsplash - documentation
Date: Wed, 9 Mar 2005 16:40:09 +0100
Message-ID: <200503091640.10421.arnd@arndb.de>
References: <20050308021706.GH26249@spock.one.pl> <200503090117.12755.arnd@arndb.de> <20050309020527.GA20294@spock.one.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20050309020527.GA20294@spock.one.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Michal Januszewski <spock@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Middeweken 09 M=C3=A4rz 2005 03:05, Michal Januszewski wrote:
> On Wed, Mar 09, 2005 at 01:17:11AM +0100, Arnd Bergmann wrote:
> change_console()
> complete_change_console()
> switch_screen() =3D=3D redraw_screen()
> con_switch() =3D=3D fbcon_switch()
>=20
> From inside fbcon_switch(), we need to call the splash helper to get =
a
> new picture for the theme 'bar' which is used on tty2. The splash hel=
per
> does an ioctl and we're back in the kernel.. with the console semapho=
re
> already held.

Ok, I now saw that you call call_usermodehelper with wait=3D=3D1. Why i=
s that
necessary? If you don't wait there, you don't need any hacks around the
console semaphore, because the helper will simply wait for change_conso=
le
to finish.
=20
> What are the alternatives to the ioctl? A relatively clean way of
> feeding the data back to the kernel would be using sysfs. However, to
> make it sane we would have to export the various components of struct
> vc_splash in /sys/class/tty/tty<x> (otherwise, we would probabky have
> to pass aggreaget data types through a sysfs entry -- something that =
is
> IMO much worse than an ioctl). That however could be a little
> problematic -- tty_class is currently defined as a class_simple.
> To add entries other than the standard 'dev' we would have to define =
a
> completely new class, right? That sounds like a rather intrusive
> change..

Right. I don't think that sysfs is the right interface for this problem=
=2E
=46or a short moment I had the idea that you could write an escape sequ=
ence
to the tty device, but that would race against the regular output.
An ioctl on the tty device is probably the best you can do here, but
if that's not possible, creating a misc device in order to do ioctl on =
it
is a rather ugly hack.

 Arnd <><
