From: Joe Perches <joe@perches.com>
Date: Tue, 16 Nov 2010 19:46:12 +0000
Subject: RE: [PATCH 01/10] MCDE: Add hardware abstraction layer
Message-Id: <1289936772.28741.188.camel@Joe-Laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289390653-6111-1-git-send-email-jimmy.rubin@stericsson.com>
	<1289390653-6111-2-git-send-email-jimmy.rubin@stericsson.com>
	<201011121643.52923.arnd@arndb.de>
	<F45880696056844FA6A73F415B568C6953604E7D94@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <F45880696056844FA6A73F415B568C6953604E7D94@EXDCVYMBSTM006.EQ1STM.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 2010-11-16 at 16:29 +0100, Jimmy RUBIN wrote:
> > > +/* Channel path */
> > > +#define MCDE_CHNLPATH(__chnl, __fifo, __type, __ifc, __link) \
> > > +	(((__chnl) << 16) | ((__fifo) << 12) | \
> > > +	 ((__type) << 8) | ((__ifc) << 4) | ((__link) << 0))
> > > +enum mcde_chnl_path {
> > > +	/* Channel A */
> > > +	MCDE_CHNLPATH_CHNLA_FIFOA_DPI_0 = MCDE_CHNLPATH(MCDE_CHNL_A,
> > > +		MCDE_FIFO_A, MCDE_PORTTYPE_DPI, 0, 0),
> > > +	MCDE_CHNLPATH_CHNLA_FIFOA_DSI_IFC0_0 > > MCDE_CHNLPATH(MCDE_CHNL_A,
> > > +		MCDE_FIFO_A, MCDE_PORTTYPE_DSI, 0, 0),
> > > +	MCDE_CHNLPATH_CHNLA_FIFOA_DSI_IFC0_1 > > MCDE_CHNLPATH(MCDE_CHNL_A,
> > > +		MCDE_FIFO_A, MCDE_PORTTYPE_DSI, 0, 1),
> > 
> > A table like this would become more readable by making each entry a
> > single line, even if that goes beyond the 80-character limit.
> Good point, we will fix this

Or the #define could be changed to do something like:

static inline u32 MCDE_channel_path(u32 chnl, u32 fifo, u32 type, u32 ifc, u32 link)
{
	return ((chnl << 16) |
		(fifo << 12) |
		(type << 8) |
		(ifc << 4) |
		(link << 0));
}

#define SET_ENUM_MCDE_CHNLPATH(chnl, fifo, var, type, ifc, link)	\
	MCDE_CHNLPATH_CHNL##chnl##_FIFO##fifo##_##var =			\
		MCDE_channel_path(MCDE_CHNL_##chnl,			\
				  MCDE_FIFO_##fifo,			\
				  MCDE_PORTTYPE_##type,			\
				  ifc,					\
				  link)

enum mcde_chnl_path {
	/* Channel A */
	SET_ENUM_MCDE_CHNLPATH(A, A, DPI_0,		DPI, 0, 0),
	SET_ENUM_MCDE_CHNLPATH(A, A, DSI_IFC0_0,	DSI, 0, 0),
	SET_ENUM_MCDE_CHNLPATH(A, A, DSI_IFC0_1,	DSI, 0, 1),
	SET_ENUM_MCDE_CHNLPATH(A, C, DSI_IFC0_2,	DSI, 0, 2),
	SET_ENUM_MCDE_CHNLPATH(A, C, DSI_IFC1_0,	DSI, 1, 0),
	SET_ENUM_MCDE_CHNLPATH(A, C, DSI_IFC1_1,	DSI, 1, 1),
	SET_ENUM_MCDE_CHNLPATH(A, A, DSI_IFC1_2,	DSI, 1, 2),
	/* Channel B */
	SET_ENUM_MCDE_CHNLPATH(B, B, DPI_1,		DPI, 0, 1),
	SET_ENUM_MCDE_CHNLPATH(B, B, DSI_IFC0_0,	DSI, 0, 0),
	SET_ENUM_MCDE_CHNLPATH(B, B, DSI_IFC0_1,	DSI, 0, 1),
	SET_ENUM_MCDE_CHNLPATH(B, C, DSI_IFC0_2,	DSI, 0, 2),
	SET_ENUM_MCDE_CHNLPATH(B, C, DSI_IFC1_0,	DSI, 1, 0),
	SET_ENUM_MCDE_CHNLPATH(B, C, DSI_IFC1_1,	DSI, 1, 1),
	SET_ENUM_MCDE_CHNLPATH(B, B, DSI_IFC1_2,	DSI, 1, 2),
	/* Channel C0 */
	SET_ENUM_MCDE_CHNLPATH(C0, A, DSI_IFC0_0,	DSI, 0, 0),
	SET_ENUM_MCDE_CHNLPATH(C0, A, DSI_IFC0_1,	DSI, 0, 1),
	SET_ENUM_MCDE_CHNLPATH(C0, C0, DSI_IFC0_2,	DSI, 0, 2),
	SET_ENUM_MCDE_CHNLPATH(C0, C0, DSI_IFC1_0,	DSI, 1, 0),
	SET_ENUM_MCDE_CHNLPATH(C0, C0, DSI_IFC1_1,	DSI, 1, 1),
	SET_ENUM_MCDE_CHNLPATH(C0, A, DSI_IFC1_2,	DSI, 1, 2),
	/* Channel C1 */
	SET_ENUM_MCDE_CHNLPATH(C1, B, DSI_IFC0_0,	DSI, 0, 0),
	SET_ENUM_MCDE_CHNLPATH(C1, B, DSI_IFC0_1,	DSI, 0, 1),
	SET_ENUM_MCDE_CHNLPATH(C1, C1, DSI_IFC0_2,	DSI, 0, 2),
	SET_ENUM_MCDE_CHNLPATH(C1, C1, DSI_IFC1_0,	DSI, 1, 0),
	SET_ENUM_MCDE_CHNLPATH(C1, C1, DSI_IFC1_1,	DSI, 1, 1),
	SET_ENUM_MCDE_CHNLPATH(C1, B, DSI_IFC1_2,	DSI, 1, 2),
};

It seems that long blocks of upper case make my eyes glaze
over and that many of your #defines are indistinguishable.

