From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 03 Jan 2018 11:18:29 +0000
Subject: Re: [PATCH V4 23/26] video: fbdev: nvidia: deprecate pci_get_bus_and_slot()
Message-Id: <1929987.3nUglloMgL@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <CGME20180102133808epcas2p19c51f6f07fcdf3dee68f4edcb2686fda@epcas2p1.samsung.com>
 <6a6b51ff-42d5-29cc-167e-f4ed74d7ac36@codeaurora.org>
In-Reply-To: <6a6b51ff-42d5-29cc-167e-f4ed74d7ac36@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "open list:NVIDIA (rivafb and nvidiafb)
 FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, linux-pci@vger.kernel.org, timur@codeaurora.org, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER
 LAYER" <dri-devel@lists.freedesktop.org>, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday, January 02, 2018 08:38:03 AM Sinan Kaya wrote:
> On 12/19/2017 12:37 AM, Sinan Kaya wrote:
> > pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> > where a PCI device is present. This restricts the device drivers to be
> > reused for other domain numbers.
> > 
> > Getting ready to remove pci_get_bus_and_slot() function in favor of
> > pci_get_domain_bus_and_slot().
> > 
> > struct nvidia_par has a pointer to struct pci_dev. Use the pci_dev
> > member to extract the domain information and pass it to
> > pci_get_domain_bus_and_slot() function.
> > 
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> Any feedback here ? most of the remaining patches have the ACK except these.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

