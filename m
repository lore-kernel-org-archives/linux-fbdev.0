From: James Simmons <jsimmons@infradead.org>
Subject: Re: tdfx & multiple voodoo cards : supposed   
 to work ?
Date: Thu, 30 Oct 2003 18:41:29 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310301839310.5296-100000@phoenix.infradead.org>
References: <20031030123418.7005615CA9@mail03.powweb.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFHjg-0005si-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 10:41:32 -0800
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AFHjf-0000mS-Uj
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 10:41:32 -0800
In-Reply-To: <20031030123418.7005615CA9@mail03.powweb.com>
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
To: Richard Drummond <evilrich@rcdrummond.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Sven Luther <sven.luther@wanadoo.fr>


> Voodoo4/5 has a different method of byte-swizzling for big-endian hardware than 
> the Voodoo3 - which isn't supported by the current tdxfb driver or by XFree86. I 
> have been working on a fix for tdfxfb, and have had some success - but since I 
> don't have any documentation, it's involved a lot of guess-work. I haven't looked 
> at this for a while, but I could dig out the code again and supply a patch against
> what I have got so far.

I have docs on Voodoo3 but I never got a hold of docs on Voodoo4/5. if 
someone has docs I really like to have them.

> As to your other problem, I have two Voodoos working on my Mac with 2.6, so I 
> would expect such a set-up to work on the Pegasos too. On PPC hardware, 
> there should be no problem of conflicting VGA ports since the PCI sub-system can 
> remap I/O ports on the PPC.

Nice :-)




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
