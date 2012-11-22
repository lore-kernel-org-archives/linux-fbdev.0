From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Thu, 22 Nov 2012 21:40:21 +0000
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Message-Id: <20121122214021.GA14771@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
 <20121120215429.B621F3E1821@localhost>
 <13540495.epaCf4JVn9@percival>
 <20121122133941.24B883E129E@localhost>
In-Reply-To: <20121122133941.24B883E129E@localhost>
To: linux-arm-kernel@lists.infradead.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 22, 2012 at 01:39:41PM +0000, Grant Likely wrote:
[...]
> I do think that each sequence should be contained within a single
> property, but I'm open to other suggestions.

IIRC a very early prototype did implement something like that. However
because of the resource issues this had to be string based, so that the
sequences looked somewhat like (Alex, correct me if I'm wrong):

	power-on = <"REGULATOR", "power", 1, "GPIO", "enable", 1>;

Instead we could possibly have something like:

	power-on = <0 &reg 1,
		    1 &gpio 42 0 1>;

Where the first cell in each entry defines the type (0 = regulator, 1 =
GPIO) and the rest would be a regular OF specifier for the given type of
resource along with some defined parameter such as enable/disable,
voltage, delay in ms, ... I don't know if that sounds any better. It
looks sort of cryptic but it is more "in the spirit of" DT, right Grant?

Writing this down, it seems to me like even that proposal was already
discussed at some point. Again, Alex may remember better.

Thierry

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQrpvFAAoJEN0jrNd/PrOhhywP/AiT0Ylywbi9V9FNnZ6zwngi
WtclXo/ALSEifXqZxDDw4wxS3rhQpSN34+l75lu5mbYP2FDgglRuKBrdXDGZuy7M
fcQKA5SDJAypajIijGWSWLzHZCnKVXonfHOUKeVmfq+Oo7LXUSYKYT4W3yYV9LcK
xJLtxJKJDNpIuxhcI0FaUewXRYjzhB/IFAf1IUWhV3YZ6ZfbR5PXwx/Jg6qvo5Ns
Z8PDMyth0YY0LWMIJBMpvZZk1xlL3yw8imwNLw+P1seICh0mq8QATXf5zM07DXa1
Lf8JWn/d8ueto4jCm0gavWLjexpN9baC2PUNkS313hRhbWGcnI+c95bMlpUx8QjI
PN3WUXF2vPcfrrsgIZrFjr5PrEIS4vQfC9LfrCg44UxM0IlvCRVEiFhEgbyTEeW5
qiuBaDnUMY6l39pZx7EG/hOU207u9ZaSM+w66COb630WzzpKnJd2ZTsf1H4dZ7w3
Oyozguikk5Ohw2olOKsNkIncvRZEYa6GYpKIIDhmW3GoNE+/rC/dVSXM2CDBlQWJ
A/QLnww1K0sKc0VN+m83JK/R7EvslAAv4gKVJ5U3AQbZm02k7bzUqFMw6ZHlNEw7
CeHgOX35dN+SQHtaVwC5G27hNpBoKSjubd3xzrS+F+65Rdt97If0Q7FgmU1o+b/u
zQV/10Xw4kMSFyk8raC3
=8uOp
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
