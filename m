From: Timur Tabi <timur@tabi.org>
Date: Tue, 24 Nov 2015 17:06:28 +0000
Subject: Re: [PATCH] video: fbdev: fsl: fix kernel crash when diu_ops is not implemented
Message-Id: <CAOZdJXX0XSN4mNrBGLvzywKs_1XGEi-A27CJ--TcLWJZ8Nizdw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Nov 24, 2015 at 12:02 PM, Wang Dongsheng
<Dongsheng.Wang@freescale.com> wrote:
>
> Here are not friendly for kernel, because if we lost the clock we cannot
> to display. We do so much things in kernel but we still cannot to display that
> is before we can know it...So still think we need to check the hook in initialization
> flow.

Ok, I agree with that.  But the check has to be more obvious, and I
think it should be done in the _init code.
