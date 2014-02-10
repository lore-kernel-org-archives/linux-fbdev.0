From: Bryan Wu <cooloney@gmail.com>
Date: Mon, 10 Feb 2014 17:37:29 +0000
Subject: Re: [PATCH] backlight: replace kfree with put_device
Message-Id: <CAK5ve-L54nmDX_HLPpfWQrTe=n11RFr5hyUFFcc-1otWPQde7Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1391762601-4560-1-git-send-email-levex@linux.com>
 <003701cf25f6$3807c6d0$a8175470$%han@samsung.com> <20140210111349.GA21522@lee--X1>
In-Reply-To: <20140210111349.GA21522@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Lee Jones <lee.jones@linaro.org>
Cc: Jingoo Han <jg1.han@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Levente Kurusa <levex@linux.com>, LKML <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, FBDEV list <linux-fbdev@vger.kernel.org>

On Mon, Feb 10, 2014 at 3:13 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> > As per the comments on device_register, we shouldn't call kfree()
>> > right after a device_register() failure. Instead call put_device(),
>> > which in turn will call bl_device_release resulting in a kfree to the
>> > full structure.
>> >
>> > Signed-off-by: Levente Kurusa <levex@linux.com>
>>
>> (+cc Bryan Wu, Lee Jones)
>>
>> Acked-by: Jingoo Han <jg1.han@samsung.com>
>
> Applied to temporary Backlight repo [1], thanks.
>
> [1] git://git.linaro.org/people/lee.jones/backlight.git
>

Great, I think we can put the Git URL into the MAINTAINS file for
Backlight subsystem after your finalize the git repo.

Thanks,
-Bryan


> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
