From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 28 Oct 2017 17:35:29 +0000
Subject: Re: [RFC PATCH] clk: move of_clk_get_parent_count() declaration to <linux/__clk.h>
Message-Id: <CAK7LNATuSGfQwL1sP9Z9qtkWgnO5agfPbYjs5m6EkOvexTzzZA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1507166751-2012-1-git-send-email-yamada.masahiro@socionext.com> <20171012231709.GH18706@codeaurora.org>
In-Reply-To: <20171012231709.GH18706@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk <linux-clk@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, linux-fbdev@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>

Hi Stephen,


2017-10-13 8:17 GMT+09:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 10/05, Masahiro Yamada wrote:
>> The clock consumer, drivers/video/fbdev/simplefb.c, includes
>> <linux/clk-provider.h> just for calling of_clk_get_parent_count().
>> This is ugly.
>>
>> Looking at simplefb_clocks_get(), of_clk_get_parent_count() seems
>> useful for clock consumers as well as for clock providers.
>>
>> Unfortunately, we do not have a good home for declarations shared
>> between consumers and providers.
>>
>> Create a new header <linux/__clk.h>, and move it over to it.  This
>> header must be included via <linux/clk.h> or <linux/clk-provider.h>
>> (this is why it is prefixed with double-underscore).  Add #error
>> so the build terminates if it is included directly.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>
> How about we add a get_all_the_clks_for_the_device() sort of API
> that uses the bulk clk code but also allocates the array by
> reading the number of clks from DT? Please think of a better name
> of course. We can figure out how to handle non-DT platforms if we
> need to. With clkdev we could probably handle it with some sort
> of lookup table search given a device name. Don't add that part
> until we have a user though. I assume simplefb is all DT
> platforms?

of_reset_control_array_get() is implemented like that.

It gets all the resets specified in DT, and automatically
allocates the array of necessary number of pointers.

clk-bulk and reset-array were implemented in a different way.



> Either way, it looks like what we really want here is a way to
> get every clk for a device and not look at the details.

Yes.  This is helpful for generic drivers.


>  USB has a
> similar case, which I think Shawn Guo/Dong Aisheng was trying to
> add an OF based bulk clk_get() API called of_clk_bulk_get()
> for[1]. If this get all clks API works there too then we should
> use it. If it can be non-DT specific, even better.
>
> [1] http://lkml.kernel.org/r/1506415441-4435-1-git-send-email-aisheng.dong@nxp.com

OK, we can implement it based on Shawn/Dong's work.

My concern is clk-bulk.c still needs to include #<linux/clk-provider.h>,
but it is a bit odd since clk-bulk.c is a helper for clk consumers.


-- 
Best Regards
Masahiro Yamada
