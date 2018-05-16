From: Timur Tabi <timur@codeaurora.org>
Date: Wed, 16 May 2018 18:31:54 +0000
Subject: Re: [RFC PATCH] efi/fb: Convert PCI bus address to resource if translated by the bridge
Message-Id: <3120434b-9831-bf33-25b8-11aba1c1b648@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Jones <pjones@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>

On 05/16/2018 01:23 PM, Sinan Kaya wrote:
> +		win_start = window->res->start - window->offset;

Can you guarantee that window->res->start is always >= window->offset?

> +		win_size = window->res->end - window->res->start + 1;

Use resource_size() instead.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
