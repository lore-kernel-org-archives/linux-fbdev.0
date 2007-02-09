From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/10] ps3: AV Settings Driver
Date: Fri, 9 Feb 2007 01:17:23 -0800
Message-ID: <20070209011723.34d1013f.akpm@linux-foundation.org>
References: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702081458190.19437@pademelon.sonytel.be>
	<20070208203014.GB2579@lst.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HFRtN-0001tP-Bz for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Feb 2007 01:18:06 -0800
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1HFRtK-000372-TB
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Feb 2007 01:18:05 -0800
In-Reply-To: <20070208203014.GB2579@lst.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Christoph Hellwig <hch@lst.de>
Cc: James Simmons <jsimmons@infradead.org>, Linux/PPC Development <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>, Linux@sc8-sf-spam2.sourceforge.net, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 8 Feb 2007 21:30:14 +0100 Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Feb 08, 2007 at 02:58:31PM +0100, Geert Uytterhoeven wrote:
> > Add the PS3 AV Settings Driver.
> > 
> > The AV Settings driver is used to control Audio and Video settings.
> > It communicates with the policy manager through the virtual uart.
> 
> please don't use kernel_thread for new code, but rather kthread_create/
> ktread_run.  And check the possible errors it can return :)

yup.

Plus basically every kernel thread needs a try_to_freeze().

> Using the kthread infrastructure also means you'll have to redo your
> synchronisation scheme as it doesn't work very well with this use
> of semaphores.  But that's a good thing as these useages are not
> easily parseable for most kernel hackers despite beeing tought in
> OS101 :)

Does it actually use sempahores in their counting mode?  If not, mutexes
are preferred.

ps3av_do_pkt() allocates 512 bytes on stack which might be a bit excessive
if you're using a 4k stack.  Especially if that function or a callee does a
__GFP_FS memory allocation.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
