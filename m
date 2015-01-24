From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 24 Jan 2015 15:50:58 +0000
Subject: Re: [RFC PATCH 2/2] fbcon: expose cursor blink interval via sysfs
Message-Id: <CAMuHMdX2cs_JW4QEC=E=m2Z6gg=kZE5PnHBQYZ5RnFp1E9m_fQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.11.1501240109060.3489@localhost.localdomain>
	<alpine.DEB.2.11.1501240117400.3639@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.11.1501240117400.3639@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scot Doyle <lkml14@scotdoyle.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Jan 24, 2015 at 2:19 AM, Scot Doyle <lkml14@scotdoyle.com> wrote:
> +static ssize_t store_cursor_blink_ms(struct device *device,
> +                                    struct device_attribute *attr,
> +                                    const char *buf, size_t count)
> +{

...

> +       unsigned long ms;

...

> +       if (!kstrtoul(buf, 0, &ms)) {

kstrtos16()?

> +               ms = min_t(unsigned long, ms, SHRT_MAX);
> +               ops->blink_jiffies = max_t(int, msecs_to_jiffies(ms), 1);


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
