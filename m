From: <JosephChan@via.com.tw>
Subject: Re: [PATCH 1/9] viafb: VIA Frame Buffer Device
	Driver - Resend
Date: Thu, 8 May 2008 08:51:37 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F6783B@exchtp03.taipei.via.com.tw>
References: <20080507184333.7d0f1bf4.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1235426522=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtuMU-0004dh-Sh for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 17:51:55 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JtuMT-0000Qn-0H
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 17:51:54 -0700
Content-class: urn:content-classes:message
In-Reply-To: <20080507184333.7d0f1bf4.krzysztof.h1@poczta.fm>
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
To: krzysztof.h1@poczta.fm
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org

--===============1235426522==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="Big5"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thanks for your reviewing.
I will ask our engineers to check what you mentioned and suggested.
In addition, the original vt8623fb (CLE266) wasn't developed by VIA. So =
it might depend on the decision of kernel community.

BRs,
Joseph Chan=20

-----Original Message-----
From: Krzysztof Helt [mailto:krzysztof.h1@poczta.fm]=20
Sent: Thursday, May 08, 2008 12:44 AM
To: Joseph Chan
Cc: akpm@linux-foundation.org; geert@linux-m68k.org; =
linux-fbdev-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [PATCH 1/9] viafb: VIA Frame Buffer =
Device Driver - Resend

Hi Joseph,

You have sent tremendous amount of work.=20

I am trying to point some mistakes or improvements, but I won't cover =
the whole code at the moment. Look at them and check if the rest of the =
code can be improved as well.

A general comment is that you use to many global variables. You should =
move some of them into the viafb_par structure.
Does any of supported devices support multi-head? If so you may prefer =
to have allocated fb_info and viafb_par structure to hold data required =
for each display separated (e.g. for different types of displays =
connected to both heads).

See below for problems I have spotted (in quick look over).

Regards,
Krzysztof

PS. I assume that your driver will replace the existing vt8623fb =
(CLE266?) driver when ready. Am I right?

On Wed, 7 May 2008 19:06:48 +0800
<JosephChan@via.com.tw> wrote:

(...)
> diff -Nur a/drivers/video/via/accel.c b/drivers/video/via/accel.c
> --- a/drivers/video/via/accel.c	1969-12-31 19:00:00.000000000 -0500
> +++ b/drivers/video/via/accel.c	2008-04-29 02:51:13.000000000 -0400
> @@ -0,0 +1,245 @@
> +/*
> + * Copyright 1998-2008 VIA Technologies, Inc. All Rights Reserved.
> + * Copyright 2001-2008 S3 Graphics, Inc. All Rights Reserved.
> +
> + * This program is free software; you can redistribute it and/or=20
> + modify
> + * it under  the terms of the GNU General Public License as published
> + * by the Free Software Foundation; either version 2, or (at your
> + option)

Somehow this line got wrapped against your intention, I suppose.

> +#include "global.h"
> +
> +void init_accel(void)
> +{
> +	parinfo.cursor_start =3D parinfo.fbmem_free - CURSOR_SIZE;
> +	parinfo.fbmem_free -=3D CURSOR_SIZE;

You can swap these two lines to get shorter code:
parinfo.fbmem_free -=3D CURSOR_SIZE;
parinfo.cursor_start =3D parinfo.fbmem_free;

> +
> +	/* Reverse 8*1024 memory space for cursor image of the XServer */
> +	parinfo.VQ_start =3D parinfo.fbmem_free - CURSOR_SIZE - VQ_SIZE;
> +	parinfo.VQ_end =3D parinfo.VQ_start + VQ_SIZE - 1;
> +	parinfo.fbmem_free -=3D (CURSOR_SIZE + VQ_SIZE);
> +	parinfo.fbmem_used +=3D (CURSOR_SIZE + VQ_SIZE); }
> +

Again, swap the third and the first line.

