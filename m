From: imranj <imran72@emirates.net.ae>
Subject: Radeon frame buffer compile error?
Date: Wed, 11 Dec 2002 23:56:31 +0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3DF7986F.409@emirates.net.ae>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from domail1.emirates.net.ae ([213.42.1.90])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18MDTv-00075W-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Dec 2002 12:29:23 -0800
Received: from dpmail1.emirates.net.ae ([213.42.1.68])
 by domail1.emirates.net.ae ("iPlanet Messaging Server 5.2")
 with ESMTP id <0H6Z00CAV28KW2@domail1.emirates.net.ae> for
 linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Dec 2002 00:29:08 +0400 (GST)
Received: from emirates.net.ae (twd064.emirates.net.ae [217.164.225.64])
 by dpmail1.emirates.net.ae (I&ES Mail Server 4.2)
 with ESMTP id <0H6Z00IYK28GVL@dpmail1.emirates.net.ae> for
 linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Dec 2002 00:29:08 +0400 (GST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: ajoshi@shell.unixbox.com
Cc: linux-fbdev-devel@lists.sourceforge.net

this is the error that i get when i compile my modules

system :- redhat 8.0 no upgrades to the core components ex gcc compilers 
every thing with default settings.


DKBUILD_MODNAME=cfbimgblt -DEXPORT_SYMTAB  -c -o 
drivers/video/cfbimgblt.o drivers/video/cfbimgblt.c
  ld -m elf_i386  -r -o drivers/video/cfbimgblt.ko drivers/video/cfbimgblt.o
  gcc -Wp,-MD,drivers/video/.radeonfb.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=pentium4 
-Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc -iwithprefix 
include -DMODULE   -DKBUILD_BASENAME=radeonfb 
-DKBUILD_MODNAME=radeonfb   -c -o drivers/video/radeonfb.o 
drivers/video/radeonfb.c
drivers/video/radeonfb.c:187: `PCI_DEVICE_ID_ATI_RADEON_QD' undeclared 
here (not in a function)
drivers/video/radeonfb.c:187: initializer element is not constant
drivers/video/radeonfb.c:187: (near initialization for 
`radeonfb_pci_table[0].device')
drivers/video/radeonfb.c:187: initializer element is not constant
drivers/video/radeonfb.c:187: (near initialization for 
`radeonfb_pci_table[0]')
drivers/video/radeonfb.c:188: `PCI_DEVICE_ID_ATI_RADEON_QE' undeclared 
here (not in a function)
drivers/video/radeonfb.c:188: initializer element is not constant
drivers/video/radeonfb.c:188: (near initialization for 
`radeonfb_pci_table[1].device')
drivers/video/radeonfb.c:188: initializer element is not constant
drivers/video/radeonfb.c:188: (near initialization for 
`radeonfb_pci_table[1]')
drivers/video/radeonfb.c:189: `PCI_DEVICE_ID_ATI_RADEON_QF' undeclared 
here (not in a function)
drivers/video/radeonfb.c:189: initializer element is not constant
drivers/video/radeonfb.c:189: (near initialization for 
`radeonfb_pci_table[2].device')
drivers/video/radeonfb.c:189: initializer element is not constant
drivers/video/radeonfb.c:189: (near initialization for 
`radeonfb_pci_table[2]')
drivers/video/radeonfb.c:190: `PCI_DEVICE_ID_ATI_RADEON_QG' undeclared 
here (not in a function)
drivers/video/radeonfb.c:190: initializer element is not constant
drivers/video/radeonfb.c:190: (near initialization for 
`radeonfb_pci_table[3].device')
drivers/video/radeonfb.c:190: initializer element is not constant
drivers/video/radeonfb.c:190: (near initialization for 
`radeonfb_pci_table[3]')
drivers/video/radeonfb.c:191: `PCI_DEVICE_ID_ATI_RADEON_QY' undeclared 
here (not in a function)
drivers/video/radeonfb.c:191: initializer element is not constant
drivers/video/radeonfb.c:191: (near initialization for 
`radeonfb_pci_table[4].device')
drivers/video/radeonfb.c:191: initializer element is not constant
drivers/video/radeonfb.c:191: (near initialization for 
`radeonfb_pci_table[4]')
drivers/video/radeonfb.c:192: `PCI_DEVICE_ID_ATI_RADEON_QZ' undeclared 
here (not in a function)
drivers/video/radeonfb.c:192: initializer element is not constant
drivers/video/radeonfb.c:192: (near initialization for 
`radeonfb_pci_table[5].device')
drivers/video/radeonfb.c:192: initializer element is not constant
drivers/video/radeonfb.c:192: (near initialization for 
`radeonfb_pci_table[5]')
drivers/video/radeonfb.c:193: `PCI_DEVICE_ID_ATI_RADEON_LW' undeclared 
here (not in a function)
drivers/video/radeonfb.c:193: initializer element is not constant
drivers/video/radeonfb.c:193: (near initialization for 
`radeonfb_pci_table[6].device')
drivers/video/radeonfb.c:193: initializer element is not constant
drivers/video/radeonfb.c:193: (near initialization for 
`radeonfb_pci_table[6]')
drivers/video/radeonfb.c:194: `PCI_DEVICE_ID_ATI_RADEON_LX' undeclared 
here (not in a function)
drivers/video/radeonfb.c:194: initializer element is not constant
drivers/video/radeonfb.c:194: (near initialization for 
`radeonfb_pci_table[7].device')
drivers/video/radeonfb.c:194: initializer element is not constant
drivers/video/radeonfb.c:194: (near initialization for 
`radeonfb_pci_table[7]')
drivers/video/radeonfb.c:195: `PCI_DEVICE_ID_ATI_RADEON_LY' undeclared 
here (not in a function)
drivers/video/radeonfb.c:195: initializer element is not constant
drivers/video/radeonfb.c:195: (near initialization for 
`radeonfb_pci_table[8].device')
drivers/video/radeonfb.c:195: initializer element is not constant
drivers/video/radeonfb.c:195: (near initialization for 
`radeonfb_pci_table[8]')
drivers/video/radeonfb.c:196: `PCI_DEVICE_ID_ATI_RADEON_LZ' undeclared 
here (not in a function)
drivers/video/radeonfb.c:196: initializer element is not constant
drivers/video/radeonfb.c:196: (near initialization for 
`radeonfb_pci_table[9].device')
drivers/video/radeonfb.c:196: initializer element is not constant
drivers/video/radeonfb.c:196: (near initialization for 
`radeonfb_pci_table[9]')
drivers/video/radeonfb.c:197: `PCI_DEVICE_ID_ATI_RADEON_QL' undeclared 
here (not in a function)
drivers/video/radeonfb.c:197: initializer element is not constant
drivers/video/radeonfb.c:197: (near initialization for 
`radeonfb_pci_table[10].device')
drivers/video/radeonfb.c:197: initializer element is not constant
drivers/video/radeonfb.c:197: (near initialization for 
`radeonfb_pci_table[10]')
drivers/video/radeonfb.c:198: `PCI_DEVICE_ID_ATI_RADEON_QN' undeclared 
here (not in a function)
drivers/video/radeonfb.c:198: initializer element is not constant
drivers/video/radeonfb.c:198: (near initialization for 
`radeonfb_pci_table[11].device')
drivers/video/radeonfb.c:198: initializer element is not constant
drivers/video/radeonfb.c:198: (near initialization for 
`radeonfb_pci_table[11]')
drivers/video/radeonfb.c:199: `PCI_DEVICE_ID_ATI_RADEON_QO' undeclared 
here (not in a function)
drivers/video/radeonfb.c:199: initializer element is not constant
drivers/video/radeonfb.c:199: (near initialization for 
`radeonfb_pci_table[12].device')
drivers/video/radeonfb.c:199: initializer element is not constant
drivers/video/radeonfb.c:199: (near initialization for 
`radeonfb_pci_table[12]')
drivers/video/radeonfb.c:200: `PCI_DEVICE_ID_ATI_RADEON_Ql' undeclared 
here (not in a function)
drivers/video/radeonfb.c:200: initializer element is not constant
drivers/video/radeonfb.c:200: (near initialization for 
`radeonfb_pci_table[13].device')
drivers/video/radeonfb.c:200: initializer element is not constant
drivers/video/radeonfb.c:200: (near initialization for 
`radeonfb_pci_table[13]')
drivers/video/radeonfb.c:201: `PCI_DEVICE_ID_ATI_RADEON_BB' undeclared 
here (not in a function)
drivers/video/radeonfb.c:201: initializer element is not constant
drivers/video/radeonfb.c:201: (near initialization for 
`radeonfb_pci_table[14].device')
drivers/video/radeonfb.c:201: initializer element is not constant
drivers/video/radeonfb.c:201: (near initialization for 
`radeonfb_pci_table[14]')
drivers/video/radeonfb.c:202: `PCI_DEVICE_ID_ATI_RADEON_QW' undeclared 
here (not in a function)
drivers/video/radeonfb.c:202: initializer element is not constant
drivers/video/radeonfb.c:202: (near initialization for 
`radeonfb_pci_table[15].device')
drivers/video/radeonfb.c:202: initializer element is not constant
drivers/video/radeonfb.c:202: (near initialization for 
`radeonfb_pci_table[15]')
drivers/video/radeonfb.c:203: `PCI_DEVICE_ID_ATI_RADEON_QX' undeclared 
here (not in a function)
drivers/video/radeonfb.c:203: initializer element is not constant
drivers/video/radeonfb.c:203: (near initialization for 
`radeonfb_pci_table[16].device')
drivers/video/radeonfb.c:203: initializer element is not constant
drivers/video/radeonfb.c:203: (near initialization for 
`radeonfb_pci_table[16]')
drivers/video/radeonfb.c:204: `PCI_DEVICE_ID_ATI_RADEON_Id' undeclared 
here (not in a function)
drivers/video/radeonfb.c:204: initializer element is not constant
drivers/video/radeonfb.c:204: (near initialization for 
`radeonfb_pci_table[17].device')
drivers/video/radeonfb.c:204: initializer element is not constant
drivers/video/radeonfb.c:204: (near initialization for 
`radeonfb_pci_table[17]')
drivers/video/radeonfb.c:205: `PCI_DEVICE_ID_ATI_RADEON_Ie' undeclared 
here (not in a function)
drivers/video/radeonfb.c:205: initializer element is not constant
drivers/video/radeonfb.c:205: (near initialization for 
`radeonfb_pci_table[18].device')
drivers/video/radeonfb.c:205: initializer element is not constant
drivers/video/radeonfb.c:205: (near initialization for 
`radeonfb_pci_table[18]')
drivers/video/radeonfb.c:206: `PCI_DEVICE_ID_ATI_RADEON_If' undeclared 
here (not in a function)
drivers/video/radeonfb.c:206: initializer element is not constant
drivers/video/radeonfb.c:206: (near initialization for 
`radeonfb_pci_table[19].device')
drivers/video/radeonfb.c:206: initializer element is not constant
drivers/video/radeonfb.c:206: (near initialization for 
`radeonfb_pci_table[19]')
drivers/video/radeonfb.c:207: `PCI_DEVICE_ID_ATI_RADEON_Ig' undeclared 
here (not in a function)
drivers/video/radeonfb.c:207: initializer element is not constant
drivers/video/radeonfb.c:207: (near initialization for 
`radeonfb_pci_table[20].device')
drivers/video/radeonfb.c:207: initializer element is not constant
drivers/video/radeonfb.c:207: (near initialization for 
`radeonfb_pci_table[20]')
drivers/video/radeonfb.c:208: `PCI_DEVICE_ID_ATI_RADEON_Ld' undeclared 
here (not in a function)
drivers/video/radeonfb.c:208: initializer element is not constant
drivers/video/radeonfb.c:208: (near initialization for 
`radeonfb_pci_table[21].device')
drivers/video/radeonfb.c:208: initializer element is not constant
drivers/video/radeonfb.c:208: (near initialization for 
`radeonfb_pci_table[21]')
drivers/video/radeonfb.c:209: `PCI_DEVICE_ID_ATI_RADEON_Le' undeclared 
here (not in a function)
drivers/video/radeonfb.c:209: initializer element is not constant
drivers/video/radeonfb.c:209: (near initialization for 
`radeonfb_pci_table[22].device')
drivers/video/radeonfb.c:209: initializer element is not constant
drivers/video/radeonfb.c:209: (near initialization for 
`radeonfb_pci_table[22]')
drivers/video/radeonfb.c:210: `PCI_DEVICE_ID_ATI_RADEON_Lf' undeclared 
here (not in a function)
drivers/video/radeonfb.c:210: initializer element is not constant
drivers/video/radeonfb.c:210: (near initialization for 
`radeonfb_pci_table[23].device')
drivers/video/radeonfb.c:210: initializer element is not constant
drivers/video/radeonfb.c:210: (near initialization for 
`radeonfb_pci_table[23]')
drivers/video/radeonfb.c:211: `PCI_DEVICE_ID_ATI_RADEON_Lg' undeclared 
here (not in a function)
drivers/video/radeonfb.c:211: initializer element is not constant
drivers/video/radeonfb.c:211: (near initialization for 
`radeonfb_pci_table[24].device')
drivers/video/radeonfb.c:211: initializer element is not constant
drivers/video/radeonfb.c:211: (near initialization for 
`radeonfb_pci_table[24]')
drivers/video/radeonfb.c:212: `PCI_DEVICE_ID_ATI_RADEON_ND' undeclared 
here (not in a function)
drivers/video/radeonfb.c:212: initializer element is not constant
drivers/video/radeonfb.c:212: (near initialization for 
`radeonfb_pci_table[25].device')
drivers/video/radeonfb.c:212: initializer element is not constant
drivers/video/radeonfb.c:212: (near initialization for 
`radeonfb_pci_table[25]')
drivers/video/radeonfb.c:213: `PCI_DEVICE_ID_ATI_RADEON_NE' undeclared 
here (not in a function)
drivers/video/radeonfb.c:213: initializer element is not constant
drivers/video/radeonfb.c:213: (near initialization for 
`radeonfb_pci_table[26].device')
drivers/video/radeonfb.c:213: initializer element is not constant
drivers/video/radeonfb.c:213: (near initialization for 
`radeonfb_pci_table[26]')
drivers/video/radeonfb.c:214: `PCI_DEVICE_ID_ATI_RADEON_NF' undeclared 
here (not in a function)
drivers/video/radeonfb.c:214: initializer element is not constant
drivers/video/radeonfb.c:214: (near initialization for 
`radeonfb_pci_table[27].device')
drivers/video/radeonfb.c:214: initializer element is not constant
drivers/video/radeonfb.c:214: (near initialization for 
`radeonfb_pci_table[27]')
drivers/video/radeonfb.c:215: `PCI_DEVICE_ID_ATI_RADEON_NG' undeclared 
here (not in a function)
drivers/video/radeonfb.c:215: initializer element is not constant
drivers/video/radeonfb.c:215: (near initialization for 
`radeonfb_pci_table[28].device')
drivers/video/radeonfb.c:215: initializer element is not constant
drivers/video/radeonfb.c:215: (near initialization for 
`radeonfb_pci_table[28]')
drivers/video/radeonfb.c:216: initializer element is not constant
drivers/video/radeonfb.c:216: (near initialization for 
`radeonfb_pci_table[29]')
drivers/video/radeonfb.c:364: field `disp' has incomplete type
drivers/video/radeonfb.c: In function `radeon_get_pllinfo':
drivers/video/radeonfb.c:857: `PCI_DEVICE_ID_ATI_RADEON_QW' undeclared 
(first use in this function)
drivers/video/radeonfb.c:857: (Each undeclared identifier is reported 
only once
drivers/video/radeonfb.c:857: for each function it appears in.)
drivers/video/radeonfb.c:858: `PCI_DEVICE_ID_ATI_RADEON_QX' undeclared 
(first use in this function)
drivers/video/radeonfb.c:865: `PCI_DEVICE_ID_ATI_RADEON_QL' undeclared 
(first use in this function)
drivers/video/radeonfb.c:866: `PCI_DEVICE_ID_ATI_RADEON_QN' undeclared 
(first use in this function)
drivers/video/radeonfb.c:867: `PCI_DEVICE_ID_ATI_RADEON_QO' undeclared 
(first use in this function)
drivers/video/radeonfb.c:868: `PCI_DEVICE_ID_ATI_RADEON_Ql' undeclared 
(first use in this function)
drivers/video/radeonfb.c:869: `PCI_DEVICE_ID_ATI_RADEON_BB' undeclared 
(first use in this function)
drivers/video/radeonfb.c:876: `PCI_DEVICE_ID_ATI_RADEON_Id' undeclared 
(first use in this function)
drivers/video/radeonfb.c:877: `PCI_DEVICE_ID_ATI_RADEON_Ie' undeclared 
(first use in this function)
drivers/video/radeonfb.c:878: `PCI_DEVICE_ID_ATI_RADEON_If' undeclared 
(first use in this function)
drivers/video/radeonfb.c:879: `PCI_DEVICE_ID_ATI_RADEON_Ig' undeclared 
(first use in this function)
drivers/video/radeonfb.c:886: `PCI_DEVICE_ID_ATI_RADEON_QD' undeclared 
(first use in this function)
drivers/video/radeonfb.c:887: `PCI_DEVICE_ID_ATI_RADEON_QE' undeclared 
(first use in this function)
drivers/video/radeonfb.c:888: `PCI_DEVICE_ID_ATI_RADEON_QF' undeclared 
(first use in this function)
drivers/video/radeonfb.c:889: `PCI_DEVICE_ID_ATI_RADEON_QG' undeclared 
(first use in this function)
drivers/video/radeonfb.c: In function `radeon_engine_init':
drivers/video/radeonfb.c:1231: `RB2D_DSTCACHE_MODE' undeclared (first 
use in this function)
drivers/video/radeonfb.c: In function `radeon_init_disp':
drivers/video/radeonfb.c:1292: warning: implicit declaration of function 
`gen_set_var'
drivers/video/radeonfb.c: In function `radeonfb_setcolreg':
drivers/video/radeonfb.c:1672: `PIXCLK_DAC_ALWAYS_ONb' undeclared (first 
use in this function)
drivers/video/radeonfb.c: In function `radeon_save_state':
drivers/video/radeonfb.c:1751: `TMDS_TRANSMITTER_CNTL' undeclared (first 
use in this function)
drivers/video/radeonfb.c: In function `radeonfb_set_par':
drivers/video/radeonfb.c:1982: `PIXCLK_DAC_ALWAYS_ONb' undeclared (first 
use in this function)
drivers/video/radeonfb.c:2041: `TMDS_RAN_PAT_RST' undeclared (first use 
in this function)
drivers/video/radeonfb.c:2042: `ICHCSEL' undeclared (first use in this 
function)
drivers/video/radeonfb.c:2042: `TMDS_PLL_EN' undeclared (first use in 
this function)
drivers/video/radeonfb.c:2043: `TMDS_PLLRST' undeclared (first use in 
this function)
drivers/video/radeonfb.c: In function `radeon_write_mode':
drivers/video/radeonfb.c:2150: `TMDS_TRANSMITTER_CNTL' undeclared (first 
use in this function)
drivers/video/radeonfb.c:2155: `LVDS_STATE_MASK' undeclared (first use 
in this function)
drivers/video/radeonfb.c: At top level:
drivers/video/radeonfb.c:2189: warning: initialization from incompatible 
pointer type
drivers/video/radeonfb.c: In function `radeon_set_fbinfo':
drivers/video/radeonfb.c:2210: structure has no member named `modename'
drivers/video/radeonfb.c:2210: structure has no member named `modename'
drivers/video/radeonfb.c:2214: structure has no member named `disp'
drivers/video/radeonfb.c: In function `radeonfb_pci_register':
drivers/video/radeonfb.c:2910: `PCI_DEVICE_ID_ATI_RADEON_LY' undeclared 
(first use in this function)
drivers/video/radeonfb.c:2911: `PCI_DEVICE_ID_ATI_RADEON_LZ' undeclared 
(first use in this function)
make[2]: *** [drivers/video/radeonfb.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2
[root@localhost linux]#




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
