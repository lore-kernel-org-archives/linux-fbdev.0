From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [BUG] 2.5.71: no cursor until tty output
Date: Mon, 16 Jun 2003 22:05:27 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0306162152120.26878-100000@phoenix.infradead.org>
References: <20030616190042.F13312@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030616190042.F13312@flint.arm.linux.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel List <linux-kernel@vger.kernel.org>


> There appears to be a bug in fbcon where the soft cursor does not appear
> on the screen until some tty output occurs.  I suspect soft cursor is
> missing some initialisation somewhere; I have once seen some random garbage
> flashing on the screen instead of the cursor, which seems to be where
> the cursor is supposed to be.
> 
> When tty output occurs, the characters appear where the garbage was, and
> the normal cursor appears.
> 
> I've noticed this on several fbcon drivers, so I don't believe it is a
> generic fbcon bug.

I know which bug you are talking about. I have a fix already in the BK 
tree. Softcursor.c uses the image drawing function. Unfortunely 
softcursor.c assumes that imageblit always process 8 bit padded data. This 
is not always the case. I noticed this with the rivafb driver. I have a 
fix in the fbdev BK tree. A few more bugs need to be fixed tho for the 
software cursor :-( They are coming.
