From: "Cheshire Cat Fish" <cat_fish@hotmail.com>
Subject: Re: Using VESA BIOS in Framebuffer driver
Date: Wed, 14 May 2003 14:37:48 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Law15-F8HY5FbEFYamN00020b83@hotmail.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from f8.law15.hotmail.com ([64.4.23.8] helo=hotmail.com)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19G3wk-0006fV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 14 May 2003 14:37:58 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: seetaram_nt@india.com, linux-fbdev-devel@lists.sourceforge.net





--
A precariously balanced mixture of myopic optimism and rampant paranoia.
>I am developing a framebuffer driver for my PLC 69030 video card.
>I have gone through the Source code of the Sample framebuffer driver and i 
>have some clarifications needed. Please clarify my doubts.

I am in the process of doing exactly this for a custom board.  So this will 
be like the blind leading the blind I suspect, but for what it is worth, 
here is what I know...

>1.How does the Frame buffer driver Switches graphics modes, i mean how does 
>it initializes the graphics system say in 640*480*256 mode and switch to 
>say 800*600*24 mode.
>Does it depend on VESA BIOS calls to do this ?

I think this is up to you how you want to do this.  In mine, I do it by 
directly programming the hardware (no BIOS calls whatsoever).   Basically, 
you are told to set a mode - how you do that is up to you.

>2.How does the framebuffer driver achieve paging ?
>Say my display memoy is 4mb and i want divide it into 4 pages then how will 
>i do this ?

I'm not sure what you mean by paging.  Video memory isn't typically paged.  
Is not all 4MB available at once?

Noel.

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
