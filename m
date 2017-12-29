From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Dec 2017 18:43:00 +0000
Subject: Re: [0/5] video-SMSC UFX: Adjustments for five function implementations
Message-Id: <265c7022-d12f-bcbe-c6f0-452ba3f73744@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0@epcas2p1.samsung.com>
 <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
 <1736749.UIs06O4xc5@amdc3058>
In-Reply-To: <1736749.UIs06O4xc5@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Steve Glendinning <steve.glendinning@shawell.net>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

>>   Delete an error message for a failed memory allocation in two functions
> 
> This patch removes the information about the device for which the allocation fails.

Should a Linux allocation failure report be sufficient here?


>>   Less checks in ufx_usb_probe() after error detection
> 
> This patch depends on the earlier patch (which is not being merged)

Partly, yes.


> so please re-base it if you want it to be applied.

Would you dare to pick another change possibility up from a patch hunk?


>>   Adjust three checks for null pointers
> 
> This patch contains unrelated change ({} braces addition) which should be dropped.

I presented such an update approach so that warnings from the script “checkpatch.pl”
will be fixed together.

Regards,
Markus
