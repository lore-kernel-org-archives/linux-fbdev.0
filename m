From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 13:34:08 +0000
Subject: Re: [PATCH v2 1/2] video/fbdev/stifb: Return -ENOMEM after a failed kzalloc() in stifb_init_fb()
Message-Id: <2557729.Jl5E8iEh4q@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7dcd32b6-9691-14a1-29cf-3a746ef5adfc@users.sourceforge.net>
 <889131fe-199c-3bef-0781-00761b807426@users.sourceforge.net>
 <6341951e-df28-0b40-974e-dedd890b5228@users.sourceforge.net>
 <CGME20180328133411epcas2p442e8f8a85d6c6e72ec5a5122519fe5eb@epcas2p4.samsung.com>
In-Reply-To: <6341951e-df28-0b40-974e-dedd890b5228@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, kernel-janitors@vger.kernel.org, "James E. J.
 Bottomley" <jejb@parisc-linux.org>, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, Rolf Eike Beer <eike-kernel@sf-tec.de>

On Sunday, January 07, 2018 12:56:45 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 7 Jan 2018 11:33:59 +0100
> 
> Replace an error code for the indication of a memory allocation failure
> in this function.
> 
> Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac ("Linux-2.6.12-rc2: Initial git repository build")
> Suggested-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

