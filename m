From: Tina Ruchandani <ruchandani.tina@gmail.com>
Date: Fri, 05 Jun 2015 07:55:05 +0000
Subject: Re: [PATCH] fbdev: radeon: Remove 'struct timeval' usage
Message-Id: <CAB__kknUjU1vdERZQQCxD95idobKN6M-eQZP1jH77tTS3MxhGA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150525040716.GA4448@tinar>
In-Reply-To: <20150525040716.GA4448@tinar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

>>> +     hz = 1000000/delta;
>
> This needs to be on of the do_div family.
>
> Dave.

Hi Dave,
I build-tested the patch for both 32-bit and 64-bit x86. If my
understanding is correct, since the divisor is 64-bit here, the
compiler will do "if (delta > 1000000) hz = 0; else hz 1000000/(s32)delta" automatically?
In general, is this a good thumb-rule to follow - use do_div if the
dividend is 64-bit, and normal divide operator if only the divisor is
64-bit?

Tina
