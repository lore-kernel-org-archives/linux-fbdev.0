From: James Simmons <jsimmons@infradead.org>
Subject: status
Date: Fri, 22 Nov 2002 17:52:43 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211220049430.17898-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
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
To: Linux console project <linuxconsole-dev@lists.sourceforge.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi folks!!!

   Just to let you know where I am for the fbdev developement. I finished 
off the latest api changes. The cursor api has been cleaned up and it uses 
fb_image struct. This makes life easier. 
   I ported over the ATI 128 driver to the latest changes. I finished the 
3Dfx driver yesterday and got the ATI mach 64 driver done this morning.
I will test it tomorrow. Then I will finsih up the NVIDIA driver. After 
that I'm going to push the code to linus. 
   I started to hack at fbcon.c but realized it is such a mess I am going 
to rewrite it from scratch. This will be after the push to linus. I plan 
to use MDA console and create a modular fbcon that I can play with at 
will. 
   The other annoucement is I have started to look for funding for this 
developement. At present I haven't found anything. I realized for the 
fbdev and console changes to be done I need to devote all my time to do 
this. To do this will require funding so I can pay my most basic bills. 
Wish me luck.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
