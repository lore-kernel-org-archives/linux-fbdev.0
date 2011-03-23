From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Mar 2011 20:11:15 +0000
Subject: Re: [trivial PATCH 1/2] treewide: Fix iomap resource size miscalculations
Message-Id: <AANLkTikOJ4ed+ExLs1Okm2iFrE95SmR1809bT43bzm8X@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1300909445.git.joe@perches.com>
	<c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
In-Reply-To: <c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

2011/3/23 Joe Perches <joe@perches.com>:

> Convert off-by-1 r->end - r->start to resource_size(r)
>
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
(for ux500)

Yours,
Linus Walleij
