From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 20 Dec 2017 09:59:26 +0000
Subject: Re: [-next PATCH 2/4] treewide: Use DEVICE_ATTR_RW
Message-Id: <20171220095926.GA24285@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1513706701.git.joe@perches.com>
 <cd38f14f06e1f447b3159ffe8c69c0df8241bb6e.1513706701.git.joe@perches.com>
 <20171220083403.GA27231@bitmer.com>
 <1513761884.1234.83.camel@perches.com>
 <20171220093211.GA16177@kroah.com>
 <1513763681.1234.101.camel@perches.com>
In-Reply-To: <1513763681.1234.101.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Joe Perches <joe@perches.com>
Cc: linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-s390@vger.kernel.org, linux-omap@vger.kernel.org, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, James Smart <james.smart@broadcom.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dick Kennedy <dick.kennedy@broadcom.com>, Mathias Nyman <mathias.nyman@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, intel-gfx@lists.freedesktop

On Wed, Dec 20, 2017 at 01:54:41AM -0800, Joe Perches wrote:
> On Wed, 2017-12-20 at 10:32 +0100, Greg Kroah-Hartman wrote:
> > On Wed, Dec 20, 2017 at 01:24:44AM -0800, Joe Perches wrote:
> > > On Wed, 2017-12-20 at 10:34 +0200, Jarkko Nikula wrote:
> > > > On Tue, Dec 19, 2017 at 10:15:07AM -0800, Joe Perches wrote:
> > > > > Convert DEVICE_ATTR uses to DEVICE_ATTR_RW where possible.
> > >=20
> > > []=20
> > > > > diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
> > >=20
> > > []
> > > > > @@ -854,7 +854,7 @@ static ssize_t dma_op_mode_store(struct devic=
e *dev,
> > > > >  	return size;
> > > > >  }
> > > > > =20
> > > > > -static DEVICE_ATTR(dma_op_mode, 0644, dma_op_mode_show, dma_op_m=
ode_store);
> > > > > +static DEVICE_ATTR_RW(dma_op_mode);
> > > > > =20
> > > >=20
> > > > While I can ack this part here if it helps generic cleanup effort I
> > > > don't understart would it improve code readability in general? Mode=
 644
> > > > is clear and don't need any grepping but for DEVICE_ATTR_RW() I had=
 to go
> > > > through all of these files in order to see what does it mean:
> >=20
> > Yeah, 644 is "clear", but _RW() is even more clear.  Ideally I want to
> > get rid of all of the "non-standard" users that set random modes of
> > sysfs files, as we get it wrong too many times.  Using the "defaults" is
> > much better.
> >=20
> > > Are you suggesting that device.h (as that is where
> > > DEVICE_ATTR and the other DEVICE_ATTR_<FOO> variants
> > > are #defined) should have better comments for the
> > > _<FOO> variants?
> > >=20
> > > > DEVICE_ATTR_RW: include/linux/device.h
> > > > __ATTR_RW: include/linux/sysfs.h
> > > > S_IWUSR: include/uapi/linux/stat.h
> > > > S_IRUGO: include/linux/stat.h
> > >=20
> > > btw: patch 1/4 of the series does remove the uses of
> > > S_<PERMS> from these macros in sysfs.h and converts
> > > them to simple octal instead.
> >=20
> > Why you didn't send that patch to the sysfs maintainer is a bit odd... =
 :)
>=20
> So here's an opportunity for you:
>=20
> The sysfs maintainer hasn't added include/linux/sysfs.h to
> the list of maintained files...
>=20
> DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS
> M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.g=
it
> S:	Supported
> F:	Documentation/kobject.txt
> F:	drivers/base/
> F:	fs/debugfs/
> F:	fs/sysfs/
> F:	include/linux/debugfs.h
> F:	include/linux/kobj*
> F:	lib/kobj*

Heh, good point, but using get_maintainer.pl does put me at the top of
the list that you should be cc:ing:

$ ./scripts/get_maintainer.pl --file include/linux/sysfs.h
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:3/3=100%,aut=
hored:2/3g%,added_lines:7/8=88%)
Kate Stewart <kstewart@linuxfoundation.org> (commit_signer:1/33%)
Thomas Gleixner <tglx@linutronix.de> (commit_signer:1/33%)
Philippe Ombredanne <pombredanne@nexb.com> (commit_signer:1/33%)
Nick Desaulniers <nick.desaulniers@gmail.com> (commit_signer:1/33%,authored=
:1/33%,added_lines:1/8=12%,removed_lines:1/1=100%)
linux-kernel@vger.kernel.org (open list)

Anyway, I'll go add sysfs.h to the list, thanks for pointing it out.

> > I should be taking this whole series through my tree.  Joe, thanks for
> > doing this in an automated way, I've been wanting to see this done for a
> > long time.
>=20
> btw: there are many uses of a reversed declaration style of DEVICE_ATTR
>=20
> Here's another thing that could be done for more DEVICE_ATTR_<FOO> uses.
>=20
> =3D>=20
> Some DEVICE_ATTR definitions use a reversed static function form from
> the typical.  Convert them to use the more common macro form so it is
> easier to grep for the style.
>=20
> i.e.:
>         static ssize_t show_<foo>(...)
> and
>         static ssize_t store_<foo>(...)
>=20
> where the static function names in the DEVICE_ATTR_RW macro are reversed
>=20
>         static ssize_t <foo>_show(...)
> and
>         static ssize_t <foo>_store(...)
>=20
> Done with perl script
>=20
> $ cat dev_attr_rw_backwards.perl
> local $/;
> while (<>) {
>     my $file =3D $_;
>     while ($file =3D~ m/\bDEVICE_ATTR\s*\(\s*(\w+)\s*,/g) {
>         my $var =3D $1;
>         if ($file =3D~ s/\bDEVICE_ATTR\s*\(\s*${var}\s*,\s*\(?(\s*S_IRUGO=
\s*\|\s*S
>             $file =3D~ s/\bshow_${var}\b/${var}_show/g;
>             $file =3D~ s/\bstore_${var}\b/${var}_store/g;
>         }
>     }
>     print $file;
> }
>=20
> $ git grep --name-only -w DEVICE_ATTR | \
>   xargs perl -i dev_attr_rw_backwards.perl
>=20

Ah, nice, I love perl :)

greg k-h
