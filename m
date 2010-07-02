From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 02 Jul 2010 11:52:05 +0000
Subject: Re: [PATCH v3 05/12] s3c-fb: Add support for display panning
Message-Id: <20100702115205.GB30655@sirena.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
	<1277712538-23188-6-git-send-email-p.osciak@samsung.com>
	<4C288779.8040702@gmail.com> <4C2DCCAD.9080306@simtec.co.uk>
In-Reply-To: <4C2DCCAD.9080306@simtec.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jul 02, 2010 at 12:25:33PM +0100, Ben Dooks wrote:
> On 28/06/10 12:28, Maurus Cuelenaere wrote:

> > No need for the '? 1 : 0'

> I tihnk there is, IIRC there is no neccessity for a compiler to produce
> one for true, just that the result be !0

The compiler will *produce* 1 for true, but it will accept any non-zero
value as true.
