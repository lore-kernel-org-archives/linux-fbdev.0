From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Tue, 05 Mar 2013 03:46:46 +0000
Subject: RE: [PATCH v2] video: Add Hyper-V Synthetic Video Frame Buffer Driver
Message-Id: <f2a49f00794e4e2bbd2f2a0201a5b544@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362434172-25070-1-git-send-email-haiyangz@microsoft.com>
 <20130305011613.GA21499@kroah.com>
In-Reply-To: <20130305011613.GA21499@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "FlorianSchandinat@gmx.de" <FlorianSchandinat@gmx.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>



> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Greg KH
> Sent: Monday, March 04, 2013 8:16 PM
> To: Haiyang Zhang
> Cc: FlorianSchandinat@gmx.de; linux-fbdev@vger.kernel.org;
> olaf@aepfle.de; jasowang@redhat.com; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org
> Subject: Re: [PATCH v2] video: Add Hyper-V Synthetic Video Frame Buffer
> Driver
> 
> On Mon, Mar 04, 2013 at 01:56:12PM -0800, Haiyang Zhang wrote:
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2951,3 +2951,6 @@
> >  #define PCI_DEVICE_ID_XEN_PLATFORM	0x0001
> >
> >  #define PCI_VENDOR_ID_OCZ		0x1b85
> > +
> > +#define PCI_VENDOR_ID_MICROSOFT		0x1414
> > +#define PCI_DEVICE_ID_HYPERV_VIDEO	0x5353
> 
> Please see the top of this while for why you shouldn't be adding any lines to
> this file.

I will move the defines back to the hyperv_fb.c.
Thanks for pointing this out.

- Haiyang

