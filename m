From: Otto Solares <solca@guug.org>
Subject: Re: fbdev timings
Date: Tue, 16 Sep 2003 00:43:49 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030916064349.GB22758@guug.org>
References: <20030915073029.GA13799@guug.org> <Pine.GSO.4.21.0309150943050.3191-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z9ZQ-0002Nc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 23:44:16 -0700
Received: from guug.org ([168.234.203.30] helo=guug.galileo.edu)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19z9ZP-0004Zd-TT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 23:44:16 -0700
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309150943050.3191-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Mon, Sep 15, 2003 at 09:43:54AM +0200, Geert Uytterhoeven wrote:
> On Mon, 15 Sep 2003, Otto Solares wrote:
> > PS. i know 2 questions is a bad habit :) but here goes
> > the other: how can i access fbdev features like
> > acceleration from userspace? or i'm supposed to map
> > the MMIO registers and do my own voodoo?
> 
> Clear the FB_ACCELF_TEXT bit in fb_var_screeninfo.accel_flags, mmap the MMIO
> registers and do your own voodoo.

Ok, thank you.

-solca



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
