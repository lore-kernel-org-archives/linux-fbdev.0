From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb: copyarea() "memmove()"
	problem
Date: Wed, 31 Mar 2004 09:00:10 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1080687610.1213.50.camel@gaston>
References: <Pine.LNX.4.58.0403291709020.2356@rosencrantz.theboonies.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8SDp-00084u-2L
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Mar 2004 15:00:41 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B8SDo-0001FC-SG
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Mar 2004 15:00:41 -0800
In-Reply-To: <Pine.LNX.4.58.0403291709020.2356@rosencrantz.theboonies.us>
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
To: David Eger <eger-dated-1081179398.a664d4@theboonies.us>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

On Tue, 2004-03-30 at 01:13, David Eger wrote:
> Now that my local kernel actually calls copyarea(), I see that my code was
> buggy... That is, the hardware needs to be told which way to do its memory
> copies if areas overlap.  Think of memmove() versus memcpy().  
> Attached is the fix.
> 
> Unfortunately, I think the fbcon layer is also buggy... 
> (try opening a file with vim, and typing "5ddP"  the copyarea()'s that 
> get sent to the fb driver seem totally bogus...)

Excellent. James, any clue about the copyarea issue ?

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
