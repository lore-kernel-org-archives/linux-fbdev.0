From: Adam Ford <aford173@gmail.com>
Date: Tue, 23 Feb 2016 10:32:00 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <CAHCN7xLo7q=Ts3WLvx_GzSBWt5r1SiU7vr+W==kUAaAvmwXJYA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
In-Reply-To: <56CC2D39.80909@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 23, 2016 at 3:58 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wro=
te:
> (cc'ing a few more people as this is going into generic direction)
>
> On 23/02/16 11:08, Linus Walleij wrote:
>> On Thu, Feb 4, 2016 at 3:04 PM, Linus Walleij <linus.walleij@linaro.org>=
 wrote:
>>
>>> This moves the versatile CLCD configuration to the device tree by:
>>
>> As this Schr=C3=B6dinger's cat approach seems controversial, as well
>> as the alternative to manipulate the DT in memory at run-time,
>> I will respin the series without the full Versatile support, adding
>> plug-in for the other ARM boards and and half-baked support
>> for the Versatile supporting just VGA (like the other reference
>> designs from ARM).
>>
>> The pluggable displays prove yet again to be a problem to the
>> world, sigh.
>>
>> I will think of a better solution, if any, for this for v4.6, but will
>> put forward something that handles the Nomadik and all the
>> other ARM reference designs for now.
>
> I had a chat with Tom Rini and Pantelis Antoniou yesterday.
>
> Panto is about to send a new series for DT overlay management soon. I
> haven't had time to test that yet, but what it would give us is that you
> could build DT overlay binaries as "firmware" into the kernel image, and
> thus the panel DT data would be there even before rootfs is mounted. The
> DT overlays can be loaded from the rootfs or initramfs too, if it's not
> critical to get the display up early.
>
> I'm not quite sure how it works if, as in versatile display case, there
> are multiple DT overlays of which one has to be enabled. I hope there's
> support to choose which one to use via kernel cmdline or similar.
>
> I would personally like it much more if the bootloader would either
> compose a final dtb from DT fragments and pass it to the kernel, or
> alternatively the bootloader would pass the base dtb image and a bunch
> of DT overlays to the kernel, and the kernel would deal with the DT
> overlays.
>
If there was a nice way to merge the device trees, I would love to
create device tree 'modules' that could be loaded at will and merged
just before the time of boot.  I could see this being useful beyond
just plugable displays.

> In any case, I think the firmware solution is a good step forward, and
> will probably work fine for many users. Then again, I haven't tested it
> yet so I don't know the details, and it's not in the mainline.
>
I am willing to test it, but I'll need the patch and some instructions
from Panto.

>  Tomi
>
