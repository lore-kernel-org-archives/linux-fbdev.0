From: Dave Airlie <airlied@gmail.com>
Date: Sat, 10 Jul 2010 02:20:28 +0000
Subject: Re: kernel mode setting / how to configure the console's resolution X
Message-Id: <AANLkTikenq4HV9SCXzAvEss1urWyX9xGy3zC8Ei9Zofp@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201007100103.55941.dieter.jurzitza@t-online.de>
In-Reply-To: <201007100103.55941.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Jul 10, 2010 at 9:03 AM, Dr. Ing. Dieter Jurzitza
<dieter.jurzitza@t-online.de> wrote:
> Dear listmembers,
> I am not sure whether or not I am at the right place here, but I'll give it a
> try as the list's name sounded most close to what I would like to talk about.
>
> Recently I installed a brand new linux distro coming with the KMS-feature.
> Though appearing quite satisfying at the first glance I noted several
> drawbacks you probably can give answers to / set me on the right track.
>
> The console mode is radically set to the maximum that is promoted by the
> monitor's edid. This leaves the console on my system totally useless as 2048 x
> something points on a 21'' display - well, if I was thirty years younger ...
> and my eyes were still that good ....
>
> Configuration options? Nope. Turn it off, if it disturbs you, I was told.
>
> This is not the way things ought to be. I would like to use KMS for X11 - but
> in X11, there is xrandr, so I have a chance to configure things afterwards -
> but the console - like it or leave it? The distros drop the xorg.conf creation
> software, saying that there is KMS - but the console is left alone(?)
>
> I have been searching for documentation, but in vain so far. Is there any
> friendly guy around explaining to me how to tame that beast? Is it really
> intended (think of visually impaired people ....) that there is no way to
> configure this behaviour?
>
> By the way, I am using kernel 2.6.34<something>
>
> Playing around with fbset yielded nothing but cryptic messages about not
> existing modes though being present in /etc/fb.modes.
>
> Thank you very much for your help in advance,

Either change console fonts to something larger (I think this is
possible haven't done it), or just boot with videod0x480 or 800x600
to change resolutions.

Dave.
