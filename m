From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9043] New: tty not printed
	to screen
Date: Thu, 20 Sep 2007 12:04:49 -0700
Message-ID: <20070920120449.54dd5d5d.akpm@linux-foundation.org>
References: <bug-9043-10286@http.bugzilla.kernel.org/>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IYRKi-0007Uh-C5 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 20 Sep 2007 12:05:05 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IYRKe-0000dF-MX
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 20 Sep 2007 12:05:04 -0700
In-Reply-To: <bug-9043-10286@http.bugzilla.kernel.org/>
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
To: jacquejeremy@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org


(Please reply via emailed reply-to-all, not via the bugzilla web interface)

On Thu, 20 Sep 2007 05:46:34 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9043
> 
>            Summary: tty not printed to screen
>            Product: Other
>            Version: 2.5
>      KernelVersion: 2.6.23-rc7
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>         AssignedTo: other_other@kernel-bugs.osdl.org
>         ReportedBy: jacquejeremy@gmail.com
> 
> 
> Most recent kernel where this bug did not occur: 2.6.23-rc6
> Distribution: Centos 4.5 (Final)  (Careless Network V3)
> Hardware Environment: NEC PowerMate VL260
>          Output of "lspci":
> 00:00.0 Host bridge: Intel Corporation 82945G/GZ/P/PL Memory Controller Hub
> (rev 02)
> 00:02.0 VGA compatible controller: Intel Corporation 82945G/GZ Integrated
> Graphics Controller (rev 02)
> 00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1
> (rev 01)
> 00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
> Controller #1 (rev 01)
> 00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
> Controller #2 (rev 01)
> 00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
> Controller #3 (rev 01)
> 00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
> Controller #4 (rev 01)
> 00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
> Controller (rev 01)
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
> 00:1e.2 Multimedia audio controller: Intel Corporation 82801G (ICH7 Family)
> AC'97 Audio Controller (rev 01)
> 00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface
> Bridge (rev 01)
> 00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller
> (rev 01)
> 00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) SATA IDE
> Controller (rev 01)
> 00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI
> Express Gigabit Ethernet controller (rev 01)
> 
> 
> 
> Software Environment: 
>           Output of ver_linux :
> Linux careless2 2.6.23-rc7 #1 SMP Thu Sep 20 10:58:53 CEST 2007 i686 i686 i386
> GNU/Linux
> Gnu C                  3.4.6
> Gnu make               3.80
> binutils               2.15.92.0.2
> util-linux             2.12a
> mount                  2.12a
> module-init-tools      3.1-pre5
> e2fsprogs              1.35
> quota-tools            3.12.
> PPP                    2.4.2
> isdn4k-utils           3.3
> nfs-utils              1.0.6
> Linux C Library        3.4
> Dynamic linker (ldd)   2.3.4
> Procps                 3.2.3
> Net-tools              1.60
> Kbd                    1.12
> Sh-utils               5.2.1
> udev                   039
> Modules Loaded         thermal processor fan button uhci_hcd intelfb
> i2c_algo_bit rng_core i2c_i801 i2c_core r8169 dm_snapshot dm_zero dm_mirror
> dm_mod ata_piix libata sd_mod scsi_mod
> 
> 
> 
> Problem Description:
> When booting "init 3", the screen prints "ENTERING SLEEPING MODE"
> and i can't access to any console even by pressing keys.
> When booting "init 5" Xorg starts nicely and works perfectly but when
> pressing CTRL-ALT-F[1-6], the same happens : the screen prints "Entering
> sleeping mode" and i am not able to see anything.
> All the rest works perfectly so i can access on ssh to the box and  i can see a
> new user with the "who" command when logging in on tty1.
> 
> 
> Please let me know how to post attachment, i think my .config and others like
> "lspci -vvv" may be needed.
> 

I don't understnad this report much, but it sounds like a very recent
regression.

You're not actually trying to suspend the machine at the time, are you?

And it doesn't sound like the keyboard has malfunctioned?

Does anyone know where this "ENTERING SLEEPING MODE" message is coming
from?  A bit of googling makes me suspect that it is actually coming from
your monitor, which perhaps indicates that the kernel is sending incorrect
DPMS signalling to the monitor, or something like that?



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
