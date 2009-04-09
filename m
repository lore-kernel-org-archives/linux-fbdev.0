From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Xilinx : Framebuffer Driver: Add PLB support (non-DCR)
Date: Thu, 9 Apr 2009 07:34:37 -0700
Message-ID: <fa686aa40904090734o293e768aidc0f6817e537f675@mail.gmail.com>
References: <20090408211521.D0EF411B8054@mail214-sin.bigfish.com> 
	<20090409124634.GF18304@zod.rchland.ibm.com>
	<c8485d470904090706t4fd2893tdeaf3710b19bd0f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <c8485d470904090706t4fd2893tdeaf3710b19bd0f1@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Suneel <suneelg@xilinx.com>, linuxppc-dev@ozlabs.org, akonovalov@ru.mvista.com, John Linn <john.linn@xilinx.com>

On Thu, Apr 9, 2009 at 7:06 AM, Roderick Colenbrander
<thunderbird2k@gmail.com> wrote:
>
> On Thu, Apr 9, 2009 at 2:46 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com>
> wrote:
>>
>> On Wed, Apr 08, 2009 at 03:11:25PM -0600, John Linn wrote:
>> >From: Suneel <[mailto:suneel.garapati@xilinx.com]>
>> >
>> >Added support for the new xps tft controller.
>> >
>> >The new core has PLB interface support in addition to existing
>> >DCR interface.
>> >
>> >The driver has been modified to support this new core which
>> >can be connected on PLB or DCR bus.
>> >
>> >Signed-off-by: Suneel <suneelg@xilinx.com>
>> >Signed-off-by: John Linn <john.linn@xilinx.com>
>> >---
>> > drivers/video/xilinxfb.c | =A0227
>> > ++++++++++++++++++++++++++++++++--------------
>> > 1 files changed, 160 insertions(+), 67 deletions(-)
>> >
>> >diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
>> >index a82c530..a28a834 100644
>> >--- a/drivers/video/xilinxfb.c
>> >+++ b/drivers/video/xilinxfb.c
>> >@@ -1,17 +1,24 @@
>> > /*
>> >- * xilinxfb.c
>> > =A0*
>> >- * Xilinx TFT LCD frame buffer driver
>> >+ * Xilinx TFT frame buffer driver
>> > =A0*
>> > =A0* Author: MontaVista Software, Inc.
>> > =A0* =A0 =A0 =A0 =A0 source@mvista.com
>> > =A0*
>> > =A0* 2002-2007 (c) MontaVista Software, Inc.
>> > =A0* 2007 (c) Secret Lab Technologies, Ltd.
>> >+ * 2009 (c) Xilinx Inc.
>> > =A0*
>> >- * This file is licensed under the terms of the GNU General Public
>> > License
>> >- * version 2. =A0This program is licensed "as is" without any warranty=
 of
>> > any
>> >- * kind, whether express or implied.
>> >+ * This program is free software; you can redistribute it
>> >+ * and/or modify it under the terms of the GNU General Public
>> >+ * License as published by the Free Software Foundation;
>> >+ * either version 2 of the License, or (at your option) any
>> >+ * later version.
>> >+ *
>> >+ * You should have received a copy of the GNU General Public
>> >+ * License along with this program; if not, write to the Free
>> >+ * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
>> >+ * 02139, USA.
>> > =A0*/
>>
>> What Stephen said.
>>
>> > #define NUM_REGS =A0 =A0 =A02
>> > #define REG_FB_ADDR =A0 0
>> >@@ -112,6 +123,11 @@ struct xilinxfb_drvdata {
>> >
>> > =A0 =A0 =A0 struct fb_info =A0info; =A0 =A0 =A0 =A0 =A0 /* FB driver i=
nfo record */
>> >
>> >+ =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 regs_phys; =A0 =A0 =A0/* phys.=
 address of the control
>> >+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0registers */
>>
>> Is this driver usable on the 440 based Xilinx devices? =A0If so, is it
>> possible
>> to have the physical address of the registers above 4GiB, so is common
>> with
>> almost all the I/O on the other 440 boards?
>>
>
> The driver works fine on 440 based Xilinx boards (the ML510 I use has a 4=
40
> core). It might be nice to move physical addresses above 4GB for devices =
but
> in all Xilinx tools and reference designs addresses below 4GB are used for
> periperhals and I think even below 2GB (or even below 1GB). It depends on
> the design.

Regardless, it is good practice to use phys_addr_t instead of u32 for
physical addresses.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
