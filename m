From: Jens Rottmann <JRottmann@LiPPERT-AT.de>
Subject: Re: lxfb driver regression
Date: Tue, 13 May 2008 12:29:23 +0200
Message-ID: <48296D83.3020007@LiPPERT-AT.de>
References: <20080507210836.1eb61b8f@ephemeral>	<48230694.5010505@LiPPERT-AT.de>
	<20080512185148.104fc4c3@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JvrlD-0007zf-2T for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 May 2008 03:29:31 -0700
Received: from mail.lippert-at.com ([62.80.22.186]
	helo=domex.lippertembedded.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JvrlB-0004LZ-MW
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 May 2008 03:29:31 -0700
In-Reply-To: <20080512185148.104fc4c3@ephemeral>
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
To: Andres Salomon <dilinger@queued.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-geode@bombadil.infradead.org, linux-kernel@vger.kernel.org, jordan.crouse@amd.com, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

I wrote:
> > Yes, of course that was my first idea, too. [...] But I'm
> > almost prepared to bet this is not the root of the evil.

Andres Salomon wrote:
> It works much better on an XO, so I've ack'd it.

Oops. Lucky I didn't bet, I'd have lost!
But it wasn't all fair, this strange fb resolution switch got me off track. ;-)


But it still surprises me that you get a white screen if you run the XO panel
with the specified frequency, and it only works as long as this is unavailable.
Are you sure the dotclock setting in olpc_dcon_modedb[] is correct?

Anyway, glad the problem is solved, now.

Again, many thanks for your help!
Jens

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
