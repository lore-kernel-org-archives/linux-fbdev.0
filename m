From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Date: Sat, 24 Oct 2015 09:33:03 +0000
Subject: Re: [PATCH v4 4/4] ARM: dts: sun6i: Add dts file for MSI Primo81 tablet
Message-Id: <20151024123303.3617260e@i7>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1445572241-13259-1-git-send-email-wens@csie.org>
 <1445572241-13259-5-git-send-email-wens@csie.org>
 <20151023145309.GA1885@excalibur.cnev.de>
 <CAGb2v67HO5isvUxG09traLUBrBp-0Bea9cXn_O0oqBCTYtfN=w@mail.gmail.com>
In-Reply-To: <CAGb2v67HO5isvUxG09traLUBrBp-0Bea9cXn_O0oqBCTYtfN=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

On Fri, 23 Oct 2015 23:46:59 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Fri, Oct 23, 2015 at 10:53 PM, Karsten Merker <merker@debian.org> wrote:
> > On Fri, Oct 23, 2015 at 11:50:41AM +0800, Chen-Yu Tsai wrote:
> >
> >> From: Karsten Merker <merker@debian.org>
> >>
> >> The MSI Primo81 is an A31s based tablet, with 1G RAM, 16G NAND,
> >> 768x1024 IPS LCD display, mono speaker, 0.3 MP front camera, 2.0 MP
> >> rear camera, 3500 mAh battery, gt911 touchscreen, mma8452 accelerometer
> >> and rtl8188etv usb wifi. Has "power", "volume+" and "volume-" buttons
> >> (both volume buttons are also connected to the UBOOT_SEL pin). The
> >
> > Hello Chen-Yu,
> >
> > the volume button function is something that I wanted to confirm
> > again but forgot to ask previously: Siarhei had pointed out that
> > only the volume+ button triggers UBOOT_SEL, but for me actually
> > both volume buttons work as described above.  Could you
> > cross-check that on your Primo81?
> 
> IIRC both work. I can test next week.

Both buttons work this way because the Allwinner's firmware
additionally checks the buttons state via LRADC and switches
into the FEL mode in a software way. But if somebody flashes a
broken bootloader to NAND (something that is recognized by the
BROM, but dies instead of booting) then we may potentially have
a bricked device because booting from NAND has the highest
priority on A31s.

The UBOOT_SEL pin on the SoC can be used to change the default
boot order and allow to boot from the SD card or USB first
regardless of what is in NAND. So if at least one of the hardware
buttons is connected to the UBOOT_SEL pin, then we have an
unbrickable device.

Checking whether the hardware button is really connected to the
UBOOT_SEL pin can be done by reading the SRAM_VER_REG hardware
register and looking at the BOOT_SEL_PAD_STA bits:
    http://linux-sunxi.org/SRAM_Controller_Register_Guide#SRAM_VER_REG

And this can be done, for example, via using the devmem2 tool:
    "devmem2 0x01c00024"

Alternatively, it is also possible to use a modified variant of the
dialog tool, which is additionally polling the state of the FEL
button and interpreting long FEL button press as KEY_ENTER and
short press as KEY_DOWN:
    https://github.com/ssvb/dialog-sunxi

This patched dialog tool is a part of the board type selection stub,
used for creating universal board-independent SD card based installers
for Allwinner devices, which has been available for Linux distribution
maintainers since a while ago:
    http://lists.denx.de/pipermail/u-boot/2015-January/202306.html

Regarding the UBOOT_SEL pin in the MSI Primo81 tablet. After
buying this tablet, I was happy to confirm that at least the
"volume+" button is connected to the UBOOT_SEL pin, making the
tablet unbrickable. However appears that it was not just some sane
decision made by MSI engineers, but in fact connecting both LRADC
and UBOOT_SEL to tablet buttons is a part of the standard Allwinner's
reference schematics. One can search for "a20_pad_std_v1_1.pdf",
"a13-sch.pdf", "A31_PAD_STD_V1_90_130225.pdf" documents on the
Internet to find this information. Basically, we should expect
the majority of Allwinner A31(s) tablets to have a hardware FEL
button and be perfectly unbrickable :-)

-- 
Best regards,
Siarhei Siamashka
