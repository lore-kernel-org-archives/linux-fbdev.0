From: James Simmons <jsimmons@infradead.org>
Subject: Re: When is the Linux Logo ( penguin ) drawn on
 startup in 2.4.20 ?
Date: Wed, 9 Jul 2003 00:54:11 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307090051480.32323-100000@phoenix.infradead.org>
References: <20030708234530.9697.qmail@web11905.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19a2II-0001GD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 08 Jul 2003 16:54:47 -0700
In-Reply-To: <20030708234530.9697.qmail@web11905.mail.yahoo.com>
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
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


> I am trying to debug a Xpert98 PCI graphics card on a
> mips system with a 2.4.20 kernel. 

Really cool. Are you using a serial console? If that is the case you can 
transfer the printks from tty0 to ttyS0. After that you can in the aty 
driver and in fbcon.c enable DEBUG. This shoudl give you lots of data. 
Hope I gave you enough detail. If not I can give you teh exact steps.
 
P.S
	I have a patch that allows you to boot that card without a BIOS 
emulator :-) I really like it if you could test it on 2.5.X.
 
I am using vga
> emulation to read the gfx card's ROM and initialize
> the card. I know the card is being somewhat
> initialized because after the vga emulation has
> completed, the vga monitor shows lots of colored
> squares / random colors etc. I have single stepped
> into the code and noticed that within aty_init() the
> call to fb_memset() clears the screen to black. But
> after that nothing else happens - ie nothing else is
> output to the screen.
> 
> Single stepping is proving to be very slow, and I
> don't really know the framebuffer code, so I would be
> very grateful if someone on the list could suggest
> which routines I need to set breakpoints in and / or
> what may be the cause of my non-existent penguin.
> 
> Please Note, I have successfully used a cirrus logic
> PCI gfx card in the same system and it outputs the
> penguin to the vga monitor, so i know the system is
> capable of it.
> 
> TIA
> 
> Wayne
> 
> __________________________________
> Do you Yahoo!?
> SBC Yahoo! DSL - Now only $29.95 per month!
> http://sbc.yahoo.com
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Parasoft
> Error proof Web apps, automate testing & more.
> Download & eval WebKing and get a free book.
> www.parasoft.com/bulletproofapps
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
