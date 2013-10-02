From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Wed, 02 Oct 2013 20:42:02 +0000
Subject: RE: [PATCH 1/2] hyperv-fb: add pci stub
Message-Id: <f163f7a7f4804187821668ce53e19119@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380714911-6254-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1380714911-6254-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: KY Srinivasan <kys@microsoft.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:Hyper-V CORE AND..." <devel@linuxdriverproject.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Gerd Hoffmann
> Sent: Wednesday, October 2, 2013 7:55 AM
> Cc: Gerd Hoffmann; KY Srinivasan; Haiyang Zhang; Jean-Christophe Plagniol-
> Villard; Tomi Valkeinen; open list:Hyper-V CORE AND...; open
> list:FRAMEBUFFER LAYER; open list
> Subject: [PATCH 1/2] hyperv-fb: add pci stub
> 
> This patch adds a pci stub driver to hyper-fb.  The hyperv framebuffer driver
> will bind to the pci device then, so linux kernel and userspace know there is a
> proper kernel driver for the device active.  lspci shows this for example:
> 
> [root@dhcp231 ~]# lspci -vs8
> 00:08.0 VGA compatible controller: Microsoft Corporation Hyper-V virtual
> VGA (prog-if 00 [VGA controller])
>         Flags: bus master, fast devsel, latency 0, IRQ 11
>         Memory at f8000000 (32-bit, non-prefetchable) [sizedM]
>         Expansion ROM at <unassigned> [disabled]
>         Kernel driver in use: hyperv_fb
> 
> Another effect is that the xorg vesa driver will not attach to the device and
> thus the Xorg server will automatically use the fbdev driver instead.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Haiyang Zhang <haiyangz@microsoft.com>

Thank you for fixing this!

- Haiyang


