From: Mark Brown <broonie@kernel.org>
Date: Thu, 25 Jul 2013 12:09:04 +0000
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Message-Id: <20130725120904.GB9858@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wg2zgDM1gLxA7pbN"
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.44L0.1307231708020.1304-100000@iolanthe.rowland.org>
 <201307242032.03597.arnd@arndb.de> <2174304.5JlzJ583hP@avalon>
 <201307251300.49282.arnd@arndb.de>
In-Reply-To: <201307251300.49282.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org


--wg2zgDM1gLxA7pbN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2013 at 01:00:49PM +0200, Arnd Bergmann wrote:

> I'm not saying that we can't support legacy board files with the common
> PHY framework, but I'd expect things to be much easier if we focus on those
> platforms that are actively being worked on for now, to bring an end to the
> pointless API discussion.

Well, it seemed like Greg's concerns had already been addressed anyway.

--wg2zgDM1gLxA7pbN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8RVcAAoJELSic+t+oim9YuEP/1JH37qhhixNi8JrjQfegt/8
CHa1paebHzFPGbKxxpSBJPna5OSGkSgiS+E2U+s4aP9kqkYzD3cX04ptz6v3DTTN
5lvt1LsAVFmneFJfB4jdCjazUPEnm2kRgk6xKoBVpdswJctx9xc5pVR2OmI8BwdW
l+7AQhCq347aGKSP4Ep/7YOUg6tD0/6zvzCmet360ai6lPAT/yhZj0dYD7Qii7Gk
uKM3cQb1PwrJk/xBcR70vEB6XMLzkzhm0yRtVk1DBziNcXdnS+N4ZyCA8Vre82ev
t/02/Bi1CCGwifKCDa/1RWb6zjYPyyixX5gBx+zxDChtiCcxwg5vJFfT+7uwiLFk
jstL8OGkt7lk2jGAOcCrszLisnPqJ2siXnGJaI/4AvVXYcd7Q+9nOggg4C8Re5E/
efnkS850CgWTgyrpun2ZyCuhoQhkbqNNB8CHw6volpjAS0i5Q0wat0FmPdBQZg9r
Fo5iLQ0i0OxKdmVO/Z5EwOeUoWjMh9lzT9q6q1zWoS233igUr5Xf9qS1svmmz1jX
TcRTGERIM12JlHUr8efalQZMOHhKT/NGWPskqV7g35n4/mVPu0DrsyzQl1DrJ470
DUMlwn+AgaU3X6ttEeTbcBJLNvrkLNI/5OvwUljDN39X2wzp888H3HD8/JpqugKI
ldM0KNy4SyQ+fIArDPob
=fqdw
-----END PGP SIGNATURE-----

--wg2zgDM1gLxA7pbN--
