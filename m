From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 06 Mar 2003 09:18:19 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046913411.1206.185.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303051939470.27760-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qk0J-0007Ax-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 17:16:59 -0800
In-Reply-To: <Pine.LNX.4.44.0303051939470.27760-100000@phoenix.infradead.org>
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
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-06 at 03:43, James Simmons wrote:
> 
> > > I think you should only accept modes where the difference is a fraction
> > > of a character width or height.  A difference more than that and
> > > clear_margins() will not work correctly.  
> > > 
> > 
> > I apologize for my stupidity, fbdev does not know the font dimensions. 
> > I guess, we'll just need to really bring back fbset resizing.
> 
> I disagree that fbset is the solution to all things. The problem is 
> fbcon_resize is severally broken. The reality is that there are fixed mode 

fbcon_resize() is not that broken, it's only trying to do what it's
supposed to do.  It is indeed limited because it is trying to outguess
the low-level drivers on the best resolution for a window size.

However, the brokenness is really on the driver side.  They are unable
to change the video mode unless they are supplied with the correct
timing parameters where in fact they actually have the best knowledge on
how to calculate them.  

So the question:  Do we let fbcon spoonfeed the timings to fbdev, or do
we let the drivers calculate it for themselves?  I go for the latter, as
fbcon really should not have any business with hardware.

> resolutions (i.e. LCD displays). So fbcon has to adpat to this. What we 
> shoudl do is set the console mode fit slightly smaller than that the 
> actually resolution. The reason being is partially drawn fonts at the 

Yes, Geert's accel_clear_margin fix should help that.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
