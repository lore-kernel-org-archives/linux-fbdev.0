From: James Simmons <jsimmons@infradead.org>
Subject: Re: Feature Freeze?
Date: Tue, 11 Mar 2003 15:57:46 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303111556100.23668-100000@phoenix.infradead.org>
References: <1046913396.1227.176.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sm9K-0007TC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 07:58:42 -0800
In-Reply-To: <1046913396.1227.176.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Secondly, we can have fbcon_resize() validate the mode instead of just
> blindly calling fb_set_var().  If it's not valid, then it can also fetch
> a working mode for it.  The user can then fine tune the timings using
> fbset afterwards.

But fb_set_var does call teh check_var routine. That is why a fb_set_var 
in fbcon_resize instead of just calling the set_par routine. 

> So, do we allow fbcon to handle mode validating and fetching, or do we
> just leave all this to fbdev? At least let's bring out some ideas on how
> to go about doing this.  Having a working idea, even if dumb, should
> interest other developers in contributing. 

That should be done by the low level driver not fbcon.



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
