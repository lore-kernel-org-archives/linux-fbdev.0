From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Apr 2018 15:42:51 +0000
Subject: Re: [PATCH] video: fbdev: savage: Replace mdelay with usleep_range in savage_init_hw
Message-Id: <7431484.AHk4tMfvN6@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180410010607epcas4p2d1b0cb70e0676a6d6f215fe7e204e699@epcas4p2.samsung.com>
        <1523322359-27598-1-git-send-email-baijiaju1990@gmail.com>
In-Reply-To: <1523322359-27598-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: adaplas@gmail.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, April 10, 2018 09:05:59 AM Jia-Ju Bai wrote:
> savage_init_hw() is never called in atomic context.
> 
> The call chains ending up at savage_init_hw() are:
> [1] savage_init_hw() <- savagefb_probe()
> [2] savage_init_hw() <- savagefb_resume()
> 
> savagefb_probe() is only set as ".probe" in struct pci_driver.
> savagefb_resume) is only set as ".resume" in struct pci_driver.
> These functions are not called in atomic context.
> 
> Despite never getting called from atomic context, savage_init_hw()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with usleep_range to
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

