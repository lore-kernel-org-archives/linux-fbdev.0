From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: ioremap problem on highmem
Date: Mon, 13 Oct 2003 13:30:58 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031013203058.20364.qmail@web14915.mail.yahoo.com>
References: <20031013191831.GB454@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A99LR-00081H-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 13 Oct 2003 13:31:09 -0700
Received: from web14915.mail.yahoo.com ([216.136.225.228])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A99LQ-00039u-Ba
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Oct 2003 13:31:08 -0700
In-Reply-To: <20031013191831.GB454@guug.org>
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
Content-Transfer-Encoding: 7bit
To: Otto Solares <solca@guug.org>, linux-fbdev-devel@lists.sourceforge.net

This is a better work around:

kernel /vmlinuz-2.6.0-test7 ro root=/dev/hda5 acpi=ht hdd=ide-scsi
reserve=FE000000-100000000

This reserves a block of address space for the Radeon card and then pushes the
rest of RAM as highmem.

--- Otto Solares <solca@guug.org> wrote:
> Hi!
> 
> FYI radeonfb is failing when highmem enabled, workaround with kernel param
> 'mem' < 896M.
> 
> Interesting bits from dmesg:
> 
> Linux version 2.6.0-test6-bk7 (solca@solcahomedesk) (gcc version 3.3.2
> 20030908 (Debian prerelease)) #10 SMP Mon Oct 6 11:37:35 CST 2003
> Video mode to be used for restore is ffff
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
>  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000007ffec000 (usable)
>  BIOS-e820: 000000007ffec000 - 000000007ffef000 (ACPI data)
>  BIOS-e820: 000000007ffef000 - 000000007ffff000 (reserved)
>  BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 1151MB HIGHMEM available.
> 896MB LOWMEM available.
> found SMP MP-table at 000f7e90
> hm, page 000f7000 reserved twice.
> hm, page 000f8000 reserved twice.
> hm, page 000f7000 reserved twice.
> hm, page 000f8000 reserved twice.
> On node 0 totalpages: 524268
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 225280 pages, LIFO batch:16
>   HighMem zone: 294892 pages, LIFO batch:16
> Kernel command line: BOOT_IMAGE=Linux ro root=303
> video=radeonfb:1024x768-8@60
> Console: colour VGA+ 80x25
> Memory: 2072716k/2097072k available (1575k kernel code, 23240k reserved, 472k
> data, 148k init, 1179568k highmem)
> radeonfb_pci_register BEGIN
> radeonfb: ref_clk=2700, ref_div=12, xclk=16600 from BIOS
> radeonfb: probed DDR SGRAM 262144k videoram
> radeon_get_moninfo: bios 4 scratch = 2000002
> radeonfb: cannot map FB
> Total HugeTLB memory allocated, 0
> highmem bounce pool size: 64 pages
> 
> -solca
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> SourceForge.net hosts over 70,000 Open Source Projects.
> See the people who have HELPED US provide better services:
> Click here: http://sourceforge.net/supporters.php
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
