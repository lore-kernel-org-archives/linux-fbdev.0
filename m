From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-users] fb0 for console & fb1 for every one
Date: Wed, 23 Apr 2003 18:55:45 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304231852060.2573-100000@phoenix.infradead.org>
References: <7A5D4FEED80CD61192F2001083FC1CF9065175@CHARLY>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <7A5D4FEED80CD61192F2001083FC1CF9065175@CHARLY>
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
To: "Filipau, Ihar" <ifilipau@sussdd.de>
Cc: "'linux-fbdev-users@lists.sourceforge.net'" <linux-fbdev-users@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 23 Apr 2003, Filipau, Ihar wrote:

> 	[ CC me please - not subscribed ]
> 
> 	I have a little question.
> 	More conceptual - documentation says nothing about it.
> 	At least I found nothing.
> 	Any fingering to RTFM is welcome.
> 
> 	We have piece of custom hardware which has 
> 	two displays: LCD and RTC.
> 	[ Kernel vanilla 2.4.20. ]
> 	We are using vga16 for RTC - testing/support/debug go here.
> 	We are using (heavily fixed) driver for sed1374 Epson 
> 	chip as a second frame buffer device.
> 
> 	And now we are hitting a lot of problems with the fact that 
> 	FBs is heavily biased in direction of consoles.
> 	But our second FB is used solely for graphics!
> 	We do not need a console on it! (but mc there looks nice ;)
> 
> 	The Question:
> 	Is there any patch for fbmem to remove its (looks like
> 	intentional) links to fbcon? move them where they (as 
> 	I believe) should be - fbcon?
>
> 	When I was recommending FB interface - I expected that fbcon 
> 	stack up on fbmem. Was my impression from docs. But that's not
> 	true.

Yes. The Linux 2.5.X is done this way. Try the latest tree. Note the 
framebuffer api has changed.

> 	Currently we are doing a lot of stupid stuff like change of 
> 	controlling terminal, hiding the cursor, switching off the 
> 	console blanking, etc.
> 
> 	Is there any way to avoid this stuff?

The new fbdev api in 2.5.X avoids this. Also it is possible to do the 
setup you are talking about. Compile in the fbdev driver you want as a 
console and the other one as a module. Boot and you will have a 
framebuffer console on that one card. Now for the modular driver just load 
it. Modular drivers are not actually mapped to the console. To do that you 
need to use con2fb. 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
