From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Twister savagefb doesn't sync
Date: Sat, 27 May 2006 17:26:18 +0800
Message-ID: <44781B3A.5030406@gmail.com>
References: <44698356.80806@iit.demokritos.gr> <447359B8.7020304@iit.demokritos.gr> <447381E9.4060705@gmail.com> <447803FC.8050009@iit.demokritos.gr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090301070204090308040004"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fjv4c-0001gO-Dl
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 02:27:06 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fjv4c-0005MY-EY
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 02:27:06 -0700
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fjv4b-0008UI-AL
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 02:27:06 -0700
Received: by py-out-1112.google.com with SMTP id c30so196485pyc
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 May 2006 02:27:04 -0700 (PDT)
In-Reply-To: <447803FC.8050009@iit.demokritos.gr>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: vasvir@iit.demokritos.gr
Cc: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090301070204090308040004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Vassilis Virvilis wrote:
> Antonino A. Daplas wrote:
> 
>> If you can somehow dump the registers of the working and non-working
>> mode,
>> we might be able find a pattern.
>>
>> If you don't know how to dump the register contents, let me know and I'll
>> send you a userspace utility to do that.
>>
>>
> 
> I found dumpreg from the svgalib distribution (svgalib-bin in debian).
> Is this
> sufficient? 

It might not be sufficient as it won't be able to recognize savage extended
VGA registers.

> If not could you please send me the userspace utility you
> mentioned
> the other day?
> 

Ok, attached, it's a quick hack. Before using it open the file savagedump.c 
and look for the following defines:

#define PCI_ID        0x8d04  /* put the PCI id of the device here */
#define PCI_PBASE     0xdfe80000  /* put the start address of the PCI resource here */

and replace the above values with your own. First do "lspci -n | grep "Class 0300"
and you'll get something like this:

01:00.0 Class 0300: 5333:8d04

Use the last 4 digit ID for the PCI_ID (ie 8d04):

Then do lspci -v -n 5333:8d04 (using instead the vendor:device that you got) and you
should get something like this:

