From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 06 Nov 2014 13:00:28 +0000
Subject: Re: [PATCH] fbdev: mxsfb: Add support for mx6sl and mx6sx
Message-Id: <CAOMZO5B9FdiR-rtWxEgmTgYT0bDdMUErguVf5XLxpUtK11+COQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1414243727-23447-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1414243727-23447-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Tomi,

On Sat, Oct 25, 2014 at 11:28 AM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> mx6sl and mx6sx share the same LCD controller as mx23 and mx28.
>
> Add support for it.
>
> The basic difference is the number of clocks that are required:
>
> - mx23/mx28: only one clock
> - mx6sl: two clocks
> - mx6sx: three clocks
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since RFC:
> - Simplified the clock handling as suggested by Tomi

If you are happy with this one, could we get it into 3.19? Thanks
