From: David Eger <eger@havoc.gtf.org>
Subject: Re: radeon_pm.c locking problem
Date: Fri, 2 Jul 2004 16:14:04 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040702201404.GA3395@havoc.gtf.org>
References: <40E59B82.7000807@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgUQJ-0005O1-PH
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 13:14:15 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BgUQJ-0003h6-0D
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 13:14:15 -0700
Content-Disposition: inline
In-Reply-To: <40E59B82.7000807@undead.cc>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Zielinski <grim@undead.cc>
Cc: linux-fbdev-devel@lists.sourceforge.net

I saw the post; the function affected is this:

static void radeon_pm_program_v2clk(struct radeonfb_info *rinfo)
{
        /* Set v2clk to 65MHz */
        OUTPLL(pllPIXCLKS_CNTL,
                INPLL(pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);

        OUTPLL(pllP2PLL_REF_DIV, 0x0000000c);
        OUTPLL(pllP2PLL_CNTL, 0x0000bf00);
        OUTPLL(pllP2PLL_DIV_0, 0x00020074 | P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W);

        OUTPLL(pllP2PLL_CNTL, INPLL(pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_SLEEP);
        mdelay(1);

        OUTPLL(pllP2PLL_CNTL, INPLL(pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_RESET);
        mdelay( 1);

        OUTPLL(pllPIXCLKS_CNTL,
                (INPLL(pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK)
                | (0x03 << PIXCLKS_CNTL__PIX2CLK_SRC_SEL__SHIFT));
        mdelay( 1);
}

and the checker program catches the cases where we do something like:

OUTPLL(foo, INPLL(bar) & ~blah);

because both OUTPLL and INPLL grab rinfo->reg_lock.

I think the right solution here - because it's logically one change, no:
Reprogramming the pixel clocks? is to just use the primitive __OUTPLL and
__INPLL and do the locking ourselves around the whole sequence.

-dte


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
