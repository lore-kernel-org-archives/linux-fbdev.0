From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 17 Feb 2016 09:41:47 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <20160217094147.GG19428@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <56C438DA.5040109@ti.com>
In-Reply-To: <56C438DA.5040109@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Feb 17, 2016 at 11:09:46AM +0200, Tomi Valkeinen wrote:
> What's the SYS_CLCD register? An EEPROM or such, programmed when the
> board is manufactured? Is the panel meant to be switchable by the user,
> possibly to a panel that's not "standard"?

If you read this bit of the patch, which describes the bits in the
register, it gives some clues:

-#define SYS_CLCD_MODE_MASK     (3 << 0)
-#define SYS_CLCD_MODE_888      (0 << 0)
-#define SYS_CLCD_MODE_5551     (1 << 0)
-#define SYS_CLCD_MODE_565_RLSB (2 << 0)
-#define SYS_CLCD_MODE_565_BLSB (3 << 0)
-#define SYS_CLCD_NLCDIOON      (1 << 2)
-#define SYS_CLCD_VDDPOSSWITCH  (1 << 3)
-#define SYS_CLCD_PWR3V5SWITCH  (1 << 4)
-#define SYS_CLCD_ID_MASK       (0x1f << 8)
-#define SYS_CLCD_ID_SANYO_3_8  (0x00 << 8)
-#define SYS_CLCD_ID_UNKNOWN_8_4        (0x01 << 8)
-#define SYS_CLCD_ID_EPSON_2_2  (0x02 << 8)
-#define SYS_CLCD_ID_SANYO_2_5  (0x07 << 8)
-#define SYS_CLCD_ID_VGA                (0x1f << 8)

The LCD panels plug-in to the board, and they have a 5-bit hard-wired
ID, which is signalled through five ID lines into the FPGA.

The register is also writable, which is used to control power supplies
to the LCD and an external MUX which changes the RGB format outside of
the capabilities of the CLCD itself.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
