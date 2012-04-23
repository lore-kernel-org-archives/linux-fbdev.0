From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 23 Apr 2012 07:50:10 +0000
Subject: Re: [PATCH V3 3/3] OMAPDSS: DISPC: Correct DISPC functional clock usage
Message-Id: <1335167410.30659.0.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-s3XjJKydvsdSXcHHT1z0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1333379598-11544-4-git-send-email-cmahapatra@ti.com>
	 <1335163610-19737-1-git-send-email-cmahapatra@ti.com>
In-Reply-To: <1335163610-19737-1-git-send-email-cmahapatra@ti.com>
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-s3XjJKydvsdSXcHHT1z0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-04-23 at 12:16 +0530, Chandrabhanu Mahapatra wrote:
> DISPC_FCLK is incorrectly used as functional clock of DISPC in scaling
> calculations. So, DISPC_CORE_CLK replaces as functional clock of DISPC.
> DISPC_CORE_CLK is derived from DISPC_FCLK divided by an independent DISPC
> divisor LCD.

Thanks, I've applied the series to "dev" branch.

 Tomi


--=-s3XjJKydvsdSXcHHT1z0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPlQmuAAoJEPo9qoy8lh71gm0P/RYqdvflGAT1M8MCev2NruL4
yMnVyrwn3yTO1gdiMdJrTNMJGVGVmBbecRdr0gpzExayHiJ1o8tiKHC7Nj8QBXns
Bff/SHhdQiDKaLOnwafEt4RTXM0HNUZo3yz3mFwYggKEt4yJlwASmxqMj+65z/eE
FLucwZ9ITmywIRHOSko6NoS/N7SgWPKBpFZAhL00DITf7aDRofCRs8EEm9gc6sti
p+kE43B/kWVDh1hLFapuNJQ2UpKnkmgtrw7g1sCQuqiE8AdZTvifq8Ea59/4Vt3u
pyG20uGOFGeCd4L2U2QTyEA2cagDeKj2aPE7w5iJKl8B+NAM+Hqypec5XnbFI7RS
KGnwEFHir0isboMVuwnaEwyLhdzpi2mHL2OXL8K4GIRtY/vYJG0rVHu5NBEOHzUd
metBeznUXidOzxc+FsmpSOKN2tb5coH6F3YZp46BhRz3Zq4Sv2Uv0x5ezVEE8cgf
U203qIABOmukR+e1sRPTiLokJblZBqGPGW35Pq8D+f1D0lqjpVikbtPjOGB3n1Dw
ji9M6PGMcvDkcx7u249UrN6ICbT7TQ2RvsDzgRwgshqsm5XTHM1QOoQ8jotj844o
RfzjVQy7orYkaBeMorXQhsknZxfUVQV4HscD1QqcZ3DHFkHe3AVrwrHsCy82qbFG
iqyBTRoj5Rm4gemgBnL+
=x3N5
-----END PGP SIGNATURE-----

--=-s3XjJKydvsdSXcHHT1z0--

