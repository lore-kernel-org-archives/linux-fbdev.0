From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 17 Nov 2015 10:58:52 +0000
Subject: Re: [PATCH] [media] move media platform data to linux/platform_data/media
Message-Id: <17824361.38HLxMaChG@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4d99e49726942dc4d6a6ee1debf6665b2b47908b.1447751746.git.mchehab@osg.samsung.com>
 <7319142.Cp8MurgLWk@wuerfel> <564B04CF.1090507@gmail.com>
In-Reply-To: <564B04CF.1090507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sergey Lapin <slapin@ossfans.org>, Timur Tabi <timur@tabi.org>, Jaroslav Kysela <perex@perex.cz>, Tomas Cech <sleep_walker@suse.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Markus Elfring <elfring@users.sourceforge.net>, Harald Welte <laforge@openezx.org>, openezx-devel@lists.openezx.org, Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Daniel Ribeiro <drwyrm@gmail.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, Philipp Zabel <p.zabel@pengutronix.de>, alsa-devel@alsa-project.org

On Tuesday 17 November 2015 11:43:27 Anton Bondarenko wrote:
> On 17.11.2015 10:23, Arnd Bergmann wrote:
> > On Tuesday 17 November 2015 07:15:59 Mauro Carvalho Chehab wrote:
> >> Now that media has its own subdirectory inside platform_data,
> >> let's move the headers that are already there to such subdir.
> >>
> >>
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Why does dma-imx.h also moved? It's the generic file, not a media specific.

You are right, I missed that when I looked at the patch. That part
of the patch needs to be taken out.

	Arnd
