From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: fb_defio with a coherent DMA framebuffer
Date: Fri, 26 Dec 2008 11:22:58 +0900
Message-ID: <aec7e5c30812251822u2b593432n1d76083eeaa56760@mail.gmail.com>
References: <8CF9D79FB605004381900048F600598803352F5D72@mucse405.eu.infineon.com>
	<45a44e480812251243w5f5ece16s9c480fa3499dac4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <magnus.damm@gmail.com>) id 1LG2Lt-00068r-Iv
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Dec 2008 02:23:01 +0000
Received: from rv-out-0708.google.com ([209.85.198.250])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LG2Lr-0003uI-Hx for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Dec 2008 02:23:01 +0000
Received: by rv-out-0708.google.com with SMTP id f25so3243714rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 25 Dec 2008 18:22:58 -0800 (PST)
In-Reply-To: <45a44e480812251243w5f5ece16s9c480fa3499dac4a@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Nick.Thompson@infineon.com

On Fri, Dec 26, 2008 at 5:43 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Fri, Dec 12, 2008 at 8:00 PM,  <Nick.Thompson@infineon.com> wrote:
>> Is fb_defio supposed to work with DMA memory? I saw a thread from over a year ago about defio's nopage (we're still using 2.6.24) being written to use driver supplied flags to specify what memory allocation type nopage is dealing with. Was this not implemented or not deemed necessary? I would be very interested to hear any suggestions about how we should tackle making this work.
>
> The current defio code does not work with DMA memory. This has been
> recently rectified by Magnus Damm. This effort is still in progress in
> some areas but I think it is usable. As for using 2.6.24, my response
> to that would be: Why? We're on 2.6.28 and defio has seen a reasonable
> amount of change since 24. :-)

The patch that Jaya referrers to simply adds support for physically
contiguous frame buffers. This means that the frame buffer is
contiguous both in virtual space and physical space. Your frame buffer
memory must be backed with struct page though. The patch can be found
here:

http://thread.gmane.org/gmane.linux.ports.sh.devel/5012/focus=5015

However, your coherent memory may or may not be backed by struct page.
Some types of memories may have pfn mappings only. If your memory is
backed by struct page or not depends on your coherent DMA memory
implementation. On SuperH we use __get_free_pages() and split_page()
unless dma_declare_coherent() has been used. This works well for me.
Have a look at arch/sh/mm/consistent.c and kernel/dma-coherent.c in a
recent kernel.

Cheers,

/ magnus

------------------------------------------------------------------------------
