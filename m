From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Wed, 24 Dec 2003 16:23:13 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1072242753.820.41.camel@gaston>
References: <1070348676.4311.39.camel@gaston>  <3FCC4018.4020503@undead.cc>
	 <1070403757.4300.75.camel@gaston>  <3FCD17D5.4040804@undead.cc>
	 <1070410792.21174.83.camel@gaston>  <3FE8CCE3.4010709@undead.cc>
	 <1072230310.739.25.camel@gaston>  <3FE90001.3080207@undead.cc>
	 <1072236683.739.32.camel@gaston>  <3FE919E1.7050609@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZ1Un-0005mk-2n
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 21:23:45 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AZ1Um-0004ar-Gs
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 21:23:44 -0800
In-Reply-To: <3FE919E1.7050609@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-12-24 at 15:45, John Zielinski wrote:
> Benjamin Herrenschmidt wrote:
> 
> >Well, the interesting thing is does X using "fbdev" has proper colors
> >(or X using "ati" driver with UseFBDev option). If yes, then that code
> >is right. It's the console/blit code that is wrong.
> >  
> >
> Confirmed using fbtest.  With that section commented out fbtest's colors 
> are messed up.
> 
> Hmmm....  Just found something.  Here's an updated patch.  Notice the 6 
> changing to a 5 in the 16 bit case.  This makes the console and fbtest 
> look right.... except for the penguins.  Their colors are messed up 
> depending on the test order.

Looks fine, I'll do tests here. What's up with the penguin ? (what do
you mean by "test order" ?)

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
