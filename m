From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Framebuffer with banked memory
Date: 31 Oct 2002 08:36:08 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1036024565.808.27.camel@daplas>
References: <20021030104922.6612.qmail@web14206.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1873OO-000367-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Oct 2002 16:41:01 -0800
Received: from AP-202-70-99-53.compass.com.ph (AP-202-70-99-53.compass.com.ph [202.70.99.53])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id IAA27914
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 31 Oct 2002 08:40:57 +0800 (PHT)
	(envelope-from adaplas@pol.net)
In-Reply-To: <20021030104922.6612.qmail@web14206.mail.yahoo.com>
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2002-10-30 at 18:49, alain volmat wrote:
> Hi,
> 
> As I said the video card I am now writing a
> framebuffer for, doesn't have linear memory, which
> means that I can only access a small part of the
> memory at a time and then set offset registers in
> order to access another part of the memory.
> 
> I would like to know if there is such case in current
> framebuffer drivers ?? If so, what is the common
> solution to do that ??
None in the current drivers.  

> 
> In fact the problem remains in the case of mmap (which
> is the most common ;( of course), since the memory
> seams to be accessed directly by pointer, there might
> be no wait to detect if we need to set or not an
> offset. In case of fb_read fb_write, it is possible to
> do that before the actual write at the end (even if it
> is not sooo beautiful ... ).
The safest solution is to create custom fb_write? and fb_read? routines.
Maybe James will add these hooks for hardware like yours.
Then disallow mmap's except probably for the MMIO regions.

Creating a bank-switching mechanism, besides entailing a lot of work, is
not entirely safe.

Tony

PS:  What's your hardware?





-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
