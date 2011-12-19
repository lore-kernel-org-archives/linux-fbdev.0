From: Shawn Guo <shawn.guo@linaro.org>
Date: Mon, 19 Dec 2011 22:54:40 +0000
Subject: Re: [PATCH RESEND] MXSFB: Fix driver registration
Message-Id: <CAAQ0ZWRPZP7cPLLdxEsx3QwU0pnxL5jy9a5JjqsOPz_rDp_Oxw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1324309079-10739-1-git-send-email-marek.vasut@gmail.com>
In-Reply-To: <1324309079-10739-1-git-send-email-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, FlorianSchandinat@gmx.de, Wolfgang Denk <wd@denx.de>, Stefano Babic <sbabic@denx.de>, Huang Shijie <b32955@freescale.com>, Axel Lin <axel.lin@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

On 19 December 2011 23:37, Marek Vasut <marek.vasut@gmail.com> wrote:
> The driver should be registered with mxsfb_driver, not with mxsfb_devtype.
> This caused obvious null pointer dereference and crash.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Huang Shijie <b32955@freescale.com>
> Cc: Axel Lin <axel.lin@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Axel Lin <axel.lin@gmail.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
