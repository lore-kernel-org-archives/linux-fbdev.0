From: Justin Ducote <justinduc@yahoo.com>
Subject: Linux Intel FB Question
Date: Mon, 14 Apr 2003 21:21:04 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030415042104.88847.qmail@web41603.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web41603.mail.yahoo.com ([66.218.93.103])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 195HwW-0008Tx-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Apr 2003 21:21:12 -0700
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: justinduc@yahoo.com

Hi guys..

I would like to use the RADEON frame buffer, with
that said I am restricting this senario to the VESA
driver ONLY to try and clear up some of my confusion..

When I boot linux/grub (Redhat 9.0) with the following
line:

vga=792

Everything works great, I get 1024x768x16m and it uses
the VESA Framebuffer (I think) and everything is
great. 

If I try and use this line instead:

video=vesa:mode:1024x768-24@60

NOTHING happens.. 

My understanding was that those two
lines should yield the exact same result in theory. I
thought they are doing the same thing but the video
line does nothing so I am confused and I do not
understand whats going on. 

Additionally, 
I would like to know what is the relationship
between VGA= and VIDEO= 

Thank you for your time.
Justin Ducote

__________________________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo
http://search.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
