From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 Nov 2010 16:16:44 +0000
Subject: Re: [PATCH 01/10] MCDE: Add hardware abstraction layer
Message-Id: <201011161716.44542.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289390653-6111-1-git-send-email-jimmy.rubin@stericsson.com>
	<F45880696056844FA6A73F415B568C6953604E7D94@EXDCVYMBSTM006.EQ1STM.local>
	<201011161712.31703.arnd@arndb.de>
In-Reply-To: <201011161712.31703.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

sent out too early...

On Tuesday 16 November 2010, Arnd Bergmann wrote:
> > > This looks a bit like you actually have multiple interrupt lines
> > > multiplexed
> > > through a private interrupt controller. Have you considered making this
> > > controller
> > > a separate device to multiplex the interrupt numbers?
> > 
> > MCDE contains several pipelines, each of them can generate interrupts.
> > Since each interrupt comes from the same device there is no need for
> > separate devices for interrupt controller.
> 
> Right, so this one and the one above is really a question of how to describe
> a pipeline:
 
It may be good to have a source file that only deals with the pipelines
and all that they have in common. If you use the same basic pipeline
logic for doing multiple different things, this can be used to structure
the code more logically. Not sure if this is worth trying, since it might
not actually gain all that much in the end

	Arnd
