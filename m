From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Date: Sat, 11 Jan 2014 13:28:08 +0000
Subject: Re: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
Message-Id: <52D146E8.4090105@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
 <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
 <20140107235951.GH5074@atomide.com> <52CD5D13.9090806@ti.com>
 <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
 <52CE5123.9050702@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EDB141E@DBDE04.ent.ti.com>
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EDB141E@DBDE04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 09.01.2014 10:08, Hiremath, Vaibhav wrote:

>
> No, that's what is causing issue to me. Can you try predefined address flow?
>
> Thanks,
> Vaibhav
>

Booting Linux on physical CPU 0x0
Initializing cgroup subsys cpu
Linux version 3.13.0-rc7+ (maemo@maemo-desktop) (gcc version 4.7.2 
20120701 (prerelease) (Linaro GCC 4.7-2012.07) ) #24 PREEMPT Sat Jan 11 
17:06:39 EET 2014
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), crc53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: Nokia RX-51 board
omapfb: reserved 0x00800000 bytes at 0x8f100000
Memory policy: Data cache writeback
On node 0 totalpages: 61696
free_area_init_node: node 0, pgdat c05b73b4, node_mem_map c061b000
   Normal zone: 512 pages used for memmap
   Normal zone: 0 pages reserved
   Normal zone: 61696 pages, LIFO batch:15
CPU: All CPU(s) started in SVC mode.
OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 61184
Kernel command line: init=/sbin/preinit ubi.mtd=rootfs root=ubi0:rootfs 
rootfstype=ubifs rootflags=bulk_read,no_chk_data_crc rw 
mtdoops.mtddev=log console=tty0 console=ttyO2 omapfb_vram=8M@0x8F100000 
omapfb.mode=lcd:848x480-16


There are no (UNDERFLOW) errors on OMAP3 when predefined address is 
used, I am still able to play every video I try.

Ivo
