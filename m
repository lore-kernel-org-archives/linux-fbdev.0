From: Lucas Stach <l.stach@pengutronix.de>
Date: Mon, 05 Aug 2013 14:18:42 +0000
Subject: Re: [PATCH 4/5] fb: Add DCU framebuffer driver for Vybrid VF610 platform
Message-Id: <1375712322.4276.12.camel@weser.hi.pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373609276-14566-1-git-send-email-b18965@freescale.com>
 <1373609276-14566-5-git-send-email-b18965@freescale.com>
 <20130729111457.GB3029@pengutronix.de>
 <81BA6E5E0BC2344391CABCEE22D1B6D83CA6F0@039-SN1MPN1-002.039d.mgd.msft.net>
 <20130805130911.GF30920@pengutronix.de>
In-Reply-To: <20130805130911.GF30920@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Am Montag, den 05.08.2013, 15:09 +0200 schrieb Robert Schwebel:
> On Mon, Aug 05, 2013 at 09:51:40AM +0000, Wang Huan-B18965 wrote:
> > > On Fri, Jul 12, 2013 at 02:07:55PM +0800, Alison Wang wrote:
> > > > The Display Controller Unit (DCU) module is a system master that
> > > > fetches graphics stored in internal or external memory and displays
> > > > them on a TFT LCD panel. A wide range of panel sizes is supported and
> > > > the timing of the interface signals is highly configurable.
> > > > Graphics are read directly from memory and then blended in real-time,
> > > > which allows for dynamic content creation with minimal CPU
> > > intervention.
> > > 
> > > Only a review of the code inline.
> > > 
> > > Maybe the real question is whether we want to introduce another
> > > framebuffer driver at all instead of making it a DRM driver.
> > [Alison Wang] I think DCU module is more suitable to be designed as a framebuffer driver than a DRM driver. Just like DIU framebuffer driver for PowerPC.
> 
> We looked at the Vybrid datasheet and it's DCU section last week, and
> with its 64 planes, the controller really wants to get a DRM driver.
> 
Exactly, with it's extensive hardware composition capabilities the
controller begs for being driven by a proper DRM driver. There is no way
in fbdev to properly support all those hardware planes without
introducing a lot of non standard ioctls, which in turn will force you
into writing a lot of custom userspace code instead of running proven
technology that sits on top of KMS.

Doing things in DRM might be slightly more work for the initial bring
up, but will pay off in the long run when you are going to really use
the hardware caps of the controller.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

