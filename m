From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: New radeonfb, mostly untested
Date: Fri, 12 Sep 2003 21:36:03 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030912193603.GA16977@dreamland.darkstar.lan>
References: <1063229555.678.10.camel@gaston> <Pine.LNX.4.44.0309121841050.5017-100000@phoenix.infradead.org>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xtje-0004w1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 12:37:38 -0700
Received: from mail-2.tiscali.it ([195.130.225.148])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xtjd-0006rP-K1
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 12:37:37 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309121841050.5017-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Fri, Sep 12, 2003 at 06:43:19PM +0100, James Simmons ha scritto: 
> > > mode 19 comes from get_detailed_timing, while 18 comes from
> > > get_std_timing and timings are calculated by calc_mode_timings (which in
> > > turn calls fb_get_mode). Any chance that there is some error in
> > > fb_get_mode?
> > 
> > I don't know the details about mode calculation and I never had any VESA
> > spec, ask James here...
> 
> I might be missing something jumping in the middle of the discussing but 
> there is a GTF paper on creating VESA modes including from stratch 
> without edid. The modes generated are pretty close to the standard VESA 
> modes. 

The problem is that mode calculated by fb_get_mode is different from the
one that comes from get_detailed_timing.

Also, modes  from fb_get_mode  are different from  XFree modes  so every
time I switch from console to X I have to re-center the screen.

This happens only when modedb is created from edid, not when using the
standard modedb.

Currently create_modedb is unused (the new radeon driver is the first
user of edid stuff) so we may be hitting a real bug.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
#include <stdio.h> 
int main(void) {printf("\t\t\b\b\b\b\b\b");
printf("\t\t\b\b\b\b\b\b");return 0;}


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
