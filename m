From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: Re: Re: Fbdev magics
Date: Tue, 11 May 2004 00:40:29 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200405110040.29985.lucasvr@gobolinux.org>
References: <200405050027.58630.lucasvr@terra.com.br> <200405070026.54372.lucasvr@gobolinux.org> <200405072133.37300.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNO8A-0004ru-4i
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 May 2004 20:40:34 -0700
Received: from chiapa.terra.com.br ([200.154.55.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BNO89-0004N3-Mb
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 May 2004 20:40:33 -0700
Received: from tucuman.terra.com.br (tucuman.terra.com.br [200.154.55.139])
	by chiapa.terra.com.br (Postfix) with ESMTP id A19D3EC434
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 May 2004 00:40:28 -0300 (BRT)
Received: from ummagumma.ozzmosis.net (200-203-051-117.nhoce7002.dsl.brasiltelecom.net.br [200.203.51.117])
	(authenticated user lucasvr)
	by tucuman.terra.com.br (Postfix) with ESMTP id 7C2683C002
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 May 2004 00:40:28 -0300 (BRT)
In-Reply-To: <200405072133.37300.adaplas@hotpop.com>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

On Friday 07 May 2004 10:33, Antonino A. Daplas wrote:
> On Friday 07 May 2004 11:26, Lucas Correia Villa Real wrote:
> > On Thursday 06 May 2004 06:17, Geert Uytterhoeven wrote:
> > ...
> >
> >
> > I've seen some LCD display drivers for embedded devices that handled it
> > directly with request_irq() on 2.4. As I could see from the bottom layers
> > of fbdev, an interrupt handler in a driver doesn't seem to hurt anyone
> > there.. or am I wrong?
>
> Within the console, you probably can't use interrupts, at least in 2.4.x.
> However, there are patches around that uses an interrupt service especially
> with waiting for vrefresh.  I've done it with the i810fb (around 2.4.18),
> and I think matroxfb has one too.

Hi Tony,

I took a read into drivers/char/console.c, but it isn't clear to me why it's 
not possible (or better yet, advised) to install interrupt handlers within 
the console. Is it because tty devices are already called from interrupts?

Cheers,
Lucas


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
