From: Timur Tabi <timur@tabi.org>
Date: Sun, 18 Oct 2015 03:53:47 +0000
Subject: Re: [PATCH] video: fbdev: fsl: Split DIU initialization entry
Message-Id: <CAOZdJXUu94-Xf4HCDq8PoCZqDZdjbGxDPQ5_t6y-UvGP_ewC8w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444709355-8905-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1444709355-8905-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Oct 12, 2015 at 11:09 PM, Dongsheng Wang
<dongsheng.wang@freescale.com> wrote:
> +       ret = fsl_diu_perpare();
> +       if (ret)
> +               goto out_diu_perpare;

I think you mean "prepare"

Thanks for posting this patch.  I will try to review it more thoroughly later.
