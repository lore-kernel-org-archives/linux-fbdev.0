From: James Simmons <jsimmons@infradead.org>
Subject: Re: Mirrored Display?
Date: Fri, 20 Dec 2002 19:49:00 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0212201947290.6471-100000@phoenix.infradead.org>
References: <200212131733.42340.kaufmann@sohard.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18PT9M-0001tR-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Fri, 20 Dec 2002 11:49:37 -0800
In-Reply-To: <200212131733.42340.kaufmann@sohard.de>
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
To: Michael Kaufmann <kaufmann@sohard.de>
Cc: Linux-fbdev-devel@lists.sourceforge.net


> I've modified existing drivers, and after a lot of work i now have a clear
> picture on my display. Unfortunately, the complete picture is mirrored.
> The Bootlogo is top/right instead of top/left and the ascii output starts from 
> right to left. 

Some hardware supports mirroring. Sounds like you turned it on by mistake.

> Where is the right place to modify this behaviour? 
> I'm also looking for a possibility to rotate the picture.
> Because my videocontroller can emulate 15 grayscales, i'm useing 4bpp.

The latest 2.5.X kernels have hardware hooks for rotation. I haven't added 
it yet to the software accel functions. I plan to a soon as I get time.
Thank you.



-------------------------------------------------------
This SF.NET email is sponsored by:  The Best Geek Holiday Gifts!
Time is running out!  Thinkgeek.com has the coolest gifts for
your favorite geek.   Let your fingers do the typing.   Visit Now.
T H I N K G E E K . C O M        http://www.thinkgeek.com/sf/
