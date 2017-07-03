From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 03 Jul 2017 09:07:09 +0000
Subject: Re: [PATCH v5 05/14] MIPS: ingenic: Enable pinctrl for all ingenic SoCs
Message-Id: <CACRpkdb=Zti+C+2me_WP0=m6z12G5Kz+W_cPcZsw=CVzBO_wAg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170402204244.14216-2-paul@crapouillou.net> <20170428200824.10906-1-paul@crapouillou.net>
 <20170428200824.10906-6-paul@crapouillou.net> <CACRpkdauf5c2i4o5i8QY8YHPNjizkvTu6kAbnquWiP_=v2=KdQ@mail.gmail.com>
 <1499013301.1477.0@smtp.crapouillou.net>
In-Reply-To: <1499013301.1477.0@smtp.crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>"linux-mtd@lists.infradead.org" <li>

On Sun, Jul 2, 2017 at 6:35 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> Hi Linus,
>
>> I applied all the patches to a branch in pinctrl and merged into my
>> devel branch for testing:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/
>> Branch: ingenic
>>
>> Ralf: are you OK with this? It would be nice to have your ACK on
>> all patches. If you want you can pull this branch into the MIPS
>> tree, or we can hope for it all to settle nicely because of low platform
>> activity in MIPS on this platform, so it only needs to come in
>> from my trees.
>
>
> There has been no word from Ralf, is this going into 4.13?

Yes.

Yours,
Linus Walleij
