From: Ondrej Zary <linux@rainbow-software.org>
Date: Thu, 02 Aug 2012 21:13:48 +0000
Subject: Re: viafb on Clevo M5x0V laptop (+VT1631L)
Message-Id: <201208022313.48729.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201208022003.28404.linux@rainbow-software.org> <501AE71A.80903@gmx.de>
In-Reply-To: <501AE71A.80903@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Thursday 02 August 2012 22:46:18 Florian Tobias Schandinat wrote:
> Hi Ondrej,
>
> On 08/02/2012 06:03 PM, Ondrej Zary wrote:
> > Hello,
> > I've got a Clevo M5x0V laptop which has VIA PM800 chipset (1106:3118) and
> > 1280x768 LCD panel connected using VT1631L LVDS transmitter. There's a
> > schematic of this laptop available on the web which shows that VT1631L's
> > I2C port is not connected anywhere...
> >
> > viafb does not work properly - LCD panel (and backlight) is turned off
> > upon module load and there's 640x480 signal on VGA connector (even when
> > monitor was not connected during module load).
>
> Yes, that's the default (640x480-60 on the VGA output) that VIA selected
> when they wrote the module. I tried to add some auto detect mechanism,
> but I guess in your case it wouldn't help, even if it were complete. The
> traditional way to use viafb is via module parameters as described in
> Documentation/fb/viafb.txt
> In your case something like this might work:
> viafb_mode80x768 viafb_lcd_panel_id=3 viafb_active_dev=LCD

Thank you very much, it works with these parameters! Looks like viafb can wake 
up the chip from S3, only the colors are messed up (X<->VT switch fixes 
that).

> Additionally it might be required to add viafb_lcd_port with any of
> DVP0, DVP1, DFP_HIGHLOW, DFP_HIGH, DFP_LOW.
>
> > Looking at the code, there's almost nothing for VT1631. What needs to be
> > done in order for the LCD to work? Xorg seems to work using openchrome
> > (but it is not able to restore the card on resume from S3):
> > (II) CHROME(0): Unable to get panel size from EDID. Return code: 0
> > (II) CHROME(0): ViaPanelGetNativeModeFromScratchPad
> > (II) CHROME(0): Native Panel Resolution is 1280x768
>
> Interesting that they get the panel resolution from the scratch pad. The
> official documentation does not contain any useful information about it
> (and openchrome didn't work on any of my LCD devices that I tested,
> hence I didn't care whether they did have any code in that area)
> Maybe the above module parameters will help you, otherwise more
> investigation will be required.

Looking at openchrome and viafb code - the code is already present in viafb in 
fp_id_to_vindex() function in lcd.c. It even finds correct panel_id for me 
(3). But it looks like that the result is not used.

-- 
Ondrej Zary
