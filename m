From: Timur Tabi <timur@tabi.org>
Date: Tue, 24 Nov 2015 17:16:12 +0000
Subject: Re: [PATCH] video: fbdev: fsl: fix kernel crash when diu_ops is not implemented
Message-Id: <CAOZdJXV03Eav2F3dWSK-Z-tCqvG9p0hK_nmjJy9ZpQcDOuoxuQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Nov 24, 2015 at 12:05 PM, Scott Wood <scottwood@freescale.com> wrote:

> I asked Dongsheng to put it in probe() during internal review because at the
> time he was printing an error, and I didn't want the error to be printed if
> the device wasn't present.  Again, there's another non-bugfix patch pending
> that moves all the rest into probe() where it belongs.

I think it should be in _init, and not display an error.

>> Third, you should probably add a boolean field
>> to platform_diu_data_ops that gets set to True if/when the platform
>> code initializes the rest of the structure.
>
> Why do you want to complicate a simple bugfix with a requirement to modify all
> platforms that use the driver, introducing a possible regression if one is
> missed?

Fair enough, but I think it should at least be documented by saying
something about set_pixel_clock must be defined, so if it isn't, then
that means the platform code does not support DIU at all, so just
abort.
