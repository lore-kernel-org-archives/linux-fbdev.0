From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: [PATCH] 0/3 Add I2C/DDC support to radeonfb
Date: Wed, 27 Aug 2003 08:17:34 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030827151734.24986.qmail@web14912.mail.yahoo.com>
References: <1061988259.1290.59.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19s23I-0003pf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 27 Aug 2003 08:17:40 -0700
Received: from web14912.mail.yahoo.com ([216.136.225.248])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19s23H-000591-Lv
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Aug 2003 08:17:39 -0700
In-Reply-To: <1061988259.1290.59.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kronos@kronoz.cjb.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

Kronos and I have a version with I2C, ROM instead of low RAM, error cleanups,
and many more PCI IDs at:
bk://mesa3d.bkbits.net/linux-2.5

I am running that version right now without problem.

--- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Fri, 2003-08-22 at 18:24, Kronos wrote:
> > In reply to this mail I'll send 3 patches that add i2c to radeonfb.
> 
> Just a note to tell that I didn't forget about this, but didn't finish
> yet neither. I'll post a new version of radeonfb with major cleanups
> (splitted) real soon now which include the i2c stuffs hopefully.
> 
> Ben.
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
