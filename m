From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: New radeonfb 0.2.0 (take 2)
Date: Tue, 09 Sep 2003 18:17:17 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1063124237.1356.1.camel@gaston>
References: <20030909155822.47988.qmail@web14904.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wlBl-0005yJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 09:17:57 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19wlBk-00034p-Mg
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 09:17:57 -0700
In-Reply-To: <20030909155822.47988.qmail@web14904.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Kronos <kronos@kronoz.cjb.net>

On Tue, 2003-09-09 at 17:58, Jon Smirl wrote:
> --- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > On Tue, 2003-09-09 at 16:52, Jon Smirl wrote:
> > What would 'base' be without all of this ? just the PCI probing ?
> > 
> Base does PCI IDs, EDID, mode setting, command parsing, maybe hardware cursor,
> VT switching and state saving.
> Second piece does fbcon support such as mapping fb to kernel space, fb accels,
> etc.

The current fbdev layer, afaik, impose vt switching, mode setting,
cursor support etc... to imply fbcon. The mapping of fb is just a
2 liner remaining that isn't worth a separate module.

Also, the accel API in 2.6 is meant to be used by more than just
fbcon afaik.

James, can you comment on this ?

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
