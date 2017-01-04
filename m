From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 04 Jan 2017 12:41:49 +0000
Subject: Re: [v1] video:fbdev:cobalt_lcdfb:- Handle return NULL error from devm_ioremap
Message-Id: <2521746.Pc0WRFopsW@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1481617252-8298-1-git-send-email-arvind.yadav.cs@gmail.com>
 <CACBHAezjGxyP1KVWuHf7oYSF_mTTnPFaDnphAXk7c0N3e3qqzA@mail.gmail.com>
 <CGME20170104124152epcas1p2f74f40d8d9d361c98a1bcd463a8fe1cd@epcas1p2.samsung.com>
In-Reply-To: <CACBHAezjGxyP1KVWuHf7oYSF_mTTnPFaDnphAXk7c0N3e3qqzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yuasa Yoichi <yuasa@linux-mips.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tomi.valkeinen@ti.com, ralf@linux-mips.org, paul.burton@imgtec.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Wednesday, December 14, 2016 11:23:07 AM Yuasa Yoichi wrote:
> Hi Arvind,
> 
> Thank you for fixing it.
> 
> Acked-by: Yoichi Yuasa <yuasa@linux-mips.org>
> 
> 2016-12-13 17:20 GMT+09:00 Arvind Yadav <arvind.yadav.cs@gmail.com>:
> > Here, If devm_ioremap will fail. It will return NULL.
> > Kernel can run into a NULL-pointer dereference.
> > This error check will avoid NULL pointer dereference.
> >
> > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied & queued for v4.10.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

