From: aherrman@arcor.de
Subject: Re: [PATCH 2/4] radeonfb: add new module
	parameter to force PLL calculation
Date: Tue, 11 Sep 2007 02:45:45 +0200
Message-ID: <20070911004545.GE5155@devil>
References: <20070904105908.GF7320@devil>
	<1188913589.5972.150.camel@localhost.localdomain>
	<20070910222012.GB5155@devil>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IUtrg-0005SL-R0 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 17:44:29 -0700
Received: from mail-in-06.arcor-online.net ([151.189.21.46])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IUtrg-0004YB-0i
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 17:44:28 -0700
Content-Disposition: inline
In-Reply-To: <20070910222012.GB5155@devil>
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
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, Sep 11, 2007 at 12:20:12AM +0200, aherrman@arcor.de wrote:
> On Tue, Sep 04, 2007 at 03:46:29PM +0200, Benjamin Herrenschmidt wrote:
> > I don't like those tunables. First we should get a look at what values
> > we obtain from the BIOS. Could be something with the parsing of ATOM
> > BIOS. In any case, we might be able to detect we got wrong values or use
> > subsystem vendor/device ID to blacklist.

     <snip>

> "nopllcalc" results in a console 80x25 but forcing pll calculation gives
> the expected result.
> 
> BTW, I am a little surprised that the display doesn't blank without
> my patch as it used to in the past ...
> 
>   Oops, PCI ID 0x5975 was already added with commit
>   b5f2f4d1a6d7efde39cfb5e1d034981c69f2214c
> 
> I guess I have to repeat some testing with both the older commit and my patch(es)
> to sort out what is really needed to support my RS482/0x5975.

Done that.
And meanwhile I found out that force_measure_pll gives the same results
like the new force_pll_calc knob. Hence that new tunable is really not needed.

By blacklisting you meant to add a workaround to reinit the card if subsystem vendor/devID
matches my combination of Acer Aspire+Radeon, right? Then I wouldn't have to add the
force_measure_pll option on boot to get the optimal resolution ...

Do we need a second Acer Aspire system that's not correctly working to justify
a blacklisting?
Well, and how should the reinit function look like?


Thanks and Regards,

Andreas


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
