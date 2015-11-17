From: Mark Brown <broonie@kernel.org>
Date: Tue, 17 Nov 2015 10:37:08 +0000
Subject: Re: [PATCH] [media] move media platform data to linux/platform_data/media
Message-Id: <20151117103708.GL31303@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AQNmCumFClRcGgHG"
List-Id: <linux-fbdev.vger.kernel.org>
References: <4d99e49726942dc4d6a6ee1debf6665b2b47908b.1447751746.git.mchehab@osg.samsung.com>
In-Reply-To: <4d99e49726942dc4d6a6ee1debf6665b2b47908b.1447751746.git.mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
To: Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Acked-by: Arnd Bergmann" <arnd-r2nGTMty4D4@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stefan Schmidt <stefan-WB6LKoYH/xlAfugRpC6u6w@public.gmane.org>, Harald Welte <laforge-WB6LKoYH/xlAfugRpC6u6w@public.gmane.org>, Tomas Cech <sleep_walker-IBi9RG/b67k@public.gmane.org>, Sergey Lapin <slapin-9cOl001CZnBAfugRpC6u6w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj@>


--AQNmCumFClRcGgHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 17, 2015 at 07:15:59AM -0200, Mauro Carvalho Chehab wrote:
> Now that media has its own subdirectory inside platform_data,
> let's move the headers that are already there to such subdir.

Acked-by: Mark Brown <broonie@kernel.org>

--AQNmCumFClRcGgHG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWSwNTAAoJECTWi3JdVIfQ4KQH/jRi+u9vkGEn+1iMaGVdyCee
J9U0tvtwOAlMOWV4MZJ6mINHE6nw6FQwEly8DLanBOkj9MtPKoiHejzPT9KPG5zl
8895O9NAhgLh4DFi8rsoMsBx1lwK3YM0mXgdmRQxlkOkMcJd/7AsApobMen5IbwN
q/7pMetyDSg9nRAcUQgRu2uJJLJpWmkDP/LgRCfYQDJtqQPDE/x9mEf1fAZ1QJ44
gFxTJqlb6VUKa0K7puMfcNLmSaedJYx7DanpbiRGobzT+Zdi6dv+99nOcJsPqp3b
kRRC2FU6gIrzJIO7kyUssJSxzPehZGP/LP8SSU0lHL3BZ5+VIsNemzMAJv+hsiA=
=fW+n
-----END PGP SIGNATURE-----

--AQNmCumFClRcGgHG--
