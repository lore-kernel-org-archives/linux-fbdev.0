From: Jim Hague <jim.hague@acm.org>
Subject: Re: pm2fb fixes
Date: Wed, 21 Apr 2004 19:21:34 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040421192134.jim.hague@acm.org>
References: <20040421132639.1d87ba1b@zerocool>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGMMB-0007gb-DJ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 11:21:59 -0700
Received: from cpc3-oxfd2-6-0-cust100.oxfd.cable.ntl.com ([81.103.193.100] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BGMMA-0001jC-TB
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 11:21:59 -0700
In-Reply-To: <20040421132639.1d87ba1b@zerocool>
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
To: Marcelo Ramos <mramos@montevideo.com.uy>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 21-Apr-2004 Marcelo Ramos wrote:
>> video=pm2fb:1024x768-70
> 
> That line didn't work but using @70 instead of -70 worked like a charm.

Oh, duh. Of course. Sorry - serious brain fade on my part. -70 is the 2.4
syntax.

> Now i'm a happy framebuffer user again.

Good news.

BTW, I'd be interested in hearing if you see any unusual behaviour. Fox
example, when switching from X to the console I see a thin white line about 1
pixel high across the bottom of the screen. Typically the line has substantial
breaks in a couple of places.

Also when shutting down from gdm with the full screen display, my console
background goes a bluey sort of shade.

Something looks like it isn't quite right. I haven't located what, yet; not
that I've looked very hard.

-- 
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
