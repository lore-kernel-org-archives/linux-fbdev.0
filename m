From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Reading the EDID block for x86 machines
Date: 19 Mar 2003 13:15:20 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048050587.1183.3.camel@localhost.localdomain>
References: <20030318170749.55622.qmail@web14904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-uhl8m0PwKCLKXqMb8bSh"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18vVyY-0007GD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Mar 2003 21:18:54 -0800
In-Reply-To: <20030318170749.55622.qmail@web14904.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-uhl8m0PwKCLKXqMb8bSh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-03-19 at 01:07, Jon Smirl wrote:
> Here is a description of how to control the shadow
> write protect for a SIS chipset. It is done by writing
> to PCI config space. There is a slim chance that this
> is a standard procedure.
> 
> http://www.missl.cs.umd.edu/Projects/sebos/winint/index1.html
> 

I tried this part, and it doesn't work with the chipset I'm using. 
Plus, PCI config space register 0x70 is device specific, only the first
64 bytes is defined generically.

> When you copied to 8000 ot 9000, did you copy the ROM
> or the image at C000? I compared a dump of C000 to the
> ROM and they don't match. ATI may have overlaid some
> code during the init procedure.

I copied the actual ROM (pointed to by Expansion ROM base address 0x30)
and placed it in 0xc000 and 0x8000.  0xc000 of course is write protected
by the BIOS, and it won't run in 0x8000.

Yes, the final BIOS image can be different from the initial image.  Most
of the time, the initial image is larger, or needs decompression.  Some 
of the newer ROM's may even use the POST Memory Manager Specification
(kinda like a POST-specific malloc and family) during INIT, but this is
available only during POST, and memory allocated by the PMM is
unavailable after POST.

> 
> So I guess we are stuck with a user space daemon.
> Athlon-64 and IA64 will require the entire VM86
> emulator. Last I checked the scitech emulator (ver8)
> han't implemented all of the instructions needed to
> run the ATI ROMs so it will need some work.
> 
> How do the Transmeta tools work? Could we turn the
> ROMs into a C program and compile them again? Or use
> something like use an emulator to capture the reset
> sequence and then compile it for protected mode. 
> 

That's another problem.  Some of the BIOS services used during INIT may
become unavailable after POST, so emulating ROM's can either be caused
by this or by an incomplete emulator.
 
> I tried a couple of reverse engineering tools on the
> ROMs but I didn't get very far. I don't have access to
> the ATI Radeon documentation so it is hard for me to
> tell what is going on.  
> 

Our best hope is for graphics manufacturer to drop VGA :-) which should
allow for relocatable ROM's and therefore initialization of multiple
graphics adapters.  Second best hope is for manufacturer's to open up
the source for initializing devices without having to initialize the VGA
BIOS. 

Anyway, attached is the code I'm using.  It basically saves the video
state, disables all VGA controllers, disables VGA routing on PCI-PCI
bridges, searches for valid expansion ROM addresss on VGA class devices,
copies it into a scratch segment, verifies the ROM, copies the verified
ROM to 0xc000 and call 0xc000:0003.  Of course, the "copies the verified
ROM to 0xc000" part will fail, so the "call 0xc000:0003" will just
warmboot your primary display again.

You have to place the file in linux/arch/i386/boot

Then in setup.S

add "include detect.S"

and 

call init_video #preferably before or after 'call video'

I'll probably drop effort on this (for now) and concentrate on adding a
userspace daemon.

Tony


--=-uhl8m0PwKCLKXqMb8bSh
Content-Disposition: attachment; filename=detect.S
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=detect.S; charset=ANSI_X3.4-1968

/*	detect.S
 *
 *	Scanning and Initialization of all Display adapters (13-Mar-2003)
 *
 *	Copyright (C) 2003 -- 2003 Antonino Daplas <adaplas@pol.net>
 *
 */

#define	SAVE_SEGMENT		0x8000
#define	SCRATCH_SEGMENT		0x7000
#define	VROM_SEGMENT		0xc000		=09
#define PCI_SIGNATURE		(('P'<<0)+('C'<<8)+('I'<<16)+(' '<< 24))
	=09
