From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 13 Aug 2015 08:59:08 +0000
Subject: Re: [PATCH] fbdev: select versatile helpers for the integrator
Message-Id: <CACRpkdYuMGnpYgYUpMVbDTjh=H6C3oyrnHZB92Zx8JPmMuC5dQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438090272-26266-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1438090272-26266-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Aug 10, 2015 at 11:19 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 10/08/15 12:03, Linus Walleij wrote:
>> On Tue, Jul 28, 2015 at 3:31 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>>> Commit 11c32d7b6274cb0f554943d65bd4a126c4a86dcd
>>> "video: move Versatile CLCD helpers" missed the fact
>>> that the Integrator/CP is also using the helper, and
>>> as a result the platform got only stubs and no graphics.
>>> Add this as a default selection to Kconfig so we have
>>> graphics again.
>>>
>>> Fixes: 11c32d7b6274 (video: move Versatile CLCD helpers)
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Ping on this.
>>
>> Shall I take this into ARM SoC instead?
>
> Sorry, I still haven't gotten into dealing with fbdev related mails
> after my vacation...
>
> This is needed for 4.2, right? I can pick this up.

In theory, it's not like it's regressing the world. I'm fine with
4.3 at this point of you just keep the Fixes:... tag.

Yours,
Linus Walleij
