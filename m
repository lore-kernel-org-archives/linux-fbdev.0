From: "Sottek, Matthew J" <matthew.j.sottek@intel.com>
Subject: RE: Adding an fb_sync() operation to fb_ops
Date: Mon, 3 Jun 2002 08:49:25 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <2B4461BF89BAD511A86100508B66D53802080A3C@fmsmsx112.fm.intel.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from fmr01.intel.com ([192.55.52.18] helo=hermes.fm.intel.com)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Eu5O-0005Uc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 03 Jun 2002 08:49:35 -0700
Received: from talaria.fm.intel.com (talaria.fm.intel.com [10.1.192.39])
	by hermes.fm.intel.com (8.11.6/8.11.6/d: outer.mc,v 1.48 2002/05/24 00:39:04 root Exp $) with ESMTP id g53Fnx325948
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 3 Jun 2002 15:49:59 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxv043-1.fm.intel.com [132.233.48.128])
	by talaria.fm.intel.com (8.11.6/8.11.6/d: inner.mc,v 1.22 2002/05/24 00:38:22 root Exp $) with SMTP id g53FrGP20748
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 3 Jun 2002 15:53:16 GMT
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Antonino Daplas' <adaplas@pol.net>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, 'James Simmons' <jsimmons@transvirtual.com>


>> This depends. For traditional MMIO we need to sync up. For async DMA,
Ring
>> buffers, and FIFOs we don't need to sync up. That is why I have no hooks
>> for syncing. I figure drivers can call the syncing functions if they need
>> it inside their own accel functions.

>Is it the other way around, async DMA, ringbuffers, and FIFOS that will
>need the syncing?

Tony is correct. I think James got it backwards.

When you have DMA, Ring Buffers, Fifo's you don't know that the command
has happened, you only know that it went into one of the aforementioned
structures. (And actually in the case are DMA buffers you don't even know
that the DMA buffer will ever be processes, which leads to the need for
flush()  in order to keep this simple we can just make sure that doesn't
happen)

So here is the obvious problem case.

Application mmap's the framebuffer.
Application Draws some pixels into the framebuffer.
Application issues an ioctl that would lead to a blit, the command is put
 in a ring buffer but hasn't happened yet.
The application draws some more pixels (via the mmap) in a region that
 intersects the previously blitted region.
The hardware gets around to the blit command and overwrites the pixels you
  just put in the frambuffer.


This is quite likely to happen when mixing direct access with asynchronous
commands. It is also possible with synchronous commands but not as likely.
The blitter does take time to process so if you access the framebuffer
during the blit you could get mixed results. (And I hear that this can
actually hang some hardware)

-Matt

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
