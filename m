From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Reading the EDID block for x86 machines
Date: Mon, 17 Mar 2003 14:02:15 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030317220215.49788.qmail@web14902.mail.yahoo.com>
References: <1047933906.3668.18.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14902.mail.yahoo.com ([216.136.225.54])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18v2gS-0002WL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 14:02:16 -0800
In-Reply-To: <1047933906.3668.18.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The VBIOS should be position independent code and it
will run at any 64K boundary. The PC bus spec simply
says the video BIOS defaults to C000, it is not a
requirement that it be located there. For example if
you look at the aty128fb driver's find ROM routine
your will notice that it is searching a broad address
space for the ROM.

I'm still not convinced that the memory at C000 is
really hardware write protected, I think it is just
RAM with a copy of the ROM in it. For example if I
turn off BIOS shadowing my system will not boot. When
debugging this I spent some time tracing into the ATI
ROM and I was pretty sure that they are dependent on
begin copied into RAM before begin run. 

Do you have a DOS floppy around? Just boot into DOS,
start debug and see if you can change C000:0.

If C000:0 is hardware write protected, there is
nothing stopping the ROM from begin copied into 8000:0
or 9000:0 or whatever where there is guaranteed RAM.
We would just need to temporarily get the kernel out
of the way.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
