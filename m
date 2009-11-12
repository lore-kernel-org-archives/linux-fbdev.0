From: Randy Dunlap <rdunlap@xenotime.net>
Date: Thu, 12 Nov 2009 18:22:24 +0000
Subject: Re: [PATCH 0/8] enable pxa168 LCD on two platform
Message-Id: <20091112102224.c053cffe.rdunlap@xenotime.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100011x60a354b0mf2e27e1c5fd0422@mail.gmail.com>
	<20091111155058.4f8d355e.akpm@linux-foundation.org>
	<4AFB4EA4.3060608@xenotime.net>
	<10f740e80911112347o45ddc2ck1515220914b4c38f@mail.gmail.com>
	<20091112084658.3ca67cb2.rdunlap@xenotime.net>
	<10f740e80911120851i2105393bkc0723e8ef05ff1b4@mail.gmail.com>
In-Reply-To: <10f740e80911120851i2105393bkc0723e8ef05ff1b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, 12 Nov 2009 17:51:41 +0100 Geert Uytterhoeven wrote:

> On Thu, Nov 12, 2009 at 17:46, Randy Dunlap <rdunlap@xenotime.net> wrote:
> > On Thu, 12 Nov 2009 08:47:49 +0100 Geert Uytterhoeven wrote:
> >> On Thu, Nov 12, 2009 at 00:54, Randy Dunlap <rdunlap@xenotime.net> wro=
te:
> >> > Andrew Morton wrote:
> >> >> On Tue, 10 Nov 2009 16:11:56 +0800
> >> >> Jun Nie <niej0001@gmail.com> wrote:
> >> >>
> >> >>> To: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.=
org
> >> >>
> >> >> I don't think linux-fbdev@vger.kernel.org exists? =A0You wanted
> >> >> linux-fbdev-devel@lists.sourceforge.net ?
> >> >
> >> > actually it does exist, but it's not used AFAIK.
> >> > http://vger.kernel.org/vger-lists.html#linux-fbdev
> >> >
> >> > The sourceforge list is the one listed in the MAINTAINERS file.
> >>
> >> Sending a patch to change that is on my (long) TODO list...
> >
> > That patch is the easy part.
> >
> > We also need to have the new list archived and somehow do away
> > with the old mailing list.
>=20
> MARC started archiving it a few days ago, so the major hurdle is gone.
>=20
> Still to do:
>   - Send submissions predating the archiving to MARC,
>   - Add MARC archive to vger list webpage,

1 & 3 are certainly more work.  for 2, just send the request to
postmaster@vger.kernel.org to have this archive:

http://marc.info/?l=3Dlinux-fbdev

added to http://vger.kernel.org/vger-lists.html#linux-fbdev

But you probably know that, so I'm just educating other people.  :)



>   - Disable posting on the old lists.


---
~Randy
