From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 26 Aug 2014 07:52:49 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826075247.GC17263@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Clx92ZfkiYIKRjnr"
List-Id: <linux-fbdev.vger.kernel.org>
References: <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825150900.GB21020@skynet.be>
In-Reply-To: <20140825150900.GB21020@skynet.be>
To: linux-arm-kernel@lists.infradead.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 05:09:00PM +0200, Luc Verhaegen wrote:
> On Mon, Aug 25, 2014 at 05:05:04PM +0200, Thierry Reding wrote:
> >=20
> > No. simplefb just wants to write to some memory that hardware has been
> > set up to scan out. The platform requires that the clocks be on.
>=20
> Simplefb also requires that the memory is there and is persistent. Fine=
=20
> for discrete graphics cards, fine for rpi where most things are hidden=20
> from the ARM core anyway, not so fine for anybody else.

I don't understand. This patch series isn't changing anything about the
memory aspects of the driver yet it's working for you on sunxi, isn't
it? So it can't be all that broken.

Thierry

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/DzPAAoJEN0jrNd/PrOhlL4QAJ/h2zWpl+YmZ8g7VPZe7fBD
OY0ZRMx47lUFuizTOJ3b1WArFfLYON//LHd9P1IfDnaXG0wAGT0Ml6UuEGHrepoJ
y6lf2l3JxnrNV860Z8G0rop7h+lsfd8hsBMFcsGjT9pYeuzV7oQAFQTGCqJwjryp
wsxcti8PZOVTt75yl5zrYcQz5B6qYFAPH+lTh4jZbNzpXhjWeuaZggGNfsIr3KEC
Rjzui43Pxzf90A2DCIaGXxjgtKdFOMRY5Rx3LXJBXNJ/44hf0kbq+JPwUG4/MfGO
ClvVeybWesWhEtKIr3ZUujRRDBy69Ca5T4VP4hGhXcXYm+4/hI/ndqUrPqh0XH2A
HF8QeJGlSTUXFX4VaNjjsF4VZzhehuDLu5WKMxsvn7ijF2fojBkI78HhMX43haK9
+l9y6Wgj+8wROecnRSyKYzLQVVDSOUzg9I2IJ35hz9OU2e2X2BW3fmc97XHseFyw
yMrFvRfJNtFyrc8R2321Zjljmb1A6Oy+zdcgoQx0OJkCtb8OdJsESRrT4VK94TIZ
J0Kvg6jH4qW6InmQWwy142Kjbkq6fpMv0LftsaIt+697Iq950ChcHw+yOtmnpZfy
hXlYMoMJIdw04BfcRowNoJnYIOCkbNSv2/kIcgU44o7YpxdYQJic3IkRFju4u5Op
l5mxwjB9ZeQqTbnQhdo2
=stZD
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
