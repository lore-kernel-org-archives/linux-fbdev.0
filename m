From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Reading the EDID block for x86 machines
Date: 18 Mar 2003 06:29:56 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047940105.3693.40.camel@localhost.localdomain>
References: <20030317220215.49788.qmail@web14902.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18v3Ab-000212-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 14:33:25 -0800
In-Reply-To: <20030317220215.49788.qmail@web14902.mail.yahoo.com>
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

On Tue, 2003-03-18 at 06:02, Jon Smirl wrote:
> The VBIOS should be position independent code and it
> will run at any 64K boundary. The PC bus spec simply
> says the video BIOS defaults to C000, it is not a
> requirement that it be located there. For example if
> you look at the aty128fb driver's find ROM routine
> your will notice that it is searching a broad address
> space for the ROM.
> 
> I'm still not convinced that the memory at C000 is
> really hardware write protected, I think it is just
> RAM with a copy of the ROM in it. For example if I
> turn off BIOS shadowing my system will not boot. When
> debugging this I spent some time tracing into the ATI
> ROM and I was pretty sure that they are dependent on
> begin copied into RAM before begin run. 

    The PC-compatible specific set of steps for the system POST code
    when handling each expansion ROM are:
    
    1. Map and enable the expansion ROM to an unoccupied area of the
    memory address space.
    2. Find the proper image in the ROM and copy it from ROM into the
    compatibility area of RAM (typically 0C0000h to 0DFFFFhh) using the
    number of bytes specified by Initialization Size.
    3. Disable the Expansion ROM Base Address register.
    4. Leave the RAM area writable and call the INIT function.
    5. Use the byte at offset 02h (which may have been modified) to
    determine how much memory is used at runtime.
    
    Before system boot, the POST code must make the RAM area containing
    expansion ROM code read-only.
    
    POST code must handle VGA devices with expansion ROMs in a special
    way.  The VGA device's expansion BIOS must be copied to 0C0000h. 
    VGA devices can be identified by examining the Class Code field in
    the device's Configuration Space.
    
-- pg. 210 PCI Local Bus Specification Revision 2.2 December 18, 1998


> 
> Do you have a DOS floppy around? Just boot into DOS,
> start debug and see if you can change C000:0.

Yes, it's unchangeable.

Tony




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
