From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 14:13:50 +0000
Subject: Re: [PATCH 1/2] video: ARM CLCD: Delete an error message for a failed memory allocation in clcdfb_pr
Message-Id: <3142281.EDeMi996z3@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <107ed35f-1775-14e0-a7b5-20e7ee02ac16@users.sourceforge.net>
        <CGME20171205171236epcas4p33d714ae79a5b69676eec15c84985576a@epcas4p3.samsung.com>
        <0ad85d10-a18f-ff02-f1f4-95452e54d32d@users.sourceforge.net>
In-Reply-To: <0ad85d10-a18f-ff02-f1f4-95452e54d32d@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Tuesday, December 05, 2017 06:12:30 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 5 Dec 2017 17:50:11 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
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

