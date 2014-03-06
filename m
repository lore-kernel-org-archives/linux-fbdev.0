From: Haojian Zhuang <haojian.zhuang@gmail.com>
Date: Thu, 06 Mar 2014 09:15:05 +0000
Subject: Re: [PATCH 0/4] Cleanups and fix for video/pxa3xx-gcu
Message-Id: <CAN1soZxOcUCUOSYWCYK7657nY_EDCTL=gLq9fmB7kEx6=ib4Ew@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394035969-32420-1-git-send-email-zonque@gmail.com>
In-Reply-To: <1394035969-32420-1-git-send-email-zonque@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Mar 6, 2014 at 5:09 PM, Daniel Mack <zonque@gmail.com> wrote:
> On 03/06/2014 03:09 AM, Haojian Zhuang wrote:
>> On Thu, Mar 6, 2014 at 12:12 AM, Daniel Mack <zonque@gmail.com> wrote:
>>> Here are some cleanups for the pxa3xx-gcu driver. Patch 3/4 is actually
>>> a real bugfix that is needed since the misc code doesn't set
>>> file->private_data for us implicitly anymore.
>>>
>>> The rest are just straight-forward cleanups.
>>>
>>> Thanks,
>>> Daniel
>>>
>>>
>>> Daniel Mack (4):
>>>   video: pxa3xx-gcu: rename some symbols
>>>   video: pxa3xx-gcu: pass around struct device *
>>>   video: pxa3xx-gcu: provide an empty .open call
>>>   video: pxa3xx-gcu: switch to devres functions
>>>
>>>  drivers/video/pxa3xx-gcu.c | 191 +++++++++++++++++++--------------------------
>>>  1 file changed, 81 insertions(+), 110 deletions(-)
>>>
>
>> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>
> Thanks Haojian!
>
> Given that this driver doesn't actually have any connection points to
> the framebuffer or video subsystem (despite its location) maybe you can
> just take these patches through your pxa tree? It's a PXA3xx specific
> device, after all. Jean-Christophe, Tomi - any objections?
>

If Jean or Tomi acked on this series, I can merge them into my pxa tree.

Best Regards
Haojian
