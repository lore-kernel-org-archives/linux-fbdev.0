From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb_pci_register video memory clear?
Date: Wed, 23 Jun 2004 10:52:57 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1088005977.1854.140.camel@gaston>
References: <40D3A2E1.2060100@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdAAc-00040K-Fs
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 09:00:18 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BdAAc-00018h-2Y
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 09:00:18 -0700
In-Reply-To: <40D3A2E1.2060100@undead.cc>
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

On Fri, 2004-06-18 at 21:20, John Zielinski wrote:
> I'm just wondering why the clearing of video memory was added to 
> radeonfb_pci_register?  The memory still belongs to vgacon at this 
> point.  There are a few other problems with this:  there is a noticable 
> delay while the screen is totaly blank,  vgacon can't save the text 
> screen to the shadow buffer, and all further output until the takeover 
> is invisible (vga font is wiped) so an oops here wouldn't be readable.

I added that to fix reports of users complaining they had garbage displayed
on boot. I didn't think about the interaction with vgacon (see, I have
absolutely no legacy hardware doing crappy VGA mode ;)

Maybe that should be reversed ....

Ben.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
