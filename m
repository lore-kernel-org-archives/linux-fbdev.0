From: Robert Siemer <Robert.Siemer@backsla.sh>
Subject: Re: [PATCH 2.6.17-1] radeonfb: use generic ddc
	read functionality
Date: Thu, 22 Jun 2006 02:22:36 +0200
Message-ID: <20060622002236.GB20522@polar.elf12.net>
References: <08F6FAE0-AA73-44C4-B9B8-CB76508D24FF@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtCyB-0008Ax-CO for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 17:22:58 -0700
Received: from backsla.sh ([217.160.178.134])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FtCy9-000264-J4
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 17:22:51 -0700
Content-Disposition: inline
In-Reply-To: <08F6FAE0-AA73-44C4-B9B8-CB76508D24FF@cecropia.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Wed, Jun 21, 2006 at 04:52:06PM -0400, Dennis Munsie wrote:
> hello --
> 
> here is that patch i promised in my last email.  This simply changes  
> the radeonfb driver from using it's current method of reading the  
> EDID block to using the new functionality that I put into fbmon.c.   
> I've been able to test it on a radeon card I have here, and it  
> appears to work just fine.  Again, I would like to get some feedback  
> from other people that I haven't broke it for their configuration.

Really? I got no comment on my email... <-:

I switched from 2.6.14 to 2.6.16 and trusted the DDC code. - radeonfb
switched to a 200Hz refresh mode. My monitor can handle only 160Hz.
I'm still not sure if the monitor is to blame but it makes not a real
differance:

There should be a 100 or 120Hz cut-off as more is not better but worse
(energy consumption, monitor aging).

I just booted a DDC enabled kernel with cmdline
video=radeonfb:1024x768@100, works fine...

Okay, the faulty seems my monitor:

ddcprobe (from edid: line on) says:
edid: 
edid: 1 1
id: 0202
eisa: EIZ0202
serial: 00000000
manufacture: 2 1996
input: separate sync, composite sync, sync on green, analog signal.
screensize: 31 23
gamma: 1.800000
dpms: RGB, active off, suspend, standby
timing: 800x600@60 Hz (VESA)
timing: 800x600@72 Hz (VESA)
timing: 1024x768@70 Hz (VESA)
monitorid: 7 V
dtiming: 1x1@642500
dtiming: 1x1@642500
dtiming: 1x1@642500


Okay, worthless. Maybe there should be just some sanity checking which
in my case would skip the dtiming values... Just for people with old
hardware combinations!? (In my very case there is no workaround a video=
line... Shame on EIZO.)

Something like minimal resolution, e.g. 320x160?
Some future prove max resolution: 10240x7680
Refresh cut-offs: 20-120Hz

Or at least a documentation file in the kernel/Documentation/fb/ tree
telling about the general fb kernel command line arguments. These could
include a "ddc=off" or a "ddc=debug". The latter would print the EDID
values without using them. The printing could be default...


Bye,
	Robert

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
