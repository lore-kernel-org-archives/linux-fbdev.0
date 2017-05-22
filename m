From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 May 2017 09:52:43 +0000
Subject: Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
Message-Id: <20170522095243.ff5uygzzrvo57jkd@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tvcs7s5pzwvwzc4b"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
In-Reply-To: <20170521220212.1404-4-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung>


--tvcs7s5pzwvwzc4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 22, 2017 at 12:02:10AM +0200, Wolfram Sang wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.

Acked-by: Mark Brown <broonie@kernel.org>

I'm missing the rest of the series and/or the cover letter...

--tvcs7s5pzwvwzc4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkitOoACgkQJNaLcl1U
h9DNBQf/W6MueE4T2MQLhzjv1GsoGBNNokoFrcJbPchpAPhw/DczZsF29IdybRFZ
VacP62GRSx1hZcxR8/ydv0S6rRUXv9jTVnL04MI6lRCMEI+PisoVGYTW+M3TmvUF
hfX/HTza1pis1bd5u5qpRJcV2MSK+cJ/tAHKgTIaZvt5u3LeF7JodmA1zYq03M8n
xdpgRf00NHikCcSgfyuf1chUpvBz4/HBA3QCNC3UpTieY16B67ZQAr17TZLuUD1G
eT9Jgt2hQHnRwzUQ6IlnO58hyFI4Q3DHJGgPCWqEp4FKTZjx1HSdXKjbDIZJeBR5
SJ58jl2BjAjeGhP2am4Xcd+Vfqr1IQ==
=pkjm
-----END PGP SIGNATURE-----

--tvcs7s5pzwvwzc4b--
