From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 26 Apr 2018 10:15:38 +0000
Subject: Re: [PATCH 2/4] video: sm501fb: Improve a size determination in sm501fb_probe()
Message-Id: <1859038.Xq2p7m02WJ@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <efb981db-e9a0-d6f7-00d4-c76e1162770c@users.sourceforge.net>
 <CGME20171126101848epcas2p3725dcc0b645cf4d4d9730f8f8edbad70@epcas2p3.samsung.com>
 <08ed1e90-5714-04b7-b3dc-067a3d9bc38b@users.sourceforge.net>
In-Reply-To: <08ed1e90-5714-04b7-b3dc-067a3d9bc38b@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>, Colin Ian King <colin.king@canonical.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>

On Sunday, November 26, 2017 11:18:26 AM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Nov 2017 10:22:37 +0100
> 
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Hand applied and queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

