From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: New radeonfb 0.2.0 (take 2)
Date: Tue, 9 Sep 2003 08:58:22 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030909155822.47988.qmail@web14904.mail.yahoo.com>
References: <1063120961.647.3.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wkst-0003om-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 08:58:27 -0700
Received: from web14904.mail.yahoo.com ([216.136.225.56])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19wksr-0002Be-Eu
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 08:58:25 -0700
In-Reply-To: <1063120961.647.3.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Kronos <kronos@kronoz.cjb.net>

--- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Tue, 2003-09-09 at 16:52, Jon Smirl wrote:
> What would 'base' be without all of this ? just the PCI probing ?
> 
Base does PCI IDs, EDID, mode setting, command parsing, maybe hardware cursor,
VT switching and state saving.
Second piece does fbcon support such as mapping fb to kernel space, fb accels,
etc.

Base is not meant to be used as a standalone driver. It will always be used in
conjunction with FB or DRI driver. 


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
