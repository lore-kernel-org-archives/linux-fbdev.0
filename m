From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Wed, 26 Feb 2014 15:46:13 +0000
Subject: RE: [PATCH v5 1/2] hyperv-fb: add support for generation 2 virtual machines.
Message-Id: <bea2fdf0ef1a40949bd5c6c5065547ce@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393411885-14895-1-git-send-email-kraxel@redhat.com>
 <1393411885-14895-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1393411885-14895-2-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, KY Srinivasan <kys@microsoft.com>, "Abhishek Gupta (LIS)" <abgupta@microsoft.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>



> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Gerd Hoffmann
> Sent: Wednesday, February 26, 2014 5:51 AM
> To: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; gregkh@linuxfoundation.org; KY Srinivasan;
> Abhishek Gupta (LIS); Haiyang Zhang; jasowang@redhat.com;
> tomi.valkeinen@ti.com; devel@linuxdriverproject.org; Gerd Hoffmann; Jean-
> Christophe Plagniol-Villard
> Subject: [PATCH v5 1/2] hyperv-fb: add support for generation 2 virtual
> machines.
> 
> UEFI-based generation 2 virtual machines support vmbus devices only.
> There is no pci bus.  Thus they use a different mechanism for the
> graphics framebuffer:  Instead of using the vga pci bar a chunk of
> memory muct be allocated from the hyperv mmio region declared using
> APCI.  This patch implements support for it.
> 
> Based on a patch by Haiyang Zhang <haiyangz@microsoft.com>
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Thank you!

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

