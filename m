From: James Simmons <jsimmons@infradead.org>
Subject: Re: Some questions
Date: Wed, 5 Mar 2003 19:02:28 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303051858250.27760-100000@phoenix.infradead.org>
References: <1046870342.1291.86.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qeAV-00088i-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 11:03:08 -0800
In-Reply-To: <1046870342.1291.86.camel@localhost.localdomain>
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


> > However, I could not manage to gain a graphical console if sisfb is a
> > module, but fbcon is in the kernel. Is this combination supposed to
> > work? If so, how?
> 
> No, fbcon will not load unless there's at least one registered fbdev.
> So, you must compile sisfb statically too.

I fixed this in my latest patch. You can use con2fb again!!!!!!

> > b) The call to fb_set_var() inside fbcon_resize() is checked for errors,
> > but not the call to fbcon_resize() from within fbcon_switch(). This
> > leads to catastrophic drawing errors if the requested mode is not
> > supported by the low level driver.
> 
> Yes, it's a bug.  I think I submitted a patch to fix that, but I'm not
> sure if James applied it to his tree.

Applied.

> Another solution is to reimplement resizing by fbset.  The code is not
> very difficult and can be added if most people want it.

:-( 

> Yes, this is a limitation of stty.  It calls con_resize twice (one for
> row and another for cols, depending on the order of the options) so it
> will not work if the driver only supports a fixed set of modes.  Another
> reason to bring back fbset resizing.

???? stty rows 128 cols 48 works for me. It should'nt calling con_resize 
twice. 

> > 3) About y panning: In the 2.4 version of sisfb, I simply forced the
> > console to do y panning (unless positively disabled by the user) by
> > "patching" yres_virtual to the maximum, depending on the available video
> > memory. I am allowed to do that with the 2.5 API? (The rivafb code makes
> > be believe so...)
> 
> Scrolling mode is now determined by fbcon.  If var->accel_flag is
> nonzero, scrolling is ypan, otherwise, it's yredraw.  It's because ypan
> requres a lot of block copy which is slow when done by software.
> 
> I still believe though that scrolling should be determined by the
> driver, not fbcon.

Scrolling needs alot of work. I plan to fix that.



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
