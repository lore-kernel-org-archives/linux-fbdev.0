From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: EDID vs. fbmon & radeon
Date: Sun, 07 Sep 2003 12:00:54 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1062928854.823.46.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vwN1-0004Ug-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Sep 2003 03:02:11 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19vwN0-0000iJ-Ne
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Sep 2003 03:02:10 -0700
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

Hi James !

I'm working on radeonfb to implement full DDC2 support among other,
however, I'm having a problem with the way you currently put the EDID
code in fbmon.c

Right now, most of the actual EDID parsing is done within fbmon with
static functions, all I can do from the "outside" is to either use
parse_edid which will get me the first detailed timing block or
build a modedb, which will cause me to lose the information of what
comes from the detailed block, and what is a strandard VESA timing.

For proper flat panel setup, I need to actually know what is a detailed
timing block and iterate over those specifically to figure out the
proper panel informations that I'll need later on to configure the
RMX (scaler engine), among others. For now, I'll be using parse_edid()
but I would prefer iterating them all 4 so I can pick the largest one,
in case the panel does HW scaling and expose that some way...

We could either export low-level parsing routines from fbmon.c so I
can do my own parsing in special cases like this one, we could just
extend the modedb created with a few flags indicating for each mode
where it comes from (detailed block, vesa block), or we could output
some different EDID-specific data structure containing the parsed
EDID in various arrays like XFree does....

What do you think ?

(BTW. What about those fb_client patches ? Any chance we get that in
Linus tree soon ? )

Ben.
 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
