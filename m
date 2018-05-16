From: Sinan Kaya <okaya@codeaurora.org>
Date: Wed, 16 May 2018 18:30:20 +0000
Subject: Re: [RFC PATCH] efi/fb: Convert PCI bus address to resource if translated by the bridge
Message-Id: <dd4dfce5-7f7e-824c-999f-b31bbd683f72@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Jones <pjones@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>

On 5/16/2018 2:23 PM, Sinan Kaya wrote:
> +		if (win_start <= base && win_end >= base + win_size - 1) {
> +			base += window->offset;
> +			break;
> +		}

I should probably add window->offset!=0 to the if statement in order not to
break non-translating case.

Any other comments?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
