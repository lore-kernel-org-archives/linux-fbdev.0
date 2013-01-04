From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Date: Fri, 04 Jan 2013 07:08:12 +0000
Subject: Re: [BUGFIX PATCH] video: mxsfb: fix crash when unblanking the display
Message-Id: <50E67FDC.3000905@bluegiga.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353588555-13168-1-git-send-email-LW@KARO-electronics.de>
 <20663.19785.221750.909491@ipc1.ka-ro>
In-Reply-To: <20663.19785.221750.909491@ipc1.ka-ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On 11/29/2012 01:55 PM, Lothar Waßmann wrote:
> Hi,
>
> adding Juergen Beisert as the driver's author to the recipient list.
>
> Lothar Waßmann writes:
>> The VDCTRL4 register does not provide the MXS SET/CLR/TOGGLE feature.
>> The write in mxsfb_disable_controller() sets the data_cnt for the LCD
>> DMA to 0 which obviously means the max. count for the LCD DMA and
>> leads to overwriting arbitrary memory when the display is unblanked.
>>
>> Note: I already sent this patch in December 2011 but noone picked it up obviously.
>>
>> Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>

Tested-by: Lauri Hintsala <lauri.hintsala@bluegiga.net>

This fixes the CPU freezing. I really recommend to apply this patch into 
mainline soon because unblanking freezes the whole system!!!

Default value of consoleblank parameter is 600 seconds and the whole 
system crashes every time when framebuffer console is activated after 
that timeout. I wonder why this issue is still open in mainline kernel.

Should this patch be added into stable versions too?

Best Regards,
Lauri Hintsala
