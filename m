From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 26 Jun 2018 13:11:13 +0000
Subject: Re: [PATCH v2] console/fbcon: Add support for deferred console takeover
Message-Id: <CACvgo52oB4xZ3XeNsDcLcjrEr7Xzk=CMGymGtxPs-1GJ_W1b2w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180626104103.12208-1-hdegoede@redhat.com>
In-Reply-To: <20180626104103.12208-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Hans,

On 26 June 2018 at 11:41, Hans de Goede <hdegoede@redhat.com> wrote:

> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
> +               if (!strcmp(options, "nodefer")) {
> +                       deferred_takeover = false;
> +                       continue;
> +               }
> +#endif
Can we please have some documentation about "nodefer".
I may have missed something, but it seems like the only instance of it
is in this hunk.

If you prefer, the documentation can be a separate commit.

Thanks
Emil
