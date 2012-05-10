From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 10 May 2012 00:16:38 +0000
Subject: Re: [PATCH] video: s3c-fb: s3c_fb_missing_pixclock() can't be __devinit
Message-Id: <20120510001638.GC13199@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="yEPQxsgoJgBvi8ip"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334486344-24073-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1334486344-24073-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-fbdev@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 10, 2012 at 12:10:13AM +0000, Florian Tobias Schandinat wrote:
> On 04/15/2012 10:39 AM, Mark Brown wrote:
> > Since s3c_fb_missing_pixclock() is called from s3c_fb_set_rgb_timing()
> > which is used in the suspend/resume paths it can't be marked __devinit
> > as this could result in it being discarded after boot.

> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> I'm not sure that this can actually happen. But the code looks saner
> with the patch applied so I applied it.

Thanks.  To trigger you'd need to disable CONFIG_HOTPLUG and modules
(possibly some other stuff too) but the main motiviation is that the
build system complains loudly about section mismatches.

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqwjfAAoJEBus8iNuMP3dFPYP/0aUosevNOLEnioQQw1X8GRO
1Qt7di/I/4Y3pYSIotJTkRT4ydw34zT+Ghp1ODoyZavx7/a0LOjl79sOtWmuM9N5
DCbiYIQ5aREmP//Z+Ke9g3ioQVF7K3MVO1VYDisALdg7JPpPiBTeoWIEBlXI7ZK6
vK8uPTDswxeVVMTuD3Rms4QcxWd2xI6LJokeHSzBXqIPzMhzK0XIZgq6WTA5PaOa
pX4bXvL2n9YsUk43PaVv3Z773M8U67oasJ9oE8jeyI/g7G7bbZO/d7mqrolwTsW/
zk6y0FeoXCp1t87OPg1BklFP/8OwxzP5N30pS3/DOQ9ogalK+YjJA30Cd66+u6el
2ih9XOlxkTZIQq2lg+JDR1/ArcbMxWFPrQRjxSYO4JeeYkpXtsyPi1s6IcLBCu66
IwqhISKBbZIhb9yG58VHHjloxIq6wKWLT09V9OinSc/7NxXOcubv7mkaGfUjOFBf
EAwrLti4CXmqygblItbkSTuySuGT/maYUjHcPbKo2963kZOMI6l/PERJTtkD8zUz
hsu041rQM33CIYTjw9GOhqCVkVVRZIK118HQhTc1I+G2br2v0d5OYTz31XVrwo3x
pkBqG47V9aVRFmJD3lDIX6CGR78yrSbWOGWKj3jkd3uUBkYawHboemiGpj+XUyLR
Jc2MKQ913Zs0eBcHJ0ry
=K/iF
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
