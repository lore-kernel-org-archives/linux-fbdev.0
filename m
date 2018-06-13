From: Sinan Kaya <okaya@codeaurora.org>
Date: Wed, 13 Jun 2018 14:22:04 +0000
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if translated by the bridge
Message-Id: <26470c5c-55db-9dff-3794-4e4a96c8bcb6@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, timur@codeaurora.org, ard.biesheuvel@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Jones <pjones@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>

Hi Ard,

On 5/18/2018 10:17 AM, Sinan Kaya wrote:
> A host bridge is allowed to remap BAR addresses using _TRA attribute in
> _CRS windows.
> 
> pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
> pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
> 
> When a VGA device is behind such a host bridge and the resource is
> translated efifb driver is trying to do ioremap against bus address
> rather than the resource address and is failing to probe.
> 
> efifb: probing for efifb
> efifb: cannot reserve video memory at 0x1e000000
> efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
> efifb: mode is 800x600x32, linelength200, pages=1
> efifb: scrolling: redraw
> efifb: Truecolor: size=8:8:8:8, shift$:16:8:0
> 
> Use the host bridge offset information to convert bus address to
> resource address in the fixup.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---

I didn't see any messages about these getting picked up for 4.18.

Are they queued on your own branch?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
