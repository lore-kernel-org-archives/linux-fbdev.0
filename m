From: Roman Kiryanov <rkir@google.com>
Date: Fri, 08 Jun 2018 23:40:12 +0000
Subject: Re: [PATCH 3/3] ANDROID: goldfish_fb: Set pixclock = 0
Message-Id: <CAOGAQeqSNpzyJ=644HH-XwW=pwwZBEuX4uVK1ekMSEoMpYMBMw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180531220252.58679-1-rkir@google.com>
 <CGME20180531220440epcas3p39993702c36d5cd4f97e251629d61949c@epcas3p3.samsung.com>
 <20180531220252.58679-3-rkir@google.com> <2257447.FoZO9vJcxE@amdc3058>
In-Reply-To: <2257447.FoZO9vJcxE@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi,

thank you for reviewing our patches. I sent "v2".

Regards,
Roman.
On Fri, Jun 8, 2018 at 9:24 AM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> [ + linux-fbdev ML ]
>
> On Thursday, May 31, 2018 03:02:52 PM rkir@google.com wrote:
> > From: Christoffer Dall <christoffer.dall@linaro.org>
> >
> > User space Android code identifies pixclock = 0 as a sign for emulation
> > and will set the frame rate to 60 fps when reading this value, which is
> > the desired outcome.
> >
> > Change-Id: I759bf518bf6683446bc786bf1be3cafa02dd8d42
>
> please drop your local Change-Id from the upstream kernel submissions
>
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> your S-o-b line is also needed
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
