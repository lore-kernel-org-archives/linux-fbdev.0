From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 18:46:48 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40903458.4070406@undead.cc>
References: <Pine.LNX.4.44.0404281829410.1187-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIxpP-0003I2-9c
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 15:46:55 -0700
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BIxpP-0003dF-0a
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 15:46:55 -0700
In-Reply-To: <Pine.LNX.4.44.0404281829410.1187-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Otto Solares <solca@guug.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

James Simmons wrote:

>This has always been. In the old days when X crashed you lost your 
>display. That was life. The X drivers are better but its up to X to 
>restore the console.
>
>  
>
By that logic we'd still be using kernel 1.0.  ;)   I still don't see a 
problem with fbcon resetting the video card to what it thinks it should 
be when it regains control of the framebuffer.   But like everything 
else in the kernel, we'll prove it works first before suggesting it be 
included in the official release.

>Plus with the software cursor we do use fb_imageblit. Also I'm 
>beginning to realize we need to clear out the framebuffer memory.
>People complain about left over junk on there screen when the console 
>takes over. 
>
>  
>
No, no, no!  :)   I want to see my boot up messages before the console 
takes over, especially if the kernel dies during bootup.  I've already 
posted a fix for this a while back for just the radeon driver but it's 
very easy to modify the other drivers.  It's just one line of code per 
driver and one line to fb.h . 

What happens is that the vga console tries to copy screen memory to it's 
save buffer when it's being shut down but the fb driver has already 
reconfigured the memory aperature layout.  A call to do_blank_screen(1) 
right before the mode switch will cause the vga console to save screen 
memory at that point.  This needs to be done in the drivers.  If it were 
done in fbcon then any prink's in the drivers would "unblank" the vga 
console and mess things up again.

>routines. Look at the debate about how to handle setting the resolution.
>Yipes it been fierce.
>
>  
>
Sorry!  I seem to have a nack at starting these things....  :)

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
