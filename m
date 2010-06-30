From: Tony Lindgren <tony@atomide.com>
Date: Wed, 30 Jun 2010 06:33:53 +0000
Subject: [PATCH] ARM: Disable VGA console for ARM in most cases (Re: [PATCH
Message-Id: <20100630063352.GR2822@atomide.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="S1BNGpv0yoYahz37"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100629113229.16008.2931.stgit@baageli.muru.com>
	<20100629114720.16008.84291.stgit@baageli.muru.com>
	<20100629120724.GA23884@oksana.dev.rtsoft.ru>
	<20100629142144.GN2822@atomide.com>
In-Reply-To: <20100629142144.GN2822@atomide.com>
To: linux-arm-kernel@lists.infradead.org


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100629 17:15]:
> * Anton Vorontsov <cbouatmailru@gmail.com> [100629 15:04]:
> > On Tue, Jun 29, 2010 at 02:47:20PM +0300, Tony Lindgren wrote:
> > > Otherwise we have to disable it manually to avoid compile errors.
> > > 
> > > Cc: linux-fbdev@vger.kernel.org
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > We'll need this for mach-cns3xxx too. And doing that change for
> > every ARM subarch is going to produce lots of rejects.
> > 
> > I'd suggest to disable (or make it 'default n') for all ARMs,
> > except these:
> > 
> > $ git grep VGA_CONSOLE= arch/arm/configs/
> > arch/arm/configs/footbridge_defconfig:CONFIG_VGA_CONSOLE=y
> > arch/arm/configs/integrator_defconfig:CONFIG_VGA_CONSOLE=y
> > arch/arm/configs/netwinder_defconfig:CONFIG_VGA_CONSOLE=y
> 
> Good idea, will post a modified patch tomorrow.

Here's this one updated.

Tony

--S1BNGpv0yoYahz37
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="kconfig-disable-vgacon.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 30 Jun 2010 09:08:23 +0300
Subject: [PATCH] ARM: Disable VGA console for ARM in most cases

Otherwise we have to disable it manually to avoid compile errors.

Now it's only enabled only for the selected machines as suggested
by Anton Vorontsov <cbouatmailru@gmail.com>:

$ git grep VGA_CONSOLE= arch/arm/configs/
arch/arm/configs/footbridge_defconfig:CONFIG_VGA_CONSOLE=y
arch/arm/configs/integrator_defconfig:CONFIG_VGA_CONSOLE=y
arch/arm/configs/netwinder_defconfig:CONFIG_VGA_CONSOLE=y

Note that the Kconfig entry no longer needs separate entries
for ARCH_ACORN, ARCH_EBSA110 ARCH_VERSATILE.

Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 8e8f18d..5a35f22 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -6,7 +6,7 @@ menu "Console display driver support"
 
 config VGA_CONSOLE
 	bool "VGA text console" if EMBEDDED || !X86
-	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !ARCH_VERSATILE && !SUPERH && !BLACKFIN && !AVR32 && !MN10300
+	depends on !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !SUPERH && !BLACKFIN && !AVR32 && !MN10300 && (!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER)
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a

--S1BNGpv0yoYahz37--
