From: James Simmons <jsimmons@infradead.org>
Subject: Re: Some questions
Date: Wed, 5 Mar 2003 19:43:57 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303051939470.27760-100000@phoenix.infradead.org>
References: <1046879235.1228.202.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qeoa-0002XL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 11:44:33 -0800
In-Reply-To: <1046879235.1228.202.camel@localhost.localdomain>
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


> > I think you should only accept modes where the difference is a fraction
> > of a character width or height.  A difference more than that and
> > clear_margins() will not work correctly.  
> > 
> 
> I apologize for my stupidity, fbdev does not know the font dimensions. 
> I guess, we'll just need to really bring back fbset resizing.

I disagree that fbset is the solution to all things. The problem is 
fbcon_resize is severally broken. The reality is that there are fixed mode 
resolutions (i.e. LCD displays). So fbcon has to adpat to this. What we 
shoudl do is set the console mode fit slightly smaller than that the 
actually resolution. The reason being is partially drawn fonts at the 
bottom of the screen would look bad. So clearing the margins also has to 
be fixed. This way we clean up the screen for situtations where the 
console screen size doesn't quite fit the resolution. This is what shoudl 
be done. 



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
