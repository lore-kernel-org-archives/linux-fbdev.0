From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BUG] 2.5.69 - no setfont and loadkeys on tty > 1
Date: Thu, 15 May 2003 00:16:27 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0305142346380.14201-100000@phoenix.infradead.org>
References: <20030514224212.GA8124@elf.ucw.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030514224212.GA8124@elf.ucw.cz>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Well, it would be nice to set the default font for newly created fonts

> Perhaps you need to make old ioctls 2.4.X compatible and introduce new
> ioctl that sets only "this" console?

PIO_FONTRESET ioctl which is old and the flag KD_FONT_OP_SET_DEFAULT.
I have to look at the setfont code to see if it sets this flag. I bet 
it doesn't. I don't see a flag to tell setfont to use this font as the 
default font for all terminals :-( The good news is you can tell which tty 
to change the fonts on (-c /dev/ttyX). So setfont has the idea of setting
a single tty but due to a bug in the console layer it set all terminals. 
I guess we need to update setfont for setting all terminals.

> Do this:
> 
> pavel@amd:~$ echo -e '\e[?8c'
> 
> Notice cursor changes to block. Switch to another console. Oops, block
> cursor, too.

Ug!!!! I have cursor_shape in struct display for this reason. Will have to 
trace to find the problem.

> > appears the flashing is the issue. I will see if a hardware cursor
> > also has

   Your right. I realize my logic error. I was literally thinking too black 
and white. In the case of a cursor that is a white thin line at the bottom 
and a grey background. That is whole cursor image!! The mask should be
the font image to be drawn. 
   You can think of it as the cursor being a big grey cookie with white 
frosting decoration on the bottom. Then I come with my font shape cookie 
cutter and cut it out.  

> >     KDGKBDTYPE.   (Wow, I can't believe we still have this. It should die)
> 
> What is that? I can not see it in 2.5.X.

Line 420 in vt_ioctl.c. 
