From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Mon, 2 Nov 2009 23:42:11 +0100
Message-ID: <D295329B-4DE0-4935-8C6B-D45042E72826@suse.de>
References: <1257199759-2941-1-git-send-email-agraf@suse.de>
	<20091102223249.GC22301@localhost>
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <agraf@suse.de>) id 1N55be-0007h7-Dq
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Nov 2009 22:42:34 +0000
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N55bX-0004o5-Hh
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Nov 2009 22:42:34 +0000
In-Reply-To: <20091102223249.GC22301@localhost>
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
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>


Am 02.11.2009 um 23:32 schrieb Ondrej Zajicek <santiago@crfreenet.org>:

> On Mon, Nov 02, 2009 at 11:09:19PM +0100, Alexander Graf wrote:
>> When we want to create a full VirtIO based machine, we're still  
>> missing
>> graphics output. Fortunately, Linux provides us with most of the  
>> frameworks
>> to render text and everything, we only need to implement a transport.
>>
>> So this is a frame buffer backend written for VirtIO. Using this  
>> and my
>> patch to qemu, you can use paravirtualized graphics.
>
> Just a note: it might be useful to allow paravirtualized graphics to
> handle text mode. In that case, it can be done in fbdev layer using
> tileblit operations.

Is there any real driver implementing this already? I'd prefer to copy  
from working code instead of writing my own :-).

Also, we still need to keep the local frame buffer copy in sync so we  
can mmap and read from it, right? So it's not really worth it  
probably...

Alex

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
