From: Andres Salomon <dilinger@queued.net>
Subject: Re: [PATCH 1/6] gxfb: create DC/VP/FP-specific
 handlers rather than using readl/writel
Date: Mon, 10 Mar 2008 17:35:44 -0400
Message-ID: <20080310173544.171183fc@ephemeral>
References: <20080308204826.0d399caf@ephemeral>
	<20080310142405.e8b92156.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JYpbD-0002LF-SP for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 14:32:00 -0700
Received: from mail.queued.net ([207.210.101.209])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JYpbB-0006DK-It
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 14:31:59 -0700
In-Reply-To: <20080310142405.e8b92156.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jordan.crouse@amd.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com, info-linux@geode.amd.com

On Mon, 10 Mar 2008 14:24:05 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sat, 8 Mar 2008 20:48:26 -0500
> Andres Salomon <dilinger@queued.net> wrote:
> 
> > +#define read_dc(reg)		readl(par->dc_regs + (reg))
> > +#define write_dc(reg, val)	writel((val), par->dc_regs + (reg))
> > +
> > +#define read_vp(reg)		readl(par->vid_regs + (reg))
> > +#define write_vp(reg, val)	writel((uint32_t) (val), \
> > +					par->vid_regs + (reg))
> > +
> > +#define read_fp(reg)		readl(par->vid_regs + (reg))
> > +#define write_fp(reg, val)	writel((uint32_t) (val), \
> > +					par->vid_regs + (reg))
> > +
> 
> Not very nice, sorry.  They're macros, and macros rather suck.  And they
> implicitly rely upon the caller having some variable called "par" in scope.
> 
> It would be much nicer to do
> 
> /*
>  * documentation goes here
>  */
> static inline u32 read_dc(struct geodefb_par *par, int reg)
> {
> 	return readl(par->dc_regs, reg);
> }
> 
> no?

I can change it if you'd like (although.. sigh.)

However, it's a lot of extra passing around of the 'par' without any
good reason.  Normal I prefer inline functions to macros as well, but
I don't see the point here.
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
