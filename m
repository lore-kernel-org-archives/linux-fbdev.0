From: Bill Shannon <bill.shannon@sun.com>
Subject: r128 driver problem
Date: Thu, 04 Nov 2004 20:34:06 -0800
Message-ID: <418B02BE.3040403@sun.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080206040104050701060506"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPvln-0003zz-6W
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 20:32:15 -0800
Received: from brmea-mail-3.sun.com ([192.18.98.34])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPvll-0003kl-UJ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 20:32:15 -0800
Received: from sfbaymail2sca.sfbay.sun.com ([129.145.155.42])
	by brmea-mail-3.sun.com (8.12.10/8.12.9) with ESMTP id iA54WCui015431
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 4 Nov 2004 21:32:12 -0700 (MST)
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
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080206040104050701060506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I'm looking for someone to help me with a problem I'm having with the
r128 driver.  See attached messages for a description of the problem.
I think I've proven that the problem is related to the driver/device,
but I don't know enough about the device and how it works to fix the
problem myself.  Any help would be much appreciated.

Thanks!

	Bill Shannon

--------------080206040104050701060506
Content-Type: message/rfc822;
 name="Attached Message"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Attached Message"

Received: from sun.com (localhost [127.0.0.1])
	by datsun.SFBay.Sun.COM (8.12.10+Sun/8.12.2) with ESMTP id i9S0kuWT023913;
	Wed, 27 Oct 2004 17:46:56 -0700 (PDT)
Message-ID: <41804180.6070602@sun.com>
Date: Wed, 27 Oct 2004 17:46:56 -0700
From: Bill Shannon <bill.shannon@sun.com>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: keith@tungstengraphics.com, anholt@FreeBSD.org
Subject: r128 driver problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi guys.  I got your names from r128_irq.c.  I'm hoping you can help
me or point me in the right direction.

I upgraded my Dell 4550 from Fedora Core 1 to Fedora Core 2 and I'm
having problems that I reported here:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=132930

I've been trying to debug this myself and so far it looks like
as soon as the r128 driver is closed, I get a flood of interrupts
that aren't handled, eventually causing the kernel to disable
IRQ 11.  My theory is that these are VBLANK interrupts from the
video card that are no longer handled because the r128 interrupt
handler has been removed from the IRQ handler list.  It's pretty
clear that the driver is attempting to disable such interrupts
before removing the driver from the list.  I don't know anything
about how this device works so I can't say whether or not it's
doing that correctly.

I've tried hacking the IRQ handler to call back into the r128 driver
when it finds that the IRQ hasn't been handled by any of the drivers
on the list, so that the r128 driver can determine if it was the
cause of the interrupt after all.  Unfortunately, I don't understand
enough about how devices work in Linux (or on x86 hardware) and I
can't seem to get this to work.  As soon as I try to touch the device
the kernel hangs.

I noticed that in FC1 the r128 driver didn't appear to use interrupts.
That seems to be a capability added in the 2.6 kernel, in the r128_irq.c
file that has your names in it!  :-)  So that would explain why FC1 works
fine on the same hardware.

Oh, and I've tried all the frequently recommended tips like booting with
pci=noacpi and acpi=off.  They don't make any difference.

Anyway, I was hoping that one of you might have some idea of what the
problem might be or what I could do to further debug the problem.

Oh yes, the video card is an "ATI Rage 128 Pro Ultra".

Thanks for any help you might offer!

	Bill Shannon


--------------080206040104050701060506
Content-Type: message/rfc822;
 name="Attached Message"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Attached Message"

Received: from sfbaymail1sca.SFBay.Sun.COM (sfbaymail1sca [129.145.154.35])
	by datsun.SFBay.Sun.COM (8.12.10+Sun/8.12.2) with ESMTP id i9S69kWT025705
	for <shannon-record@datsun.SFBay.Sun.COM>; Wed, 27 Oct 2004 23:09:46 -0700 (PDT)
Received: from nissan.sfbay.sun.com (vpn-129-150-16-112.SFBay.Sun.COM [129.150.16.112])
	by sfbaymail1sca.SFBay.Sun.COM (8.12.10+Sun/8.12.10/ENSMAIL,v2.2) with ESMTP id i9S6BWEG007274;
	Wed, 27 Oct 2004 23:11:32 -0700 (PDT)
Received: from sun.com (micron [192.168.1.5])
	by nissan.sfbay.sun.com (8.12.10+Sun/8.12.5) with ESMTP id i9S6A2GF003014;
	Wed, 27 Oct 2004 23:10:02 -0700 (PDT)
Message-ID: <41808DB9.9030900@sun.com>
Date: Wed, 27 Oct 2004 23:12:09 -0700
From: Bill Shannon <bill.shannon@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: keith@tungstengraphics.com, anholt@FreeBSD.org
Subject: Re: r128 driver problems
References: <41804180.6070602@sun.com>
In-Reply-To: <41804180.6070602@sun.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ok, I think I've now proven that my ATI Rage 128 device is generating
interrupts even after the r128 driver disables interrupts.

In r128_driver_irq_uninstall, after it writes to the device to
disable interrupts, I set a global variable that says interrupts
are disabled.  I then use vblank_wait to wait for the next
vblank interrupt.  If interrupts were really disabled, I would
expect vblank_wait to return indicating that the timeout expired.
It doesn't, it returns success.

In r128_dma_service, if I get an interrupt while the global
"interrupts are disabled" flag is set, I increment a counter.
After vblank_wait returns in r128_driver_irq_uninstall, I
check the count.  It indicates that an interrupt was received
after interrupts were disabled.

To me, that looks like proof that there's something wrong here.
Maybe the hardware is broken, or maybe it's just not working
the way the driver expects.  Or maybe the driver is not doing
the right thing to really disable interrupts.

At this point I need some help.  Are either of you the right
person to help?  If not, can you point me to someone else who
might be able to help?

Thanks much!

	Bill Shannon

--------------080206040104050701060506--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
