From: Kronos <kronos@people.it>
Subject: Re: radeonfb_pci_register video memory clear?
Date: Sat, 19 Jun 2004 21:27:44 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040619192744.GA3979@dreamland.darkstar.lan>
References: <40D3A2E1.2060100@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BblVJ-0007P1-SG
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 12:27:53 -0700
Received: from mail-relay-3.tiscali.it ([212.123.84.93])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BblVJ-00079X-G3
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 12:27:53 -0700
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: John Zielinski <grim@undead.cc>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Il Fri, Jun 18, 2004 at 10:20:17PM -0400, John Zielinski ha scritto: 
> *This message was transferred with a trial version of CommuniGate(tm) Pro*
> I'm just wondering why the clearing of video memory was added to 
> radeonfb_pci_register? 

AFAIK without that radeonfb will display the content of the memory as
random garbage.

Luca
-- 
Home: http://kronoz.cjb.net
Software is like sex; it's better when it's free.
Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
