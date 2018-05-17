From: Sinan Kaya <okaya@codeaurora.org>
Date: Thu, 17 May 2018 13:05:28 +0000
Subject: Re: [RFC PATCH] efi/fb: Convert PCI bus address to resource if translated by the bridge
Message-Id: <6e875491-38a9-f7cf-92d7-53698299403a@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
 <74ae2347-464c-ddc1-3cb9-f928692e792f@arm.com>
In-Reply-To: <74ae2347-464c-ddc1-3cb9-f928692e792f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, Peter Jones <pjones@redhat.com>, linux-arm-kernel@lists.infradead.org

On 5/17/2018 6:17 AM, Robin Murphy wrote:
>> +    }
>> +
> 
> Is this not pretty much just pcibios_bus_to_resource()?
>

Agreed, let me convert the code to use pcibios_bus_to_resource() API.
I wasn't aware of its existence.
 
> Robin.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
