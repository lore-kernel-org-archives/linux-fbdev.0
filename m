From: James Simmons <jsimmons@infradead.org>
Subject: Re: Some questions
Date: Wed, 5 Mar 2003 19:16:11 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303051905490.27760-100000@phoenix.infradead.org>
References: <1046877920.1228.190.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qeNl-0002mj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 11:16:50 -0800
In-Reply-To: <1046877920.1228.190.camel@localhost.localdomain>
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
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > Well, this assumes that the user always want the best refresh rate, 
> > which is not desired in all cases.
> > 
> 
> fb_get_mode() accepts 4 flags.  Maximum refresh rate, hscan-driven,
> vrefresh-driven and dotclock-driven calculations.  It's flexible enough,
> but of course not as flexible as specifying your own modeline.

Things like pixclock rates can be changes by fbset and fbcon still 
sees these changes. stty is for the basic changes and fbset for advance 
changes. 

On a personal note. Many fbdev drivers in 2.4.X where also broken in that 
only the boot mode worked. This is where the fbset mode database in 
userland hack came in (/etc/fb.modes). This is horriable. Even with that 
userland database I often couldn't change video modes after booting. 

We should split the monitor programing stuff out from stuff like bpp etc.
Now if you think about it we can do things like change the bpp without 
having to redo the monitor programming. This is the flaw with the old and 
even the new api. 
 



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
