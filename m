From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 13:48:55 +0000
Subject: Re: [PATCH v3 2/3] video: smscufx: Return an error code only as a constant in ufx_realloc_framebuffe
Message-Id: <8231980.bzy6TRmRmS@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0@epcas2p1.samsung.com>
 <a36fa112-40a1-703c-c2ac-ce7e88bb8609@users.sourceforge.net>
 <31ecfef4-a193-dea0-0ff3-0d5a108a14f3@users.sourceforge.net>
In-Reply-To: <31ecfef4-a193-dea0-0ff3-0d5a108a14f3@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Steve Glendinning <steve.glendinning@shawell.net>, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org

On Sunday, January 07, 2018 05:04:04 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 7 Jan 2018 16:07:11 +0100
> 
> * Return an error code without storing it in an intermediate variable.
> 
> * Delete the label "error" and local variable "retval"
>   which became unnecessary with this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

