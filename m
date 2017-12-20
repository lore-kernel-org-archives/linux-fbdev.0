From: Joe Perches <joe@perches.com>
Date: Wed, 20 Dec 2017 10:55:07 +0000
Subject: Re: [-next PATCH 2/4] treewide: Use DEVICE_ATTR_RW
Message-Id: <1513767307.1234.114.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1513706701.git.joe@perches.com>
 <cd38f14f06e1f447b3159ffe8c69c0df8241bb6e.1513706701.git.joe@perches.com>
 <20171220083403.GA27231@bitmer.com> <1513761884.1234.83.camel@perches.com>
 <20171220093211.GA16177@kroah.com> <1513763681.1234.101.camel@perches.com>
 <20171220095926.GA24285@kroah.com>
In-Reply-To: <20171220095926.GA24285@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
Cc: linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-s390@vger.kernel.org, linux-omap@vger.kernel.org, "James E.J.
 Bottomley" <jejb@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, James Smart <james.smart@broadcom.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dick Kennedy <dick.kennedy@broadcom.com>, Mathias Nyman <mathias.nyman@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Peter Oberparleiter <oberp>

On Wed, 2017-12-20 at 10:59 +0100, Greg Kroah-Hartman wrote:
> > > Why you didn't send that patch to the sysfs maintainer is a bit odd..=
.  :)
> >=20
> > So here's an opportunity for you:
> >=20
> > The sysfs maintainer hasn't added include/linux/sysfs.h to
> > the list of maintained files...
> >=20
> > DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS
> > M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core=
.git
> > S:	Supported
> > F:	Documentation/kobject.txt
> > F:	drivers/base/
> > F:	fs/debugfs/
> > F:	fs/sysfs/
> > F:	include/linux/debugfs.h
> > F:	include/linux/kobj*
> > F:	lib/kobj*
>=20
> Heh, good point, but using get_maintainer.pl does put me at the top of
> the list that you should be cc:ing:
>=20
> $ ./scripts/get_maintainer.pl --file include/linux/sysfs.h
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:3/3=100%,a=
uthored:2/3g%,added_lines:7/8=88%)
> Kate Stewart <kstewart@linuxfoundation.org> (commit_signer:1/33%)
> Thomas Gleixner <tglx@linutronix.de> (commit_signer:1/33%)
> Philippe Ombredanne <pombredanne@nexb.com> (commit_signer:1/33%)
> Nick Desaulniers <nick.desaulniers@gmail.com> (commit_signer:1/33%,author=
ed:1/33%,added_lines:1/8=12%,removed_lines:1/1=100%)
> linux-kernel@vger.kernel.org (open list)

The script I use to send patches adds --nogit --nogit-fallback
to copy only listed maintainers because people that send cleanup
patches don't generally like to get random patches.

> > btw: there are many uses of a reversed declaration style of DEVICE_ATTR
> >=20
> > Here's another thing that could be done for more DEVICE_ATTR_<FOO> uses.
> >=20
> > =3D> >=20
> > Some DEVICE_ATTR definitions use a reversed static function form from
> > the typical.  Convert them to use the more common macro form so it is
> > easier to grep for the style.
[]
> > $ git grep --name-only -w DEVICE_ATTR | \
> >   xargs perl -i dev_attr_rw_backwards.perl
> Ah, nice, I love perl :

That was a bad copy/paste of the script.

The actual script for RW is:

$ cat dev_attr_rw_backwards.perl
local $/;
while (<>) {
    my $file =3D $_;
    while ($file =3D~ m/\bDEVICE_ATTR\s*\(\s*(\w+)\s*,/g) {
	my $var =3D $1;
	if ($file =3D~ s/\bDEVICE_ATTR\s*\(\s*${var}\s*,\s*\(?(\s*S_IRUGO\s*\|\s*S=
_IWUSR|\s*S_IWUSR\s*\|\s*S_IRUGO\s*|\s*0644\s*)\)?\s*,\s*show_${var}\s*,\s*=
store_${var}\s*\)/DEVICE_ATTR_RW(${var})/g) {
	    $file =3D~ s/\bshow_${var}\b/${var}_show/g;
	    $file =3D~ s/\bstore_${var}\b/${var}_store/g;
	}
    }
    print $file;
}

There are 3 different perl scripts for rw, ro, and wo.
and these scripts, because of function renaming and
possible reuse of the original function names by other
string concatenated macros, create some bad conversions
so they need some manual cleanups too.

Perhaps coccinelle could do a better job of it, but
likely string concatenation macro uses are going to
be hard to deal with in any case.

