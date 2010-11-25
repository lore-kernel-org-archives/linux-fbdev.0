From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 25 Nov 2010 16:21:12 +0000
Subject: Re: [PATCH 02/10] MCDE: Add configuration registers
Message-Id: <201011251721.12315.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289390653-6111-1-git-send-email-jimmy.rubin@stericsson.com>
	<201011121614.51528.arnd@arndb.de>
	<F45880696056844FA6A73F415B568C695365E671B7@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <F45880696056844FA6A73F415B568C695365E671B7@EXDCVYMBSTM006.EQ1STM.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 25 November 2010, Jimmy RUBIN wrote:
> 
> All these header files,
> Configuration, pixel processing, formatter, dsi link registers are auto generated from an xml file.

This actually may or may not be a legal problem, because it means that the
distributed source code is not the preferred form for making modifications
as the GPL intends, you might want to ask a lawyer. Distributing the XML
file and the script with the kernel would solve that, but people might
consider that ugly ;-).

> This is made because there are many registers which a prone to change for new hardware revisions and there is a possibility to exclude registers that are not used.
> The chance of manual errors are less this way.
> 
> I also believe that these helper macros makes the source code easier to read.
> For example.
> #define MCDE_CR_DSICMD2_EN_V1_SHIFT 0
> #define MCDE_CR_DSICMD2_EN_V1_MASK 0x00000001
> #define MCDE_CR_DSICMD2_EN_V1(__x) \
> 	MCDE_VAL2REG(MCDE_CR, DSICMD2_EN_V1, __x)
> 
> Writing a single field in the register MCDE_CR can e.g. be done like this:
> mcde_wfld(MCDE_CR, DSICMD1_EN_V1, true);
> 
> and for a whole register (a totally other register but just to show):
> 		mcde_wreg(MCDE_ROTACONF + chnl_id * MCDE_ROTACONF_GROUPOFFSET,
> 			MCDE_ROTACONF_ROTBURSTSIZE_ENUM(8W) |
> 			MCDE_ROTACONF_ROTBURSTSIZE_HW(1) |
> 			MCDE_ROTACONF_ROTDIR(regs->rotdir) |
> 			MCDE_ROTACONF_STRIP_WIDTH_ENUM(16PIX) |
> 			MCDE_ROTACONF_RD_MAXOUT_ENUM(4_REQ) |
> 			MCDE_ROTACONF_WR_MAXOUT_ENUM(8_REQ));

I see what you mean, though I would probably still prefer an inline
function for doing the same:

static inline void mcde_write_rotaconf(struct mcde_chnl *chnl, unsigned burstsize,
				unsigned rotdir, unsigned strip_width,
				unsigned rd_maxout, wr_maxout)
{
	unsigned __iomem *reg = chnl->base + MCDE_ROTACONF +
				chnl->id * MCDE_ROTACONF_GROUPOFFSET;

	writel(reg, burstsize << 20 | rotdir << 12 | strip_width << 8 |
		rd_maxout << 4 | wr_maxout);
}

Anyway, it's not really important how you do it, this is mostly a matter
of personal preference. If you can find a way to make it more readable,
that would be really good, but it's really a minor issue compared to
getting the overall layering inside the driver right.

> I agree that the header files looks a bit unreadable I will try indent as you
> suggested I am just worried about the file size. (Patch limit 100kbyte)

Don't worry about the patch size limit too much, that is not the real
problem here ;-). For review, you can always cut parts of these files
since nobody will notice a problem in the middle of 2000 almost identical
source lines. When you ask for a git pull, the size no longer matters.

	Arnd
