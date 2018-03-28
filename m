From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 13:46:32 +0000
Subject: Re: [PATCH v3 1/3] video: smscufx: Less checks in ufx_usb_probe() after error detection
Message-Id: <1923231.ySCFlVkifY@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0@epcas2p1.samsung.com>
        <a36fa112-40a1-703c-c2ac-ce7e88bb8609@users.sourceforge.net>
        <03be4276-520e-1d22-1c6e-e35c8df2b1e8@users.sourceforge.net>
In-Reply-To: <03be4276-520e-1d22-1c6e-e35c8df2b1e8@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Steve Glendinning <steve.glendinning@shawell.net>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Sunday, January 07, 2018 05:02:21 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 7 Jan 2018 15:56:11 +0100
> 
> Up to four checks could be repeated by the ufx_usb_probe() function
> during error handling even if the relevant properties can be determined
> for the involved variables before by source code analysis.
> 
> * Return directly after a call of the function "kzalloc" failed
>   at the beginning.
> 
> * Adjust jump targets so that extra checks can be omitted at the end.
> 
> * Delete initialisations for the variables "info" and "retval"
>   which became unnecessary with this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

