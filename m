From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: New kernel API for ROMs
Date: Sat, 7 Aug 2004 10:40:57 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040807174057.35529.qmail@web14922.mail.yahoo.com>
References: <1091894996.18407.122.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BtVBi-00016Q-77
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 07 Aug 2004 10:40:58 -0700
Received: from web14922.mail.yahoo.com ([216.136.225.6])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BtVBh-0004h9-QV
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 07 Aug 2004 10:40:58 -0700
In-Reply-To: <1091894996.18407.122.camel@localhost.localdomain>
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
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kronos <kronos@people.it>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Geert Uytterhoeven <geert@linux-m68k.org>, DRI Devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Sad, 2004-08-07 at 17:37, Kronos wrote:
> > You can check and see if the ROM is really big and use vmalloc, if
> not
> > then you use kmalloc (if I remember correctly my radeon has a 4KB
> ROM -
> > vmalloc would be overkill).
> 
> You can also read it out to userspace in a loop in chunks thus
> needing
> only a single 4K page or you could mmap it

We have to copy the whole thing when the driver tells us to. After we
copy the ROM the hardware is going to use the address decoder for
something else. There is no safe way to get back to the ROM again other
than to unload the device driver.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Y! Messenger - Communicate in real time. Download now. 
http://messenger.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
