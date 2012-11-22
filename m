From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Nov 2012 08:57:22 +0000
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Message-Id: <CACRpkdaNmBpfONDpt7zFqLaqfiGm+ELpO-v5gZmM0rEi_AzijQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
 <20121120215429.B621F3E1821@localhost>
 <20121121013133.GE4673@opensource.wolfsonmicro.com>
In-Reply-To: <20121121013133.GE4673@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Nov 21, 2012 at 2:31 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> As I said in my earlier reviews I think this is a useful thing to have
> as a utility library for drivers independantly of the DT bindings, it
> would allow drivers to become more data driven.  Perhaps we can rework
> the series so that the DT bindings are added as a final patch?  All the
> rest of the code seems OK.

I have the same (limited by experience) opinion. Working sort of
near som audio drivers I have understood that power sequencing
is a big issue not only for things like this backlight example, but
even more so in the area of audio to avoid clicks and pops.

Is it correct to assume that this library will be useful also for ALSA
SoC type of devices?

Then whether to couple that to DT or ACPI or SFI or whatever
is a different discussion altogether.

Yours,
Linus Walleij
