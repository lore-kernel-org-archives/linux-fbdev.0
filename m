From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Jan 2017 12:22:21 +0000
Subject: Re: [PATCH 0/4] video: ARM CLCD: add support of an optional GPIO to enable panel
Message-Id: <CACRpkdYbwr8kH-o7C3GN2UeLSmL2=MgNr0rXu+rW-WpPj9moQw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161221032717.13154-1-vz@mleia.com>
 <CGME20170112212713epcas2p108e55dc682911981f750f197f30c7d5f@epcas2p1.samsung.com>
 <d1534f4b-e564-d87e-b408-9b7215a90de2@mleia.com> <3057141.7Vn8X5ONyT@amdc3058>
 <ae187f91-ca9b-c51a-d7cb-14fd99baa434@mleia.com>
In-Reply-To: <ae187f91-ca9b-c51a-d7cb-14fd99baa434@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jan 17, 2017 at 2:57 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:

> I've noticed that 4/4 requires special attention due to the anticipated
> change of devm_get_gpiod_from_child() interface.

Hm. Yeah I merged that patch to the GPIO tree yesterday.

I can of course put those patches on an immutable branch to
be pulled into the fbdev tree, if Bartlomiej wants to kickstart
the fbdev work with some complex cross-git merging :D

> Some updates, now I've developed a simple CLCD DRM driver which works
> nicely on one of my boards powered by LPC3250 (has MMU), but I still
> have to find enough time and check that the driver works on MMU-less
> LPC4357 with the applied DRM core change referenced by Vladimir earlier.
>
> Most probably I'll complete polishing the driver on this weekend and
> send it for review on the next week.

Nice! I look forward to it.

> One more comment, I've found a discussion when DT support to the CLCD
> fbdev driver was added [1], there are some comments about panel device
> node and endpoints incompatibility in comparison to the common layout
> for Linux-ish DRM devices, and I do confirm that this incompatibility
> exists. I have both versions though, but you guess that DRM flavour
> is cleaner, and for CLCD DRM driver I'm going to use it.

Probably a good idea.

> The legacy DT layout can be supported in the same driver in parallel,
> but unfortunately it makes the driver not so cute, and I decide to
> drop it in the initial version. It implies that CLCD fbdev users with
> the controller and panel descriptions in DT and who want to switch to
> CLCD DRM driver should update DTS. Sorry, I know it is inconvenient...

I'm one of those who tend to be lax on these DT ABI issues.

I guess it makes most sense to merge the DRM driver in parallel,
using the DRM bindings, then I can work on adding in support for
my misc systems (all ARM reference designs essentially, plus
Nomadik) using the DRM bindings, and we can stabilize that,
then as a last step simply switch over, augment all device trees
and delete the old fbdev driver.

These systems do NOT have deployed DTB device trees that cannot
be upgraded, they are reference designs not consumer products,
so requireing people to update their device trees is totally
reasonable. In fact I use attached device tree on all of them.

Yours,
Linus Walleij
