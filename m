From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: fbcon sleeping function call from
	illegal context
Date: 26 Mar 2003 22:57:44 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048715864.10475.61.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.44.0303261811350.18664-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-1-208.abo.wanadoo.fr ([193.252.38.208] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yItc-0007pm-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Mar 2003 13:57:20 -0800
In-Reply-To: <Pine.LNX.4.44.0303261811350.18664-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Thomas Molina <tmolina@cox.net>, Thomas Schlichter <schlicht@uni-mannheim.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-26 at 19:33, James Simmons wrote:
> > Running with the patch as posted by Mr. Simmons I didn't get any further 
> > instances of the sleeping function call from illegal context messages I 
> > reported before, until screenblanking went into effect.  I then got the 
> > following:
> 
> Oh no!!! I just look at the console timer blanking code. It calls alot of 
> stuff. Not only does this mean we are limited in using kmalloc if we need 
> it but also using a semaphore to sync up the fb_pixmap stuff. At present 
> we use a spinlock. I tried it with a semphore but it kept hosing my 
> system. Now I know why. 

Junk. Move that console blanking stuff to process context too.

Actually, I've never fully understood some of the console blanking
code, especially the PM callback in there which does really weird
things. On pmacs, this code cause the screen to first blank, then
unblank, then blank again when the machine is going to sleep.

Ben.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
