From: Kronos <kronos@people.it>
Subject: Re: "Remote" frambuffer - is it possible?
Date: Thu, 15 Jul 2004 20:44:56 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040715184456.GA11737@dreamland.darkstar.lan>
References: <F7D7691C9511064FA92D5891E144AECB1D539F@cacexc06.americas.cpqcorp.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BlBEA-0005Wb-Px
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Jul 2004 11:45:06 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BlBE9-0001Mp-RD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Jul 2004 11:45:06 -0700
Content-Disposition: inline
In-Reply-To: <F7D7691C9511064FA92D5891E144AECB1D539F@cacexc06.americas.cpqcorp.net>
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
To: "Queisser, Andrew (C++ rules)" <andrew.queisser@hp.com>
Cc: "Linux-Fbdev-Devel (E-mail)" <linux-fbdev-devel@lists.sourceforge.net>

Il Thu, Jul 15, 2004 at 09:37:04AM -0700, Queisser, Andrew (C++ rules) ha scritto: 
> - Is there a "null" framebuffer driver which simply provides
> the interface to apps but doesn't actually do anything
> with the pixels? Seems like that would be a good place
> to start. If not, which simple driver should I look at to
> get an in-depth understanding of how this stuff works?

There's the virtual framebuffer, it acts as a (somewhat limited)
framebuffer device with no output. The source is in drivers/video/vfb.c.
There's also drivers/video/skeleton.c, which is the skeleton of a
framebuffer driver; there's a comment for each function explaining its
semantic.

Luca
-- 
Home: http://kronoz.cjb.net
You and me baby ain't nothin' but mammals
So let's do it like they do on the Discovery Channel


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
