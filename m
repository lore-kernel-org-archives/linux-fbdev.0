From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Reading the EDID block for x86 machines
Date: 18 Mar 2003 18:00:09 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047981547.3668.73.camel@localhost.localdomain>
References: <20030317234143.79388.qmail@web14914.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18vDwY-0008Ar-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Mar 2003 02:03:39 -0800
In-Reply-To: <20030317234143.79388.qmail@web14914.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-03-18 at 07:41, Jon Smirl wrote:
> The C000 must be a PCI restriction, it was not there
> during ISA days.

It's not.  It's IBM defining that VGA ROM should be at segment C000. 
 
> Plan A: how is C000:0 protected; does the chipset
> hardware do it or is it done via the descriptor
> tables? Descriptor tables can be fixed but there is
> probably no general solution to chipset protection. 
> 

This is most probably chipset specific.  

> On the other hand, we may be lucky and the PCI spec
> has specified a standard way for enabling write
> protect. Could there be a BIOS INT xx function for
> this?
> 

If writable shadow ROM is to be supported, this has to be a specific
implementation by the BIOS vendor.  The standard (well, at least by
Phoenix), does not define any BIOS service to do this.

> Plan B is to copy the ROM to something like 8000 or
> 9000. But the question there is, are VBIOS ROMs still
> written to run position independent give the PCI C000
> requirement?

It won't run.  I already tried it.

> 
> Plan C is go into VM86 mode during early boot and
> remap the memory.

That means go to protected mode first, then vm86, since vm86 can only be
entered in protected mode.  Personally, this is too much work.

> 
> Plan D would be to get enough info to write the code
> in protected mode.

That's one plan.  Emulate real-mode x86 while in real-mode/protected
mode.  However, x86emu requires a bunch of functions to parse and
execute the opcodes.

> 
> Are there more ways to do this?


I've thought of 2 more things.  The first is similar to Unreal Mode or
Voodoo mode. This mode was employed by DOS game developers before the
advent of protected mode DOS.  They initialize the GDT to have a segment
limit of 4G, go to protected mode, then immediately switch back to real
mode.  Upon return to real mode, they now have a segment:offset of 16:32
instead of 16:16.  This is real mode with a 4 Gigabyte address limit. 

The variant of what I'm thinking is to do the same thing, but instead of
adjusting the segment limit, adjust the base address of the GDT by an
offset of 1 MB.  Copy the memory contents from 0 - 1 MB and place them
at 1 - 2 MB. Then, go to protected mode and back to real mode. 
Hopefully, if this works, I can now have an address space that starts at
0x100000  (1MB) but would still appear to everyone as starting at 0
effectively bypassing BIOS protection of expansion segments.  

I'm not sure if the above will work though, but should be easy enough to
experiment on. But if anyone knows that it won't work, let me know.

The other one is proposed by Kendall. Let's just have a userspace daemon
that does all BIOS requests.

The second is easy to implement since we already have the tools.  Also,
you can literally request for BIOS services anytime.  Plus, it can even
run on non-x86 using an emulator.

The first may not work at all, and even if it does, will run only once. 
Also, it has to be coded in assembly and though I've done a lot of
assembly before, it takes too long to code.  But it does have the
advantage of initializing adapters before the kernel loads, so we can
have multiple framebuffers loaded at boot time.

I'm still weighing which I should look first into.  The second seems to
be more useful, the first is much more interesting.  

What do you think?

Tony





-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
