From: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 18 May 2018 14:20:29 +0000
Subject: Re: [PATCH] efi/fb: Convert PCI bus address to resource if translated by the bridge
Message-Id: <733101d0-9051-a5a6-ef64-162d8d1e10a1@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526563343-28721-1-git-send-email-okaya@codeaurora.org>
 <36cf3f12-bfe8-1c38-4d2c-b785fc64a3f6@arm.com>
In-Reply-To: <36cf3f12-bfe8-1c38-4d2c-b785fc64a3f6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org, timur@codeaurora.org, ard.biesheuvel@linaro.org
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, Peter Jones <pjones@redhat.com>, linux-arm-kernel@lists.infradead.org

On 5/18/2018 6:42 AM, Robin Murphy wrote:
> 
> FWIW, now that I've actually gone and looked, it appears you could simplify the whole function quite a bit by getting rid of these and just using the new local resource directly, especially since the only actual use of size is an open-coded resource_contains().

Posted V2 a minute ago. I did the simplification on a prior patch in order not to
mix the issues.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
