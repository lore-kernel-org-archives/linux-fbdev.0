From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: FBDEV 2.6.0-test7 updates.
Date: Thu, 16 Oct 2003 10:19:12 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1066292352.661.114.camel@gaston>
References: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
	 <20031015162056.018737f1.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AA3Me-0000tI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 01:20:08 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1AA3Mc-0006wH-Vk
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Oct 2003 01:20:07 -0700
In-Reply-To: <20031015162056.018737f1.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Thu, 2003-10-16 at 01:20, Andrew Morton wrote:
> James Simmons <jsimmons@infradead.org> wrote:
> >
> > Here is the latest fbdev patches.
> 
> This one comes up again and again.  What should we do with it?

The fix is wrong for accelerated displays.

rinfo->pitch should be initialized previously, but then, I'm not sure
what version of radeonfb James actually has in his tree. I'm mostly
rewriting it now, though my "new" version hasn't been submited yet,
it's definitely not ready.

I could eventually submit an updated "old" version though...

Ben.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
