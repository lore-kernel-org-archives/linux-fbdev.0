From: Scott Robert Ladd <coyote@coyotegulch.com>
Subject: Re: Framebuffer updates.
Date: Wed, 26 Mar 2003 09:03:03 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E81B317.3080504@coyotegulch.com>
References: <Pine.LNX.4.33.0303251032320.4272-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from relay02.valueweb.net ([216.219.253.236])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yBVq-00041F-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Mar 2003 06:04:18 -0800
In-Reply-To: <Pine.LNX.4.33.0303251032320.4272-100000@maxwell.earthlink.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James Simmons wrote:
> As usually I have a patch avalaible at 
> The patch has updates for the ATI Rage 128, Control, and Platnium 
> framebuffer driver. The Radeon patch adds PLL times for the R* series of
> cards. Memory is now safe to allocate for the software cursor and inside 
> fbcon. There still are issues with syncing which cause the cursor on some 
> systems to become corrupt sometimes. 

 From your description, this doesn't sound like these patches solve the 
problem with radeonfb not detecting a DFP connected to the DVI. I posted 
a message about this bug a week ago, and am more than willing to look 
into fixing it myself if it isn't on your schedule.

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
