From: James Simmons <jsimmons@infradead.org>
Subject: Re: EDID vs. fbmon & radeon
Date: Tue, 9 Sep 2003 00:53:20 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309090045530.23354-100000@phoenix.infradead.org>
References: <1062928854.823.46.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wZvZ-0007Qa-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 08 Sep 2003 21:16:29 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19wVpi-0002hB-PE
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Sep 2003 16:54:11 -0700
In-Reply-To: <1062928854.823.46.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> I'm working on radeonfb to implement full DDC2 support among other,
> however, I'm having a problem with the way you currently put the EDID
> code in fbmon.c

I have been watching. Really cool stuff. 
 
> Right now, most of the actual EDID parsing is done within fbmon with
> static functions, all I can do from the "outside" is to either use
> parse_edid which will get me the first detailed timing block or
> build a modedb, which will cause me to lose the information of what
> comes from the detailed block, and what is a strandard VESA timing.
> 
> For proper flat panel setup, I need to actually know what is a detailed
> timing block and iterate over those specifically to figure out the
> proper panel informations that I'll need later on to configure the
> RMX (scaler engine), among others. For now, I'll be using parse_edid()
> but I would prefer iterating them all 4 so I can pick the largest one,
> in case the panel does HW scaling and expose that some way...
> 
> We could either export low-level parsing routines from fbmon.c so I
> can do my own parsing in special cases like this one, we could just
> extend the modedb created with a few flags indicating for each mode
> where it comes from (detailed block, vesa block), or we could output
> some different EDID-specific data structure containing the parsed
> EDID in various arrays like XFree does....
> 
> What do you think ?

Hm. The most important goal I think should be that as much as possible 
code sharing goes on. The way XFree86 handles it is that th edrivers only 
have to deal with 2 functions for writing the i2c register. Everything 
else is handled by a upper layer. I like to see fbdev have the same thing.

> (BTW. What about those fb_client patches ? Any chance we get that in
> Linus tree soon ? )

Yes. I have viewed the code and I like to go over some ideas with you on 
it. I will post my comments tomorrow. 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