init_video:
	pushw	%ds			# We use different segments
	pushw	%ds			# FS contains original DS
	popw	%fs
	pushw	%cs			# DS is equal to CS
	popw	%ds
	pushw	%cs			# ES is equal to CS
	popw	%es
	xorw	%ax, %ax
	movw	%ax, %gs		# GS is zero

	call	find_pci_bios		# check for PCI BIOS directory service=20
	cmpb	$0, %ah			# not available?
	jne	init_video_done

	call	save_video		# save video state
	call	disable_bridge		# disable VGA routing on bridges
	call	disable_all		# disable all VGA class devices
	call	controller_init		# warmboot all VGA class devices=09
	call	enable_bridge		# reenable VGA routing on bridges
	call	enable_all		# reenable VGA class devices
	call	restore_video		# restore video state
init_video_done:=09
	popw	%ds		=09
	ret

#---------------------------------------------------------------

# -------------------------------------------------------------------------=
----
# disable_all: disables all VGA class devices=20
#--------------------------------------------------------------------------=
---
disable_all:=09
	movw	$0, %si
disable_all_loop:=09
	call	find_vga_class		# find all VGA class devices=09
	cmpb	$0, %ah			# no more devices?
	jne	disable_all_done
	pushw	%si
	call	disable_dev		#disable
	popw	%si=09
	incw	%si
	jmp	disable_all_loop	# do it again
disable_all_done:
	ret

# -------------------------------------------------------------------------=
----
# enable_all: enables all VGA class devices=20
#--------------------------------------------------------------------------=
---
enable_all:=09
	movw	$0, %si
enable_all_loop:=09
	call	find_vga_class		# find all VGA class devices
	cmpb	$0, %ah			# no more devices?
	jne	enable_all_done
	pushw	%si		=09
	call	enable_dev		# and enable
	popw	%si=09
	incw	%si
	jmp	enable_all_loop		# do it again
enable_all_done:
	ret
	=09
# -------------------------------------------------------------------------=
----
# save_video: Saves current state of video controller=20
#
# USES:	 cursor, vid_state
#--------------------------------------------------------------------------=
---
save_video:
	movw	$0x3, %ax		# save cursor position
	int	$0x10=09
	movw	%dx, cursor

	pushw	%es			# disable and save current state
	pushw	%ds
	popw	%es=09
	movw	$0x1202, %ax
	movb	$0x35, %bl
	leaw	vid_state, %dx	=09
	int	$0x10
	popw	%es

	# save 64K at 0xc000:0000
	pushw	%ds
	pushw	%es

	pushw	$SAVE_SEGMENT		# save a copy of original ROM=20
	popw	%es
	pushw	$VROM_SEGMENT
	popw	%ds
	movw	$0, %di
	movw	$0, %si
	movw	$0x4000, %cx=09
	rep
	movsl

	popw	%es
	popw	%ds

	ret

# -------------------------------------------------------------------------=
----
# restore_video: Restores saved state of video controller=20
#
# USES:	 cursor, vid_state
#--------------------------------------------------------------------------=
---
restore_video:
	pushw	%ds			# restore ROM
	pushw	%es
	pushw	$SAVE_SEGMENT
	popw	%ds
	pushw	$VROM_SEGMENT
	popw	%es
	movw	$0, %di
	movw	$0, %si
	movw	$0x4000, %cx=09
	rep
	movsl
	popw	%es
	popw	%ds

	pushw	%es			# restore video state
	pushw	%ds
	popw	%es
	movw	$0x1203, %ax
	movb	$0x35, %bl
	leaw	vid_state, %dx
	int	$0x10
	popw	%es=09

	movw	cursor, %dx		# restore cursor
	movb	$2, %ah
	int	$0x10

	ret