01:00.0 VGA compatible controller: S3 Inc. VT8375 [ProSavage8 KM266/KL266] (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 807b
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 16
        Memory at dfe80000 (32-bit, non-prefetchable) [size=512K]
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at dfe70000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [80] AGP version 2.0

Look for the (32-bit, non-prefetchable) string, the 32-bit hex number is what you're going
to use for your PCI_PBASE.

Once you've done all of the above, compile the app:

gcc -o savagedump savagedump.c

You can now run savagedump as root inside X or the console. Better if you run it in xterm
with X at different modes and with "UseBIOS" set to True and False.

./savagedump > /tmp/savagedump.txt

Send me the files you got, or you may examine it on your own to find a pattern.

Tony

PS: This utility dumps only the CRTC and Sequencer registers.  Hopefully that's enough.
If not, we can revise it so it dumps all registers.


--------------090301070204090308040004
Content-Type: text/plain;
 name="savagedump.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="savagedump.c"

#include <stdarg.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <string.h>
#include <errno.h>

#define PCI_ID        0x8d04  /* put the PCI id of the device here */
#define PCI_PBASE     0xdfe80000  /* put the start address of the PCI resource here */

#define PCI_CHIP_SAVAGE4      0x8a22
#define PCI_CHIP_SAVAGE3D     0x8a20
#define PCI_CHIP_SAVAGE3D_MV  0x8a21
#define PCI_CHIP_SAVAGE2000   0x9102
#define PCI_CHIP_SAVAGE_MX_MV 0x8c10
#define PCI_CHIP_SAVAGE_MX    0x8c11
#define PCI_CHIP_SAVAGE_IX_MV 0x8c12
#define PCI_CHIP_SAVAGE_IX    0x8c13
#define PCI_CHIP_PROSAVAGE_PM 0x8a25
#define PCI_CHIP_PROSAVAGE_KM 0x8a26
#define PCI_CHIP_S3TWISTER_P  0x8d01
#define PCI_CHIP_S3TWISTER_K  0x8d02
#define PCI_CHIP_PROSAVAGE_DDR          0x8d03
#define PCI_CHIP_PROSAVAGE_DDRK         0x8d04
#define PCI_CHIP_SUPSAV_MX128		0x8c22
#define PCI_CHIP_SUPSAV_MX64		0x8c24
#define PCI_CHIP_SUPSAV_MX64C		0x8c26
#define PCI_CHIP_SUPSAV_IX128SDR	0x8c2a
#define PCI_CHIP_SUPSAV_IX128DDR	0x8c2b
#define PCI_CHIP_SUPSAV_IX64SDR		0x8c2c
#define PCI_CHIP_SUPSAV_IX64DDR		0x8c2d
#define PCI_CHIP_SUPSAV_IXCSDR		0x8c2e
#define PCI_CHIP_SUPSAV_IXCDDR		0x8c2f

#define FB_ACCEL_SAVAGE4        0x80	/* S3 Savage4                   */
#define FB_ACCEL_SAVAGE3D       0x81	/* S3 Savage3D                  */
#define FB_ACCEL_SAVAGE3D_MV    0x82	/* S3 Savage3D-MV               */
#define FB_ACCEL_SAVAGE2000     0x83	/* S3 Savage2000                */
#define FB_ACCEL_SAVAGE_MX_MV   0x84	/* S3 Savage/MX-MV              */
#define FB_ACCEL_SAVAGE_MX      0x85	/* S3 Savage/MX                 */
#define FB_ACCEL_SAVAGE_IX_MV   0x86	/* S3 Savage/IX-MV              */
#define FB_ACCEL_SAVAGE_IX      0x87	/* S3 Savage/IX                 */
#define FB_ACCEL_PROSAVAGE_PM   0x88	/* S3 ProSavage PM133           */
#define FB_ACCEL_PROSAVAGE_KM   0x89	/* S3 ProSavage KM133           */
#define FB_ACCEL_S3TWISTER_P    0x8a	/* S3 Twister                   */
#define FB_ACCEL_S3TWISTER_K    0x8b	/* S3 TwisterK                  */
#define FB_ACCEL_SUPERSAVAGE    0x8c    /* S3 Supersavage               */
#define FB_ACCEL_PROSAVAGE_DDR  0x8d	/* S3 ProSavage DDR             */
#define FB_ACCEL_PROSAVAGE_DDRK 0x8e	/* S3 ProSavage DDR-K           */

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
#define SAVAGE_NEWMMIO_REGBASE_S3    0x1000000  /* 16MB */
#define SAVAGE_NEWMMIO_REGBASE_S4    0x0000000

#define savage_readb(mmio_base, where)                     \
        *((volatile char *) (mmio_base + where))

#define savage_readw(mmio_base, where)                     \
        *((volatile short *) (mmio_base + where))

#define savage_readl(mmio_base, where)                     \
        *((volatile int *) (mmio_base + where))

#define savage_writeb(mmio_base, where, val)                              \
	*((volatile char *) (mmio_base + where)) = (volatile char) val

#define savage_writew(mmio_base, where, val)                              \
	*((volatile short *) (mmio_base + where)) = (volatile short) val

#define savage_writel(mmio_base, where, val)                              \
	*((volatile int *) (mmio_base + where)) = (volatile int) val

typedef enum {
  S3_UNKNOWN = 0,
  S3_SAVAGE3D,
  S3_SAVAGE_MX,
  S3_SAVAGE4,
  S3_PROSAVAGE,
  S3_SUPERSAVAGE,
  S3_SAVAGE2000,
  S3_LAST
} savage_chipset;

struct s3_device {
	int id;
	int chip;
};

static struct s3_device savage_device[] =  {
	{PCI_CHIP_SUPSAV_MX128, FB_ACCEL_SUPERSAVAGE},
	{PCI_CHIP_SUPSAV_MX64, FB_ACCEL_SUPERSAVAGE},
	{PCI_CHIP_SUPSAV_MX64C, FB_ACCEL_SUPERSAVAGE},
	{PCI_CHIP_SUPSAV_IX128SDR, FB_ACCEL_SUPERSAVAGE},
	{PCI_CHIP_SUPSAV_IX128DDR, FB_ACCEL_SUPERSAVAGE},
	{PCI_CHIP_SUPSAV_IX64SDR, FB_ACCEL_SUPERSAVAGE},
	{PCI_CHIP_SUPSAV_IX64DDR, FB_ACCEL_SUPERSAVAGE},
	{PCI_CHIP_SUPSAV_IXCSDR, FB_ACCEL_SUPERSAVAGE},
	{PCI_CHIP_SUPSAV_IXCDDR, FB_ACCEL_SUPERSAVAGE},
	{PCI_CHIP_SAVAGE4, FB_ACCEL_SAVAGE4},
	{PCI_CHIP_SAVAGE3D, FB_ACCEL_SAVAGE3D},
	{PCI_CHIP_SAVAGE3D_MV, FB_ACCEL_SAVAGE3D_MV},
	{PCI_CHIP_SAVAGE2000, FB_ACCEL_SAVAGE2000},
	{PCI_CHIP_SAVAGE_MX_MV, FB_ACCEL_SAVAGE_MX_MV},
	{PCI_CHIP_SAVAGE_MX, FB_ACCEL_SAVAGE_MX},
	{PCI_CHIP_SAVAGE_IX_MV, FB_ACCEL_SAVAGE_IX_MV},
	{PCI_CHIP_SAVAGE_IX, FB_ACCEL_SAVAGE_IX},
	{PCI_CHIP_PROSAVAGE_PM, FB_ACCEL_PROSAVAGE_PM},
	{PCI_CHIP_PROSAVAGE_KM, FB_ACCEL_PROSAVAGE_KM},
	{PCI_CHIP_S3TWISTER_P, FB_ACCEL_S3TWISTER_P},
	{PCI_CHIP_S3TWISTER_K, FB_ACCEL_S3TWISTER_K},
	{PCI_CHIP_PROSAVAGE_DDR, FB_ACCEL_PROSAVAGE_DDR},
	{PCI_CHIP_PROSAVAGE_DDRK, FB_ACCEL_PROSAVAGE_DDRK},
};	

int main(int argc, char *argv[])
{
	int mem, j, accel, chip, pbase;
	unsigned char i, *mmio;
	int vgaCRIndex = 0x3d4;
	int vgaCRReg = 0x3d5;

	mem = open("/dev/mem", O_RDWR);

	if (mem == -1)
		exit(1);
	
	for (i = 0; i < ARRAY_SIZE(savage_device); i++) {
		if (savage_device[i].id == PCI_ID) {
			accel = savage_device[i].chip;
			break;
		}
	}

	switch (accel) {
	case FB_ACCEL_SUPERSAVAGE:
		chip = S3_SUPERSAVAGE;
		printf("SuperSavage");
		break;
	case FB_ACCEL_SAVAGE4:
		chip = S3_SAVAGE4;
		printf("Savage4");
		break;
	case FB_ACCEL_SAVAGE3D:
		chip = S3_SAVAGE3D;
		printf("Savage3D");
		break;
	case FB_ACCEL_SAVAGE3D_MV:
		chip = S3_SAVAGE3D;
		printf("Savage3D-MV");
		break;
	case FB_ACCEL_SAVAGE2000:
		chip = S3_SAVAGE2000;
		printf("Savage2000");
		break;
	case FB_ACCEL_SAVAGE_MX_MV:
		chip = S3_SAVAGE_MX;
		printf("Savage/MX-MV");
		break;
	case FB_ACCEL_SAVAGE_MX:
		chip = S3_SAVAGE_MX;
		printf("Savage/MX");
		break;
	case FB_ACCEL_SAVAGE_IX_MV:
		chip = S3_SAVAGE_MX;
		printf("Savage/IX-MV");
		break;
	case FB_ACCEL_SAVAGE_IX:
		chip = S3_SAVAGE_MX;
		printf("Savage/IX");
		break;
	case FB_ACCEL_PROSAVAGE_PM:
		chip = S3_PROSAVAGE;
		printf("ProSavagePM");
		break;
	case FB_ACCEL_PROSAVAGE_KM:
		chip = S3_PROSAVAGE;
		printf("ProSavageKM");
		break;
	case FB_ACCEL_S3TWISTER_P:
		chip = S3_PROSAVAGE;
		printf("TwisterP");
		break;
	case FB_ACCEL_S3TWISTER_K:
		chip = S3_PROSAVAGE;
		printf("TwisterK");
		break;
	case FB_ACCEL_PROSAVAGE_DDR:
		chip = S3_PROSAVAGE;
		printf("ProSavageDDR");
		break;
	case FB_ACCEL_PROSAVAGE_DDRK:
		chip = S3_PROSAVAGE;
		printf("ProSavage8");
		break;
	}

	printf("\n");

	if ((chip >= S3_SAVAGE3D) && (chip <= S3_SAVAGE_MX))
		pbase = PCI_PBASE + SAVAGE_NEWMMIO_REGBASE_S3;
	else
		pbase = PCI_PBASE + SAVAGE_NEWMMIO_REGBASE_S4;

	mmio = mmap(NULL, 512 * 1024, PROT_WRITE | PROT_READ, MAP_SHARED, mem,
		    pbase);

	if (!mmio)
		exit(1);
	
	for (i = 0; i < 0x70; i++) {
		if (!(i % 16))
			printf("\nSR%xx ", i >> 4);
		savage_writeb(mmio, 0x3c4 + 0x8000, i);
		printf(" %02x", savage_readb(mmio, 0x8000 + 0x3c5));
	}

	for (i = 0; i < 0xB7; i++) {
		if (!(i % 16))
			printf("\nCR%xx ", i >> 4);
		savage_writeb(mmio, 0x8000 + vgaCRIndex, i);
		printf(" %02x", savage_readb(mmio, 0x8000 + vgaCRReg));
	}

	printf("\n\n");

	exit(0);
}

--------------090301070204090308040004--



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
