From: Alessandro Rubini <rubini@unipv.it>
Date: Tue, 06 Dec 2011 15:59:11 +0000
Subject: Re: [GIT PULL] ARM: amba: Enable module alias autogeneration for
Message-Id: <20111206155911.GA11902@mail.gnudd.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20111206151541.GA13774@linaro.org>
	<1321961573-4562-1-git-send-email-dave.martin@linaro.org>
In-Reply-To: <20111206151541.GA13774-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Pawel.Moll-5wv7dgnIgG8@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, julia-dAYI7NvHqcQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

> ... it looks like Alessandro's proposed change to tidy up scripts/mod/
> ile2alias.c may get merged soon

No, I don't think it will happen. Rusty disagrees, and his own
suggestion is in the queue. I'm waiting a while to understand
what is happening.

Anyways, I think it's better for me to wait for amba to come in, and
work on scripts/mod later on. After all, it's meant to ease adding new
buses later, not to make it more difficult for already scheduled ones.

/alessandro
