From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: resizing results.
Date: Tue, 16 Mar 2004 11:10:37 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1079395837.1968.194.camel@gaston>
References: <Pine.LNX.4.44.0403151732090.19671-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B32Fz-0004wr-0v
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Mar 2004 16:16:31 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B32Fx-0003Nk-GS
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Mar 2004 16:16:29 -0800
In-Reply-To: <Pine.LNX.4.44.0403151732090.19671-100000@phoenix.infradead.org>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-03-16 at 04:38, James Simmons wrote:
> Hi folks. 
> 
>    I have been doing some work on cleaning up and debugging the resize 
> issue of fbcon. The first think I discovered where I never paid attention 
> to before was that the number of columns and rows change you you run 
> setfont. Isn't this wrong. The number of rows and columns should remain 
> the same. Only the font size chaneg which causes a console resolution 
> change.

I don't agree. As a user, if I change the font, I expect a row/col
change rather than a resolution change...

Note that the resolution change code doesn't work properly anyway,
not until we have proper code to look for a matching mode along with
monitor detection in drivers, which we don't have.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
