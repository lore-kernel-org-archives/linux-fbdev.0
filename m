From: Felipe Balbi <balbi@ti.com>
Date: Tue, 17 Sep 2013 15:41:07 +0000
Subject: Re: [PATCH v11 0/8] PHY framework
Message-Id: <20130917154107.GH15645@radagast>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="YPJ8CVbwFUtL7OFW"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1377063973-22044-1-git-send-email-kishon@ti.com>
 <521B0E79.6060506@ti.com> <20130827192059.GZ3005@radagast>
 <5225FF63.6080608@ti.com> <20130903155030.GA21525@kroah.com>
 <5226F5E2.5010409@ti.com>
In-Reply-To: <5226F5E2.5010409@ti.com>
To: linux-arm-kernel@lists.infradead.org

--YPJ8CVbwFUtL7OFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2013 at 02:27:06PM +0530, Kishon Vijay Abraham I wrote:
> On Tuesday 03 September 2013 09:20 PM, Greg KH wrote:
> > On Tue, Sep 03, 2013 at 08:55:23PM +0530, Kishon Vijay Abraham I wrote:
> >> Hi Greg,
> >>
> >> On Wednesday 28 August 2013 12:50 AM, Felipe Balbi wrote:
> >>> Hi,
> >>>
> >>> On Mon, Aug 26, 2013 at 01:44:49PM +0530, Kishon Vijay Abraham I wrot=
e:
> >>>> On Wednesday 21 August 2013 11:16 AM, Kishon Vijay Abraham I wrote:
> >>>>> Added a generic PHY framework that provides a set of APIs for the P=
HY drivers
> >>>>> to create/destroy a PHY and APIs for the PHY users to obtain a refe=
rence to
> >>>>> the PHY with or without using phandle.
> >>>>>
> >>>>> This framework will be of use only to devices that uses external PH=
Y (PHY
> >>>>> functionality is not embedded within the controller).
> >>>>>
> >>>>> The intention of creating this framework is to bring the phy driver=
s spread
> >>>>> all over the Linux kernel to drivers/phy to increase code re-use an=
d to
> >>>>> increase code maintainability.
> >>>>>
> >>>>> Comments to make PHY as bus wasn't done because PHY devices can be =
part of
> >>>>> other bus and making a same device attached to multiple bus leads t=
o bad
> >>>>> design.
> >>>>>
> >>>>> If the PHY driver has to send notification on connect/disconnect, t=
he PHY
> >>>>> driver should make use of the extcon framework. Using this susbsyst=
em
> >>>>> to use extcon framwork will have to be analysed.
> >>>>>
> >>>>> You can find this patch series @
> >>>>> git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git =
testing
> >>>>
> >>>> Looks like there are not further comments on this series. Can you ta=
ke this in
> >>>> your misc tree?
> >>>
> >>> Do you want me to queue these for you ? There are quite a few users f=
or
> >>> this framework already and I know of at least 2 others which will show
> >>> up for v3.13.
> >>
> >> Can you queue this patch series? There are quite a few users already f=
or this
> >> framework.
> >=20
> > It will have to wait for 3.13 as the merge window for new features has
> > been closed for a week or so.  Sorry, I'll queue this up after 3.12-rc1
> > is out.
>=20
> Alright, thanks.

Just a gentle ping on this one...

cheers

--=20
balbi

--YPJ8CVbwFUtL7OFW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSOHgTAAoJEIaOsuA1yqREH7QP/RrRhj27omVfupAPeHzOVlYD
HtXIlK9wsVeD36xJP+ZjCgLWCuzLCz2lR0rXYjJDwcTw6+RiJHxVUrhdrO8dIeXT
jvGjSmz+QtV7dSrN7vQtsNRUdYxOgvV9IOtnKRz1EgepcvDcrri16y9xz0hxH8b+
jS1fp7shRuF5vz+/mk1hryyKmhMH34T8HK2uEz/XTQuw58V8CNP0dxNPXXeprIXv
IGCubSvWr2igiQBmRpsKiyczoH1YgovXE3mY4VcrTLuu/M8PwcpCtddrJUP4j8vI
jAyU2NZ3B4IsjcbQzA56R72FcXfk00D90oyg3KF1CM7ABcH9jFBkYNLNXVV87v9P
BeZOEiGoSCZvPOyPqQ2i0sOMTrFLsqDZOSv5dIL+Ai9VT80qo1aZHz21QWJ9J522
S/ez8SbWeuEBcqE6gqyA0CgwwubSWQEqUZYFi2ryXGBMi09JE10SOBdlhWcXMXQp
WXMBAK/J2cFsn9iWEXgAr1tF4NdQlZyqvZ4cgppbKsy+ImpfMUXgME948Yp49fnn
EoRXpb6BgS6cZUeazoaVWSC38lDdVdYOIvERcWLu3oxUwOE3ykQq0E6IeKjxXnHW
21S1vvGfwFN2ODw1nYUW10UFGuFz16OfHZJ5T1Uehl1zks6UFOWcA0kdsKjheOlZ
iWGOFMZF6lEMV8/o+A+h
=1Rub
-----END PGP SIGNATURE-----

--YPJ8CVbwFUtL7OFW--
