From: "Diego A. Fons" <diegofons@apexar.com>
Subject: Re: Problem with FB
Date: Wed, 30 May 2007 10:00:20 -0300
Message-ID: <465D7564.7000809@apexar.com>
References: <464B3527.4080406@apexar.com>
	<464D5A56.4070906@rfo.atmel.com>	<464DA279.6070404@apexar.com>
	<464DA8FA.6050303@rfo.atmel.com>	 <4655CC7D.6020600@apexar.com>
	<465AF2E1.9090705@rfo.atmel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HtO92-0000Gp-3Y for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 May 2007 06:23:20 -0700
Received: from smtp1.allytech.com ([200.49.145.100] helo=ns1.arsesco.com.ar)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HtO8z-0007tZ-B9
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 May 2007 06:23:20 -0700
In-Reply-To: <465AF2E1.9090705@rfo.atmel.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Nicolas Ferre escribi=F3:

> Diego A. Fons :
>
>> I was changing the timings values but it seems to get worse, with a =

>> set of values the screen moves with every ftp command thet sftp sends!
>> Now the values are (it doesn't work either):
>>
>> #define AT91_DM9000_NWE_SETUP           (8 << 0)
>> #define AT91_DM9000_NCS_WR_SETUP        (4 << 8)
>> #define AT91_DM9000_NRD_SETUP           (8 << 16)
>> #define AT91_DM9000_NCS_RD_SETUP        (4 << 24)
>>
>> #define AT91_DM9000_NWE_PULSE           (16 << 0)
>> #define AT91_DM9000_NCS_WR_PULSE        (32 << 8)
>> #define AT91_DM9000_NRD_PULSE           (16 << 16)
>> #define AT91_DM9000_NCS_RD_PULSE        (32 << 24)
>>
>> #define AT91_DM9000_NWE_CYCLE           (36 << 0)
>> #define AT91_DM9000_NRD_CYCLE           (36 << 16)
>>
>> #define AT91_DM9000_TDF                 (1 << 16)
>>
>> I test it with lower and higher values and nothing (with 1 and 127).
>>
>> Can you tell me how is it possible that the DM9000 timings interfere =

>> with the frame buffer?
>
>
> Well they both use the SDRam/EBI interface (in fact the ARM926 and the =

> LCD) and they may be in conflict some time to get the internal AHB bus =

> (H matrix).
> The idea is that one or the other master takes the bus for too long.
>
> What can help us is if you can also check if the fifo underflow UFLWIS =

> bit (#4) rises during LDC use.
>
> So, if the LCD is interrupted during a data burst from sdram, it can =

> have difficulties to resume its transfer. You can try to lower the =

> configured burst length on the LCD : ATMEL_LCDC_DMA_BURST_LEN =3D 4 (so =

> the register field must be written with 0x3) instead of 8.
>
> Another option will be to keep the burst length and increase the slot =

> cycle in the Matrix interface (from 16->32 or 64). It is the preferred =

> one. This is done in the AT91bootstrap but you can do it for testing =

> using a jtag ice.
>
> Keep me informed, Cheers,

Good news!... kind of :(

I was working in this problem and i was able to get a solution but it is =

not a good practice.
First of all i have to add a line in the at91_add_device_lcdc function =

(ah! i made this tests using kernel 2.6.21):

File: arch/arm/mach-at91/at91sam9261_devices.c
Function: at91_add_device_lcdc()
Line: at91_set_A_periph(AT91_PIN_PB0, 0);

This line enables the Vertical Sync of the LCD, i don't know why it is =

not set by default, so i didnt' have any vertical signal so the display =

didn't work.

Second. I set the fifo underflow interrupt to see if the problem was a =

buffer underflow and it's that way, the interrupt occurs so the probles =

is that display run out of data. I could solve this by calling a =

function that resets all de lcd driver, also i kept enable the =

interruptions all the time. This is the modified function (in the driver =

file, drivers/video/atmel_lcdfb.c):

static irqreturn_t atmel_lcdfb_interrupt(int irq, void *dev_id)
{
        struct fb_info *info =3D dev_id;
        struct atmel_lcdfb_info *sinfo =3D info->par;
        u32 status;

        status =3D lcdc_readl(sinfo, ATMEL_LCDC_ISR);

        // this is the reset call
        atmel_lcdfb_set_par(info);

        //lcdc_writel(sinfo, ATMEL_LCDC_IDR, status);
        lcdc_writel(sinfo, ATMEL_LCDC_ICR, status);

        return IRQ_HANDLED;
}

And the function atmel_lcdfb_set_par was modified to keep enable the =

interruptions:

static int atmel_lcdfb_set_par(struct fb_info *info)
{
...

        // Added this line at the botom, the rest remains the same
        lcdc_writel(sinfo, ATMEL_LCDC_IER, 0x00000010);
        return 0;
}

With this modifications when the screens moves, it reset the parameters =

and you see the screen go down and up.
The question is: is there an elegant way to solve this?

Third. I was trying to reconfigure the Matrix from linx but all i got =

was a coredump from the kernel itself. I'm not able to configure it at =

boot time because i'm using u-boot (and i'm not able to flash a new =

compiled version).

Well, that's it. Sorry for the long mail.I'll be waiting an advise from you.

Best regards,
Diego A. Fons.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