=09
# -------------------------------------------------------------------------=
----
# disable_bridge: disables VGA routing on bridges=20
#--------------------------------------------------------------------------=
---
disable_bridge:
	movw	$0, %si
	movl	$0x00060400, %ecx	# find all PCI-PCI bridges
	int	$0x1a
	cmp 	$0, %ah			# no more devices?
	jnz	bridge_done

	pushw	%si	=09
	movw	$0xb10a, %ax		# read command word
	movw	$0x40, %di
	int	$0x1a		=09

	andl	$(~(8 << 16)), %ecx	# disable VGA routing
	movw	$0xb10d, %ax	=09
	movw	$0x3c, %di
	int	$0x1a		=09

	popw	%si
	inc	%si
	jmp	disable_bridge		# do it again
bridge_done:=09
	ret	=09

# -------------------------------------------------------------------------=
----
# enable_bridge: enables VGA routing on bridges=20
#--------------------------------------------------------------------------=
---
enable_bridge:
	movw	$0, %si
	movl	$0x00060400, %ecx	# find all PCI-PCI bridges
	int	$0x1a
	cmp 	$0, %ah			# no more devices?
	jnz	bridge1_done

	pushw	%si		=09
	movw	$0xb10a, %ax		# read command word
	movw	$0x3c, %di
	int	$0x1a		=09

	orl	$(8 << 16), %ecx	# enable VGA routing
	movw	$0xb10d, %ax	=09
	movw	$0x3c, %di
	int	$0x1a		=09

	popw	%si
	inc	%si
	jmp	enable_bridge		# do it again
bridge1_done:=09
	ret	=09

# -------------------------------------------------------------------------=
----
# find_pci_bios: Check if PCI BIOS directory service is available on this=20
#	         machine
# RETURNS:	AH =3D 0 - found : 1 - not found
#--------------------------------------------------------------------------=
---
find_pci_bios:=09
	movw	$0xb101, %ax		# detect PCI BIOS directory service
	int	$0x1a
	jc	bios_no_good		# CF set, service not present
	cmpl	$PCI_SIGNATURE, %edx	# check for signature
	jne	bios_no_good
	movb	$0, %ah			# return success
	ret=09
bios_no_good:=09
	movb	$1, %ah			# return fail
	ret
=09
# -------------------------------------------------------------------------=
---
# find_vga_class: Check for PCI devices of VGA base class (3)
# ENTRY:	SI =3D index
# RETURNS:	AH =3D 0 - found : 1 - not found
#		BH =3D bus number
#		BL =3D device (3-7) and function number (0-2)=09
#
#--------------------------------------------------------------------------=
---
find_vga_class:
	movw	$0xb103, %ax
	movl	$0x000030000, %ecx
	int	$0x1a
	ret
	=09
# -------------------------------------------------------------------------=
---
# disable_dev:  disables all controllers
# ENTRY:	BX =3D bus, device and function number=20
#--------------------------------------------------------------------------=
---
disable_dev:
	movw	$0xb10a, %ax		#read Expansion Rom
	movw	$0x30, %di
	int	$0x1a=09
=09
	movw	$0xb10d, %ax	=09
	movw	$0x30, %di
	andw	$(~1), %cx		# disable expansion ROM
	int	$0x1a=09

	movw	$0xb109, %ax		# read command word
	movw	$0x04, %di
	int	$0x1a		=09
=09
	movw	$0xb10c, %ax		# disable command word
	andw	$(~3), %cx
	movw	$0x04, %di
	int	$0x1a		=09

	ret=09

# -------------------------------------------------------------------------=
---
# enable_dev:  enables all controllers
# ENTRY:	BX =3D bus, device and function number=20
#--------------------------------------------------------------------------=
---
enable_dev:
	movw	$0xb109, %ax		#read command word
	movw	$0x04, %di
	int	$0x1a		=09
=09
	movw	$0xb10c, %ax		# enable bit 0,1 of command word
	orw	$3, %cx
	movw	$0x04, %di
	int	$0x1a		=09

	ret=09
=09
# -------------------------------------------------------------------------=
---
# controller_init:  searches, verifies, copies and warmboots ROM
#--------------------------------------------------------------------------=
---
controller_init:
	movw	$0, %si
