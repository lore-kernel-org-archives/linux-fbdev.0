From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Fri, 08 Mar 2013 09:37:45 +0000
Subject: Re: [PATCH 0/5] at91: atmel_lcdfb: regression fixes and cpu_is removal
Message-Id: <5139B169.7050807@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1360340791.git.nicolas.ferre@atmel.com>
 <20130210004740.GH16278@quad.lixom.net>
 <CAMgPeKV4=C_msvZixVS-o3-QHaJxZP7T4EwLa9vnmYgVheXHgQ@mail.gmail.com>
In-Reply-To: <CAMgPeKV4=C_msvZixVS-o3-QHaJxZP7T4EwLa9vnmYgVheXHgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 02/10/2013 07:45 PM, Johan Hovold :
> On Sun, Feb 10, 2013 at 1:47 AM, Olof Johansson <olof@lixom.net> wrote:
>> On Fri, Feb 08, 2013 at 05:35:13PM +0100, Nicolas Ferre wrote:
>>> These patches fix a regression in 16-bpp support for older SOCs which
>>> use IBGR:555 rather than BGR:565 pixel layout. Use SOC-type to
>>> determine if the controller uses the intensity-bit and restore the
>>> old layout in that case.
>>>
>>> The last patch is a removal of uses of cpu_is_xxxx() macros in
>>> atmel_lcdfb with a platform-device-id table and static
>>> configurations.
>>>
>>>
>>> Patches from Johan Hovold taken from: "[PATCH 0/3] atmel_lcdfb: fix
>>> 16-bpp regression" and "[PATCH v2 0/3] ARM: at91/avr32/atmel_lcdfb:
>>> remove cpu_is macros" patch series to form a clean patch series with
>>> my signature.
>>>
>>> Arnd, Olof, as it seems that old fbdev drivers are not so much
>>> reviewed those days, can we take the decision to queue this material
>>> through arm-soc with other AT91 drivers updates?
>>
>> It would be beneficial to get an ack from Florian. Was he involved in
>> the review of the code that regressed 16-bpp support in the first
>> place? When was the regression introduced?
> 
> In v3.4 by commit 787f9fd2328 ("atmel_lcdfb: support 16bit BGR:565 mode,
> remove unsupported 15bit modes").

Arnd, Olof,

Please tell me if I can do something to ease the adoption of these
patches during 3.9-rc timeframe (I can rebase it on top of 3.9-rc1 to
avoid any conflict: the file board-neocore926.c was removed during the
merge window).
Johan has written the series a long time ago and we still do not have it
in mainline.

If the option to ask Andrew is better in your opinion, please tell me.

Best regards,
-- 
Nicolas Ferre
