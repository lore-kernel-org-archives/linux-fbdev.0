From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb_pci_register video memory clear?
Date: Wed, 23 Jun 2004 10:56:52 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1088006211.1854.147.camel@gaston>
References: <40D3A2E1.2060100@undead.cc>
	 <20040619192744.GA3979@dreamland.darkstar.lan> <40D4980F.3000401@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdAEQ-0004ZE-9z
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 09:04:14 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BdAEP-000261-TS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 09:04:14 -0700
In-Reply-To: <40D4980F.3000401@undead.cc>
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
Cc: Kronos <kronos@people.it>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2004-06-19 at 14:46, John Zielinski wrote:
> Kronos wrote:
> 
> >AFAIK without that radeonfb will display the content of the memory as
> >random garbage.
> >  
> >
> I does fix it but the side effects I listed make it a bad idea, 
> especially the fact that the radeonfb driver doesn't own the memory 
> yet.  Tony has posted a proper fix for the problem so whoever put this 
> in, please remove it.

Provided Tony fix gets upstream instead of beeing lost for 6 more
monthes in the fbdev tree ...

Ben.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
