From: Michal Suchanek <hramrach@centrum.cz>
Date: Tue, 22 Mar 2011 15:26:43 +0000
Subject: Re: Future desktop on dumb frame buffers?
Message-Id: <AANLkTinO=LSsnkpUv07taaY=PO_6KQa8Kg-ZZB-StiBj@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimJWpebAskcjA+qQUDWXjiH6aHta4fri9z6OxRN@mail.gmail.com>
	<20110321110040.6f1ea6d3@jbarnes-desktop>
	<AANLkTimjOs8ZuKRUt1aOizhbRw2-Ni4bTPty-dKpZ-rz@mail.gmail.com>
	<20110321122518.6b7ec7e4@jbarnes-desktop>
In-Reply-To: <20110321122518.6b7ec7e4@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
Cc: timofonic timofonic <timofonic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, wayland-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

On 21 March 2011 20:25, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> On Mon, 21 Mar 2011 19:19:43 +0000
> timofonic timofonic <timofonic@gmail.com> wrote:
>> So if KMS is so cool and provides many advantages over fbdev and
>> such... Why isn't more widely used intead of still relying on fbdev?
>> Why still using fbdev emulation (that is partial and somewhat broken,
>> it seems) instead using KMS directly?
>
> Used by what?  All three major GPU device classes have KMS support
> (Intel, ATI, and nVidia).  If you want it for a particular device, you
> can always port it over.
>
> As for fbdev emulation, what's still using it?  There's nothing
> stopping projects from converting over; X and Wayland can already
> handle KMS APIs just fine.

The console and a few terminal emulators for it I guess.

Thanks

Michal
