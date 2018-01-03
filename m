From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 03 Jan 2018 11:18:15 +0000
Subject: Re: [PATCH V4 22/26] video: fbdev: intelfb: deprecate pci_get_bus_and_slot()
Message-Id: <1712261.2Mai7cXr8p@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
        <CGME20180102133833epcas1p4003614ea6c95c4568e8433acbb30f52d@epcas1p4.samsung.com>
        <7099e2af-4704-4611-94c0-830483de4578@codeaurora.org>
In-Reply-To: <7099e2af-4704-4611-94c0-830483de4578@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Maik Broemme <mbroemme@libmpq.org>, "open list:INTEL FRAMEBUFFER DRIVER (excluding 810 and 815)" <linux-fbdev@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>

On Tuesday, January 02, 2018 08:38:24 AM Sinan Kaya wrote:
> On 12/19/2017 12:37 AM, Sinan Kaya wrote:
> > pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> > where a PCI device is present. This restricts the device drivers to be
> > reused for other domain numbers.
> > 
> > Getting ready to remove pci_get_bus_and_slot() function in favor of
> > pci_get_domain_bus_and_slot().
> > 
> > Find the domain number from pdev.
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

