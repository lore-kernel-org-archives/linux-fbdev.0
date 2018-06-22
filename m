From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 22 Jun 2018 10:11:53 +0000
Subject: Re: [PATCH V2 1/2] efi/fb: Simplify fixup code to prefer struct resource
Message-Id: <1548378.AvPlWv1vxJ@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <CGME20180613154216epcas4p16e6cac42e19f870f761ee3e735bc4dc3@epcas4p1.samsung.com>
 <CAKv+Gu-LkJBa+QKwROqWApfKHjZ8huDYPi9FanU2AhKECv=dog@mail.gmail.com>
In-Reply-To: <CAKv+Gu-LkJBa+QKwROqWApfKHjZ8huDYPi9FanU2AhKECv=dog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, Sinan Kaya <okaya@codeaurora.org>, Peter Jones <pjones@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Wednesday, June 13, 2018 05:42:11 PM Ard Biesheuvel wrote:
> On 18 May 2018 at 16:17, Sinan Kaya <okaya@codeaurora.org> wrote:
> > Get rid of base and size variables in favor of a struct resource.
> > The conditional for checking window can be replaced with
> > resource_contains().
> >
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

