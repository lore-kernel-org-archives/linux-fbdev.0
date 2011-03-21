From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Mon, 21 Mar 2011 19:25:18 +0000
Subject: Re: Future desktop on dumb frame buffers?
Message-Id: <20110321122518.6b7ec7e4@jbarnes-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimJWpebAskcjA+qQUDWXjiH6aHta4fri9z6OxRN@mail.gmail.com>
	<20110321110040.6f1ea6d3@jbarnes-desktop>
	<AANLkTimjOs8ZuKRUt1aOizhbRw2-Ni4bTPty-dKpZ-rz@mail.gmail.com>
In-Reply-To: <AANLkTimjOs8ZuKRUt1aOizhbRw2-Ni4bTPty-dKpZ-rz-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: timofonic timofonic <timofonic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, wayland-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

On Mon, 21 Mar 2011 19:19:43 +0000
timofonic timofonic <timofonic@gmail.com> wrote:
> So if KMS is so cool and provides many advantages over fbdev and
> such... Why isn't more widely used intead of still relying on fbdev?
> Why still using fbdev emulation (that is partial and somewhat broken,
> it seems) instead using KMS directly?

Used by what?  All three major GPU device classes have KMS support
(Intel, ATI, and nVidia).  If you want it for a particular device, you
can always port it over.

As for fbdev emulation, what's still using it?  There's nothing
stopping projects from converting over; X and Wayland can already
handle KMS APIs just fine.

> I know the graphic driver situation is quite bad on Linux, especially
> on the embedded world. Fbdev seems is still quite used there by binary
> blob drivers.

Probably for a couple of reasons:
  1) inertia: fbdev has been around a lot longer, and provides most of
  what embedded devices need anyway
  2) feature set: why bother doing a full KMS driver if you're not
  going to use any of the additional features it would provide (output
  management, memory management, execution management)

Jesse
