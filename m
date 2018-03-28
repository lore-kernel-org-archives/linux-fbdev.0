From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 13:53:38 +0000
Subject: Re: [PATCH v2] video: ssd1307fb: Improve a size determination in ssd1307fb_probe()
Message-Id: <3926941.Nf8LXND9kI@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171125160425epcas5p43b2d94fbcc74745017c4c91ff08de685@epcas5p4.samsung.com>
        <2091464.qzRHS0Wsad@amdc3058>
        <c2fc8e5c-e4d3-51da-451c-be70e0d3fef0@users.sourceforge.net>
In-Reply-To: <c2fc8e5c-e4d3-51da-451c-be70e0d3fef0@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Bastian Stender <bst@pengutronix.de>, Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Sunday, January 07, 2018 07:34:44 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 7 Jan 2018 19:27:28 +0100
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

