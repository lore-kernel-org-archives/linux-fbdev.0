From: Bill Unruh <unruh@physics.ubc.ca>
Subject: Re: [Bugme-new] [Bug 12300] New: The VGA
 console driver does not work with the Panasonic W7 (Intel 965 video)
Date: Sat, 27 Dec 2008 10:18:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0812271015400.19292@info.physics.ubc.ca>
References: <bug-12300-10286@http.bugzilla.kernel.org/>
	<20081225202510.3bfb7a4d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <unruh@physics.ubc.ca>) id 1LGdjz-0006aA-P2
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 27 Dec 2008 18:18:23 +0000
Received: from info.physics.ubc.ca ([142.103.234.23])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LGdjw-0001bj-IS for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 27 Dec 2008 18:18:23 +0000
In-Reply-To: <20081225202510.3bfb7a4d.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org


I have now used the vga=ask  kernel parameter and tried a large fraction of the VESA modes and
the VGA modes listed. (7 VGA modes F00-F03 F05-7 and 9 VESA modes
305 307 318 312 314 315 301 303 311) .  None of the VESA modes I tried worked
. All of the VGA modes I tried work.
By work I mean display anything after the mode is selected
  In the VESA modes the screen is
simply blank.-- no cursor, no nothing. In the VGA modes, text appears,
scrolling
by (various kernel reports during the startup). Ie, the kernel's handling of
the VESA modes on this system do not seem to work at all.

I have no idea if the fault lies within the kernel or whether Mandriva did
something to the kernel. Note again that the xorg drivers work fine, as X
works and displays.

On Thu, 25 Dec 2008, Andrew Morton wrote:

>
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
>
> On Thu, 25 Dec 2008 19:22:25 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:
>
>> http://bugzilla.kernel.org/show_bug.cgi?id=12300
>>
>>            Summary: The VGA console driver does not work with the Panasonic
>>                     W7 (Intel 965 video)
>>            Product: Drivers
>>            Version: 2.5
>>      KernelVersion: 2.6.24.4
>>           Platform: All
>>         OS/Version: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: blocking
>>           Priority: P1
>>          Component: Console/Framebuffers
>>         AssignedTo: jsimmons@infradead.org
>>         ReportedBy: unruh@physics.ubc.ca
>>
>>
>> Latest working kernel version:Unknown
>> Earliest failing kernel version: At least 2.6.17
>> Distribution:Mandriva 2007.1-2008.1
>> Hardware Environment:Panasonic toughbook W7
>> Software Environment:Mandriva 2008.1 installation
>> Problem Description:
>> When I try to install Mandriva 2008.1 onto a Panasonic Toughbook W7 after
>> intial splash sceen ( which displays presumably because it uses the bios) and
>> the loading of the kernel, the screen goes blank. This seems to be because the
>> kernel is unable to actually display any of the text in the VGA console mode
>> onto the screen. If I make menu choices blindly, the DVD disk is read.
>>
>> When I used the MCNLinux Toronto ( based on the Mandriva 2007.1 with the 2.6.17
>> kernel) after the kernel loads I see nothing until finally X is started and it
>> displays fine. If I do alt-ctrl-F1 (or F2 or ..) ( which should open a console
>> screen) I again see nothing. This makes me think strongly that the problem is
>> taht somehow the console VGA driver within the kernel is not working, although
>> the xorg video card works fine (since X displays without problem). Of course
>> not having the VGA console output makes it impossible to actually install
>> Mandriva or any Linux onto the system.
>> The Panasonic toughbook line has been wonderful with Linux, until the W7.
>>
>> Perhaps there are some kernel options I could try, to see where the problem
>> lies, but have no idea what they might be (I tried to remove the vga=788 kernel
>> option but that made no difference, nor did putting in vga=normal)
>>
>> How in the world can bog standard VGA not work?
>>
>> Steps to reproduce: See above.
>

-- 
William G. Unruh   |  Canadian Institute for|     Tel: +1(604)822-3273
Physics&Astronomy  |     Advanced Research  |     Fax: +1(604)822-5324
UBC, Vancouver,BC  |   Program in Cosmology |     unruh@physics.ubc.ca
Canada V6T 1Z1     |      and Gravity       |  www.theory.physics.ubc.ca/

------------------------------------------------------------------------------
