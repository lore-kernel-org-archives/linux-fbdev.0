From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 05 Mar 2003 23:48:03 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046879235.1228.202.camel@localhost.localdomain>
References: <3E65EAFB.7020208@winischhofer.net>
	<1046870342.1291.86.camel@localhost.localdomain> 
	<3E66044D.5030007@winischhofer.net> 
	<1046877920.1228.190.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qb6W-0003jK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 07:46:48 -0800
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
Content-Type: text/plain; charset="us-ascii"
To: Antonino Daplas <adaplas@pol.net>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-05 at 23:25, Antonino Daplas wrote:

> > > 
> > > Yes, that's the Real Thing :-)  fbcon_resize has a "fuzzy mode" too --
> > > it won't do an fb_set_var() if the change in dimensions is only a
> > > fraction of a character's dimension.
> > 
> > Ack. Is 16 fuzzy enough, what do you think?
> 
> I think you should only accept modes where the difference is a fraction
> of a character width or height.  A difference more than that and
> clear_margins() will not work correctly.  
> 

I apologize for my stupidity, fbdev does not know the font dimensions. 
I guess, we'll just need to really bring back fbset resizing.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
