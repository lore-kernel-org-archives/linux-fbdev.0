From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 20 Jul 2020 09:35:24 +0000
Subject: Re: SM750 : from which driver should I start to add a new transmitter ?
Message-Id: <CADVatmOmhA5E6Qi23YtdZjtoS=dKKCk1bujw9dEY-sKrGAt30A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <36f3542011c34c4a9509f00c666a514a@kontron.com>
In-Reply-To: <36f3542011c34c4a9509f00c666a514a@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gilles Buloz <Gilles.Buloz@kontron.com>
Cc: "greg@kroah.com" <greg@kroah.com>, LFBDEV <linux-fbdev@vger.kernel.org>, "teddy.wang@siliconmotion.com" <teddy.wang@siliconmotion.com>, dri-devel <dri-devel@lists.freedesktop.org>

HI Gilles, (Added fbdev and dri list)

On Mon, Jul 20, 2020 at 10:18 AM Gilles Buloz <Gilles.Buloz@kontron.com> wrote:
>
> Dear developers,
>
>
> My company is manufacturing M2 graphics modules based on SM750. and I need to add support for an ANX9404 transmitter (for DP). I'm wondering which driver you would recommend to start my development :
>
> - your SM750 framebuffer driver is available in the kernel under drivers/staging/sm750fb/. It is clean and maintained.

Yes, and I know many companies who are using SM750 uses this driver,
but the fact remains that it can be removed from staging any time as
it can never migrate out of staging,

>
> - I'm currently using another driver from SiliconMotion I got through Innodisk (another modules manufacturer) supporting SM750/SM768 and labelled "SiliconMotion GPU DRM Driver". But the code is not very clean and produces lots of warning when building, and seems no more maintained. I even don't have the name nor the email of the developer. However it already works fine with our current HDMI transmitter.
>
>
> Having a look to the sm750fb kernel driver, the TODO file says : "must be ported to the atomic kms framework in the drm subsystem (which will give you a basic fbdev driver for free)".

Yes.

>
> It seems my current driver is already of this kind (DRM driver using modesetting Xorg module). I can send you the source code of this driver as it is open source If you want to see which driver I mean.

Is it the same as the one I have at gitlab
(https://gitlab.com/sudipm/sm750/tree/sm750) ? If it is same then it
will not be accepted in drm subsystem as it needs to be cleaned and I
will need to add "atomic" to it. Well, atomic was the main blocker.
But, if the driver that you have has been already converted to be an
atomic driver then please send it to me and I can clean it up and
submit.



--
Regards
Sudip
