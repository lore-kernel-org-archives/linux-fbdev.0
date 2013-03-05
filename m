From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 05 Mar 2013 01:16:13 +0000
Subject: Re: [PATCH v2] video: Add Hyper-V Synthetic Video Frame Buffer Driver
Message-Id: <20130305011613.GA21499@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362434172-25070-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1362434172-25070-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, olaf@aepfle.de, jasowang@redhat.com, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org

On Mon, Mar 04, 2013 at 01:56:12PM -0800, Haiyang Zhang wrote:
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2951,3 +2951,6 @@
>  #define PCI_DEVICE_ID_XEN_PLATFORM	0x0001
>  
>  #define PCI_VENDOR_ID_OCZ		0x1b85
> +
> +#define PCI_VENDOR_ID_MICROSOFT		0x1414
> +#define PCI_DEVICE_ID_HYPERV_VIDEO	0x5353

Please see the top of this while for why you shouldn't be adding any
lines to this file.

greg k-h
