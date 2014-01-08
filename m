From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 08 Jan 2014 13:48:28 +0000
Subject: Re: [PATCH] video: vgacon: Don't build on arm64
Message-Id: <14702006.daUmPS66ac@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387323421-26126-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1387323421-26126-1-git-send-email-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wednesday 08 January 2014 15:43:20 Tomi Valkeinen wrote:
> On 2013-12-18 01:37, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>
> > 
> > arm64 is unlikely to have a VGA console and does not export screen_info
> > causing build failures if the driver is build, for example in all*config.
> > Add a dependency on !ARM64 to prevent this.
> > 
> > This list is getting quite long, it may be easier to depend on a symbol
> > which architectures that do support the driver can select.
> 
> I agree, that depends on looks horrible =).

I've suggested creating a "CONFIG_PC_IO" symbol before that could used
to simplify this one and a couple of other similar Kconfig statements.
It is unfortunately a bit tricky because out of the dozen drivers that
are similar to this one, each one has a slightly different list of
architectures, and it's not clear which of the differences are intentional
rather than mistakes.

	Arnd
