From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 10 Apr 2017 10:55:47 +0000
Subject: Re: [PATCH v4 2/2] crypto: hw_random - Add new Exynos RNG driver
Message-Id: <20170410105547.GA8615@gondor.apana.org.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170408133245.30147-1-krzk@kernel.org>
 <20170408133245.30147-3-krzk@kernel.org>
In-Reply-To: <20170408133245.30147-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: James Hogan <james.hogan@imgtec.com>, Matt Mackall <mpm@selenic.com>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, "David S. Miller" <davem@davemloft.net>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Bernie Thompson <bernie@plugable.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>, linux-kernel@vger.kernel.org, linux-metag@vger.kernel.org, linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>

On Sat, Apr 08, 2017 at 03:32:45PM +0200, Krzysztof Kozlowski wrote:
>
> +static struct rng_alg exynos_rng_alg = {
> +	.generate		= exynos_rng_generate,
> +	.seed			= exynos_rng_seed,
> +	.seedsize		= EXYNOS_RNG_SEED_SIZE,
> +	.base			= {
> +		.cra_name		= "exynos_rng",

Please use stdrng.  Or is there a reason why this can't be used
by the crypto layer itself?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
