From: Joe Perches <joe@perches.com>
Date: Mon, 15 Nov 2010 16:30:18 +0000
Subject: RE: [PATCH 01/10] MCDE: Add hardware abstraction layer
Message-Id: <1289838618.16461.132.camel@Joe-Laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289390653-6111-1-git-send-email-jimmy.rubin@stericsson.com>
	<1289390653-6111-2-git-send-email-jimmy.rubin@stericsson.com>
	<1289409276.15905.65.camel@Joe-Laptop>
	<F45880696056844FA6A73F415B568C6953604E7105@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <F45880696056844FA6A73F415B568C6953604E7105@EXDCVYMBSTM006.EQ1STM.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 2010-11-15 at 10:52 +0100, Jimmy RUBIN wrote:
> > Just trivia:
[]
> > It'd be nice to change to continuous_running
> Continous_running [...]

It was just a spelling comment.
continous
continuous

> 
> > > +int mcde_dsi_dcs_write(struct mcde_chnl_state *chnl, u8 cmd, u8*
> > data, int len)
> > > +{
> > > +	int i;
> > > +	u32 wrdat[4] = { 0, 0, 0, 0 };
> > > +	u32 settings;
> > > +	u8 link = chnl->port.link;
> > > +	u8 virt_id = chnl->port.phy.dsi.virt_id;
> > > +
> > > +	/* REVIEW: One command at a time */
> > > +	/* REVIEW: Allow read/write on unreserved ports */
> > > +	if (len > MCDE_MAX_DCS_WRITE || chnl->port.type !> > MCDE_PORTTYPE_DSI)
> > > +		return -EINVAL;
> > > +
> > > +	wrdat[0] = cmd;
> > > +	for (i = 1; i <= len; i++)
> > > +		wrdat[i>>2] |= ((u32)data[i-1] << ((i & 3) * 8));
> > 
> > Ever overrun wrdat?
> > Maybe WARN_ON(len > 16, "oops?")
> > 
> MCDE_MAX_DCS_WRITE is 15 so it will be an early return in that case.

Perhaps it'd be better to use

DECLARE_BITMAP(wrdat, MCDE_MAX_DCS_WRITE);

or some other mechanism to link the array
size to the #define. 

> /Jimmy



