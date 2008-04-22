From: "Scott D. Davilla" <davilla@4pi.com>
Subject: Re: deprecating fix->mmio_start and smem_start
Date: Tue, 22 Apr 2008 14:52:59 -0400
Message-ID: <p0623091ec433e2bacafc@[192.168.2.55]>
References: <1208827046.9640.73.camel@pasglop>
	<Pine.LNX.4.64.0804220951380.14102@anakin>
	<p0623091ac433bc15bc29@[192.168.2.55]>
	<Pine.LNX.4.64.0804222011140.9710@anakin>
	<p0623091dc433dce76d94@[192.168.2.55]>
	<Pine.LNX.4.64.0804222043110.9710@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JoNcM-0003tA-Gw for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 11:53:26 -0700
Received: from mx.4pi.com ([24.172.19.59])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JoNcJ-0008CF-10
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 11:53:26 -0700
In-Reply-To: <Pine.LNX.4.64.0804222043110.9710@anakin>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

>On Tue, 22 Apr 2008, Scott D. Davilla wrote:
>>  > On Tue, 22 Apr 2008, Scott D. Davilla wrote:
>>  > >  >On Tue, 22 Apr 2008, Benjamin Herrenschmidt wrote:
>>  > >  >>  We currently have a problem with those two members of struct
>>  > >  >>  fb_fix_screeninfo. The struct contains an "unsigned long" 
>>which means
>>  > >  >>  that:
>>  > >  >>
>>  > >  >>  - 64 bits kernels with 32 bits userspace can't pass a complete
>  > > > address
>>  > >  >>  - 32 bits machines with 64 bits resource_size_t can't 
>>pass a complete
>>  > >  >>  address
>>  > >  >>  - The structure isn't even properly padded to be 32/64 bits neutral
>>  > > in
>>  > >  >>  the first place.
>>  > >  >>
>>  > >  >  > We could define new versions of the struct with new 
>>get/set ioctls,
>>  > >  >>  or we could try to just deprecate those fields. What do you guys
>>  > > think ?
>>  > >  >
>>  > >  >As userspace doesn't really need those fields[1], we can easily
>>  > >  >deprecate them.
>>  > >
>>  >  > kexec uses FBIOGET_FSCREENINFO and FBIOGET_VSCREENINFO. So if these
>>  >  > ioctls changes, it will possibly break kexec under vesafb and efifb.
>>  >
>>  > Does kexec use the smem_start and mmio_start fields of
>>  > fb_fix_screeninfo?
>>  >
>>
>>  In "kexec/arch/i386/x86-linux-setup.c", the routine 
>>"setup_linux_vesafb" uses
>>  smem_start, smem_len, and line_length.
>>
>>  This is used for vesafb and efifb framebuffer kernel boot param 
>>setup. This is
>>  required for PC hardware that do not contain a PC-BIOS and need 
>>the bootloader
>>  to setup the kernel video boot params.
>
>OK, but the problem doesn't show up on x86-32 (no >32-bit physical
>addresses yet), as x86_linux_param_header.lfb_base is uint32_t and there's no
>way it's gonna change.
>

I seem to remember the EFI/kexec guys have been doing kexec from 
32->64 kernel and I think 64->32. I'm 32 bit only so I have no 
experience under 64 bit kernels and don't really pay much attention 
to 64 bit kernel patches. Huang Ying was doing the EFI/kexec patches 
a few months ago.



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
