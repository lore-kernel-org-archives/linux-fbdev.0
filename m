From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbcon sleeping function call from illegal context
Date: Wed, 26 Mar 2003 18:33:40 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303261811350.18664-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0303261049490.1347-100000@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yFj9-0007Wc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Mar 2003 10:34:20 -0800
In-Reply-To: <Pine.LNX.4.44.0303261049490.1347-100000@localhost.localdomain>
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
To: Thomas Molina <tmolina@cox.net>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Running with the patch as posted by Mr. Simmons I didn't get any further 
> instances of the sleeping function call from illegal context messages I 
> reported before, until screenblanking went into effect.  I then got the 
> following:

Oh no!!! I just look at the console timer blanking code. It calls alot of 
stuff. Not only does this mean we are limited in using kmalloc if we need 
it but also using a semaphore to sync up the fb_pixmap stuff. At present 
we use a spinlock. I tried it with a semphore but it kept hosing my 
system. Now I know why. 

What should be done is the console blank timer be passed onto 
console_callback.

P.S
     I reversed some of the cursor changes. It uses static buffers again 
until we have these issues solved. The code works as long as you don't use 
more than one framebuffer device but it is rock solid like before for a 
single framebuffer device. I will have a patch ready in the hour.





-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
