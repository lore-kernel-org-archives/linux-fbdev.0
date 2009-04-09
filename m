From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Xilinx : Framebuffer Driver: Add PLB support (non-DCR)
Date: Thu, 9 Apr 2009 10:33:19 -0400
Message-ID: <20090409143319.GG18304@zod.rchland.ibm.com>
References: <20090408211521.D0EF411B8054@mail214-sin.bigfish.com>
	<20090409124634.GF18304@zod.rchland.ibm.com>
	<c8485d470904090706t4fd2893tdeaf3710b19bd0f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
Content-Disposition: inline
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
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Suneel <suneelg@xilinx.com>, linuxppc-dev@ozlabs.org, Suneel <"[mailto:suneel.garapati@xilinx.com]"@xilinx.com>, akonovalov@ru.mvista.com, John Linn <john.linn@xilinx.com>

On Thu, Apr 09, 2009 at 04:06:56PM +0200, Roderick Colenbrander wrote:
>On Thu, Apr 9, 2009 at 2:46 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com>wrote:
>> > #define NUM_REGS      2
>> > #define REG_FB_ADDR   0
>> >@@ -112,6 +123,11 @@ struct xilinxfb_drvdata {
>> >
>> >       struct fb_info  info;           /* FB driver info record */
>> >
>> >+      u32             regs_phys;      /* phys. address of the control
>> >+                                              registers */
>>
>> Is this driver usable on the 440 based Xilinx devices?  If so, is it
>> possible
>> to have the physical address of the registers above 4GiB, so is common with
>> almost all the I/O on the other 440 boards?
>>
>>
>The driver works fine on 440 based Xilinx boards (the ML510 I use has a 440
>core). It might be nice to move physical addresses above 4GB for devices but
>in all Xilinx tools and reference designs addresses below 4GB are used for
>periperhals and I think even below 2GB (or even below 1GB). It depends on
>the design.

Right.  The "depends on the design" part is what I'm worried about.  Perhaps
using resource_size_t here is more appropriate, given that designs can change
and put the regs above 4GiB.  That way you can set the Kconfig option
appropriately for both cases.

josh
