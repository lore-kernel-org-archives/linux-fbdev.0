From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 10 Feb 2016 19:52:51 +0000
Subject: Re: [PATCH] video: fbdev: imxfb: Provide a reset mechanism
Message-Id: <CAOMZO5AaJjQ-JMTzgqLFFE+YSV-sftZe8=zMxLygvToMd4DfsA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1453209057-16444-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1453209057-16444-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Tomi,

On Fri, Jan 29, 2016 at 10:20 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
>
> On 19/01/16 15:10, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> Currently when we boot the kernel on a mx25pdk the LCDC controller
>> does not show the Linux logo on boot.
>>
>> This problem is well explained by Sascha Hauer:
>>
>> "Unfortunately this LCD controller does not have an enable bit. The
>> controller starts directly when the clocks are enabled. If the clocks
>> are enabled when the controller is not yet programmed with proper
>> register values then it just goes into some undefined state. What I
>> suspect is that the clocks already were enabled before driver probe,
>> presumably by the bootloader, so the controller is already in undefined
>> state when entering Linux. Now by dis/enabling the ipg clock you
>> effectively reset the controller. Since you have programmed it with
>> valid register values in the mean time it starts working after this
>> reset."
>>
>> So do as suggested and force a reset of the LCDC hardware by
>> enabling and disabling the IPG clock.
>>
>> With this change the Linux logo can be seen on boot on a mx25pdk.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
>> ---
>>  drivers/video/fbdev/imxfb.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>
> Thanks. Queued for 4.5 fixes.

Still don't see this one applied in Linus nor linux-next tree yet.
