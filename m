From: Nicholas Wourms <dragon@gentoo.org>
Subject: Re: [BK UPDATES] Frmaebuffer updates.
Date: Sun, 23 Mar 2003 08:05:49 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E7DB12D.3080006@gentoo.org>
References: <Pine.LNX.4.44.0303230314210.30614-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18x5OX-0008Fv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 23 Mar 2003 05:20:13 -0800
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 18x5OT-0004ed-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 23 Mar 2003 14:20:09 +0100
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jsimmons@infradead.org

James Simmons wrote:
> Linus, please do a
> 
> 	bk pull http://fbdev.bkbits.net/fbdev-2.5
> 
> This is the bulk of the framebuffer changes. It has many important fixes 
> that are needed. Please apply. Normal diff is avaliable at
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> Thank you.
> 
> This will update the following files:
[SNIP]

James,

This change just broke the updated fix for matroxfb that 
Petr provided.  So, with all due respect, where do you (or 
anyone else) stand on getting matroxfb working again?  I'm 
not complaining, but matrox cards are *supposed* to be the 
most supported cards by linux, which was one of the factors 
which led me to buy one.  I know nothing about video 
programming, otherwise I'd try doing it myself.  Thanks for 
all the hardwork you and others have done so far.

Cheers,
Nicholas




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
