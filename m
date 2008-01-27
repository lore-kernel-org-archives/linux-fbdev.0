From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Fw: [Bugme-new] [Bug 9822] New: mdacon
 messing up console on hw w/o MDA adapter
Date: Sun, 27 Jan 2008 10:29:48 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801271029010.6515@anakin>
References: <20080126222433.e1c662d5.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JJ3pv-0002CB-I8 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 Jan 2008 01:29:59 -0800
Received: from ananke.telenet-ops.be ([195.130.137.78])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JJ3pr-000473-6F
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 Jan 2008 01:29:56 -0800
In-Reply-To: <20080126222433.e1c662d5.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 26 Jan 2008, Andrew Morton wrote:
> Begin forwarded message:
> 
> Date: Sat, 26 Jan 2008 06:00:42 -0800 (PST)
> From: bugme-daemon@bugzilla.kernel.org
> To: bugme-new@lists.osdl.org
> Subject: [Bugme-new] [Bug 9822] New: mdacon messing up console on hw w/o MDA adapter
> 
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=9822
> 
>            Summary: mdacon messing up console on hw w/o MDA adapter
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.24 and before
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: low
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: devzero@web.de
> 
> 
> Latest working kernel version: didn`t try before 
> Earliest failing kernel version: don`t know, but may exist for a long time
> Distribution: openSuSE
> Hardware Environment: various (e.g. FSC Scenic T 1Ghz i815 PC, FSC Lifebook,
> VMware Workstation)
> Software Environment: -
> 
> Problem Description:
> loading mdacon on a system without MDA adapter screws up the console window. i
> cannot use it afterwards. i would have expected some "no mda adapter found" and
> a clean exit afterwards.
> 
> Steps to reproduce:
> modprobe mdacon
> 
> also see:
> http://marc.info/?l=linux-kernel&m=120082731013963&w=2
> http://uwsg.indiana.edu/hypermail/linux/kernel/0203.3/0524.html
> 
> 
> same issue with cfag12864bfb. behaviour is a little bit different, but console
> is also unusable afterwards.

Cfag12864bfb uses a plain platform device, which doesn't seem to do any
checking for the presence of the appropriate hardware.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
