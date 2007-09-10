From: aherrman@arcor.de
Subject: Re: [PATCH 1/4] radeonfb: add PCI Id
	for	RS482/Radeon Xpress 200M
Date: Tue, 11 Sep 2007 00:38:18 +0200
Message-ID: <20070910223818.GC5155@devil>
References: <20070904105831.GE7320@devil>
	<1188913512.5972.147.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IUrsL-0001SE-Jg for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 15:37:01 -0700
Received: from mail-in-10.arcor-online.net ([151.189.21.50])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IUrsJ-00079Q-Q7
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 15:37:01 -0700
Content-Disposition: inline
In-Reply-To: <1188913512.5972.147.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, Sep 04, 2007 at 03:45:12PM +0200, Benjamin Herrenschmidt wrote:
> On Tue, 2007-09-04 at 12:58 +0200, aherrman@arcor.de wrote:
> > .. which can be found in Acer Aspire 5100.
> > 
> > Signed-off-by: Andreas Herrmann <aherrman@arcor.de>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Sorry, I have missed that 0x5975 was already defined for radeonfb.
So this patch shouldn't be applied.

We have already:

        /*Mobility Xpress 200 */
        CHIP_DEF(PCI_CHIP_RS485_5975,   R300,   CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),

This was introduced with commit b5f2f4d1a6d7efde39cfb5e1d034981c69f2214c

But obviously this is not correct as the 0x5975 is an RS48x not R300.
With the current git (w/o my patch) my display goes blank (or better it looks striped)
and the Laptop hangs.

I'll do some further tests on my Laptop and probably come up with a new patch.


Regards,

Andreas


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
