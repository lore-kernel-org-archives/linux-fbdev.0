From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] VT locking
Date: Wed, 07 Jan 2004 10:08:49 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1073430528.4067.27.camel@gaston>
References: <1073349182.9504.175.camel@gaston>
	 <Pine.GSO.4.58.0401061725250.5752@waterleaf.sonytel.be>
	 <1073425440.773.10.camel@gaston>  <20040106140002.6806757b.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Ae0KQ-000089-7r
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 15:09:38 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Ae0KP-0004uB-Dp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 15:09:37 -0800
In-Reply-To: <20040106140002.6806757b.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>


> That's OK, it's just in there for a soak-test at present - this stuff is
> quite a long way away, yes?

The VT locking on the debug crude hack ? :)

Well it depends :) If nobody complains, it could get in pretty fast :)
In any case, please report me any trigger of the WARN_ON... I didn't
chield everything yet with the console sem, so there may still be
some of them coming from the low level code.

> It's probably just easiest for you to work against current -bk, send me a
> single rolled up patch whenever you have new things for people to test. 
> When we're happy with it all we can do a bk merge of everything.

Ok.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
