From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Tue, 27 Apr 2004 21:27:50 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404272126240.21601-100000@phoenix.infradead.org>
References: <1083060616.16475.4.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIZBR-0004fR-Lh
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 13:28:01 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIZBP-0002F7-Kj
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 13:28:00 -0700
In-Reply-To: <1083060616.16475.4.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>



> > I'm currently running through the radeon code trying to figure who all 
> > twiddles var before it gets set to registers and how to rework fbcon to be
> > sensible...
> 
> The whole var thing is too messy right now. Especially, the lack of a
> per-VT var right now makes things even more difficult

the real problem is the VT system was designed around VGA text mode. For 
example alot of the scrolling code in fbcon should be in the generic VT 
layer. 






-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
