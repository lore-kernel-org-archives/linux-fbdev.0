From: James Simmons <jsimmons@infradead.org>
Subject: Re: tdfx & multiple voodoo cards : supposed to
 work ?
Date: Thu, 30 Oct 2003 18:27:54 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310301827220.4560-100000@phoenix.infradead.org>
References: <20031030091541.GA4422@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFHWY-0003o5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 10:27:58 -0800
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AFHWX-0003iq-9f
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 10:27:57 -0800
In-Reply-To: <20031030091541.GA4422@iliana>
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > Yeap. Also the driver uses the VGA legacy IO ports. It is possible to run 
> > the driver without BIOS support. The specs have such info. I just haven't 
> > got around to it.
> 
> Notice : this is on powerpc, but the pegasos OF has support for
> emulating x86 bioses.
> 
> What about running fbdev only on the first head, and have XFree86
> initialize the second head ? The problem is that just having the two
> boards in the box freezes the kernel.

The tdfx uses the legacy ports to set a video mode :-( This needs to be 
cleaned up.





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
