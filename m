From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Apr 2018 15:48:05 +0000
Subject: Re: [PATCH] video: fbdev: aty: aty128fb: Replace mdelay with msleep in aty128_set_suspend
Message-Id: <12527186.HoBsF7gLxN@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180410014047epcas1p28c608903eaf0d74930dfded2f82297e6@epcas1p2.samsung.com>
        <1523324435-28719-1-git-send-email-baijiaju1990@gmail.com>
In-Reply-To: <1523324435-28719-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: paulus@samba.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, April 10, 2018 09:40:35 AM Jia-Ju Bai wrote:
> aty128_set_suspend() is never called in atomic context.
> 
> The call chains ending up at aty128_set_suspend() are:
> [1] aty128_set_suspend() <- aty128_pci_suspend()
> [2] aty128_set_suspend() <- aty128_do_resume() <- aty128_pci_resume()
> [3] aty128_set_suspend() <- aty128_do_resume() <- aty128_early_resume()
> 
> aty128_pci_suspend() is set as ".suspend" in struct pci_driver.
> aty128_pci_resume() is set as ".resume" in struct pci_driver.
> aty128_early_resume() is never called.
> These functions are not called in atomic context.
> 
> Despite never getting called from atomic context, aty128_set_suspend()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with msleep() to
> avoid busy waiting.
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

