From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] [FBDEV]: Hardware State
	Notification
Date: Wed, 23 Jun 2004 11:02:53 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1088006572.1855.154.camel@gaston>
References: <200406220639.26576.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdALX-00054w-GK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 09:11:35 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BdALX-0003gQ-13
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 09:11:35 -0700
In-Reply-To: <200406220639.26576.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2004-06-21 at 17:39, Antonino A. Daplas wrote:
> Hi,
> 
> **This patch is more of an RFC.  BenH probably has similar code.
> 
> This patch adds a method (con_notify) that will notify console drivers of 
> impending console switches, passing them with the about-to-be-old (last)
> vc structure and about-to-be-new (wanted) vc structure.  The console 
> drivers can then elect to pass selected information to low-level drivers.
> 
> This is important to fbcon so it can detect a switch from a graphics console to a
> text console and vice versa. This will give underlying drivers a chance to update
> its hardware state. This is added via the  method fbcon_state_switch(). Fbcon
> will, however, do a set_par if the _state_switch method is not availabe and if
> switching from a KD_GRAPHICS console.
> 
> Also updated rivafb to take advantage of this method.  With this, switching
> to/from X with XFree86/Org nv driver works.  Usually it hangs without the
> option usefbdev, or gets a Sig11 if with option usefbdev.
> 
> (Unfortunately it doesn't work for nVidia's binary nvidia driver, switching to 
> the console is possible, switching back to X will hang the machine).

You don't need that. A method for that was _ALREADY_ added to the kernel,
it's based on the fact that the blank() callback is called on switches
between KD_TEXT and KD_GRAPHICS. After discussing the issue with Linus,
we decided to add a parameter to it indicating the nature of the
switch. You should be able to rely on that. Actually, if you look at
the code, I'm forcing a set_par in this case. If this doesn't work, then
I may have missed a code path, and that should be fixed but there is no
need at this point to change the infrastructure.

Ben.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