coninit_loop:=09
	pushw	%si			# find all VGA class devices
	movw	$0xb103, %ax
	movl	$0x000030000, %ecx
	int	$0x1a

	cmpb	$0, %ah			# no more devices?
	jne	coninit_done=20

	movw	%bx, dev_num		# save bus, device and func number
	call	enable_dev		# enable this device
	call	check_rom
	cmpb	$0, %ah			# no ROM?
	je	has_no_rom
	call	copy_rom
	cmpb	$0, %ah			# copy failed?
	je	has_no_rom
	call	verify_rom	=09
	cmpb	$0, %ah			# verify failed?
	je	has_no_rom
	call	post_rom
	movw	dev_num, %bx
	call	disable_dev		# disable this device=09
has_no_rom:=09
	popw	%si
	incw	%si
	jmp	coninit_loop		# do it again
coninit_done:=09
	popw	%si
	ret
=09
# -------------------------------------------------------------------------=
---
# check_rom:  searches for valid ROM address
# USES:	      dev_num - current bus, device and function number=09
# RETURNS:    AH - 0 none found, 1 found
#--------------------------------------------------------------------------=
---
check_rom:
	movw	$0xb10a, %ax		# read Expansion Rom
	movw	dev_num, %bx		# get current device
	movw	$0x30, %di
	int	$0x1a=09
=09
	cmpl	$0, %ecx		# no ROM, check BAR
	je	check_base_addr
	pushl	%ecx
	movl	%ecx, dev_addr		# save ROM address

check_rom_cont:=09
	movw	$0xb109, %ax		# read command word
	movw	dev_num, %bx
	movw	$0x04, %di
	int	$0x1a		=09

	movw	$0xb10c, %ax		# enabled bit 0,1 of command word
	movw	dev_num, %bx
	movw	$0x04, %di
	orw	$0x3, %cx	=09
	int	$0x1a

	popl	%ecx			# enable expansion ROM
	movw	$0xb10d, %ax	=09
	movw	dev_num, %bx
	movw	$0x30, %di
	orl	$1, %ecx
	int	$0x1a=09

	movb	$1, %ah			# return success
	ret
=09
check_base_addr:=09
	movw	$6, %cx			# max 6 BAR's supported
	movw	$0x10, %di		# first BAR=09
check_base_addr_loop:=09
	pushw	%di		=09
	pushw	%cx
	movw	$0xb10a, %ax		# read BAR's
	movw	dev_num, %bx
	int	$0x1a=09

	testl	$1, %ecx		# check for IO
	jnz	do_have_rom		# is IO? assume ROM
	popw	%cx
	popw	%di
	addw	$4, %di			# check next BAR
	decw	%cx
	jcxz	no_rom_really
	jmp	check_base_addr_loop		=09

do_have_rom:			=09
	andl	$(~1), %ecx		# assume BAR is ROM
	movl	%ecx, dev_addr		# save BAR address

	movw	$0xb10d, %ax		# write BAR to expansion ROM
	movw	dev_num, %bx
	movw	$0x30, %di
	int	$0x1a
	popw	%cx
	popw	%di=09
	jmp	check_rom_cont		# continue with initialization

no_rom_really:	=09
	movb	$0, %ah			# no ROM at all, return fail
	ret

# -------------------------------------------------------------------------=
---
# copy_rom:	copy ROM to SCRATCH_SEGMENT using int 10h, function 0x87
# USES:		dev_num - current bus, device and function number
# RETURNS:   	AH =3D 0 copy failed, AH =3D 1 copy successful=09
#--------------------------------------------------------------------------=
---

