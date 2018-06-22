From: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 22 Jun 2018 13:52:54 +0000
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if translated by the bridge
Message-Id: <2a805337-c0b5-e134-7695-5a543ecaa26a@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
 <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
In-Reply-To: <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, Peter Jones <pjones@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Ard,

On 6/22/2018 7:21 AM, Ard Biesheuvel wrote:
> Apologies for only bringing this up now, but I think this patch is
> wrong after all.
> 
> screen_info.lfb_base is supposed to be a CPU address, and so
> translating it like this is wrong. If you end up with a PCI address
> here, you have made a mistake in hacking support for PCI outbound
> translations into UEFI. Other users such as UEFI itself or GRUB will
> treat this as a CPU physical address as well, so the kernel should not
> treat it any differently.

The behavior I'm seeing is from a UEFI BIOS vendor. I did not write the
code for it...

I was asked to debug it.

I'd like to dive into your statement about UEFI and GRUB using this address
as physical addresses.

AFAIK, all PCI outbound requests go through PCI IO protocol in UEFI and the
translation information is hidden inside the UEFI PCI Host Bridge driver.
Drivers are not allowed to access PCI resources directly especially as a
memory mapped address.

This particular vendor is programming the BAR address into the GOP protocol.
Since the host bridge driver is doing a translation, we are hitting this
issue.

Is there a UEFI spec reference about the definition of this field?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
