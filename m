From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [Linux-fbdev-devel] Generic VESA framebuffer driver and Videocard BOOT?
Date: Sat, 16 Oct 2004 02:14:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <88056F38E9E48644A0F562A38C64FB60031D9F43@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268695AbUJPJPY@vger.kernel.org>
Content-class: urn:content-classes:message
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: ncunningham@linuxmail.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, penguinppc-team@lists.penguinppc.org


>-----Original Message-----
>From: Nigel Cunningham [mailto:ncunningham@linuxmail.org] 
>Sent: Saturday, October 16, 2004 2:02 AM
>To: Pallipadi, Venkatesh
>Cc: Geert Uytterhoeven; Linux Frame Buffer Device Development; 
>Linux Kernel Development; penguinppc-team@lists.penguinppc.org
>Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer 
>driver and Videocard BOOT?
>
>Hi.
>
>On Sat, 2004-10-16 at 04:29, Venkatesh Pallipadi wrote:
>> > Why not? Of course you won't get any output before the 
>graphics card has been
>> > re-initialized to a sane and usable state...
>> > 
>> 
>> True. I do it on my Dell 600m (Radeon 9000M) using usermodehelper and
>> it works just fine. It works both with VGA and X. I need to split up
>> the thaw_processes into two stages though. It may not work with fb as
>> fb driver resumes earlier. I use the patch below for the kernel and a
>> userlevel x86 emulator.
>> 
>> I have to say though, it will help if we have a such an 
>emulator in the kernel.
>
>Just a quick question: is this the right way to distinguish kernel
>threads? I've been checking if the process has an mm context 
>(if p->mm).
>
>> +		if (p->parent->pid != 1)
>> +			continue;
>

I guess p->mm is a better way to catch all kernel threads. My check
above actually catches all daemons (even userspace daemons like acpid). 

Thanks,
Venki
