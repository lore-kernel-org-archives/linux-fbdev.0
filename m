From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 21 Mar 2011 05:51:56 +0000
Subject: Re: Regression: black screen with Radeon KMS in 2.6.38 (2.6.37.4
Message-Id: <1300686716.2402.215.camel@pasglop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4D86E4E6.3040403@tds.net>
In-Reply-To: <4D86E4E6.3040403@tds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, 2011-03-21 at 01:40 -0400, John Lindgren wrote:
> Hi,
> 
> I want to report a bug in the Linux kernel 2.6.38.  Loading the radeon 
> module causes the console to go completely blank (laptop backlight on, 
> but nothing displayed).  The system still responds to ctrl-alt-del and 
> reboots.  This is a regression from the previous kernel, 2.6.37.4, where 
> kernel mode setting works flawlessly.
> 
> With radeon.modeset=0, or with the module blacklisted, the system boots 
> fine, and I can use X, but without the powersaving features available 
> through KMS.

You should probably report that to the appropriate freedesktop mailing
lists & bugzilla. I am not directly involved in the dev. of KMS.

Cheers,
Ben.

> System: Toshiba Satellite A305-S6916
> Graphics: ATI Radeon Mobility HD 3650
> Kernel: 2.6.38 (x86_64)
> 
> Kernel log when loading the module:
> 
> Mar 21 00:57:38 localhost kernel: [drm] Initialized drm 1.1.0 20060810
> Mar 21 00:57:38 localhost kernel: [drm] radeon defaulting to kernel modesetting.
> Mar 21 00:57:38 localhost kernel: [drm] radeon kernel modesetting enabled.
> Mar 21 00:57:38 localhost kernel: radeon 0000:01:00.0: PCI INT A ->  GSI 16 (level, low) ->  IRQ 16
> Mar 21 00:57:38 localhost kernel: radeon 0000:01:00.0: setting latency timer to 64
> Mar 21 00:57:38 localhost kernel: [drm] initializing kernel modesetting (RV635 0x1002:0x9591).
> Mar 21 00:57:38 localhost kernel: [drm] register mmio base: 0xD6300000
> Mar 21 00:57:38 localhost kernel: [drm] register mmio size: 65536
> Mar 21 00:57:38 localhost kernel: ATOM BIOS: Tosh_IEC_Potomac_M86_DDR2
> Mar 21 00:57:38 localhost kernel: radeon 0000:01:00.0: VRAM: 512M 0x0000000000000000 - 0x000000001FFFFFFF (512M used)
> Mar 21 00:57:38 localhost kernel: radeon 0000:01:00.0: GTT: 512M 0x0000000020000000 - 0x000000003FFFFFFF
> Mar 21 00:57:38 localhost kernel: [drm] Detected VRAM RAMQ2M, BAR%6M
> Mar 21 00:57:38 localhost kernel: [drm] RAM width 128bits DDR
> Mar 21 00:57:38 localhost kernel: [TTM] Zone  kernel: Available graphics memory: 2027544 kiB.
> Mar 21 00:57:38 localhost kernel: [TTM] Initializing pool allocator.
> Mar 21 00:57:38 localhost kernel: [drm] radeon: 512M of VRAM memory ready
> Mar 21 00:57:38 localhost kernel: [drm] radeon: 512M of GTT memory ready.
> Mar 21 00:57:38 localhost kernel: [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
> Mar 21 00:57:38 localhost kernel: [drm] Driver supports precise vblank timestamp query.
> Mar 21 00:57:38 localhost kernel: radeon 0000:01:00.0: irq 49 for MSI/MSI-X
> Mar 21 00:57:38 localhost kernel: radeon 0000:01:00.0: radeon: using MSI.
> Mar 21 00:57:38 localhost kernel: [drm] radeon: irq initialized.
> Mar 21 00:57:38 localhost kernel: [drm] GART: num cpu pages 131072, num gpu pages 131072
> Mar 21 00:57:38 localhost kernel: [drm] Loading RV635 Microcode
> Mar 21 00:57:38 localhost kernel: radeon 0000:01:00.0: WB enabled
> Mar 21 00:57:38 localhost kernel: [drm] ring test succeeded in 1 usecs
> Mar 21 00:57:38 localhost kernel: [drm] radeon: ib pool ready.
> Mar 21 00:57:38 localhost kernel: [drm] ib test succeeded in 0 usecs
> Mar 21 00:57:38 localhost kernel: [drm] Enabling audio support
> Mar 21 00:57:38 localhost kernel: HDMI hot plug event: Pin=3 Presence_Detect=0 ELD_Valid=0
> 
> 
> If there is any more info I can provide, please ask.
> 
> -- John Lindgren


