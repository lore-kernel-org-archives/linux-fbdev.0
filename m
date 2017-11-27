From: Timur Tabi <timur@tabi.org>
Date: Mon, 27 Nov 2017 17:31:10 +0000
Subject: Re: [PATCH] video: fsl-diu-fb: Delete an error message for a failed memory allocation in fsl_diu_ini
Message-Id: <f1760f28-84f4-24d9-9cf4-ca94b0537338@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <39d05a48-e649-fb88-0e86-4f7528fd67f8@users.sourceforge.net>
In-Reply-To: <39d05a48-e649-fb88-0e86-4f7528fd67f8@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 11/27/17 3:00 AM, SF Markus Elfring wrote:
> From: Markus Elfring<elfring@users.sourceforge.net>
> Date: Mon, 27 Nov 2017 09:56:09 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring<elfring@users.sourceforge.net>

Acked-by: Timur Tabi <timur@tabi.org>