> +	if (parinfo.VQ_start !=3D 0) {
> +		/* Enable VQ */
> +		dwVQStartAddr =3D parinfo.VQ_start;
> +		dwVQEndAddr =3D parinfo.VQ_end;
> +		switch (chip_info.gfx_chip_name) {
> +		case UNICHROME_K8M890:
> +		case UNICHROME_P4M900:
> +			dwVQStartL =3D 0x70000000 | (dwVQStartAddr & 0xFFFFFF);
> +			dwVQEndL =3D 0x71000000 | (dwVQEndAddr & 0xFFFFFF);
> +			dwVQStartEndH =3D
> +			    0x72000000 | ((dwVQStartAddr & 0xFF000000) >>
> +					  24) | ((dwVQEndAddr & 0xFF000000)
> +						 >> 16);
> +			dwVQLen =3D 0x73000000 | (VQ_SIZE >> 3);
> +			break;
> +		default:
> +			dwVQStartL =3D 0x50000000 | (dwVQStartAddr & 0xFFFFFF);
> +			dwVQEndL =3D 0x51000000 | (dwVQEndAddr & 0xFFFFFF);
> +			dwVQStartEndH =3D
> +			    0x52000000 | ((dwVQStartAddr & 0xFF000000) >>
> +					  24) | ((dwVQEndAddr & 0xFF000000)
> +						 >> 16);
> +			dwVQLen =3D 0x53000000 | (VQ_SIZE >> 3);

You can move the default case before switch the only or the 0x20000000 =
bit in case of the K8M890 or P4M900 chipsets. It will show that you set =
actually the same values (except one bit) for both.

> +
> +int wait_engine_idle(void)
> +{
> +	int loop =3D 0;
> +
> +	while (!(MMIO_IN32(VIA_REG_STATUS) & VIA_VR_QUEUE_BUSY)
> +	       && (loop++ < MAXLOOP)) ;
> +
> +	while ((MMIO_IN32(VIA_REG_STATUS) &
> +		(VIA_CMD_RGTR_BUSY | VIA_2D_ENG_BUSY | VIA_3D_ENG_BUSY)) &&
> +	       (loop++ < MAXLOOP)) ;
> +

You can add cpu_relax() call into these waiting loops.

> diff -Nur a/drivers/video/via/accel.h b/drivers/video/via/accel.h
> --- a/drivers/video/via/accel.h	1969-12-31 19:00:00.000000000 -0500
> +++ b/drivers/video/via/accel.h	2008-04-29 02:51:14.000000000 -0400
> @@ -0,0 +1,190 @@
> +/*
> + * Copyright 1998-2008 VIA Technologies, Inc. All Rights Reserved.
> + * Copyright 2001-2008 S3 Graphics, Inc. All Rights Reserved.
> +
> + * This program is free software; you can redistribute it and/or=20
> + modify
> + * it under  the terms of the GNU General Public License as published
> + * by the Free Software Foundation; either version 2, or (at your
> + option)

Again, wrapped.

> + * any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTIES OR REPRESENTATIONS; without even
> + * the implied warranty of MERCHANTABILITY or FITNESS FOR
> + * A PARTICULAR PURPOSE.See the GNU General Public License
> + * for more details.
> +
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc.,
> + * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + */
> +
> +#ifndef __ACCEL_H__
> +#define __ACCEL_H__
> +
> +#ifndef FB_ACCEL_VIA_UNICHROME
> +#define FB_ACCEL_VIA_UNICHROME  50
> +#endif

This is the only place you define FB_ACCEL_VIA_UNICHROME. If so you =
don't need to do #ifndef.

> +
> +#ifndef VIA_MMIO
> +#define VIA_MMIO 1
> +#endif
> +

The same as the above.

> +#if VIA_MMIO
> +#define MMIO_OUT8(reg, val)  writeb(val, parinfo.io_virt + reg)=20
> +#define MMIO_OUT16(reg, val) writew(val, parinfo.io_virt + reg)=20
> +#define MMIO_OUT32(reg, val) writel(val, parinfo.io_virt + reg)

These lines get wrapped badly.

> +#define MMIO_IN8(reg)       readb(parinfo.io_virt + reg)
> +#define MMIO_IN16(reg)      readw(parinfo.io_virt + reg)
> +#define MMIO_IN32(reg)      readl(parinfo.io_virt + reg)
> +
> +#else
> +#define MMIO_OUT8(reg, val)  outb(val, reg) #define MMIO_OUT16(reg,
> +val) outw(val, reg) #define MMIO_OUT32(reg, val) outl(val, reg)
> +#define MMIO_IN8(reg)       inb(reg)
> +#define MMIO_IN16(reg)      inw(reg)
> +#define MMIO_IN32(reg)      inl(reg)
> +#endif
> +

Your devices seem to be 32-bit only because 8 and 16-bit accesses are =
never used. You can remove these macros.

> diff -Nur a/drivers/video/via/chip.h b/drivers/video/via/chip.h
> --- a/drivers/video/via/chip.h	1969-12-31 19:00:00.000000000 -0500
> +++ b/drivers/video/via/chip.h	2008-04-29 02:51:15.000000000 -0400
> @@ -0,0 +1,189 @@
> +/*
> + * Copyright 1998-2008 VIA Technologies, Inc. All Rights Reserved.
> + * Copyright 2001-2008 S3 Graphics, Inc. All Rights Reserved.
> +
> + * This program is free software; you can redistribute it and/or=20
> + modify
> + * it under  the terms of the GNU General Public License as published
> + * by the Free Software Foundation; either version 2, or (at your
> + option)

Wrapped. Check all other files for this.

> diff -Nur a/drivers/video/via/dvi.c b/drivers/video/via/dvi.c
> --- a/drivers/video/via/dvi.c	1969-12-31 19:00:00.000000000 -0500
> +++ b/drivers/video/via/dvi.c	2008-05-04 07:28:49.000000000 -0400
> @@ -0,0 +1,721 @@
(...)
> +
> +/* Sense DVI Connector */
> +int dvi_sense(void)
> +{
> +	u8 RegSR1E =3D 0, RegSR3E =3D 0, RegCR6B =3D 0, RegCR91 =3D 0, =
RegCR93 =3D
> +	    0, RegCR9B =3D 0, data;

There is no need to initialize these variables. They are set before use =
(and if not a compiler will generate warning).

(...)
> +	/* Restore status */
> +	if (chip_info.gfx_chip_name =3D=3D UNICHROME_CLE266) {
> +		write_reg(SR1E, VIASR, RegSR1E);
> +		write_reg(CR6B, VIACR, RegCR6B);
> +		write_reg(CR91, VIACR, RegCR91);
> +		write_reg(CR93, VIACR, RegCR93);
> +	} else {
> +		write_reg(SR1E, VIASR, RegSR1E);
> +		write_reg(SR3E, VIASR, RegSR3E);
> +		write_reg(CR91, VIACR, RegCR91);
> +		write_reg(CR9B, VIACR, RegCR9B);
> +	}
> +

You can  put at least the first line before the if. Make common code =
just single instance (the third line can be moved if sequence is not =
important).

> +int dvi_get_panel_size_from_DDCv1(void)
> +{
> +	int i, max_h =3D 0, max_v =3D 0, tmp, restore;
> +	unsigned char rData;
> +	unsigned char EDID_DATA[18];
> +
> +	DEBUG_MSG(KERN_INFO "\n dvi_get_panel_size_from_DDCv1 \n");
> +
> +	restore =3D chip_info.tmds_chip_info.tmds_chip_slave_addr;
> +	chip_info.tmds_chip_info.tmds_chip_slave_addr =3D 0xA0;
> +
> +	for (i =3D 0x23; i < 0x6D; i++) {
> +		switch (i) {
> +		case 0x23:
> +			rData =3D tmds_register_read(0x23);
> +			if (rData & 0x3C)
> +				max_h =3D 640;
> +			if (rData & 0xC0)
> +				max_h =3D 720;
> +			if (rData & 0x03)
> +				max_h =3D 800;
> +			break;
> +		case 0x24:
> +			rData =3D tmds_register_read(0x24);
> +			if (rData & 0xC0)
> +				max_h =3D 800;
> +			if (rData & 0x1E)
> +				max_h =3D 1024;
> +			if (rData & 0x01)
> +				max_h =3D 1280;
> +			break;

You can move these two cases before the loop and change loop's range.

(...)
> +			if (via_bus_width =3D=3D 24) {
> +				if (device_lcd_dualedge =3D=3D 1)
> +					i2cWriteByte(chip_info.
> +						     tmds_chip_info.
> +						     tmds_chip_slave_addr,
> +						     0x08, 0x3F);
> +				else
> +					i2cWriteByte(chip_info.
> +						     tmds_chip_info.
> +						     tmds_chip_slave_addr,
> +						     0x08, 0x37);

These to branches differs only by the set value. It is shorter to set =
value inside if-else the call i2cWriteByte after.


----------------------------------------------------------------------
Sprawdz, czy jestes prawdziwym internauta!
Kliknij http://link.interia.pl/f1d6e



--===============1235426522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============1235426522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1235426522==--
