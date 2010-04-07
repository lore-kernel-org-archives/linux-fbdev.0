From: Roger Quadros <roger.quadros@nokia.com>
Date: Wed, 07 Apr 2010 07:38:57 +0000
Subject: Re: [PATCH 0/5] OMAP: RX51: Add LCD Panel Support for N900
Message-Id: <4BBC3691.3030505@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com>	<87pr2datft.fsf@small.ssi.corp> <4BBB03F2.5050706@nokia.com>	<87iq84cnzg.fsf@small.ssi.corp>	<1270618692.2447.39.camel@tubuntu.research.nokia.com> <87r5mrzpe4.fsf@small.ssi.corp>
In-Reply-To: <87r5mrzpe4.fsf@small.ssi.corp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Arnaud Ebalard <arno@natisbad.org>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

ext Arnaud Ebalard wrote:
> Hi Tomi,
> 
> Tomi Valkeinen <tomi.valkeinen@nokia.com> writes:
> 
>> On Tue, 2010-04-06 at 22:41 +0200, ext Arnaud Ebalard wrote:
>>
>>> For the records, just in case someone wants to do the same, I had to
>>> use: 
>>>
>>>    /sbin/getty 115200 tty0 -n -l /bin/sh
>>>
>>> I also had to set CONFIG_KEYBOARD_TWL4030 to get the keyboard
>>> working. Any reason for that option not be enabled by default in
>>> rx51_defconfig?
>>>
>>> Additionally, after something like 25 seconds, the screen goes black and
>>> the device stops. Any clue? Can be panel realted?
>> I'm guessing here, but it could be the HW watchdog kicking in if by
>> "device stops" you mean that serial etc also stops. Although it should
>> reboot, not stop...
> 
> Well, it's a stock N900, not a development board so I don't have a
> serial; only the screen and the led in the left corner below the
> screen. By "device stops" I mean that the screen and the led (which was
> previously on) get dark and stay as is.
> 
> I also suspected a HW watchdog but 25 seconds did not sound like it. I
> built a kernel without HW watchdog: same result.
> 
> Any idea regarding how I could debug that?
> 
You can try disabling the hw watchdogs via flasher.

sudo flasher --set-rd-flags=no-omap-wd,no-ext-wd,no-lifeguard-reset

This should prevent any watchdog resets.


To restore to factory settings do

sudo flasher --disable-rd-mode


cheers,
-roger
