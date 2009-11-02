From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 3 Nov 2009 00:53:08 +0100
Message-ID: <6C8638F3-7AC7-44CC-A86E-C26E29350BD8@suse.de>
References: <1257199759-2941-1-git-send-email-agraf@suse.de>
	<20091102223249.GC22301@localhost>
	<D295329B-4DE0-4935-8C6B-D45042E72826@suse.de>
	<20091102235116.GA28292@localhost>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <agraf@suse.de>) id 1N56iF-0005vS-OW
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Nov 2009 23:53:27 +0000
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N56i3-0003y5-8B for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Nov 2009 23:53:22 +0000
In-Reply-To: <20091102235116.GA28292@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


On 03.11.2009, at 00:51, Ondrej Zajicek wrote:

> On Mon, Nov 02, 2009 at 11:42:11PM +0100, Alexander Graf wrote:
>>
>> Am 02.11.2009 um 23:32 schrieb Ondrej Zajicek  
>> <santiago@crfreenet.org>:
>>
>>> On Mon, Nov 02, 2009 at 11:09:19PM +0100, Alexander Graf wrote:
>>>> When we want to create a full VirtIO based machine, we're still
>>>> missing
>>>> graphics output. Fortunately, Linux provides us with most of the
>>>> frameworks
>>>> to render text and everything, we only need to implement a  
>>>> transport.
>>>>
>>>> So this is a frame buffer backend written for VirtIO. Using this  
>>>> and
>>>> my
>>>> patch to qemu, you can use paravirtualized graphics.
>>>
>>> Just a note: it might be useful to allow paravirtualized graphics to
>>> handle text mode. In that case, it can be done in fbdev layer using
>>> tileblit operations.
>>
>> Is there any real driver implementing this already? I'd prefer to  
>> copy
>> from working code instead of writing my own :-).
>
> Yes, for example s3fb and vt8623fb (struct fb_tile_ops).
>
>> Also, we still need to keep the local frame buffer copy in sync so we
>> can mmap and read from it, right? So it's not really worth it
>> probably...
>
> Advantages might be on Qemu side (like ability to run in text-only
> mode without need to change console on virtualized sytem).

Oh, so we could use the curses frontend. That's a neat idea.

But that also means we'll lose the penguin, right?


Alex

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
