From: John Zielinski <grim@undead.cc>
Subject: radeonfb_pci_register video memory clear?
Date: Fri, 18 Jun 2004 22:20:17 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40D3A2E1.2060100@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbVSz-0003Ig-Qb
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 19:20:25 -0700
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BbVSz-0004Kv-CI
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 19:20:25 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

I'm just wondering why the clearing of video memory was added to 
radeonfb_pci_register?  The memory still belongs to vgacon at this 
point.  There are a few other problems with this:  there is a noticable 
delay while the screen is totaly blank,  vgacon can't save the text 
screen to the shadow buffer, and all further output until the takeover 
is invisible (vga font is wiped) so an oops here wouldn't be readable.

John




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
