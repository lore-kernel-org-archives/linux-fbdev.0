From: Timur Tabi <timur@tabi.org>
Date: Tue, 24 Nov 2015 17:05:27 +0000
Subject: Re: [PATCH] video: fbdev: fsl: fix kernel crash when diu_ops is not implemented
Message-Id: <CAOZdJXUzhz9_K0VaWjXT9EQxQT7noRy4E4zWUT5t6W-H3aDQ_A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Nov 24, 2015 at 12:00 PM, Scott Wood <scottwood@freescale.com> wrote:
>
> FWIW, I don't like the fact that this driver requires "platform code" at all.
>  Why isn't it self-contained, with knowledge of the relevant boards?

Yeah, I was never crazy about that either.  To make the change you
want, we would need Dongsheng's other patch that moves all hardware
init into the _probe function first.  And then we would need to get
rid of the #ifdefs for 5121.  I'm all for that, but at the time this
code was written, no one expected Freescale to continue using the DIU
after the P1022.
