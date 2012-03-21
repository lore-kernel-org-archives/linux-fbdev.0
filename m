From: Fabio Coatti <fabio.coatti@gmail.com>
Date: Wed, 21 Mar 2012 23:01:30 +0000
Subject: Re: Radeon fb issue: invalid framebuffer id kernel 3.2.12
Message-Id: <CADpTngVd8HFKo7+=BK=M0DgaB9PXAEo4c+jUWqTPzyiM8jxbKQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADpTngU6fL3r3cHsH3B6Hx68Bm4R_baoBeVmvGf6bUJPV3CXbA@mail.gmail.com>
In-Reply-To: <CADpTngU6fL3r3cHsH3B6Hx68Bm4R_baoBeVmvGf6bUJPV3CXbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

2012/3/19 Dave Airlie <airlied@gmail.com>:
>> Hi all,
>> I'm setting up a new laptot with Advanced Micro Devices [AMD] nee ATI
>> Seymour [Radeon HD 6400M Series] card, using radeon drivers. I'm
>> facing an issue for wich I found a lot of references but no actual
>> solution, so I'm asking here for some help
>
> the invalid framebuffer id isn't fatal, however it sounds like you
> haven't got CONFIG_FRAMEBUFFER_CONSOLE
> or haven't loaded fbcon.

Indeed your'e right. I was confused by the error and i didn't looked
in the right and obvious place, silly me.

Thanks for the heads up!



-- 
Fabio
