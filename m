From: Alex Bennee <kernel-hacker@bennee.com>
Subject: How can I test my console driver?
Date: 11 Mar 2003 09:52:35 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047376355.5640.5.camel@cambridge.braddahead>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from nimbus19.internetters.co.uk ([209.61.216.65])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sgRB-0004TP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 01:52:45 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

I sent this to lkml but it probably got missed in the volume of mail.
Can anyone point me anything that describes how I could test my console
driver. Would it be the same approach for example as testing the vfb
frame buffer driver?

-----Forwarded Message-----
> Hi,
> 
> I'm writting a console driver for an embedded system for which the
> hardware isn't quite ready yet. As a result I'm building on a PC with a
> quickly hacked up proc interface so I can test the logic before the
> final hardware.
> 
> On loading the module my code does the following:
> 
>     take_over_console(&sh_con, MAX_NR_CONSOLES - 1, MAX_NR_CONSOLES - 1,
> 1);
> 
> Which I understand should associate my new console driver with the last
> system console (63 in this case). Then to test the console output I do:
> 
>     echo "this is a test string" > /dev/vc/63
> 
> However my dmesg output shows no sign of any of the console functions
> being called to write data, although the module itself has loaded
> succesfully and run the take_over_console code.
> 
> Obviously I'm mis-understanding how the console should be accessed but
> I'm stuck looking for any pointers. I've been looking thorugh the
> newport_con.c driver for pointers but so far I've not seen any extra
> magic that I'm missing. Can anyone point me in the right direction/offer
> some tips?
> 

-- 
Alex, homepage: http://www.bennee.com/~alex/

It's not reality or how you perceive things that's important -- it's
what you're taking for it...



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
