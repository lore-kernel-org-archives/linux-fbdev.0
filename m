From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: Re: Screen Refresh
Date: Wed, 5 May 2004 12:46:11 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200405051246.11464.lucasvr@gobolinux.org>
References: <200405051047.00127.lucasvr@gobolinux.org> <20040505140257.GI29503@lug-owl.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLOdq-0001WP-IF
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 May 2004 08:49:02 -0700
Received: from ibague.terra.com.br ([200.154.55.225])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLOdq-0000uc-7B
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 May 2004 08:49:02 -0700
Received: from tucuman.terra.com.br (tucuman.terra.com.br [200.154.55.139])
	by ibague.terra.com.br (Postfix) with ESMTP id 779C0EDE11
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  5 May 2004 12:46:04 -0300 (BRT)
Received: from ummagumma.ozzmosis.net (200-203-051-117.nhoce7002.dsl.brasiltelecom.net.br [200.203.51.117])
	(authenticated user lucasvr)
	by tucuman.terra.com.br (Postfix) with ESMTP id 498E83C038
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  5 May 2004 12:46:04 -0300 (BRT)
In-Reply-To: <20040505140257.GI29503@lug-owl.de>
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

On Wednesday 05 May 2004 11:02, Jan-Benedict Glaw wrote:
> On Wed, 2004-05-05 10:47:00 -0300, Lucas Correia Villa Real
> <lucasvr@gobolinux.org>
>
> wrote in message <200405051047.00127.lucasvr@gobolinux.org>:
> > I'm writing a device driver for a monochrome LCD display managed by a
> > controller that will be plugged into the CPU through a SPI, that is, I
> > cannot directly memory-map it's address, since the communication will be
> > done via a serial interface.
>
> So I see two ways.
>
> 	If you only want to be able to output text, then you'd register
> as a console device. You'll then get write accesses, which you can then
> promote to real hardware.
>
> 	If you really want to provide a graphical display, you'll need
> something like two buffers (one the kernel writes to, probably a 2nd one
> to store the "current" image to only send down the changed pixels).
> That'll come along with some timed function - not nice, but may work.
>
> In theory, you'd try to not actually provide a framebuffer (memory), but
> to simply give pointers to all those accelerated functions. If you've
> got enough luck, you'll only see these functions called, so that you can
> do graphics with merely no overhead of polling the whole memory...

Hmm, that's a good idea! I'll need to have graphical display, so I think I'll 
start by writing a first release using this double buffering technique, and 
later try to play with accelerated functions.

Thanks for the help!
Lucas


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
