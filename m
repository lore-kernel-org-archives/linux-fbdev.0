From: "Cheshire Cat Fish" <cat_fish@hotmail.com>
Subject: Re: Questions on more than one framebuffer device
Date: Tue, 13 May 2003 17:23:52 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Law15-F104wY6YHkidc00013e45@hotmail.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from f104.law15.hotmail.com ([64.4.23.104] helo=hotmail.com)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Fk3q-0005wa-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 May 2003 17:23:58 -0700
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
To: cat_fish@hotmail.com, linux-fbdev-devel@lists.sourceforge.net


>The problem comes when I run X with two cards in the system.  I can run X 
>on either card ok.  When I try to run X on both devices at the same time, 
>some things don't get drawn, and the screen doesn't always repaint right.  
>What does get drawn, is drawn to the correct screen, just some drawing 
>operations seem to be dropped.

One further piece of information. The drawing errors always happen on the 
second screen.

It doesn't matter which screen (0 or 1) I map to which framebuffer (/dev/fb0 
or /dev/fb1), the drawing on screen 0 is correct, the drawing on screen 1 is 
corrupted.

I am wondering if it is even a problem with my driver now.   Xfree86 should 
be able to run with multiple fbdev drivers, right?

Thanks,
Noel.



--
A precariously balanced mixture of myopic optimism and rampant paranoia.

_________________________________________________________________
STOP MORE SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
