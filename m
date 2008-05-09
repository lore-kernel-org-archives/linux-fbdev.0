From: Jens Rottmann <JRottmann@LiPPERT-AT.de>
Subject: Re: lxfb driver regression
Date: Fri, 09 May 2008 12:33:32 +0200
Message-ID: <4824287C.4050300@LiPPERT-AT.de>
References: <20080507210836.1eb61b8f@ephemeral>	<48230694.5010505@LiPPERT-AT.de>
	<20080508104808.77f48f41@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JuPuu-0004nz-Ls for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 May 2008 03:33:32 -0700
Received: from mail.lippert-at.com ([62.80.22.186]
	helo=domex.lippertembedded.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JuPut-0001xa-7q
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 May 2008 03:33:32 -0700
In-Reply-To: <20080508104808.77f48f41@ephemeral>
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
To: Andres Salomon <dilinger@queued.net>, jordan.crouse@amd.com
Cc: linux-geode@bombadil.infradead.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Andres Salomon wrote:
> The pixclock that's specified is 17460 (from the olpc dcon table)
> [...] Prior to your patch, this was:  { 0x00004286, 56250 },
> [...] Your patch adds:  { 0x00014170, 57375 },

Yes, of course that was my first idea, too. And this was my motivation for
sending you the cut down patch without the > 25 MHz entries. But I'm almost
prepared to bet this is not the root of the evil.

As I said, this does not explain why the resolution seems to switch to 800x640,
because lx_set_clock() does not return any feedback. I somehow doubt you'll get
a white screen just by raising the dotclock by 2 % (and getting it _closer_ to
the intended value)?

And before I wrote my mail yesterday, I checked the dotclock for the 0x00004286
and 0x00014170 PLL values with a scope, and both settings produced a fine signal
with the expected frequencies.

Anyway, I hope I'm wrong, then at least we'd have a solution for this issue.

> BTW, where did the intermediate values in your table come from?

Took the original table from lxfb_ops.c, everywhere set DIV4 and divided
frequency by 4, merged it back into the original table, dropping all lines
within 300 kHz of an preexisting setting.
I wrote a small script to do this, to avoid typos when mangling the table
(assuming the original table was ok).

> The LX data book shows the DOTPLL equation (6.14.2.14), but very
> little documentation of DIV4 or the usable values below 15MHz.

LX Data Book, p. 554:
"DIV4: Divide by 4. When set, the PLL output is divided by 4 before clocking the
logic."

Sounds like a simple divider circuit _behind_ the PLL, so as long as the
original frequency is ok, the DIV4-ed should be, too.

As I said, I assumed the original table in lxfb_ops.c to contain usable values.
And all of the few settings I checked with the scope looked ok.

Jordan Crouse wrote:
> ... the original value (56.250), which in retrospect is probably
> a better choice for ths display.

So in case the increased dotclock in fact causes the white screen, it might be
cleaner to lower the _requested_ dotclock in the OLPC DCON mode timing to 56.250
MHz instead of cutting out PLL settings.

> I don't think we really need divided signals > 24Mhz.

Well, in my opinion it would be nice to have some intermediate steps in the
available dotclocks. However, I don't actually need those for the 320x240 panel,
so I don't care much.

Regards,
Jens

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
