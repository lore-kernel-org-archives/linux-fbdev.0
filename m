From: Tony Lindgren <tony@atomide.com>
Date: Fri, 23 May 2014 14:45:34 +0000
Subject: Re: [PATCH v3 2/3] ARM: dts: oma3-gta04: Add display support
Message-Id: <20140523144533.GC2321@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1399580212-5183-1-git-send-email-marek@goldelico.com>
 <1399580212-5183-3-git-send-email-marek@goldelico.com>
 <537F04D7.4000201@ti.com>
In-Reply-To: <537F04D7.4000201@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140523 01:21]:
> On 08/05/14 23:16, Marek Belisko wrote:
> > This patch add support for lcd display on gta04 board. Display control
> > is connected to spi (used spi bitbang driver).
> > 
> > Signed-off-by: Marek Belisko <marek@goldelico.com>
> > ---
> >  arch/arm/boot/dts/omap3-gta04.dts | 87 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> 
> I can take this via my tree.
> 
> Tony, can I have your ack on this?

Yes for the whole series:

Acked-by: Tony Lindgren <tony@atomide.com>
