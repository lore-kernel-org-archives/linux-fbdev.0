From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Console rotation problems
Date: Thu, 24 Nov 2005 12:47:11 +1100
Message-ID: <1132796831.26560.392.camel@gaston>
References: <1132793150.26560.357.camel@gaston>
	 <1132793556.26560.361.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ef6GO-0003AD-RN
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Nov 2005 17:51:04 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Ef6GN-0002wI-Ka
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Nov 2005 17:51:05 -0800
In-Reply-To: <1132793556.26560.361.camel@gaston>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@gmail.com
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Thu, 2005-11-24 at 11:52 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2005-11-24 at 11:45 +1100, Benjamin Herrenschmidt wrote:
> > Hi Antonio !
> > 
> > I decided to give a quick test to console rotation on my g5 (radeonfb)
> > and couldn't get it to work.
> > 
> > When I tried echo'ing something in con_rotate, something very strange
> > happened:
> > 
> > pogo:/sys/class/graphics/fb0# echo "1" >con_rotate
> > benh@pogo:~$
> 
>   .../...
> 
> And here is the Oops that explains the shell exit and that I didn't see
> the first time :)
> 
> Trap 0x600 is an alignment exception, which is a bit weird, I'll try to
> dig a bit more, it could be a problem with the alignment trap handler on
> ppc.

Ok, looks like an unaligned set_bit() or atomic_or(). You can't do
atomic operations on non-aligned quantities. Let me check the code ...

OUCH !

Is there any reason why you are using set_bit & friends all over the
place over there in fbcon_rotate.h ? Are you actually trying to perform
atomic operations ?

set_bit(), clear_bit() etc... are

1) atomic. that mean slow, won't work on uncached memory (like
framebuffer), and won't work if not aligned propertly

2) won't guarantee the bit position, they are consistent within an
architecture but not accross.

If you want bit manipulation of pixel data, use your own routines, using
set_bit/clear_bit & friends is completely bogus.

The __xxx versions will fix 1), but not 2) btw.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
