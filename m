From: Joe Perches <joe@perches.com>
Date: Wed, 17 Nov 2010 16:01:17 +0000
Subject: Re: [PATCH 01/10] MCDE: Add hardware abstraction layer
Message-Id: <1290009677.28741.302.camel@Joe-Laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289390653-6111-1-git-send-email-jimmy.rubin@stericsson.com>
	<F45880696056844FA6A73F415B568C6953604E7D94@EXDCVYMBSTM006.EQ1STM.local>
	<1289936772.28741.188.camel@Joe-Laptop>
	<201011171055.58201.arnd@arndb.de>
In-Reply-To: <201011171055.58201.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 2010-11-17 at 10:55 +0100, Arnd Bergmann wrote:
> On Tuesday 16 November 2010, Joe Perches wrote:
> > static inline u32 MCDE_channel_path(u32 chnl, u32 fifo, u32 type, u32 ifc, u32 link)
> > {
> >         return ((chnl << 16) |
> >                 (fifo << 12) |
> >                 (type << 8) |
> >                 (ifc << 4) |
> >                 (link << 0));
> > }
> > 
> > #define SET_ENUM_MCDE_CHNLPATH(chnl, fifo, var, type, ifc, link)        \
> >         MCDE_CHNLPATH_CHNL##chnl##_FIFO##fifo##_##var =                 \
> >                 MCDE_channel_path(MCDE_CHNL_##chnl,                     \
> >                                   MCDE_FIFO_##fifo,                     \
> >                                   MCDE_PORTTYPE_##type,                 \
> >                                   ifc,                                  \
> >                                   link)
> > 
> > enum mcde_chnl_path {
> >         /* Channel A */
> >         SET_ENUM_MCDE_CHNLPATH(A, A, DPI_0,             DPI, 0, 0),
> >         SET_ENUM_MCDE_CHNLPATH(A, A, DSI_IFC0_0,        DSI, 0, 0),
> >         SET_ENUM_MCDE_CHNLPATH(A, A, DSI_IFC0_1,        DSI, 0, 1),
> 
> While more readable, this has two significant problems:
> 
> * You cannot use the result of an inline function in an enum definition
> * It hides the name of the identifier, making it impossible to use grep
>   or ctags to find the definition when you only know the name

True, though I would avoid that problem by using a get function/macro
and not use an enum at all.

There are just 4 items of interest here.  chan, fifo, #1, #2.
Encoding those in the variable name is a bit of a visual chase and
a bit mind numbing to read I think.
 
> The easiest way is probably to get rid of the macros entirely here
> and just define the values as hex, with a comment exmplaining what the
> digits mean.

That'd be fine too.


