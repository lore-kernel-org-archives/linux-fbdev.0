From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Apr 2018 15:51:23 +0000
Subject: Re: [PATCH] video: fbdev: aty: radeon_pm: Replace mdelay with msleep in radeonfb_pci_suspend
Message-Id: <7290517.RXRYeCv1u3@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180410014725epcas1p2f9db790e2df6754f108048b00f399130@epcas1p2.samsung.com>
        <1523324840-28830-1-git-send-email-baijiaju1990@gmail.com>
In-Reply-To: <1523324840-28830-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: benh@kernel.crashing.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, April 10, 2018 09:47:20 AM Jia-Ju Bai wrote:
> radeonfb_pci_suspend() is never called in atomic context.
> 
> radeonfb_pci_suspend() is only set as ".suspend" in struct pci_driver.
> This function is not called in atomic context.
> 
> Despite never getting called from atomic context, radeonfb_pci_suspend()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with msleep() 
> and usleep_range() to avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

