From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Small API change
Date: 01 Apr 2003 20:30:58 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049221857.589.138.camel@zion.wanadoo.fr>
References: <20030401152209.91116.qmail@web14913.mail.yahoo.com>
	 <1049214320.1174.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-6-134.abo.wanadoo.fr ([80.11.137.134] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190QWd-0007pi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Apr 2003 10:30:23 -0800
In-Reply-To: <1049214320.1174.68.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

I want to add a flag passed by userland in fb_var_screeninfo
that say, for an LCD using a scaled mode, to either use a full
scaling or to keep aspect ratio (when possible).

This is quite useful for things like titanium powerbooks with their
wide LCDs. Currently, if I set a 1024x768 mode on my 'native' 1152x768,
I get a horizontal scaling and no vertical scaling, thus a bad
aspect ratio. It can be ok for some things, not for others, I'd like
to let userland the choice. MacOS does provide both set of modes
as well. In the "keep aspect ratio" mode, the driver would scale
both H and V the same (based on the smaller of H and V ratios)
and add margins to center the display. On some radeons, I think I
even have optional HW automatic centering.

We can either define a "flags" field using on of the reserved ones
and stuff that (along with 31 remaining bits for whatever other
flags we may have, I'm thinking about 6 vs. 8 bits DACs or such
other options that are common to enough HW to be worth defining
there).

We can define a "hw_specific_flags" field. Same as above, but we
define the meaning of this field as depending on the driver. That
is, we add a way for userland to pass mode attributes (we are really
talking about mode attributes here, that should be passed along with
setting the mode) that are specific to a given driver, though the
problem of identifying the driver type may not be that simple (using
the accel type constant ?)

Or we can eventually just define a new bit in the "sync" field, that
seem to be the most economic way, since we have 32 bits available
and only 6 used so far




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
