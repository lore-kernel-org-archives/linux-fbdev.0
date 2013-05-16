From: Laurent Navet <laurent.navet@gmail.com>
Date: Thu, 16 May 2013 09:46:19 +0000
Subject: Re: [PATCH] drivers: video: mxsfb: clean use of devm_ioremap_resource()
Message-Id: <CAH7P7NiA98MFLwNTdOGh36MvgV0gGTPyk0oTud6GYYXvRKJ4Ng@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <19650694.136921368693687337.JavaMail.weblogic@epml12>
In-Reply-To: <19650694.136921368693687337.JavaMail.weblogic@epml12>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jg1.han@samsung.com
Cc: "FlorianSchandinat@gmx.de" <FlorianSchandinat@gmx.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

2013/5/16, Jingoo Han <jg1.han@samsung.com>:
> It makes build warning as below:
>
> drivers/video/mxsfb.c:887:13: warning: 'host' is used uninitialized in this
> function [-Wuninitialized]
> drivers/video/mxsfb.c:965:21: warning: 'fb_info' may be used uninitialized
> in this function [-Wuninitialized]
>
> It breaks the assignment.
> 	host = to_imxfb_host(fb_info);
>
> Also, 'goto fb_release;' is not good.
> Please use ' return PTR_ERR(host->base);' as below:
> +       host->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(host->base))
> +               return PTR_ERR(host->base);
>
>
> Best regards,
> Jingoo Han

Thank's for reviewing, I'll look at and resend.

Laurent,
