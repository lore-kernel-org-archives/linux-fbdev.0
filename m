From: James Simmons <jsimmons@infradead.org>
Subject: Re: Framebuffer updates.
Date: Wed, 26 Mar 2003 20:07:49 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303262007240.21188-100000@phoenix.infradead.org>
References: <3E81B317.3080504@coyotegulch.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yHCG-0005ss-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Mar 2003 12:08:29 -0800
In-Reply-To: <3E81B317.3080504@coyotegulch.com>
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
To: Scott Robert Ladd <coyote@coyotegulch.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > As usually I have a patch avalaible at 
> > The patch has updates for the ATI Rage 128, Control, and Platnium 
> > framebuffer driver. The Radeon patch adds PLL times for the R* series of
> > cards. Memory is now safe to allocate for the software cursor and inside 
> > fbcon. There still are issues with syncing which cause the cursor on some 
> > systems to become corrupt sometimes. 
> 
>  From your description, this doesn't sound like these patches solve the 
> problem with radeonfb not detecting a DFP connected to the DVI. I posted 
> a message about this bug a week ago, and am more than willing to look 
> into fixing it myself if it isn't on your schedule.

If you have the docs and teh ahrdware could you? I don't have either.




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