copy_rom:
	movl	dev_addr, %eax		# write ROM addr to GDT
	movw	%ax, gdt_src1
	shrl	$16, %eax
	movb	%al, gdt_src2
	movb	%ah, gdt_src3

	pushw	%es
	pushw	%ds
	popw	%es

	movw	$4, %cx			# zeroes first 16 bytes of gdt
	movl	$0, %eax
	leaw	gdt_p, %di
	cld
	rep
	stosl
	movw	$4, %cx			# zeroes last 16 bytes of gdt
	leaw	gdt_dummy, %di
	cld
	rep
	stosl

	leaw	gdt_p, %si		# copy extended memory
	movw	$0x8000, %cx
	movw	$0x8700, %ax
	int	$0x15
	popw	%es

	jc	extcopy_fail
	movw	$0xb10a, %ax		# read Expansion Rom
	movw	dev_num, %bx
	movw	$0x30, %di
	int	$0x1a=09
=09
	movw	$0xb10d, %ax		# disable expansion ROM after copy	=09
	movw	dev_num, %bx
	movw	$0x30, %di
	andw	$(~1), %cx
	int	$0x1a=09

	movb	$1, %ah			# return success
	ret
extcopy_fail:=09
	movb	$0, %ah			# return failed
	ret	=20

# -------------------------------------------------------------------------=
---
# verify_rom:	verifies ROM for signature bytes and size <=3D 64K
# USES:		dev_num - current bus, device and function number
# RETURNS:   	AH =3D 0 verify failed, AH =3D size of ROM in 512-byte blocks=
=09
#--------------------------------------------------------------------------=
---
verify_rom:
	pushw	%es
	movw	$SCRATCH_SEGMENT, %ax
	movw	%ax, %es=09
	movw	%es:(0), %ax
	cmpw	$0xaa55, %ax		# check for rom sig bytes
	jne	corrupt_rom
	movb	%es:(2), %ah		# put ROM size in AH
	cmpb	$128, %ah		# check if init size > 64K
	jns	corrupt_rom
	popw	%es
	ret
corrupt_rom:=09
	popw	%es
	movb	$0, %ah			# return fail
	ret=09
=09
# -------------------------------------------------------------------------=
---
# post_rom:	warmboots ROM
# USES:		dev_num - current bus, device and function number
#--------------------------------------------------------------------------=
---

	# FIXME:	currently does not work as C000:0000 is write
	#	        protected by BIOS=09
post_rom:
	xorl	%ecx, %ecx	=09
	movb	%ah, %cl		# AH has number of 512 bytes to copy
	shll	$7, %ecx		# number of dwords to copy
=09
	pushw	%ds		=09
	pushw	%es
	pushw	$SCRATCH_SEGMENT	# copy from scratch segment ...=09
	popw	%ds
	pushw	$VROM_SEGMENT		# to 0xC000 - doesn't work as=20
	popw	%es			# 0xC000 is write-protected
	movw	$0, %di
	movw	$0, %si
	cld
	rep
	movsb
	popw	%es
	popw	%ds
=09
	movw	dev_num, %ax		# putting device number to ax may help=20
	lcall	$VROM_SEGMENT, $0x0003	# warmboot :)

	ret
=09
#------------------------------------------------------------=09
		=09
dev_addr:	.long	0		# current ROM address
dev_num:	.word	0		# current bus, device, func number
cursor:		.word	0		# cursor state
vid_state:	.fill	128, 0		# video state

# gdt table used for int 10h ah=3D87 (copy extended memory)=09
gdt_p:		.long	0,0,0,0		# fill with zeroes
gdt_src_seg:	.word	0xffff		# segment limit
gdt_src1:	.word	0		# src address (0-15)
gdt_src2:	.byte	0		# src address (16-23)
gdt_src_access:	.byte	0x93		# access
gdt_src_x:	.byte	0		# extended access/segment limit
gdt_src3:	.byte	0		# src address (24-31)
gdt_dst_seg:	.word	0xffff
gdt_dst1:	.word	0x0000
gdt_dst2:	.byte	0x07=09
gdt_dst_access:	.byte	0x93
gdt_dst_x:	.byte	0
gdt_dst3:	.byte	0 =20
gdt_dummy:	.long	0,0,0,0

#------------------------------------------------------------=09


--=-uhl8m0PwKCLKXqMb8bSh--




-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
