From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: fbdev cursor part 1.
Date: Thu, 11 Mar 2004 16:05:32 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1078981531.23047.265.camel@gaston>
References: <Pine.LNX.4.44.0403101747120.24760-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1IjS-0001eW-1L
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Mar 2004 21:27:46 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B1IRz-0002F8-5o
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Mar 2004 21:09:43 -0800
In-Reply-To: <Pine.LNX.4.44.0403101747120.24760-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Alexander Kern <alex.kern@gmx.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2004-03-11 at 04:49, James Simmons wrote:
> Sorry about the delay. I have been bug bashing other code in fbdev. Here 
> is your latest driver against the vanillia tree. It works because I have 
> tested on my laptop. I even did some repairs on the software cursor. It 
> now behaves better, except it doesn't like none 8 bit wide fonts.
> 
> http://phoenix.infradead.org/~jsimmons/mach64.diff.gz

this is a patch against what ? Linus ? I've had some problems with
mach64 lately and hacked various things, so please, let me run
through this before commiting upstream

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
