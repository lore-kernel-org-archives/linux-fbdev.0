From: James Simmons <jsimmons@infradead.org>
Subject: Re: Running frame buffer programs using a VGA
 console?
Date: Tue, 6 Jan 2004 22:47:42 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401062246010.21143-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0311271109100.19234-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdzzI-0006ga-9O
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 14:47:48 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AdzzH-0000Ya-Nm
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 14:47:47 -0800
In-Reply-To: <Pine.GSO.4.21.0311271109100.19234-100000@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Zielinski <grim@undead.cc>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> On Thu, 27 Nov 2003, John Zielinski wrote:
> > Silly question.  Is it actually possible to run a fb program like fbtest 
> > if your console is the VGA console?  I tried it but the fb driver 
> > doesn't seem to switch modes.
> 
> No, you cannot. You need an active frame buffer device driver.

It depends on the setup and driver. With the riva and vga16fb driver you 
can. You just enable fbdev support without fbcon and use vgacon. It works 
:-) 




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
