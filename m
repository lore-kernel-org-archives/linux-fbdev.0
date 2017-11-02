From: Stephen Boyd <sboyd@codeaurora.org>
Date: Thu, 02 Nov 2017 05:32:23 +0000
Subject: Re: [RFC PATCH] clk: move of_clk_get_parent_count() declaration to <linux/__clk.h>
Message-Id: <20171102053223.GH30645@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1507166751-2012-1-git-send-email-yamada.masahiro@socionext.com>
 <20171012231709.GH18706@codeaurora.org>
 <CAK7LNATuSGfQwL1sP9Z9qtkWgnO5agfPbYjs5m6EkOvexTzzZA@mail.gmail.com>
In-Reply-To: <CAK7LNATuSGfQwL1sP9Z9qtkWgnO5agfPbYjs5m6EkOvexTzzZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, linux-fbdev@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>

On 10/29, Masahiro Yamada wrote:
> 2017-10-13 8:17 GMT+09:00 Stephen Boyd <sboyd@codeaurora.org>:
> 
> >  USB has a
> > similar case, which I think Shawn Guo/Dong Aisheng was trying to
> > add an OF based bulk clk_get() API called of_clk_bulk_get()
> > for[1]. If this get all clks API works there too then we should
> > use it. If it can be non-DT specific, even better.
> >
> > [1] http://lkml.kernel.org/r/1506415441-4435-1-git-send-email-aisheng.dong@nxp.com
> 
> OK, we can implement it based on Shawn/Dong's work.
> 
> My concern is clk-bulk.c still needs to include #<linux/clk-provider.h>,
> but it is a bit odd since clk-bulk.c is a helper for clk consumers.
> 
> 

Understood. I'm not concerned though, it's one place where this
happens, not in a bunch of random drivers. What exactly do you
need from clk-provider.h in clk-bulk.c though?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
