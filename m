From: Jimmy RUBIN <jimmy.rubin@stericsson.com>
Date: Thu, 25 Nov 2010 11:30:11 +0000
Subject: RE: [PATCH 02/10] MCDE: Add configuration registers
Message-Id: <F45880696056844FA6A73F415B568C695365E671B7@EXDCVYMBSTM006.EQ1STM.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289390653-6111-1-git-send-email-jimmy.rubin@stericsson.com>
	<1289390653-6111-2-git-send-email-jimmy.rubin@stericsson.com>
	<1289390653-6111-3-git-send-email-jimmy.rubin@stericsson.com>
	<201011121614.51528.arnd@arndb.de>
In-Reply-To: <201011121614.51528.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

> >
> > This patch adds the configuration registers found in MCDE.
> 
> > +
> > +#define MCDE_VAL2REG(__reg, __fld, __val) \
> > +	(((__val) << __reg##_##__fld##_SHIFT) &
> __reg##_##__fld##_MASK)
> > +#define MCDE_REG2VAL(__reg, __fld, __val) \
> > +	(((__val) & __reg##_##__fld##_MASK) >>
> __reg##_##__fld##_SHIFT)
> > +
> > +#define MCDE_CR 0x00000000
> > +#define MCDE_CR_DSICMD2_EN_V1_SHIFT 0
> > +#define MCDE_CR_DSICMD2_EN_V1_MASK 0x00000001
> > +#define MCDE_CR_DSICMD2_EN_V1(__x) \
> > +	MCDE_VAL2REG(MCDE_CR, DSICMD2_EN_V1, __x)
> > +#define MCDE_CR_DSICMD1_EN_V1_SHIFT 1
> > +#define MCDE_CR_DSICMD1_EN_V1_MASK 0x00000002
> > +#define MCDE_CR_DSICMD1_EN_V1(__x) \
> > +	MCDE_VAL2REG(MCDE_CR, DSICMD1_EN_V1, __x)
> > +#define MCDE_CR_DSI0_EN_V3_SHIFT 0
> > +#define MCDE_CR_DSI0_EN_V3_MASK 0x00000001
> > +#define MCDE_CR_DSI0_EN_V3(__x) \
> > +	MCDE_VAL2REG(MCDE_CR, DSI0_EN_V3, __x)
> 
> This looks all rather unreadable. The easiest way is usually to just
> define the bit mask, i.e. the second line of each register definition,
> which you can use to mask the bits. It's also useful to indent the
> lines
> so you can easily tell the register offsets apart from the contents:
> 
> #define MCDE_CR 0x00000000
> #define		MCDE_CR_DSICMD2_EN_V1 0x00000001
> #define		MCDE_CR_DSICMD1_EN_V1 0x00000002
> 
> Some people prefer to express all this in C instead of macros:
> 
> struct mcde_registers {
> 	enum {
> 		mcde_cr_dsicmd2_en = 0x00000001,
> 		mcde_cr_dsicmd1_en = 0x00000002,
> 		...
> 	} cr;
> 	enum {
> 		mcde_conf0_syncmux0 = 0x00000001,
> 		...
> 	} conf0;
> 	...
> };
> 
> This gives you better type safety, but which one you choose is your
> decision.
> 
> 	Arnd

All these header files,
Configuration, pixel processing, formatter, dsi link registers are auto generated from an xml file.
This is made because there are many registers which a prone to change for new hardware revisions and there is a possibility to exclude registers that are not used.
The chance of manual errors are less this way.

I also believe that these helper macros makes the source code easier to read.
For example.
#define MCDE_CR_DSICMD2_EN_V1_SHIFT 0
#define MCDE_CR_DSICMD2_EN_V1_MASK 0x00000001
#define MCDE_CR_DSICMD2_EN_V1(__x) \
	MCDE_VAL2REG(MCDE_CR, DSICMD2_EN_V1, __x)

Writing a single field in the register MCDE_CR can e.g. be done like this:
mcde_wfld(MCDE_CR, DSICMD1_EN_V1, true);

and for a whole register (a totally other register but just to show):
		mcde_wreg(MCDE_ROTACONF + chnl_id * MCDE_ROTACONF_GROUPOFFSET,
			MCDE_ROTACONF_ROTBURSTSIZE_ENUM(8W) |
			MCDE_ROTACONF_ROTBURSTSIZE_HW(1) |
			MCDE_ROTACONF_ROTDIR(regs->rotdir) |
			MCDE_ROTACONF_STRIP_WIDTH_ENUM(16PIX) |
			MCDE_ROTACONF_RD_MAXOUT_ENUM(4_REQ) |
			MCDE_ROTACONF_WR_MAXOUT_ENUM(8_REQ));


I agree that the header files looks a bit unreadable I will try indent as you suggested I am just worried about the file size. (Patch limit 100kbyte)

/Jimmy
