From: John Zielinski <grim@undead.cc>
Subject: Re: radeonfb_pci_register video memory clear?
Date: Sat, 19 Jun 2004 15:46:23 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40D4980F.3000401@undead.cc>
References: <40D3A2E1.2060100@undead.cc> <20040619192744.GA3979@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BblnK-0000WL-Fi
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 12:46:30 -0700
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BblnJ-0002nP-TC
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 12:46:30 -0700
In-Reply-To: <20040619192744.GA3979@dreamland.darkstar.lan>
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
To: Kronos <kronos@people.it>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Kronos wrote:

>AFAIK without that radeonfb will display the content of the memory as
>random garbage.
>  
>
I does fix it but the side effects I listed make it a bad idea, 
especially the fact that the radeonfb driver doesn't own the memory 
yet.  Tony has posted a proper fix for the problem so whoever put this 
in, please remove it.

John




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
