From: James Simmons <jsimmons@infradead.org>
Subject: Re: problem in displaying logo
Date: Sat, 21 Dec 2002 20:51:54 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0212212045460.11087-100000@phoenix.infradead.org>
References: <3E044692.89F5BEA6@ncoretech.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Pqbm-00015e-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Dec 2002 12:52:30 -0800
In-Reply-To: <3E044692.89F5BEA6@ncoretech.com>
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
To: Ramprasad <ramprasad@ncoretech.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


>  I am using 2.4.18-rmk7 kernel on assabet like board , with 240x320 LCD
> color display panel.
> 
> 
> My problem is i have modified the linux startup logo to 240x320 size
> ,This works fine on 32MB RAM and 16MB flash
>  board, i.e  i can see full screen logo and i boots up fine. This does
> not work on  64MB RAM and 32MB flash board . logo comes up and kernel
> panic..
> 
> I just  tried to reduce the size of logo to 240x280 this works fine.
> 
> Can anybody give some pointers why this is happening..

Wow! I'm amazed changing the size of the logo didn't cause problem at any 
size. The code expect 80x80 size :-/



-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
