From: Otto Solares <solca@guug.org>
Subject: Re: Merge of Luca and Ben's sysfs work for Radeon
Date: Thu, 25 Sep 2003 13:21:16 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030925192116.GA9615@guug.org>
References: <20030925060524.24191.qmail@web14909.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2bgb-0002Cz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 12:21:57 -0700
Received: from guug.org ([168.234.203.30] helo=guug.galileo.edu)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A2bga-0005C5-Hk
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Sep 2003 12:21:56 -0700
Content-Disposition: inline
In-Reply-To: <20030925060524.24191.qmail@web14909.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Sep 24, 2003 at 11:05:24PM -0700, Jon Smirl wrote:
> Here is a sample of what sysfs looks like with the new radeon driver. I have an
> Intel 875 chipset so there are three buses: 0 - system, 1 - AGP, 2 - PCI. Note
> that the EDID block is available.

This is so cool!

> I was thinking about adding these attributes to the fb device: geometry,
> timings, interlaced, hsync, vsync. and then writing a new fbset command.

Plz add that too as is useful info, and has the potential to remove a lot
of ioctls in userspace code.

Where can i grab these changes?, are these radeon specific? what about r128?

Thanks in advance.

-solca



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
