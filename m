From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 08 Feb 2019 17:00:19 +0000
Subject: Re: [PATCH -next] drivers/video/fbdev: remove set but not used variable 'size'
Message-Id: <b762a997-d2b3-7f59-7f20-e70db566b22c@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1539676794-40133-1-git-send-email-yuehaibing@huawei.com>
 <CGME20181016235224epcas1p32a5893f82dc7abbe40941ce6e6f4e3f9@epcas1p3.samsung.com>
 <87d0s9laaf.fsf@concordia.ellerman.id.au>
In-Reply-To: <87d0s9laaf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YueHaibing <yuehaibing@huawei.com>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org


On 10/17/2018 01:52 AM, Michael Ellerman wrote:
> YueHaibing <yuehaibing@huawei.com> writes:
> 
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/video/fbdev/chipsfb.c: In function 'chipsfb_pci_init':
>> drivers/video/fbdev/chipsfb.c:352:22: warning:
>>  variable 'size' set but not used [-Wunused-but-set-variable]
>>
>> It not used any more after commit
>> 8c8709334cec ("[PATCH] ppc32: Remove CONFIG_PMAC_PBOOK")
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/video/fbdev/chipsfb.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Looks good, thanks.
> 
> Should I merge this? Or otherwise:
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

I've queued the patch to fbdev tree for v5.1 w/ slightly modified patch
summary ("fbdev: chipsfb: ...") add patch description (use Fixes: tag),
thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
