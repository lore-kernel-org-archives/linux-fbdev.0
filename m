From: Chad A Daelhousen <cd9@cse.Buffalo.EDU>
Subject: Re: resizing results.
Date: Mon, 15 Mar 2004 14:34:20 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040315193420.GA15714@armstrong.cse.Buffalo.EDU>
References: <Pine.LNX.4.44.0403151732090.19671-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2xr2-00015r-QL
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Mar 2004 11:34:28 -0800
Received: from armstrong.cse.buffalo.edu ([128.205.32.3] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2xr1-0004aw-IF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Mar 2004 11:34:27 -0800
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

At Mon, Mar 15, 2004 at 05:38:46PM +0000, James Simmons wrote:
> 
> Hi folks. 
> 
>    I have been doing some work on cleaning up and debugging the resize 
> issue of fbcon. The first think I discovered where I never paid attention 
> to before was that the number of columns and rows change you you run 
> setfont. Isn't this wrong. The number of rows and columns should remain 
> the same. Only the font size chaneg which causes a console resolution 
> change.

Say, if one replaces an 8x16 font with an 8x8 one on 1280x1024,
shouldn't the number of rows double (64 to 128), and the vertical size
remain the same? Trying to go to 1280x512 doesn't make much sense to me.

Or is that not what you meant? I'm rather confused.

-- 
Chad Daelhousen
My opinions are my own, unless UB purchases my soul.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
