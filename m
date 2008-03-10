From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/6] gxfb: create DC/VP/FP-specific handlers rather than
 using readl/writel
Date: Mon, 10 Mar 2008 14:24:05 -0700
Message-ID: <20080310142405.e8b92156.akpm@linux-foundation.org>
References: <20080308204826.0d399caf@ephemeral>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757086AbYCJVYh@vger.kernel.org>
In-Reply-To: <20080308204826.0d399caf@ephemeral>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andres Salomon <dilinger@queued.net>
Cc: adaplas@gmail.com, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, info-linux@geode.amd.com, jordan.crouse@amd.com

On Sat, 8 Mar 2008 20:48:26 -0500
Andres Salomon <dilinger@queued.net> wrote:

> +#define read_dc(reg)		readl(par->dc_regs + (reg))
> +#define write_dc(reg, val)	writel((val), par->dc_regs + (reg))
> +
> +#define read_vp(reg)		readl(par->vid_regs + (reg))
> +#define write_vp(reg, val)	writel((uint32_t) (val), \
> +					par->vid_regs + (reg))
> +
> +#define read_fp(reg)		readl(par->vid_regs + (reg))
> +#define write_fp(reg, val)	writel((uint32_t) (val), \
> +					par->vid_regs + (reg))
> +

Not very nice, sorry.  They're macros, and macros rather suck.  And they
implicitly rely upon the caller having some variable called "par" in scope.

It would be much nicer to do

/*
 * documentation goes here
 */
static inline u32 read_dc(struct geodefb_par *par, int reg)
{
	return readl(par->dc_regs, reg);
}

no?
