From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 26 Apr 2018 10:08:12 +0000
Subject: Re: [PATCH 1/2] video: fbdev-MMP: Delete an error message for a failed memory allocation in two func
Message-Id: <1981428.zQfQG5i5U7@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <e2c5fe9e-8e01-7fef-a243-ff5d063787b0@users.sourceforge.net>
 <CGME20171126204255epcas3p19d6324568d821993e2a4beb971907de6@epcas3p1.samsung.com>
 <9aa9c376-22a3-f682-d9a4-5ee95cfd75a0@users.sourceforge.net>
In-Reply-To: <9aa9c376-22a3-f682-d9a4-5ee95cfd75a0@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org

On Sunday, November 26, 2017 09:42:49 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Nov 2017 21:16:30 +0100
> 
> Omit an extra message for a memory allocation failure in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I've done requested audit regarding multiple fb devices support
myself now and it is okay to apply this patch.

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

