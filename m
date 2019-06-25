From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 25 Jun 2019 17:06:17 +0000
Subject: Re: [PATCH] video: fbdev: s3c-fb: Mark expected switch fall-throughs
Message-Id: <3e40f8c1-9699-2723-4e70-9e91ff256257@embeddedor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625160103.GA13133@embeddedor>
 <2bdbbd7909c5c4ad96d32c0c5be4690292132a34.camel@perches.com>
In-Reply-To: <2bdbbd7909c5c4ad96d32c0c5be4690292132a34.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>, Kees Cook <keescook@chromium.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Masahiro Yamada <yamada.masahiro@socionext.com>



On 6/25/19 11:52 AM, Joe Perches wrote:
> On Tue, 2019-06-25 at 11:01 -0500, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
> []
>> This patch is part of the ongoing efforts to enable
>> -Wimplicit-fallthrough.
> 
> Just enable the thing already.
> 
> If you stopped trying to do it all yourself, others

What are you talking about?

Anyone can enable it, I'm adding this to every commit:

Warning level 3 was used: -Wimplicit-fallthrough=3

And I'll send a PR with a proper patch for the Makefile
during the next merge window.

If had the power I would have enabled this option since day 1,
so every developer can take care of their own code.

Lately, you are not being of much help, Joe.

--
Gustavo
