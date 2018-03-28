From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 14:16:58 +0000
Subject: Re: [PATCH 2/2] video: ARM CLCD: Improve a size determination in clcdfb_probe()
Message-Id: <3181596.jONtYT21fI@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <107ed35f-1775-14e0-a7b5-20e7ee02ac16@users.sourceforge.net>
 <CGME20171205171416epcas5p170833154061d837027c6dccfee0ccc6c@epcas5p1.samsung.com>
 <3656de6d-53cc-f6a4-1950-71fc989c79a4@users.sourceforge.net>
In-Reply-To: <3656de6d-53cc-f6a4-1950-71fc989c79a4@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>

On Tuesday, December 05, 2017 06:13:33 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 5 Dec 2017 17:53:19 +0100
> 
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

